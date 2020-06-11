Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26928C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D922074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgFKHgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:36:23 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:36:23 -0700 (PDT)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
        by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jpa@lakka.kapsi.fi>)
        id 1jjHku-0004TY-5Y; Thu, 11 Jun 2020 10:36:08 +0300
Received: from jpa by lakka.kapsi.fi with local (Exim 4.92)
        (envelope-from <jpa@lakka.kapsi.fi>)
        id 1jjHku-0000c4-2E; Thu, 11 Jun 2020 10:36:08 +0300
Date:   Thu, 11 Jun 2020 10:36:08 +0300
From:   Petteri Aimonen <jpa@git.mail.kapsi.fi>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200611073607.GH17423@lakka.kapsi.fi>
References: <20200602101119.GA11634@zn.tnic>
 <20200602102951.GE17423@lakka.kapsi.fi>
 <20200602105649.GB11634@zn.tnic>
 <CALCETrURrz=L5f-HHF3kZtUqV0dw5hAEGqSxWTsOjoZvOKaccw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrURrz=L5f-HHF3kZtUqV0dw5hAEGqSxWTsOjoZvOKaccw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspam-Score: 1.2 (+)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: DMARC_NA(0.00)
 Symbol: AUTH_NA(1.00)
 Symbol: NEURAL_SPAM(0.00)
 Symbol: TO_DN_ALL(0.00)
 Symbol: RCPT_COUNT_SEVEN(0.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20200611073607.GH17423@lakka.kapsi.fi
X-Rspam-Bar: +
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: jpa@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> How about putting the file you frob in
> /sys/kernel/debug/selftest_helpers/something_or_other.  The idea would
> be that /sys/kernel/debug/selftest_helpers would be a general place
> for kernel helpers needed to make selftests work.

Seems like this is the consensus for now.

Any opinions on whether the module should remove "selftest_helpers"
directory on unloading, or not?

1) Removing would break if other test modules will use the same dir.
2) Not removing will leave the directory dangling.
3) Remove only if empty is one option, though I'm unsure how to
   cleanly check if debugfs directory is empty.
4) E.g. /sys/kernel/debug/x86/ is created centrally and a symbol is
   exported for its dentry. But I'm not sure if it really makes sense
   to add another exported symbol just for selftest_helpers.

--
Petteri

