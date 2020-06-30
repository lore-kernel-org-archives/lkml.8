Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD9CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFD8207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgF3Hwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:52:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:11359 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbgF3Hwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:52:45 -0400
IronPort-SDR: 4uKteS3ft0b/qoHH5vZf6mopGpvd2k4pABT2Kez7Jk/GZDF3ffKAYxppDZqEHdKO0j1LcWPDzf
 CkYCeTMizuYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="164181079"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="164181079"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:52:44 -0700
IronPort-SDR: eGGj2t6g5LUU1YhVwky6xRMNCWEVLwnbATlY9tpArRmc7dT1GHG5j1QV6jPn1Wb22N2/pWvd7O
 F2WuH6iRJGHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="266412260"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.173.186]) ([10.249.173.186])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2020 00:52:41 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Sun, Jian" <jian.sun@intel.com>
Subject: Re: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To:     Koba Ko <koba.ko@canonical.com>
References: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
 <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com>
 <CAJB-X+WgjKR3PgoF_tn_g__+agCSGJpyB8sh+A62gs0qztDuVQ@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <66cacbab-b04d-33f3-053e-4d554ac7c662@linux.intel.com>
Date:   Tue, 30 Jun 2020 15:52:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJB-X+WgjKR3PgoF_tn_g__+agCSGJpyB8sh+A62gs0qztDuVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Koba,

On 2020/6/30 15:31, Koba Ko wrote:
> On Mon, Jun 15, 2020 at 3:20 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi Koba Ko,
>>
>> On 2020/6/15 11:19, Koba Ko wrote:
>>> hi All,
>>> I have a machine and there's only intel gpu.
>>> the secureboot and vt-d is enabled in BIOS.
>>> On the Ubuntu desktop, I do s2idle first and restart the machine.
>>> The machine can't restart successfully, so I need to press the
>>> power button to shutdown.
>>> I tried  each of the following and the issue can't be triggered.
>>> 1. disable secure boot in BIOS.
>>> 2. intel_iommu=off.
>>> 3. intel_iomm=igfx_off.
>>> 4. nomodeset
>>> 5. i915.modeset=0.
>>>
>>> After I investigate further, find inte_iommu keeps checking the status
>>> of DMA_GSTS_TES.
>>> During the procedure of restart, the driver would disable iommu
>>> translation and
>>> check status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
>>>
>>> If you need more information, I can provide it.
>>
>> Do you mind telling what platform is it?
>>
>> Best regards,
>> baolu
> Hi Baolu,
> Sorry, i missed your email.
> I'm running on TGL.
> My colleague has reported this on bugzilla.
> Have tested your patch and it works fine.
> https://bugzilla.kernel.org/show_bug.cgi?id=208363
> 
> Could you explain more about these patches!? Why do we need  a flag
> for active iommu!?
> 

We're still investigating this issue. If we find out more, I'll let you
know. Thanks a lot for the reporting.

Best regards,
baolu

