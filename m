Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9206EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7CB207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMNl+3uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFEIyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:54:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726135AbgFEIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591347274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0r/b2eFY9+k9/mVafvta/fNndA6rDDpBttvueSmSAvo=;
        b=iMNl+3uY+6xbsO8RuZ0xqzwOKxT6BTorX1vbNItNsocg7/Ytt8QNuXFNzBYFAvwl1r1gy2
        K0RZlwBaMxVgtOEZL4WgA+TbpX9eNOgcc3OgEynVXdP4WsZ4oS0WCExOVobaaokiifFErF
        UTaPGFaOhTQcs1uJuar2uU7R2r7w21w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-kMNLCwG-MMGG8qw_EOqPGw-1; Fri, 05 Jun 2020 04:54:31 -0400
X-MC-Unique: kMNLCwG-MMGG8qw_EOqPGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B6EC107ACF9;
        Fri,  5 Jun 2020 08:54:28 +0000 (UTC)
Received: from [10.72.12.233] (ovpn-12-233.pek2.redhat.com [10.72.12.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 918D519C58;
        Fri,  5 Jun 2020 08:54:19 +0000 (UTC)
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
 <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
Message-ID: <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
Date:   Fri, 5 Jun 2020 16:54:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/2 下午3:08, Jason Wang wrote:
>>
>>> +static const struct pci_device_id vp_vdpa_id_table[] = {
>>> +    { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
>>> +    { 0 }
>>> +};
>> This looks like it'll create a mess with either virtio pci
>> or vdpa being loaded at random. Maybe just don't specify
>> any IDs for now. Down the road we could get a
>> distinct vendor ID or a range of device IDs for this.
>
>
> Right, will do.
>
> Thanks 


Rethink about this. If we don't specify any ID, the binding won't work.

How about using a dedicated subsystem vendor id for this?

Thanks

