Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4D1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563AB20658
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVDIPQj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgDBK6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:58:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54743 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgDBK6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:58:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so2898140wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=47lPMSxdt4f25c5HwPuDBnuxGeMfln6TbzT50KS/Jbs=;
        b=hVDIPQj6XR3HIdYvciCYuMFsrUmHZxXhV6ruRRBRtp4dFH5YOz2uNY5BFXbL7ci2BH
         FU9HaQCVe4R0FWsf7owA34pkFkKL4KH1ipmazO6g+JK8/2Hljc8+PPFZilBSJ1EfOoCj
         1yIBeZ+mRXeUkamn0beQQDZ6hz/V9FMAk3hassXm9QCJPzg5srzybvV/C431NZST8qJN
         PpGkPwlNPC+HTN5NSq2ObcO3rw1FXIpbd4xL4tS6ImtuUCWanwIhkx5/UD5/6mHDCuL3
         YmADwQ0Px3gDTQMKNjRk6oparIE2hnupgR7J/MQA74t5PDjM/cUsrGuGq1MsahIU4eyU
         AjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=47lPMSxdt4f25c5HwPuDBnuxGeMfln6TbzT50KS/Jbs=;
        b=QmRWhL/jplv4h7NlsxR+xVUs/VEwijx5rYs4V16486rilp33Xn14NP0Fh6PRzFX3U9
         LGY3odW4d98UElE8ndKf5aRzhtYkzpY3l/+fJzd66CFVOtogzDlRsuTm+iduwnbgoib8
         oXoacYIJ4d+GBUFUoasHvCjn7EhR72eRlhFj0zf6Qms/zi9RdRZ1hEcGWNiJGONeWPOe
         Bg2m6pWoi5uC/Gom/oi5iJkDaX85Dmk6mF7cLQV4skpjjdboiK3SDhoJNWotg440/Y94
         /HhR/HUIqplTiBADL+GajcOvSORG99/fW0CXG/ZoDHOQ1eX0z8Fc/ctyvLDKHFFvkO7H
         MqDQ==
X-Gm-Message-State: AGi0Pub3QdcZsBOkFPnyLK0MUv/+nixDMC9fDtsv0Pf1bs/qV477NJU+
        PyE/WGjD2HJe0S0PLzRMK8QPSU7K
X-Google-Smtp-Source: APiQypJDMD2R5sy9cmmW9jv7KH6/ZHSS+ZHR7n3THuS5LV/L2636pPzidXXzYATmE1MbqnlSClOJvw==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr2906449wmj.139.1585825090573;
        Thu, 02 Apr 2020 03:58:10 -0700 (PDT)
Received: from [192.168.43.227] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id j6sm7406601wrb.4.2020.04.02.03.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 03:58:09 -0700 (PDT)
Subject: Re: [PATCH] staging: vt6656: Use defines in vnt_mac_reg_bits_*
 functions
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Oscar Carter <oscar.carter@gmx.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200328095433.7879-1-oscar.carter@gmx.com>
 <20200331102906.GA2066@kadam> <20200401165537.GC3109@ubuntu>
 <20200402091917.GA17323@jiffies>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <4e5fc495-9355-02b7-4148-ea4de5370617@gmail.com>
Date:   Thu, 2 Apr 2020 11:58:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402091917.GA17323@jiffies>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/04/2020 10:19, Quentin Deslandes wrote:
> On 04/01/20 18:55:38, Oscar Carter wrote:
>> On Tue, Mar 31, 2020 at 01:29:06PM +0300, Dan Carpenter wrote:
>>> On Sat, Mar 28, 2020 at 10:54:33AM +0100, Oscar Carter wrote:
>>>> Define the necessary bits in the CHANNEL, PAPEDELAY and GPIOCTL0
>>>> registers to can use them in the calls to vnt_mac_reg_bits_on and
>>>> vnt_mac_reg_bits_off functions. In this way, avoid the use of BIT()
>>>> macros and clarify the code.
>>>>
>>>> Fixes: 3017e587e368 ("staging: vt6656: Use BIT() macro in vnt_mac_reg_bits_* functions")
>>>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
>>>> ---
>>>>   drivers/staging/vt6656/baseband.c |  6 ++++--
>>>>   drivers/staging/vt6656/card.c     |  3 +--
>>>>   drivers/staging/vt6656/mac.h      | 12 ++++++++++++
>>>>   drivers/staging/vt6656/main_usb.c |  2 +-
>>>>   4 files changed, 18 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
>>>> index a19a563d8bcc..dd3c3bf5e8b5 100644
>>>> --- a/drivers/staging/vt6656/baseband.c
>>>> +++ b/drivers/staging/vt6656/baseband.c
>>>> @@ -442,7 +442,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
>>>>   		if (ret)
>>>>   			goto end;
>>>>
>>>> -		ret = vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
>>>> +		ret = vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY,
>>>> +					  PAPEDELAY_B0);
>>>
>>> This doesn't clarify anything.  It makes it less clear because someone
>>> would assume B0 means something but it's just hiding a magic number
>>> behind a meaningless define.  B0 means BIT(0) which means nothing.  So
>>> now we have to jump through two hoops to find out that we don't know
>>> anything.
>>>
>> I created this names due to the lack of information about the hardware. I
>> searched but I did not find anything.
>>
>>> Just leave it as-is.  Same for the rest.
>> Ok.
>>
>>>
>>> There problem is a hardware spec which explains what this stuff is.
>>>
>> It's possible to find a datasheet of this hardware to make this modification
>> accordingly to the correct bit names of registers ?
> 
> I haven't found any so far, if your researches are luckier than mine, I
> would be interested too. Even getting your hands on the actual device is
> complicated.

All I can tell you is it related to command above it MAC_REG_ITRTMSET 
without it the device will not associate with access point is probably 
TX timing/power rated.

Other bits in MAC_REG_PAPEDELAY are related to LED function and defined 
in LEDSTS_* in mac.h.

I think it is some kind of enable so something like ITRTMSET_ENABLE 
would do.

Regards

Malcolm
