Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B34C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D401A2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuAsPE19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgBKMEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:04:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55620 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727936AbgBKMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581422677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjQwrMmKYTsdFrSHKfW1siyerTxdkA/ZJqrqrVqTmls=;
        b=YuAsPE195sEZeLQzfUTp9HzuyxS9cRmy/NrFihMqMP4+CbRAuJrzSAOzz2haIogNqKLCe/
        pFIRgeoqDxuWQdW6YLwqXVEl8gYzXdTq+t27Ygliu1ex4gfByTtlYyevYFHY1j/GWpNDGX
        DbR+rsnaoUPQ3/XODj/GUmIZo5okOVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-070av-dGNxCVVe93W4fnVw-1; Tue, 11 Feb 2020 07:04:36 -0500
X-MC-Unique: 070av-dGNxCVVe93W4fnVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A383107ACC9;
        Tue, 11 Feb 2020 12:04:34 +0000 (UTC)
Received: from [10.72.13.150] (ovpn-13-150.pek2.redhat.com [10.72.13.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56C6960BF4;
        Tue, 11 Feb 2020 12:04:25 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Zha Bin <zhabin@linux.alibaba.com>, slp@redhat.com,
        "Liu, Jing2" <jing2.liu@linux.intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
Date:   Tue, 11 Feb 2020 20:04:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200211065319-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/11 =E4=B8=8B=E5=8D=887:58, Michael S. Tsirkin wrote:
> On Tue, Feb 11, 2020 at 03:40:23PM +0800, Jason Wang wrote:
>> On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
>>> On 2/11/2020 12:02 PM, Jason Wang wrote:
>>>> On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>>>>> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>>>>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>>
>>>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take
>>>>>>> advantage of using
>>>>>>> virtio over mmio devices as a lightweight machine model for moder=
n
>>>>>>> cloud. The standard virtio over MMIO transport layer
>>>>>>> only supports one
>>>>>>> legacy interrupt, which is much heavier than virtio over
>>>>>>> PCI transport
>>>>>>> layer using MSI. Legacy interrupt has long work path and
>>>>>>> causes specific
>>>>>>> VMExits in following cases, which would considerably slow down th=
e
>>>>>>> performance:
>>>>>>>
>>>>>>> 1) read interrupt status register
>>>>>>> 2) update interrupt status register
>>>>>>> 3) write IOAPIC EOI register
>>>>>>>
>>>>>>> We proposed to add MSI support for virtio over MMIO via new featu=
re
>>>>>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performanc=
e.
>>>>>>>
>>>>>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio=
 MSI
>>>>>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>>>>>> Bit 1 is 0: device uses non-sharing and fixed vector per
>>>>>>> event mapping.
>>>>>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>>>>> I believe dynamic mapping should cover the case of fixed vector?
>>>>>>
>>>>> Actually this bit*aims*  for msi sharing or msi non-sharing.
>>>>>
>>>>> It means, when msi sharing bit is 1, device doesn't want vector
>>>>> per queue
>>>>>
>>>>> (it wants msi vector sharing as name) and doesn't want a high
>>>>> interrupt rate.
>>>>>
>>>>> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>>>>>
>>>>> So they are opposite not superset.
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Jing
>>>> I think you need add more comments on the command.
>>>>
>>>> E.g if I want to map vector 0 to queue 1, how do I need to do?
>>>>
>>>> write(1, queue_sel);
>>>> write(0, vector_sel);
>>> That's true. Besides, two commands are used for msi sharing mode,
>>>
>>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
>>>
>>> "To set up the event and vector mapping for MSI sharing mode, driver
>>> SHOULD write a valid MsiVecSel followed by
>>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command =
to
>>> map the configuration change/selected queue events respectively.=C2=A0=
 " (See
>>> spec patch 5/5)
>>>
>>> So if driver detects the msi sharing mode, when it does setup vq, wri=
tes
>>> the queue_sel (this already exists in setup vq), vector sel and then
>>> MAP_QUEUE command to do the queue event mapping.
>>>
>> So actually the per vq msix could be done through this. I don't get wh=
y you
>> need to introduce MSI_SHARING_MASK which is the charge of driver inste=
ad of
>> device. The interrupt rate should have no direct relationship with whe=
ther
>> it has been shared or not.
>>
>> Btw, you introduce mask/unmask without pending, how to deal with the l=
ost
>> interrupt during the masking then?
> pending can be an internal device register. as long as device
> does not lose interrupts while masked, all's well.


You meant raise the interrupt during unmask automatically?


>
> There's value is being able to say "this queue sends no
> interrupts do not bother checking used notification area".
> so we need way to say that. So I guess an enable interrupts
> register might have some value...
> But besides that, it's enough to have mask/unmask/address/data
> per vq.


Just to check, do you mean "per vector" here?

Thanks


>
>

