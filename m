Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BBFC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F53B2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD2HBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:01:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:42563 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgD2HBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:01:21 -0400
IronPort-SDR: lZ3219YFCMq0Em6g3ODZ4xcW7vqiOHIOctgQM89qBUQw7+ZJC5QJyMX9lOk3OV2kBgKy+wHJkA
 jsbA0lY83yRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 00:01:20 -0700
IronPort-SDR: 4DvuVAJfnwee41/vUOY7D8kJA2vxdQDguCSVgDEfD+VPgf23D9je1CKT13vT2xgvP4h9E5vTMK
 lf2m1SGXRZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="404952135"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.254]) ([10.254.210.254])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2020 00:01:15 -0700
Cc:     baolu.lu@linux.intel.com,
        Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
        konrad.wilk@oracle.com, jan.kiszka@siemens.com,
        jasowang@redhat.com, christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
To:     "Michael S. Tsirkin" <mst@redhat.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <80a3a471-0a2c-3ab3-529c-1b8b624679f8@linux.intel.com>
Date:   Wed, 29 Apr 2020 15:01:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429023842-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/29 14:50, Michael S. Tsirkin wrote:
> On Wed, Apr 29, 2020 at 01:42:13PM +0800, Lu Baolu wrote:
>> On 2020/4/29 12:57, Michael S. Tsirkin wrote:
>>> On Wed, Apr 29, 2020 at 10:22:32AM +0800, Lu Baolu wrote:
>>>> On 2020/4/29 4:41, Michael S. Tsirkin wrote:
>>>>> On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
>>>>>> * Michael S. Tsirkin<mst@redhat.com>   [2020-04-28 12:17:57]:
>>>>>>
>>>>>>> Okay, but how is all this virtio specific?  For example, why not allow
>>>>>>> separate swiotlbs for any type of device?
>>>>>>> For example, this might make sense if a given device is from a
>>>>>>> different, less trusted vendor.
>>>>>> Is swiotlb commonly used for multiple devices that may be on different trust
>>>>>> boundaries (and not behind a hardware iommu)?
>>>>> Even a hardware iommu does not imply a 100% security from malicious
>>>>> hardware. First lots of people use iommu=pt for performance reasons.
>>>>> Second even without pt, unmaps are often batched, and sub-page buffers
>>>>> might be used for DMA, so we are not 100% protected at all times.
>>>>>
>>>> For untrusted devices, IOMMU is forced on even iommu=pt is used;
>>> I think you are talking about untrusted*drivers*  like with VFIO.
>> No. I am talking about untrusted devices like thunderbolt peripherals.
>> We always trust drivers hosted in kernel and the DMA APIs are designed
>> for them, right?
>>
>> Please refer to this series.
>>
>> https://lkml.org/lkml/2019/9/6/39
>>
>> Best regards,
>> baolu
> Oh, thanks for that! I didn't realize Linux is doing this.
> 
> So it seems that with modern Linux, all one needs
> to do on x86 is mark the device as untrusted.
> It's already possible to do this with ACPI and with OF - would that be
> sufficient for achieving what this patchset is trying to do?

Yes.

> 
> Adding more ways to mark a device as untrusted, and adding
> support for more platforms to use bounce buffers
> sounds like a reasonable thing to do.
> 

Agreed.

Best regards,
baolu
