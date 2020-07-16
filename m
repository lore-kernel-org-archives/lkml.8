Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B7EC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467D62074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsSYkSC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGPJcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:32:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25049 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbgGPJcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594891971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HM60XLMgdg8Xi8aOyww6UtyARMKxQfyJ5RsQS2i7liw=;
        b=WsSYkSC7vOztTb608Gr5QkH6Z5UY7akD3D7TIQUD943OX0XHCV8Z258RjFQhWGw/A0OeJC
        Q+2+uhPkSI48NITyeY1lrjCHigjhI/p7ycDRvKoEqmiI8hq9eZ+p8GAoZVwZwJCk1th3IM
        Fv/nhdGRUmU8ZeHhR+qZISYdkNh4uY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-lW23ye-FOHabPUgtOU_xMg-1; Thu, 16 Jul 2020 05:32:48 -0400
X-MC-Unique: lW23ye-FOHabPUgtOU_xMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9E5B1005260;
        Thu, 16 Jul 2020 09:32:46 +0000 (UTC)
Received: from [10.72.12.131] (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F01C5C1D2;
        Thu, 16 Jul 2020 09:32:39 +0000 (UTC)
Subject: Re: [PATCH vhost next 09/10] vdpa/mlx5: Add shared memory
 registration code
To:     Eli Cohen <eli@mellanox.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-10-eli@mellanox.com>
 <61765932-5411-9f37-3a4a-ca5ac5daa28e@redhat.com>
 <20200716082840.GB182860@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ad3c6157-2224-8e1f-7afb-deb9b45f568e@redhat.com>
Date:   Thu, 16 Jul 2020 17:32:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716082840.GB182860@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/16 下午4:28, Eli Cohen wrote:
> On Thu, Jul 16, 2020 at 04:13:21PM +0800, Jason Wang wrote:
>> On 2020/7/16 下午3:23, Eli Cohen wrote:
>>> Add code to support registering guest's memory region for the device.
>>
>> It would be better to use "userspace" memory here since vhost-vDPA
>> could be used by e.g dpdk application on the host in the future.
>>
> How about replaciing "guest's memory" with "address space". It is more
> general and aligns with the with the fact that virio driver can run in
> the guest's kernel.


Probably but note that guest driver is not the only user for this. It 
could be either:

1) Guest virtio driver
2) Userspace virtio driver on the host
3) Kernel virtio driver on the host.

Thanks


>

