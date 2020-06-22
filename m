Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC3CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B99620707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Bqy7PfP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgFVRMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbgFVRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:12:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:12:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8DCE1EC0283;
        Mon, 22 Jun 2020 19:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592845963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8pdlAxMtk14iCGsQC9GsAzOVaIHg8KSlUXfBeiO9yvI=;
        b=Bqy7PfP0IdSf6GW8vFktNVtJGjB8NV0y69FE7K3yoCerVVlVXPd2tshLPR3Go6RSC0QdkZ
        1+3ujmLPiNnao1gnK8jdazPMGkUZu01PvpYC2ygsp1WjT4hpZ7BVUSLf1UFf+7jyK9GMz8
        K8Lx8mQikHrO2v34023VsxcBw3Grk4Q=
Date:   Mon, 22 Jun 2020 19:12:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
Message-ID: <20200622171240.GI32200@zn.tnic>
References: <20200619174127.22304-1-bp@alien8.de>
 <20200619174127.22304-3-bp@alien8.de>
 <CALCETrXXzt8WZMs3dsReCJ5wdF3zhxFmUtGnmdCgV7_exFUKKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXXzt8WZMs3dsReCJ5wdF3zhxFmUtGnmdCgV7_exFUKKQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:00:28AM -0700, Andy Lutomirski wrote:
> This should be cc-option, not cc-ifversion, I think.

Why?

> But maybe we should consider dropping the problematic GCC version
> instead? The old GCC versions with stack alignment problems are
> seriously problematic for x86 kernels, and I don't really trust
> kernels built with them.

Can't - we just upped min gcc version to 4.8:

5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for kernel builds to 4.8")

I mean we could but everytime we do that, it is all a big bikeshedding
discussion. Even though almost everyone is using gcc9 or so to build...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
