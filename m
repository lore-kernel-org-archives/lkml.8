Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09636C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D2D20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="A2DCqD0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgETWUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETWT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:19:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9950AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:19:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f6so2132536pgm.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ycck34yOE2eI9p8XWX3gxgUmzwvA56jseIW5KzHm0FY=;
        b=A2DCqD0hVrSACeq0opTnEGbqUnFx7U3NbKrctUt8Fdp4HjEK96vLUZVZxbuOjtTdIh
         Pbz3ztBmNqUcs7UitHS3izJWLdMiIMKDqJXpXNRSjufBQx47OoKi653UN/2KthcG2V/X
         Z+DZhrBPirFLJiBzVVneXPrIobV9exvpAXaXk+geGM+UwkNiTYiq2lBellAWSGZN2Mx0
         Y1OEY7xC5wTR0nISpAnvYgG4tb04ZFLjhwfNehfkBo3inxr0c/IMgHFMSFlnIJhcmV/v
         3n+8ZMYs0p/6tXSSAgHWOVyYgbRCG4CYl/HP0ZkXv9ijLS0R2hZdtA/4u+o2fz2pGP84
         FGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ycck34yOE2eI9p8XWX3gxgUmzwvA56jseIW5KzHm0FY=;
        b=K3taOGPZgupTsEWyxGbiWEetEy522BxkhXZY7u7Q0ZwxAjsRmHyB8/CfQPqaq/XmRn
         B4jGuVS106Cd1DfJ/OUTE9O6urgFZxQND/dgXJ2OIEn/50F3aWtGgPpX415oHBaT3XWa
         1KkMZ4Puf2jQ8U1YyOdj/DCsPdk1fEJueoGEkqgqvE/0XE0f7MY8u6bANzRWCKAsejCg
         r/pwHiWzhn3eaQYWO/amiIIIaZ09ROq5mEvGsB8oDV+6FPHelHS7s/D+HpYMxIICmefJ
         gozKwZnxstecIawtEeVmP+PxrmUbDtr0IY0I87rPTmPlyAQAGz6gIKOs4NTcM7iPTl9r
         LtGg==
X-Gm-Message-State: AOAM530mUj+d6VAPEusNpMTzX9V9VxSomEDfBS5YjPOLLdWCNfWVISAa
        w7DNMXJgU2sNLuBbR+HUJcqV0Q==
X-Google-Smtp-Source: ABdhPJzBffw38fH6z7ClizvGlzg2njXTkTLF5T+vdnNSXUq5Ja4qQVrUaZwoxh29v5k8bvkf9BzFUg==
X-Received: by 2002:a62:4e83:: with SMTP id c125mr2021866pfb.165.1590013198938;
        Wed, 20 May 2020 15:19:58 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y4sm2966513pfq.10.2020.05.20.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:19:58 -0700 (PDT)
Date:   Wed, 20 May 2020 15:19:58 -0700 (PDT)
X-Google-Original-Date: Wed, 20 May 2020 15:12:25 PDT (-0700)
Subject:     Re: [PATCH v5 0/2] cacheinfo support to read no. of L2 cache ways enabled
In-Reply-To: <1582175719-7401-1-git-send-email-yash.shah@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, Greg KH <gregkh@linuxfoundation.org>,
        alexios.zavras@intel.com, tglx@linutronix.de, bp@suse.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     david.abdurachmanov@gmail.com, yash.shah@sifive.com
Message-ID: <mhng-2f2a1b1f-278b-4062-82cd-750b4e9f3d55@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 21:15:17 PST (-0800), yash.shah@sifive.com wrote:
> The patchset includes 2 patches. Patch 1 implements cache_get_priv_group
> which make use of a generic ops structure to return a private attribute
> group for custom cacheinfo. Patch 2 implements a private attribute named
> "number_of_ways_enabled" in the cacheinfo framework. Reading this
> attribute returns the number of L2 cache ways enabled at runtime,
>
> This patchset is based on Linux v5.6-rc2 and tested on HiFive Unleashed
> board.
>
> v5:
> - Since WayEnable is 8bits, mask out and return only the last 8 bit in
>   l2_largest_wayenabled()
> - Rebased on Linux v5.6-rc2
>
> v4:
> - Rename "sifive_l2_largest_wayenabled" to "l2_largest_wayenabled" and
>   make it a static function
>
> v3:
> - As per Anup Patel's suggestion[0], implement a new approach which uses
>   generic ops structure. Hence addition of patch 1 to this series and
>   corresponding changes to patch 2.
> - Dropped "riscv: dts: Add DT support for SiFive L2 cache controller"
>   patch since it is already merged
> - Rebased on Linux v5.5-rc6
>
> Changes in v2:
> - Rebase the series on v5.5-rc3
> - Remove the reserved-memory node from DT
>
> [0]: https://lore.kernel.org/linux-riscv/CAAhSdy0CXde5s_ya=4YvmA4UQ5f5gLU-Z_FaOr8LPni+s_615Q@mail.gmail.com/
>
> Yash Shah (2):
>   riscv: cacheinfo: Implement cache_get_priv_group with a generic ops
>     structure
>   riscv: Add support to determine no. of L2 cache way enabled
>
>  arch/riscv/include/asm/cacheinfo.h   | 15 ++++++++++++++
>  arch/riscv/kernel/cacheinfo.c        | 17 ++++++++++++++++
>  drivers/soc/sifive/sifive_l2_cache.c | 38 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
>  create mode 100644 arch/riscv/include/asm/cacheinfo.h

I must have lost track of this one, it's on for-next now.  Thanks to David for
reminding me.
