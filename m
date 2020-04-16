Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1310AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 04:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B6D2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 04:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wydQ1wV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404177AbgDPEZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403897AbgDPEZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:25:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F7C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 21:25:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z9so830336pjd.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 21:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rKdwxJq97I01y7ryQhSihbE5DvwLxtqugoVKkJX3ixQ=;
        b=wydQ1wV/OhVMd3QRFRKKNzkbsnXsrk7VwwEFQLbqM5ghK2myZ3rUwtN43+86ag5Yt2
         TOVAOmy3v83wlL5xBTadZIUPf+hW0tBsAuWepalWfrbGXhvYreeXUsNypMLEaIpgpwvr
         PdXGZjbSqpgXelubvmrELN3048hxl5mUCg3NnN2b4krIxxmP0EodZKg13/EFYF9wHYZu
         th6OcVEd1GYkAlpaK0/CDS+PavGH/YJhb9gM6FMd2Hn30UAhBpPttl/yVOnQckXFs1+9
         ByjKBlDgOAaMd4fSyIWUuB3lXPe1GalgZBYhX0Jk2ev8iAwwfXtj7rBzBsG2jmmx/old
         tBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rKdwxJq97I01y7ryQhSihbE5DvwLxtqugoVKkJX3ixQ=;
        b=ecuUcDQfvc0fSgHz3lFOTuZwe8iioSm9Zlw6sUJGriNXILk4AXwNrh96Tppm3nK/l6
         yxDgpF3NI3bR8eI3kBBSYVT6yo5ydVUQ1wnhwlXOakjeZiKLg2I8607rsN8NgQo4V6GC
         U2J0GuAVcvbGzBQ1WQ6Fn617qOzU1a3bIcuo+pXwr0m00bHKpteBR5VX5UnODyKJ8QYq
         2Xoad7jCW3HvX+eZIemLiVrIQ55DWnNsVxYH9vclYf9iuFppgXDkWb18vNDxJXbx8WB+
         mA2+vXumBY7z+ODgBVbnWbS5Y2q4MNpfuAjD4f6Ddv7EZA7cn57oo7o97DKTMmB5Ykh+
         fWGg==
X-Gm-Message-State: AGi0PuY9xirsB3dzejiAP8jOJcBO32DvCzf1O2At7kpavk1QvX4KHP7v
        Mq4/UQdH2rU1xsm+tD4k6smhIA==
X-Google-Smtp-Source: APiQypIcBT/ktZ74DASZLCa7QPuT/QUI+4S8qRnrlE/V9pcUl97OuPwTBQpFJ7Cl/s+5dnZ05jLWvw==
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr2650982pjb.96.1587011147553;
        Wed, 15 Apr 2020 21:25:47 -0700 (PDT)
Received: from [10.129.0.126] ([45.135.186.84])
        by smtp.gmail.com with ESMTPSA id e29sm10568241pgn.57.2020.04.15.21.25.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 21:25:47 -0700 (PDT)
Subject: Re: [PATCH v11 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
        joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com
Cc:     jean-philippe@linaro.org, shameerali.kolothum.thodi@huawei.com,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, peter.maydell@linaro.org, tn@semihalf.com,
        bbhushan2@marvell.com
References: <20200414150607.28488-1-eric.auger@redhat.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <eb27f625-ad7a-fcb5-2185-5471e4666f09@linaro.org>
Date:   Thu, 16 Apr 2020 12:25:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200414150607.28488-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/14 下午11:05, Eric Auger wrote:
> This version fixes an issue observed by Shameer on an SMMU 3.2,
> when moving from dual stage config to stage 1 only config.
> The 2 high 64b of the STE now get reset. Otherwise, leaving the
> S2TTB set may cause a C_BAD_STE error.
>
> This series can be found at:
> https://github.com/eauger/linux/tree/v5.6-2stage-v11_10.1
> (including the VFIO part)
> The QEMU fellow series still can be found at:
> https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6
>
> Users have expressed interest in that work and tested v9/v10:
> - https://patchwork.kernel.org/cover/11039995/#23012381
> - https://patchwork.kernel.org/cover/11039995/#23197235
>
> Background:
>
> This series brings the IOMMU part of HW nested paging support
> in the SMMUv3. The VFIO part is submitted separately.
>
> The IOMMU API is extended to support 2 new API functionalities:
> 1) pass the guest stage 1 configuration
> 2) pass stage 1 MSI bindings
>
> Then those capabilities gets implemented in the SMMUv3 driver.
>
> The virtualizer passes information through the VFIO user API
> which cascades them to the iommu subsystem. This allows the guest
> to own stage 1 tables and context descriptors (so-called PASID
> table) while the host owns stage 2 tables and main configuration
> structures (STE).
>
>

Thanks Eric

Tested v11 on Hisilicon kunpeng920 board via hardware zip accelerator.
1. no-sva works, where guest app directly use physical address via ioctl.
2. vSVA still not work, same as v10,
3.  the v10 issue reported by Shameer has been solved,  first start qemu 
with  iommu=smmuv3, then start qemu without  iommu=smmuv3
4. no-sva also works without  iommu=smmuv3

Test details in https://docs.qq.com/doc/DRU5oR1NtUERseFNL

Thanks
