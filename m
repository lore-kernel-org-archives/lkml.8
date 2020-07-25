Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3E7C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 08:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B69206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 08:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfqr1Xn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgGYIo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGYIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 04:44:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD11C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 01:44:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g7so3971656ejw.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0eCpXv6tlNwLNhcVnFmKjptKWSpAoc1WprIax3wqYt8=;
        b=Yfqr1Xn2CpzkXvW05kqAPg1Wb2BmyojgU7C2S/xPA5DNKfeU6qT2I/sIyd7PpFFt1r
         rh7yNWHL1h8qL2li5zAQccddcwKjYyjEuZSHXlq/txVDqhUfxeokKkMQ8jeNNh6b7NDx
         fjSn/dl3wmxBWef2KzXFoVUkNwdbWW7CI/f3PVAxTS6eAjHFApKftKyuZWi0gXAYAswx
         mGJGJ2KT52nRwvs2yYzSCyeDJq9P5WYOmQP+QSzTr6etupk/BI50ouKbYWlpgTh+aMCJ
         CjJ1SclTV9LHEoDR25yoJT2yu5jIamIIXx2VRHKtTFBJNUC8YKN2pD/D0lgxR/o3ewH1
         aC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=0eCpXv6tlNwLNhcVnFmKjptKWSpAoc1WprIax3wqYt8=;
        b=k3OOC53fYC/S2tCMTYqIyJITG903qryg1Nonnm2w1vDRJIKcHLTL1Gb4qt8WJ9VDMU
         OfdyJF22clOF5OIcjSPGSuG0cUp4Px1iObi7BNYQh5iSAMBPQGzYoygtDk/AHrg/g6Cq
         pMRROaIiXjg/8R2Dc8wsAoR+1ifWSCVP2W49VXG/WGZYuAPJ5qTDs6U5+Wv7LYA8RFIc
         QfYCald6edZbP4ltwqtuJDT9k1OR5tP8D7tbp0ypM7JNtAB0q/jiwop0aaStUl0ZvnqS
         P9IFlTd7YeHicq8Tch83khLcwMljKowKEstvJZ4lNHAjMmlIA71Wm64NBpBhrAdEaiLI
         9C/g==
X-Gm-Message-State: AOAM5314ax2YMBIIfZvTU1pc/PDl1na5i6SIMqyrSJfqfSfWUQznBFa/
        NHrpdfjXcR3IbaZUOloKmk5sAaK0
X-Google-Smtp-Source: ABdhPJxinqP5dwikN8TBnCxJAAC2Z2DTLNdUzENaL5EBSYp+fl33xszs7Azq5+ZHIN6Wv0lOGnanPw==
X-Received: by 2002:a17:906:c259:: with SMTP id bl25mr12537887ejb.303.1595666662998;
        Sat, 25 Jul 2020 01:44:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id v19sm2426156edy.50.2020.07.25.01.44.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jul 2020 01:44:22 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Change type of module param
 `ppfeaturemask` to hexint
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
 <20200703142939.28663-3-pmenzel@molgen.mpg.de>
 <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
 <7e5b2284-0549-185c-4afd-f7d193e2faf9@molgen.mpg.de>
 <54ad054c-2cf4-765e-4ecc-44e2b98422f0@amd.com>
 <CAHk-=whxP-2tFBX9ctP242TsgJhtp7yhNrkG6Tj+Ng=FiT1FbQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <14c71f74-654d-5d03-4865-249751cf65a2@gmail.com>
Date:   Sat, 25 Jul 2020 10:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whxP-2tFBX9ctP242TsgJhtp7yhNrkG6Tj+Ng=FiT1FbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.07.20 um 22:29 schrieb Linus Torvalds:
> On Fri, Jul 24, 2020 at 12:54 AM Christian König
> <christian.koenig@amd.com> wrote:
>> But since you already addressed Linus comments and it looks rather clean
>> I think I can just push it to drm-misc-next on Monday if nobody objects
>> over the weekend.
> Yeah, no objections from me.
>
> Add a note to it to the pull request, so that when my bird-brain sees
> the pull during the next merge window and I've forgotten this thread,
> I don't go "why is the drm tree modifying code files"?

Well Dave is sending those requests to you usually.

I will just add an Acked-by: Linus Torvalds 
<torvalds@linux-foundation.org> to the patch before pushing :)

Thanks,
Christian.

>
>               Linus
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

