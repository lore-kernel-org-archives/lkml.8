Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7738DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5D2206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFBLFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgFBLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:05:53 -0400
X-Greylist: delayed 2144 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Jun 2020 04:05:53 PDT
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793BEC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 04:05:53 -0700 (PDT)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
        by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jpa@lakka.kapsi.fi>)
        id 1jg4B5-0001K0-OB; Tue, 02 Jun 2020 13:29:52 +0300
Received: from jpa by lakka.kapsi.fi with local (Exim 4.92)
        (envelope-from <jpa@lakka.kapsi.fi>)
        id 1jg4B5-00021k-MV; Tue, 02 Jun 2020 13:29:51 +0300
Date:   Tue, 2 Jun 2020 13:29:51 +0300
From:   Petteri Aimonen <jpa@git.mail.kapsi.fi>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200602102951.GE17423@lakka.kapsi.fi>
References: <20200602101119.GA11634@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602101119.GA11634@zn.tnic>
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
 Symbol: RCPT_COUNT_FIVE(0.00)
 Symbol: TO_DN_ALL(0.00)
 Symbol: NEURAL_HAM(-0.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20200602102951.GE17423@lakka.kapsi.fi
X-Rspam-Bar: +
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: jpa@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Instead of adding that kernel module which is x86-specific
> to a generic lib/ directory, it should be in, say,
> tools/testing/selftests/x86/test_fpu_module.c or so and instead of

The kernel module is not actually x86-specific, even though it is 
currently only enabled for x86. amdgpu driver already does kernel mode 
floating point operations on PPC64 also, and the same module could be 
used to test the same thing there.

> reading /proc/sys/debug/test_fpu, the user portion of the code would
> simply modprobe it.

To deterministically trigger the bug, the syscall has to come from the 
same thread that has modified MXCSR. Going through /usr/sbin/modprobe 
won't work, and manually doing the necessary syscalls for module loading 
seems too complicated.

> What is also missing is the user portion doing ldmxcsr before running
> the test and the test should be causing at least one exception which
> MXCSR masks off.

The fesetround() and feenableexcept() are the portable ways to modify 
MXCSR. The test module does cause Precision Exception and Denormal 
Exception if those exceptions are unmasked.

--
Petteri
