Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F41BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 12:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539062075B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 12:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2vTzVx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGMDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 07:03:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgCGMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 07:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583582621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUukN5YqJY/S454IY2OKTFidd3uQ3MfuvVzq3/Fu8So=;
        b=S2vTzVx4cTGJ4FwgPRP6hLR/oQDaPcZMHVWUTAA5YwG0sySWF2ovMklqNMw65NdvCI7WQv
        g4CTbnKz1W5wQgwlrRqluuewdjZM+93v5gHFPLSoiT82d7kNffwa3KOFYH674ZrL7lexhd
        BlW75y4NTv9vJg1xXuriXd6M4mVKx48=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-pQwfmBxmMO-ujxHTSmWIsA-1; Sat, 07 Mar 2020 07:03:37 -0500
X-MC-Unique: pQwfmBxmMO-ujxHTSmWIsA-1
Received: by mail-wr1-f69.google.com with SMTP id n12so2321487wrp.19
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 04:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUukN5YqJY/S454IY2OKTFidd3uQ3MfuvVzq3/Fu8So=;
        b=bg7ZB8LLUqeRC/a/Z+D3UIRH+zdwdgt1YX0UPYiyO70jiLsPSoPacn3FVYuWJGpmVI
         +NHT+INchkHaXrEXBGDEGdLHC2ngnIlRX0BBQQY9Sbu/VKdnP0YfCGgzE3BrDGcUxJM8
         QVAlcOArDibxJHsXHJ/z5Bx3I++A21NETmivZZOpAmr3YZa3ZkSk2pbGobChpzBV39ft
         7vzIFu9FrhDCu5BcS+7J0BgbysaZ+yN3hTsUAOb+7wuMCq4xdBnbscBbDc9uGEA8h4n4
         JjRs7A7OsH79ns7W+puTIOntypmjs59S81dLChNd/rIVADmA77q6xqXd5DE/g+0ZO2Vs
         W+zg==
X-Gm-Message-State: ANhLgQ2utLI6N3XspflB8jf6bM1d4nGncKkQXmPQau2uUGKJIThDKYeb
        Ro2gRwXhNYo4aT/4XRStcux2K/wJdMKNV76fjNDGD3ibBiulp+wdIHjayyuhMkVGNtT/PELOYyn
        GtaeKKdF6VCFNaul91morH1yQ
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr2854992wrp.214.1583582615458;
        Sat, 07 Mar 2020 04:03:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtzB8xe/uIZ14rpqcoUTPZsdHikyLwdsuXPODIXDnw8js25x5XEh+do1YNn/zatTaheRRd75g==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr2854975wrp.214.1583582615201;
        Sat, 07 Mar 2020 04:03:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id m3sm33958379wrx.9.2020.03.07.04.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 04:03:34 -0800 (PST)
Subject: Re: [PATCH][next] drm/vboxvideo/vboxvideo.h: Replace zero-length
 array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200305105558.GA19124@embeddedor>
 <8e2ab9a2-fb47-1d61-d09c-0510ad5ee5ff@redhat.com>
 <20200306104118.GV2363188@phenom.ffwll.local>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2bc072ea-9e18-2d2c-8427-80a721f8750e@redhat.com>
Date:   Sat, 7 Mar 2020 13:03:33 +0100
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

I've pushed this now, sorry for the confusion I will be more
clear about my intentions next time.

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

