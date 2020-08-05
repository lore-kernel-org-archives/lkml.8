Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B190BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944AC2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="D3gZ60Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHEBRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:17:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED795C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 18:17:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so11359111plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 18:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2AOGkiNTffjyxOtPLoc4ZEcdEbmpmadV+kYe/cYkEjM=;
        b=D3gZ60OyZwbyd09ShybcvvMYw6LzhZaX6TWjzSCqN3OgpxJG7N3ySA31Z6+N2snajO
         vBzQPBhqPDxx+fC3bswYNrRV8CPOwXzELiybXXGafU5PewQqD5ST+ZueQNRqfBa/jJDP
         zND15xoFN1+u3FeBksQsWIns1zdrOHDk3KQtlYTbRBgWwM7ca1+ezfQJI8PEovOWMdF/
         9QlZ9/jrea2i5UZqOPL52wNrL/PQvGG+4xX8/sGBoLtrAV4Y0P9IP6PnAoX6oZ7BrHMl
         hXGTXpiABsIcdS1sTBzlPKlCvF5K8SSKCWOhGUxpra37layH4diEspSs8w8RZ8/nHWO7
         m+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2AOGkiNTffjyxOtPLoc4ZEcdEbmpmadV+kYe/cYkEjM=;
        b=AhAF5L++pIbx3F3whUntzUfOc5tFH/zV5NU7/HZ41a3ju1lfleNNk/9L2eubn749PL
         QAEPIUK8jplGHiQmhYTQz03hnYZWnrNxOXW7JHRLmXHvI4HZbrBoGpa85V2JVMWYSbaA
         uYDVWQ2QUJeo3Pt0uty0yxByarNZJeOMkaO7BU08L3U0Am1NdEqspboPPl1DGSGtaEcx
         +//AzD/4+I0x5G0IpSswUQjZ7GHITBXnUyQwik5wSPuVVp+0qxriEd2CUGsLUgjzQfwY
         C6kBT630yqAx67OaIgt/ou0zFxuwxMAxaQyQ12dbjdKF6i+UWyuthNN6b2m2JZ50PFIc
         Dj1A==
X-Gm-Message-State: AOAM5336AnoGPbEYcOI5kaZOfYJc8sxCiObtji0YhMYrwHi3cbZHcXof
        Xs5s/bAdWf3bPb/wmKCUKBxft/zpxQk=
X-Google-Smtp-Source: ABdhPJz4vm6iZW7xaPR7FTRcls9YtW05RQnx34nH4eSh5XI22o/MlIx8A2Zojix7gTB/adp227PEGw==
X-Received: by 2002:a17:902:988f:: with SMTP id s15mr969507plp.14.1596590256310;
        Tue, 04 Aug 2020 18:17:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z9sm531081pgh.94.2020.08.04.18.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 18:17:35 -0700 (PDT)
Date:   Tue, 04 Aug 2020 18:17:35 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Aug 2020 18:17:33 PDT (-0700)
Subject:     Re: linux-next: manual merge of the pidfd tree with the risc-v tree
In-Reply-To: <20200805103943.3c28da7f@canb.auug.org.au>
CC:     christian@brauner.io, Paul Walmsley <paul@pwsan.com>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        greentime.hu@sifive.com, tklauser@distanz.ch
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-d98d39e0-9fc5-4bad-b7d2-984d0dc638eb@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Aug 2020 17:39:43 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> On Mon, 13 Jul 2020 16:58:46 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the pidfd tree got a conflict in:
>> 
>>   arch/riscv/Kconfig
>> 
>> between commit:
>> 
>>   95ce6c73da3b ("riscv: Enable context tracking")
>>   929f6a183839 ("riscv: Add kmemleak support")
>> 
>> from the risc-v tree and commit:
>> 
>>   140c8180eb7c ("arch: remove HAVE_COPY_THREAD_TLS")
>> 
>> from the pidfd tree.
>> 
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>> 
>> diff --cc arch/riscv/Kconfig
>> index 76a0cfad3367,f6a3a2bea3d8..000000000000
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@@ -57,9 -52,6 +57,8 @@@ config RISC
>>   	select HAVE_ARCH_SECCOMP_FILTER
>>   	select HAVE_ARCH_TRACEHOOK
>>   	select HAVE_ASM_MODVERSIONS
>>  +	select HAVE_CONTEXT_TRACKING
>> - 	select HAVE_COPY_THREAD_TLS
>>  +	select HAVE_DEBUG_KMEMLEAK
>>   	select HAVE_DMA_CONTIGUOUS if MMU
>>   	select HAVE_EBPF_JIT if MMU
>>   	select HAVE_FUTEX_CMPXCHG if FUTEX
>
> This is now a conflict between the risc-v tree and Linus' tree.

Thanks.  I'd just pulled in some stuff and was intending on sending a PR to
Linus tomorrow (we've got some autobuilders that run overnight that I like to
give a crack at the actual commit before I send anything).  For this one I
think the best bet is to just mention it to Linus as a conflict to be fixed --
the only other thing I can think of would be to rebase my tree, which seems
worse at this point.

LMK if anyone has a better idea, otherwise I'll send it out.
