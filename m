Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2232AC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A04206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595622588;
	bh=P4GcqCKdCgwDEfUywIJppQbaoV/1hKs3gacaqPa1wHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s23LEv6Gg1B3zjzSAm6JZ/2ojvpNIFTU22xasEBoqNNsXFwgAYI6EpTJNmfN669rm
	 vZzrRKBTQOWQv9oRYjWaOWESxVqiT3kwQK3c+JAvfSitxTaHfozWAYjBU6fFKTtTvR
	 R74ksc2IvlTDw2mnog0D3/N+GWoik8DfSx97LAB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgGXU3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgGXU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:29:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8AC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:29:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x9so11246506ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rN5RMUW/56gaFNCn9cuYichcDB+Mu1aPFaim03Y9pNc=;
        b=ABndUtX222DsXCRyLiuR08D4nTyyZmgGC2ovL55ed45uZT14odfvFGQhNKX3Vm9PWv
         md1/mNmLLeG75u2/dzJ6n9XdWSGLSp+BtCTnU5dWEKfY+RGK4X4nhF7Ta1cIgMcklTrh
         ZIPc5vt8aGQ89cJrTZe3k4/Jna1PAuDK2WEfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rN5RMUW/56gaFNCn9cuYichcDB+Mu1aPFaim03Y9pNc=;
        b=MIE/vnLnk7bpCqc5cjP7oDpzriEFQhPy91F9CrGhOoFbMNEriDbkptSk/SfvW3f4yp
         isqqhSKEDQsyJZwwzRe0OIcLXKMCWOn2L1i69f1xzyd1BZY7hSKWQ6g9o2JZuLU27G7i
         FqqDq12SW6mwhUSAYCsaR/0y/riwhTt9AzAUVoj/UnDSeV/HYed2TNDVX2j96Cdm1n4l
         HEShoDUdttn7/xrt0hl7Te6f60mqrXZpAnS5z182MnoXHvBdvzJTmXH20/tnOIYvi8gK
         s4+/iciIxfLfIFG7IbElmggZV9vM5OAvlBeoN5rarmVBVgCwPGwVZ4k7zvNU1dCLHZCA
         oO5g==
X-Gm-Message-State: AOAM533DJ0ZVcUqm/O4AQqDODk5wsjoeGSyQnSmz3b98r/tT7t32B1bW
        PJKssyPUrr9A1/tiM/lrpmx66kVuOTg=
X-Google-Smtp-Source: ABdhPJx63YABHDN9Lh4CCqqLeB7vDSUxyp8hH0BPN68rbDqu43GGh6JyckS7vWWhQy5++DOQBHHS6g==
X-Received: by 2002:a2e:302:: with SMTP id 2mr4759670ljd.156.1595622583845;
        Fri, 24 Jul 2020 13:29:43 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x13sm558191lfr.95.2020.07.24.13.29.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:29:42 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id k13so5881727lfo.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:29:42 -0700 (PDT)
X-Received: by 2002:ac2:521a:: with SMTP id a26mr5747786lfl.192.1595622582122;
 Fri, 24 Jul 2020 13:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de> <20200703142939.28663-3-pmenzel@molgen.mpg.de>
 <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com> <7e5b2284-0549-185c-4afd-f7d193e2faf9@molgen.mpg.de>
 <54ad054c-2cf4-765e-4ecc-44e2b98422f0@amd.com>
In-Reply-To: <54ad054c-2cf4-765e-4ecc-44e2b98422f0@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 13:29:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxP-2tFBX9ctP242TsgJhtp7yhNrkG6Tj+Ng=FiT1FbQ@mail.gmail.com>
Message-ID: <CAHk-=whxP-2tFBX9ctP242TsgJhtp7yhNrkG6Tj+Ng=FiT1FbQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Change type of module param
 `ppfeaturemask` to hexint
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:54 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> But since you already addressed Linus comments and it looks rather clean
> I think I can just push it to drm-misc-next on Monday if nobody objects
> over the weekend.

Yeah, no objections from me.

Add a note to it to the pull request, so that when my bird-brain sees
the pull during the next merge window and I've forgotten this thread,
I don't go "why is the drm tree modifying code files"?

             Linus
