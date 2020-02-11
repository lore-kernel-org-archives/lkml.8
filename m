Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B4C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E367C20661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBKDfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:35:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:50073 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbgBKDfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:35:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 19:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,427,1574150400"; 
   d="scan'208";a="221791265"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.249.174.64]) ([10.249.174.64])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2020 19:35:43 -0800
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To:     Jason Wang <jasowang@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com,
        qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
Date:   Tue, 11 Feb 2020 11:35:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/11/2020 11:17 AM, Jason Wang wrote:
>
> On 2020/2/10 下午5:05, Zha Bin wrote:
>> From: Liu Jiang<gerry@linux.alibaba.com>
>>
>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
>> virtio over mmio devices as a lightweight machine model for modern
>> cloud. The standard virtio over MMIO transport layer only supports one
>> legacy interrupt, which is much heavier than virtio over PCI transport
>> layer using MSI. Legacy interrupt has long work path and causes specific
>> VMExits in following cases, which would considerably slow down the
>> performance:
>>
>> 1) read interrupt status register
>> 2) update interrupt status register
>> 3) write IOAPIC EOI register
>>
>> We proposed to add MSI support for virtio over MMIO via new feature
>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>
>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
>> uses msi_sharing[1] to indicate the event and vector mapping.
>> Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>
>
> I believe dynamic mapping should cover the case of fixed vector?
>
Actually this bit *aims* for msi sharing or msi non-sharing.

It means, when msi sharing bit is 1, device doesn't want vector per queue

(it wants msi vector sharing as name) and doesn't want a high interrupt 
rate.

So driver turns to !per_vq_vectors and has to do dynamical mapping.

So they are opposite not superset.

Thanks!

Jing


> Thanks
>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
