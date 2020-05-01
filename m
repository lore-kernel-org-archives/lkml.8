Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C864DC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 09:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D43B20731
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 09:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP8zzJ0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgEAJCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 05:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgEAJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 05:02:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD3C035495
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 02:02:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l20so4308696pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3Ysbis/inrfbBoA8BHLbvKshdlzgqGs68fIPEsHEVg=;
        b=eP8zzJ0a/Hmxxv5G2MaxHN/LWkzXcKt9XG/Dkv5ekKbIOKKvJns/1BXUiUvN6wBFR1
         ubq6YddXMtvjXmTLTdz2/V79yjXk6Jcz8rG/1h2spbuEE705AGdFp5QJ+sjjfJukGYup
         tqCILrFlD2kfAciwlWW5qH3SyEn4KpUe+4gHFU/LQwQFix0zCmFoB/0ILU4+KHaUKqSr
         6ppcJC24WyNXNI0Jy6GZSjwMK2NWCWmJ06Vp/4ZGELxAfSLtCXCMHRaDuLVwHcF75KTW
         qhDuhgJO4bXNK61Ji7BmtVdVywwIl4sPbL1pdfgXXDxPYSeWCQyZrverPp90pUs70n/1
         /WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3Ysbis/inrfbBoA8BHLbvKshdlzgqGs68fIPEsHEVg=;
        b=Jn2m/GimktFTSpednsDTNbokzrKB4VKXFZ3XpAtLyuEKrSgMw1BGa/hpHPY0wzrqH8
         mXSc1wm0JIfFF/89OUXRKd+4R+tJ+OOMhFs7TMxlMsjP2+kZfzv6DG8oIvkT7qTXzBA/
         GbhPFW4X4Tv+FeFS6Sxq9FzBuFMAUyoZMt3Nuvk9nD7ecOIcFebpDEEJt3K9wgpEzHFS
         whblhaSf1GUJP42FWVtE7Mf3JXGNzZcl9EltcDCI29O3G2p85vBWG/VIUijo8309MOh0
         s9Yy9IP9wLjpJi4B95/G11xybsQ088HElAENBMGRD7MTc9pnUG75jaa+86oISgIT8wzM
         9o1A==
X-Gm-Message-State: AGi0Pubkk2+EKO3E4LjFeDipxT6AvD0uSxcpJVOaWzOOeYK01I+qeyet
        kRGMSbdvXuGrHUA1ZdEImGJZ1txMtAv5/uGbV5Y=
X-Google-Smtp-Source: APiQypJLo1nGAOOIWllcnXFOKuucbQaa8VZAHPvXQvNynJ2CUHJzn4/TY0TzKEEla2OjP3Wo0iR/lsY0rp2wUCMCZpw=
X-Received: by 2002:a63:d3:: with SMTP id 202mr3124152pga.378.1588323750902;
 Fri, 01 May 2020 02:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200430203845.582900-1-ira.weiny@intel.com> <20200501084634.GH27858@infradead.org>
In-Reply-To: <20200501084634.GH27858@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 1 May 2020 02:02:19 -0700
Message-ID: <CAMo8Bf+Mvvg_f1-33iQhTqZPVw1civX94KS2mf4uSkcpEVx55Q@mail.gmail.com>
Subject: Re: xtensa question, was Re: [PATCH V1 00/10] Remove duplicated kmap code
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ira.weiny@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, May 1, 2020 at 1:46 AM Christoph Hellwig <hch@infradead.org> wrote:
> any idea why xtensa uses PAGE_KERNEL_EXEC instead of PAGE_KERNEL
> for kmap_prot?  Mapping all mapped highmem as executable seems rather
> dangerous.

I sure do: to allow instruction cache flushing when writing to high user
pages temporarily mapped with kmap. Instruction cache management
opcodes that operate on virtual addresses would raise an exception if
the address is not executable.

-- 
Thanks.
-- Max
