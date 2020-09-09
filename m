Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD5C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACF7218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Urki6VlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIIIzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:55:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27282 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728207AbgIIIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599641692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1J7anzfs0x90xPTUoNfpAZn+NVUcNxeloajMKaQs88=;
        b=Urki6VlHx0+BoaA6E4yv7jPounS6SUjqhoZWvTB1/qkh22LfxSBQAT4eHhvTysmZV5Htf/
        g1iivHOWK+yio7hUz3/1S8MWsEoApWOY07Z5hMYqfQueKamS6cgvJ3Xbmscg6uUVrgI8BG
        unCeinckDxjNlZ8zb1r8Nd7WQ9ywnbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-V9dOtQlONK2TiuIUhnEkEQ-1; Wed, 09 Sep 2020 04:54:50 -0400
X-MC-Unique: V9dOtQlONK2TiuIUhnEkEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A29B1091061;
        Wed,  9 Sep 2020 08:54:48 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1AFB60C87;
        Wed,  9 Sep 2020 08:54:37 +0000 (UTC)
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To:     Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, wsa+renesas@sang-engineering.com, wsa@kernel.org,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        jdelvare@suse.de, Sergey.Semin@baikalelectronics.ru,
        krzk@kernel.org, rppt@kernel.org, loic.poulain@linaro.org,
        tali.perry1@gmail.com, bjorn.andersson@linaro.org,
        shuo.a.liu@intel.com, conghui.chen@intel.com, yu1.wang@intel.com
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <18828d17-c3ac-31bd-2dcf-ecdbd4ad844e@redhat.com>
 <e63a96bf-65d2-ed03-dadc-42d1d8808c9d@intel.com>
 <3dc0d61c-9345-2b61-828c-89ca96555e5e@redhat.com>
 <c9be298b-c51b-f7f3-994b-b7bd9ae53b99@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f89142e6-a92d-b417-5e1c-bbe813636023@redhat.com>
Date:   Wed, 9 Sep 2020 16:54:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c9be298b-c51b-f7f3-994b-b7bd9ae53b99@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/8 上午9:40, Jie Deng wrote:
>
>
> On 2020/9/7 13:40, Jason Wang wrote:
>>
>>>
>>>
>>>>
>>>>>
>>>>> +struct virtio_i2c_msg {
>>>>> +    struct virtio_i2c_hdr hdr;
>>>>> +    char *buf;
>>>>> +    u8 status;
>>>>
>>>>
>>>> Any reason for separating status out of virtio_i2c_hdr?
>>>>
>>> The status is not from i2c_msg. 
>>
>>
>> You meant ic2_hdr? You embed status in virtio_i2c_msg anyway.
>>
>>
> The "i2c_msg" structure defined in i2c.h.
>
>>> So I put it out of virtio_i2c_hdr.
>>
>>
>> Something like status or response is pretty common in virtio request 
>> (e.g net or scsi), if no special reason, it's better to keep it in 
>> the hdr.
>>
> Mainly based on IN or OUT.
>
> The addr, flags and len are from "i2c_msg". They are put in one 
> structure as an OUT**scatterlist.
> The buf can be an OUT**or an IN scatterlist depending on write or read.
> The status is a result from the backend  which is defined as an IN 
> scatterlis. 


Ok. I get this.

Thanks


