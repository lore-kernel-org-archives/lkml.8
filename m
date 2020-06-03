Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AFBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBD7206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFCFUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCFUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:20:04 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E6C05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 22:20:03 -0700 (PDT)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
        by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jpa@lakka.kapsi.fi>)
        id 1jgLoY-0003XD-TX; Wed, 03 Jun 2020 08:19:47 +0300
Received: from jpa by lakka.kapsi.fi with local (Exim 4.92)
        (envelope-from <jpa@lakka.kapsi.fi>)
        id 1jgLoY-000616-Qw; Wed, 03 Jun 2020 08:19:46 +0300
Date:   Wed, 3 Jun 2020 08:19:46 +0300
From:   Petteri Aimonen <jpa@git.mail.kapsi.fi>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200603051946.GF17423@lakka.kapsi.fi>
References: <8b1f0bfa-79b0-74e4-0241-8b2a94491807@linuxfoundation.org>
 <C6F6F6E4-CBD8-4E72-812B-99F008ECAA4F@amacapital.net>
 <b4629042-21c7-2b38-4c3f-44f9be469cca@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4629042-21c7-2b38-4c3f-44f9be469cca@linuxfoundation.org>
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
 Symbol: TO_DN_ALL(0.00)
 Symbol: RCPT_COUNT_SEVEN(0.00)
 Symbol: NEURAL_HAM(-0.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20200603051946.GF17423@lakka.kapsi.fi
X-Rspam-Bar: +
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: jpa@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Is it correct to assume the stuff checked differs from test to test
> and done in user-space.
> 
> > undo_evil_state();
> 
> Is it correct to assume undoing evil differs from test to test
> and done in user-space, provide it can be done from userspace.

Yes, currently the test works like:

do_test_setup();
read_from_debugfs_file();
check_results();

and the middle step stays the same. But of course in general case there 
could be argument passing etc, even though the test for this issue 
doesn't need them.

Myself I don't see the problem with just adding a file under debugfs and 
bind to its read.

--
Petteri
