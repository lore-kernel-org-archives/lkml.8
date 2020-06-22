Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF041C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47C420738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgFVShJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbgFVShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:37:07 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13564C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:37:07 -0700 (PDT)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
        by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jpa@lakka.kapsi.fi>)
        id 1jnRJR-0007No-Ms; Mon, 22 Jun 2020 21:36:57 +0300
Received: from jpa by lakka.kapsi.fi with local (Exim 4.92)
        (envelope-from <jpa@lakka.kapsi.fi>)
        id 1jnRJR-0005sG-K9; Mon, 22 Jun 2020 21:36:57 +0300
Date:   Mon, 22 Jun 2020 21:36:57 +0300
From:   Petteri Aimonen <jpa@kernelbug.mail.kapsi.fi>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200622183657.GH20421@lakka.kapsi.fi>
References: <20200619174127.22304-1-bp@alien8.de>
 <20200619174127.22304-2-bp@alien8.de>
 <CALCETrXZhFJGJA2h4zP743KYTtni-rQSUME8mtSYUdk1-ZTauQ@mail.gmail.com>
 <20200622170908.GH32200@zn.tnic>
 <CALCETrU0C5yVwfAOj+v1RqNBZY+phXrdvCBZMKdOXOExBgMbVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU0C5yVwfAOj+v1RqNBZY+phXrdvCBZMKdOXOExBgMbVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspam-Score: -1.8 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: DMARC_NA(0.00)
 Symbol: AUTH_NA(1.00)
 Symbol: RCPT_COUNT_FIVE(0.00)
 Symbol: TO_DN_ALL(0.00)
 Symbol: NEURAL_HAM(-0.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: BAYES_HAM(-2.99)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20200622183657.GH20421@lakka.kapsi.fi
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: jpa@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We want to make sure that GCC puts things in the right order.  I
> suppose that even a memory clobber is insufficient here, though.

amdgpu worked around that by using a noinline function:
https://github.com/torvalds/linux/commit/59dfb0c64d3853d20dc84f4561f28d4f5a2ddc7d#diff-a82b8ab0e6b4f9abfd3344d1427d765f

If there is something that would help, it would have to be an
attribute added to kernel_fpu_begin() in the header. Any barriers
inside the function will be invisible to code generation in other
compilation units.

--
Petteri
