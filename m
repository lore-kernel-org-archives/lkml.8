Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D99FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03492076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="kpie1bvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgHTUpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgHTUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:45:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35840C061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:45:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so1613387pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Dj6dnw1SSGK0z0yl6jJ2uTtBS6LOewFQlnOBWDc3SWg=;
        b=kpie1bvbURjnyGG5tFbzrQs43n0HWVHiEYDQrm96KF6px5dqNEbRvhU3+tGczCdBEN
         nH9nuWE/dOw1Fgm1b8XE++szjDp0mBzlS073HLhBZlzJRTxzBxHat4pKrJ+PAUUpdnkm
         6TqGwZcpetdpfq+xwK7v6+z4qTQ2Sx1kOiVB+dnlANwEjP87QrY+E1wazm4JJMh1Dtte
         tNTb00w8s9tvECp5T1ElK7APHequbv1ziFmjXXxOKTD0T16K6rLqPQ34Epqyx4dc0gth
         om4nel1RoFf6E8Eb6r55DxKFBm7aDXCQkDwlRiAeo/LUpJQgJ0amSKOIviXzQItZZOur
         iqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Dj6dnw1SSGK0z0yl6jJ2uTtBS6LOewFQlnOBWDc3SWg=;
        b=ojW1V6cGC8uAfkWwZyUH8VtikBBU0glvcG6zMw4URBhUhyU2hEA0BHU35O/ShoijfQ
         2bH5FoXK5Q5rjkWvvwayimRsJEk8GL5SjvrXlvVNS7KyrwtjVz00UwALcI/VO26o8U9z
         LJGdAVs2/oVicC+ol++IzPLoOoNV2Dr0o6kDasYfN+23UPTN+jPqVFujkCJDdceaSeaT
         rgIj8WmAg3BloWzIAwxVweg4EjizP+FIFi1rnp9D+OFYi5YCvRclBCM+nSZVIG7cT6rS
         qa6zFlVaKqkUCaziMFZZsGvH6joAW84ZqA3wkkW/EK4LW5xcB68hQtaN0X5aYmXzEyNk
         RJNw==
X-Gm-Message-State: AOAM530AQ2YsphHfjzFSDVW3FMLnplYJmmfH99DtVsTr1NRUfp04BSGS
        iIvazUOqYfE7xEQeN420w/+ejlQlFYfOZw==
X-Google-Smtp-Source: ABdhPJzF3fXdvzsbcrHyfPMlzhgjHfm67wi5JSAW979oB4n9Hau5vaGRKvg3+pKBywuyTGj6Vn1+jw==
X-Received: by 2002:aa7:8751:: with SMTP id g17mr384012pfo.109.1597956301621;
        Thu, 20 Aug 2020 13:45:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r21sm2855133pjo.39.2020.08.20.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 13:45:00 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:45:00 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Aug 2020 13:44:52 PDT (-0700)
Subject:     Re: [PATCH 0/3] Get cache information from userland
In-Reply-To: <cover.1593766028.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-ec05108e-fd03-44c2-992d-649e967f86f0@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 01:57:52 PDT (-0700), zong.li@sifive.com wrote:
> There are no standard CSR registers to provide cache information, the
> way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
> AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
> could use them to get information of cache through AUX vector. We
> exploit 'struct cacheinfo' to obtain the information of cache, then we
> don't need additional variable or data structure to record it.
>
> We also need some works in glibc, but we have to support the function in
> kernel first by rule of glibc, then post the patch to glibc site.
>
> The result of 'getconf -a' as follows:
>
> LEVEL1_ICACHE_SIZE                 32768
> LEVEL1_ICACHE_ASSOC                8
> LEVEL1_ICACHE_LINESIZE             64
> LEVEL1_DCACHE_SIZE                 32768
> LEVEL1_DCACHE_ASSOC                8
> LEVEL1_DCACHE_LINESIZE             64
> LEVEL2_CACHE_SIZE                  2097152
> LEVEL2_CACHE_ASSOC                 32
> LEVEL2_CACHE_LINESIZE              64
>
> Zong Li (3):
>   riscv: Set more data to cacheinfo
>   riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
>   riscv: Add cache information in AUX vector
>
>  arch/riscv/include/asm/cacheinfo.h   | 14 +++++
>  arch/riscv/include/asm/elf.h         | 13 ++++
>  arch/riscv/include/uapi/asm/auxvec.h | 24 ++++++++
>  arch/riscv/kernel/cacheinfo.c        | 92 +++++++++++++++++++++++-----
>  4 files changed, 127 insertions(+), 16 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cacheinfo.h

Sorry, I lost track of these.  There's a little issue in #1, LMK if you want to
send another version or if you want me to just fix it.
