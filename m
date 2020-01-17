Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145A1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC29D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUxmebV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAQJfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:35:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31909 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgAQJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579253703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nu3Vp7+fg9qn8Lm5n1B7l7mycGGYWiANJs0CEehFMnI=;
        b=iUxmebV94r7vENVUyxQA32WDcllFl3MS3GpwAtFShfrYbyYZf+TBF8qs0NtOdWteNqbXUv
        XhFC54mpxn/NXofcJHnvqdpGaBAeQpAJlyNBKOJJ/dPss0yABAskl4g0J/c9cbkVmd6p4K
        9upUPQFRG/OZ9aawJRKH9hwdP0KWuV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-DhT6pOBPNFqi9OWJQVeXoQ-1; Fri, 17 Jan 2020 04:35:01 -0500
X-MC-Unique: DhT6pOBPNFqi9OWJQVeXoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B7918C35A2;
        Fri, 17 Jan 2020 09:34:58 +0000 (UTC)
Received: from [10.72.12.168] (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7EB05C3FA;
        Fri, 17 Jan 2020 09:34:35 +0000 (UTC)
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
To:     Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org,
        aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <3d0951af-a854-3b4a-99e4-d501a7fa7a9c@infradead.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6388c5ca-0b42-29ec-0fcd-e720651972d1@redhat.com>
Date:   Fri, 17 Jan 2020 17:34:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d0951af-a854-3b4a-99e4-d501a7fa7a9c@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/1/17 =E4=B8=8B=E5=8D=8812:16, Randy Dunlap wrote:
> On 1/16/20 4:42 AM, Jason Wang wrote:
>> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
>> new file mode 100644
>> index 000000000000..3032727b4d98
>> --- /dev/null
>> +++ b/drivers/virtio/vdpa/Kconfig
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config VDPA
>> +	tristate
>> +        default n
>> +        help
>> +          Enable this module to support vDPA device that uses a
> 	                                        devices
>
>> +          datapath which complies with virtio specifications with
>> +          vendor specific control path.
>> +
> Use tab + 2 spaces for Kconfig indentation.


Will fix.

Thanks

>

