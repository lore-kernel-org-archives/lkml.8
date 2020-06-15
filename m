Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0364FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8C2206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgFOHUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:20:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:46777 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgFOHUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:20:06 -0400
IronPort-SDR: N33jDiy6WlRnjBigzHEbGB1ze3x9aiOb6JyNGy3os0Hsg3qQ4RN2XKSZXsMRBXVKWGG40qxe4D
 m/ld/TkDIGmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 00:20:05 -0700
IronPort-SDR: pVjKcvD5DUuXyhgZT/+naM0K/wlrsMopD51B8UUhQTP3hZZFhEZH31f+pgYgEtpm5B0DDhvfBj
 ZNbGfr7bb5DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="382433255"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.172.204]) ([10.249.172.204])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 00:20:03 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Sun, Jian" <jian.sun@intel.com>
Subject: Re: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To:     Koba Ko <koba.ko@canonical.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com>
Date:   Mon, 15 Jun 2020 15:20:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Koba Ko,

On 2020/6/15 11:19, Koba Ko wrote:
> hi All,
> I have a machine and there's only intel gpu.
> the secureboot and vt-d is enabled in BIOS.
> On the Ubuntu desktop, I do s2idle first and restart the machine.
> The machine can't restart successfully, so I need to press the 
> power button to shutdown.
> I tried  each of the following and the issue can't be triggered.
> 1. disable secure boot in BIOS.
> 2. intel_iommu=off.
> 3. intel_iomm=igfx_off.
> 4. nomodeset
> 5. i915.modeset=0.
> 
> After I investigate further, find inte_iommu keeps checking the status 
> of DMA_GSTS_TES.
> During the procedure of restart, the driver would disable iommu 
> translation and
> check status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
> 
> If you need more information, I can provide it.

Do you mind telling what platform is it?

Best regards,
baolu
