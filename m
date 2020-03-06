Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60852C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311F520848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0qYnrfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFLFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:05:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726025AbgCFLFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583492699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Vd4lXmmBZJECiSqYOl3s7WemhxZZt5CNTvS6vYMPFM=;
        b=O0qYnrfA00r/hwfK4N04o9pNTXF4RkPo1Lo4an4LNx/2Ob+ckI7Ad3zl/Deg2H9DRfm1MJ
        SOb/8yELuwrPG+uPV17dQ3yqKhqnO4tvaIKoOvnt9UoSPN7k1HTk2fsHxlwXM7IW4T2Cj/
        I4va46jcpF05pA9UNXZ5pWNM9nzTBsM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-uEOEPqwgPQKXOaJTZgwA7g-1; Fri, 06 Mar 2020 06:04:55 -0500
X-MC-Unique: uEOEPqwgPQKXOaJTZgwA7g-1
Received: by mail-wm1-f72.google.com with SMTP id f207so744788wme.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 03:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Vd4lXmmBZJECiSqYOl3s7WemhxZZt5CNTvS6vYMPFM=;
        b=rTi24VJVrxxlZcvKVVpAyC0eXqdCdgqq7eWqmhulFKfcjBoDKgNEB3O31/xbReHSSi
         awKWk9M1Nh5l4f5UWN0iV3pObkxASK0LcQqH905AF25v+fbAN9wcTpYhekQOrZJ0LmiU
         vR8a3I1ai1IuSQsK3ENevAAM2MCCRZnUSoHM0EBQdt4+ZrcKXKj/5pcXOtUFISNGDdkw
         y6RkhMmQRZ0iMeOI3XeZ7CVsBf47CZ1z1FLt2MTxpciiuBYDK8bUhHGC2FnvnN8wGYTz
         PO8hA4M2Dze97EnUoCm8ghvFTvx/yUZKMZtb9MG14m19xrZPi8sRf2oiMVT84FuYkPCB
         FjJg==
X-Gm-Message-State: ANhLgQ3AQliQAk23IUbRC4uIaGRyuHBGMdJkB+JuchkeyKBAm7Hw2zGD
        aD/rJFmJP6hR132ujkjesezfAZ4t15SrQJiEf6gZ+cDcTzVm09HNFw0rrbDHKwFM5U6P7J51xKg
        HaDAIOfd6+1E2tLyNibSqlD93
X-Received: by 2002:a05:600c:581:: with SMTP id o1mr3507752wmd.8.1583492693970;
        Fri, 06 Mar 2020 03:04:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu7+UUGyrJbYNEJnOT9VcmpJO5hckGHBjC0pdy9GLX2QkWv1D5IkKHrCWu6PX+2j4ofwCJ6FQ==
X-Received: by 2002:a05:600c:581:: with SMTP id o1mr3507730wmd.8.1583492693730;
        Fri, 06 Mar 2020 03:04:53 -0800 (PST)
Received: from x1.localdomain ([2a0e:5700:4:11:42c0:3c5d:2f33:1a6c])
        by smtp.gmail.com with ESMTPSA id v16sm31228537wrp.84.2020.03.06.03.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 03:04:53 -0800 (PST)
Subject: Re: [PATCH][next] drm/vboxvideo/vboxvideo.h: Replace zero-length
 array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200305105558.GA19124@embeddedor>
 <8e2ab9a2-fb47-1d61-d09c-0510ad5ee5ff@redhat.com>
 <20200306104118.GV2363188@phenom.ffwll.local>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b6b0d74d-f08a-e5af-b17c-899d6d6da487@redhat.com>
Date:   Fri, 6 Mar 2020 12:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306104118.GV2363188@phenom.ffwll.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/6/20 11:41 AM, Daniel Vetter wrote:
> On Thu, Mar 05, 2020 at 03:22:38PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 3/5/20 11:55 AM, Gustavo A. R. Silva wrote:
>>> The current codebase makes use of the zero-length array language
>>> extension to the C90 standard, but the preferred mechanism to declare
>>> variable-length types such as these ones is a flexible array member[1][2],
>>> introduced in C99:
>>>
>>> struct foo {
>>>           int stuff;
>>>           struct boo array[];
>>> };
>>>
>>> By making use of the mechanism above, we will get a compiler warning
>>> in case the flexible array does not occur last in the structure, which
>>> will help us prevent some kind of undefined behavior bugs from being
>>> inadvertently introduced[3] to the codebase from now on.
>>>
>>> Also, notice that, dynamic memory allocations won't be affected by
>>> this change:
>>>
>>> "Flexible array members have incomplete type, and so the sizeof operator
>>> may not be applied. As a quirk of the original implementation of
>>> zero-length arrays, sizeof evaluates to zero."[1]
>>>
>>> This issue was found with the help of Coccinelle.
>>>
>>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>>> [2] https://github.com/KSPP/linux/issues/21
>>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>
>> Patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> You're also going to push this? r-b by maintainers without any hint to
> what's going to happen is always rather confusing.

Sorry about that, atm I'm on the road which makes pushing things somewhat
inconvenient, so if someone else can push this, that would be great.

Regards,

Hans





>>> ---
>>>    drivers/gpu/drm/vboxvideo/vboxvideo.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo.h b/drivers/gpu/drm/vboxvideo/vboxvideo.h
>>> index 0592004f71aa..a5de40fe1a76 100644
>>> --- a/drivers/gpu/drm/vboxvideo/vboxvideo.h
>>> +++ b/drivers/gpu/drm/vboxvideo/vboxvideo.h
>>> @@ -138,7 +138,7 @@ struct vbva_buffer {
>>>    	u32 data_len;
>>>    	/* variable size for the rest of the vbva_buffer area in VRAM. */
>>> -	u8 data[0];
>>> +	u8 data[];
>>>    } __packed;
>>>    #define VBVA_MAX_RECORD_SIZE (128 * 1024 * 1024)
>>>
>>
> 

