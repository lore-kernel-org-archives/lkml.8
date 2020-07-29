Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F88C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F6C20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596021611;
	bh=sfQo1XYQGZh1YfIaqwIY4uzjVW3dDmUizxnx9/B+Cds=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PonyiWvxBMIXcWnHrIPa1EGWXbfjszzcGbbNOg6cvqRAn3uuE7NXX3NFUXFp3nkSl
	 T59Lg76z7TXCBOguVkS+6gLWEcnju8MQSsEAV0++YdtV7PZZoJnK2BV1yeNlUJ2YcS
	 XbEorHxnrQfjuZe6EBpgKL4u9brXpOSo01nHGvrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgG2LUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:20:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34873 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgG2LUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:20:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id m20so7633462eds.2;
        Wed, 29 Jul 2020 04:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NiS9IH7Od8Q9xbyIfFxNL/qSLHRh5AtTCa5eRtX/6P0=;
        b=Zmy5LvHf6EZfB0YKskh4TRHNgaolaveL99jWlEe2pF1Q7EnWRWklwvfXKhcTfOD820
         TbORY0voLA+wtgW1fWR5aZDgC/1i8fRjBjAtXrESiDxX8ct6Ap96/G6dLK6HX/eZl2vm
         cH73FlZrUok6r1WwTXct4I0j4uJIDok1Hd/tMLlZ4OXkdzyMXWC7GKXOLzUtLWvk0W7d
         Ok4400nhYZXWQqwLonFlcmuNgnbUB9ztUTZLAu7yejYtMFNfwhV32uV3MPaZ2L/zEpBv
         8cCcocxr135coE5UHQ55lkyOF2/7yRHvX5D+2JDrjPhN5vcrsT9TiuELWH9i5lBIQOzd
         a35g==
X-Gm-Message-State: AOAM5320E6g6nNw8zRjgqztYtuPVT6sj6BiI4ww9husibM/rgWu7V1Ky
        SVT1r2Id09+x+A+hg2u0FFBDFtMt
X-Google-Smtp-Source: ABdhPJwEICJkcOEaQN8mut/yS4vwhDihD9l4jxfSgBLLqefKZMf5ENVOkl+EfbA/uvzttuTQQojyGQ==
X-Received: by 2002:aa7:c442:: with SMTP id n2mr29841866edr.309.1596021602580;
        Wed, 29 Jul 2020 04:20:02 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y14sm420978ejr.35.2020.07.29.04.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 04:20:01 -0700 (PDT)
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
To:     =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        b.zolnierkie@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>, Solar Designer <solar@openwall.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        Security Officers <security@kernel.org>,
        linux-distros@vs.openwall.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <c1f267aa-dfb3-91fa-3111-30c1676f1a91@kernel.org>
 <c5a73038-f441-602b-584b-3d84622b1fb1@nsfocus.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <d0cc1f99-1ef0-c7a2-6b42-d25d8fa49f1e@kernel.org>
Date:   Wed, 29 Jul 2020 13:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c5a73038-f441-602b-584b-3d84622b1fb1@nsfocus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 07. 20, 10:19, 张云海 wrote:
> On 2020/7/29 16:11, Jiri Slaby wrote:
>> But the loop checks for the overflow:
>>   if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
>>         vgacon_scrollback_cur->tail = 0;
>>
>> So the first 2 iterations would write to the end of the buffer and this
>> 3rd one should have zeroed ->tail.
> 
> In the 2nd  iteration before the check:
> vgacon_scrollback_cur->tail is 65360 which is still less then
> vgacon_scrollback_cur->size(65440), so the ->tail won't be zeroed.
> 
> Then it gose to the 3rd  iteration, overflow occurs.

Ahh, I see now! So it must be triggered by CSI M instead. It allows for
more than 1 in count. So this is PoC for this case:
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>

int main(int argc, char** argv)
{
        int fd = open("/dev/tty1", O_RDWR);
        unsigned short size[3] = {25, 200, 0};
        ioctl(fd, 0x5609, size); // VT_RESIZE

        write(fd, "\e[1;1H", 6);
        for (int i = 0; i < 30; i++)
                write(fd, "\e[10M", 5);
}

It corrupts memory, so it crashes the kernel randomly. Even with my
before-loop patch.

So now: could you resend your patch with improved commit message, add
all those Ccs etc.? You can copy most of the Ccs from my patch verbatim.

I am also not sure the test I was pointing out on the top of this
message would be of any use after the change. But maybe leave the code
rest in peace.

thanks,
-- 
js
suse labs
