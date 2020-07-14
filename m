Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE41EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D772242B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pGhuzzIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGNQ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:56:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgGNQ4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:56:19 -0400
Received: from nazgul.tnic (77-85-108-148.ip.btc-net.bg [77.85.108.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D8AF1EC0316;
        Tue, 14 Jul 2020 18:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1594745777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eSZXXJhICHmfJsUPO4ZXL5UFX2Z45md7BXHPQUpwRrQ=;
        b=pGhuzzIUmbeeMwDdTz2V3jYnn383OWOOI2M1nIV782YvNDHdupPrCyfSuPCaW1W2BKN5RA
        J6baEJxyrDDE6wIsMgRRI1ZXx2LD97AxV62rma4Hm6rQr/oyn4/j4smliO9NhECk4F/pPr
        fHInmQA4BPMQ28+OWcZDhhXRfz0l2Vg=
Date:   Tue, 14 Jul 2020 18:56:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        tony.luck@intel.com, torvalds@linux-foundation.org, x86@kernel.org,
        kernel-team@fb.com, Matthew Garrett <matthewgarrett@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200714165621.GA3622@nazgul.tnic>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714160448.GC2080@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 05:04:48PM +0100, Chris Down wrote:
> Since the issue involves DPTF which is only supported via binary blobs, I
> can't say for certain what the issue is. As I understand it, when the
> throttling behaviour isn't explicitly configured by the OS kernel, the
> default policy is extremely overeager. Matthew also had a look at it[0], but
> I don't know if anything eventually happened there. I've cc'ed him.
> 
> Either way, again, this isn't really the point. :-) The point is that there
> _are_ currently widespread cases involving poking MSRs from userspace,
> however sacrilegious or ugly (which I agree with!), and while people should
> be told about that, it's excessive to have the potential to take up 80% of
> kmsg in the default configuration. It doesn't take thousands of messages to
> get the message across, that's what a custom printk ratelimit is for.

Ok, feel free to suggest a fix, better yet send a patch. Otherwise,
you'd have to wait for my vacation to end first. :-)

> 0: https://twitter.com/mjg59/status/1034132444201582596

As to the power issue, lemme CC some Intel folks I found in MAINTAINERS.

Intel folks, pls check the link above and upthread: Why TF do people
need to use some luserspace daemon which pokes at MSRs which the kernel
writes to too, in order to bypass some apparently too conservative
throttling, AFAIU?

And why does this work on windoze reportedly?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
