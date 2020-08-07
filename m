Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55446C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D04E2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkZWRvcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHGD1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:27:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20340 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbgHGD1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596770825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzBVMxtG2p8vYea4PsugHNCB46PX04hMXUf43TE1qM8=;
        b=VkZWRvcEfrNplcAoweCEX+niiIFh67ohVytaIyurCz+miFQCxlhQK9Xf14+GrRIt9O2O2m
        B4v+Z936UJhbwed6wEVLBcqllxBXOWuqggph541tQzqMwy7QudMT7LQvqjWNTnsfVH91jM
        L5LhuD4igpvvlobaA5q1og/qgcBPGoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-Bc6xhlj6Opam2uxRH5xr5Q-1; Thu, 06 Aug 2020 23:27:02 -0400
X-MC-Unique: Bc6xhlj6Opam2uxRH5xr5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC21518C63E7;
        Fri,  7 Aug 2020 03:27:01 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D31B587A66;
        Fri,  7 Aug 2020 03:26:57 +0000 (UTC)
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
 <20200805074434-mutt-send-email-mst@kernel.org>
 <4aa65ad6-5324-0a8c-0fa6-0d8e680f0706@redhat.com>
 <20200806015604-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a4ef115c-f005-fd09-a94f-5b2a004b672b@redhat.com>
Date:   Fri, 7 Aug 2020 11:26:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806015604-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/6 下午1:58, Michael S. Tsirkin wrote:
> On Thu, Aug 06, 2020 at 11:37:38AM +0800, Jason Wang wrote:
>> On 2020/8/5 下午7:45, Michael S. Tsirkin wrote:
>>>>>     #define virtio_cread(vdev, structname, member, ptr)			\
>>>>>     	do {								\
>>>>>     		might_sleep();						\
>>>>>     		/* Must match the member's type, and be integer */	\
>>>>> -		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
>>>>> +		if (!__virtio_typecheck(structname, member, *(ptr)))	\
>>>>>     			(*ptr) = 1;					\
>>>> A silly question,  compare to using set()/get() directly, what's the value
>>>> of the accessors macro here?
>>>>
>>>> Thanks
>>> get/set don't convert to the native endian, I guess that's why
>>> drivers use cread/cwrite. It is also nice that there's type
>>> safety, checking the correct integer width is used.
>>
>> Yes, but this is simply because a macro is used here, how about just doing
>> things similar like virtio_cread_bytes():
>>
>> static inline void virtio_cread(struct virtio_device *vdev,
>>                        unsigned int offset,
>>                        void *buf, size_t len)
>>
>>
>> And do the endian conversion inside?
>>
>> Thanks
>>
> Then you lose type safety. It's very easy to have an le32 field
> and try to read it into a u16 by mistake.
>
> These macros are all about preventing bugs: and the whole patchset
> is about several bugs sparse found - that is what prompted me to make
> type checks more strict.


Yes, but we need to do the macro with compiler extensions. I wonder 
whether or not the kernel has already had something since this request 
here is pretty common?

Thanks


>
>

