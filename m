Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E374CC33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A882620661
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL/rOhBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgBAAQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:16:49 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:42216 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgBAAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:16:49 -0500
Received: by mail-io1-f41.google.com with SMTP id n11so10244799iom.9;
        Fri, 31 Jan 2020 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=evgn2eCStl1u1DSxLMmu7UxGUG0Z10tWNwwr+UMqyok=;
        b=TL/rOhBGaZQlymYYnnrtCuhEk2uRZVoNN7xJ77z2CRAG8btVymOfnBs+XzBYfuuL28
         gJr1Mrb7jFmCFS8QMtjmxWNgT1PWT+s8vHGST+j4NZDWPNhHuqeo1nlTVwjOiCrhvFHe
         MlWO5obHA7xodNRq9rrv5VzWsvJM4Bw0s8w42SBBn22R4coc0532CmSPIxPWm53VmVOv
         5ehwOdn/kO5N3cfQQNIJLud6pBN7/u18uEhYncF485l+Lu1SqVMKJ3Qk2hhAHPfh/AWv
         NVBNS3EAsnfjitJUZBD0hsoZGVC0p8kVQbilk0cwWZwVyeeInEXm3OIT5y/iMNSi5YHC
         smdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=evgn2eCStl1u1DSxLMmu7UxGUG0Z10tWNwwr+UMqyok=;
        b=aY9RLUI+5hGRtTo0aIoIw6ZlXdEbAVnWUGEawhq81AUMLe0fGw8xNBojh3+R1HtHu6
         eO57Kq6LroRhzRYXEg5QvZBSucBDLFICBRc4EwSXfiqLUgqArVwDSeWv2hJAHIaYm401
         gfTh5kCENYqieRnRFgudXohmhWZn/WkEc2ora2ax9fYOe3/thpz7mi3Mww71aBWacLbD
         9a3/BVblUQUP0O9yRF67Cx9Tk7qV//T4xfGnmGOitO+iEbMoQ+u6RY0sk5VPTYeqraYi
         o4ARwOtcDrrJrTsyoZ9TwPL8qjZDxhBJygbRZuSwbWiF1ysuD/bp6gSNMuVlO1m+CvoM
         FXSg==
X-Gm-Message-State: APjAAAWe6mgozMUwpoZ2preClJx7o9TNtcJfXteqI1rJHYC1QA19jGOm
        +5qwFe6irTIVlqTGykiyVJxWl0dxArTKCOS/JokqDA==
X-Google-Smtp-Source: APXvYqwdlsY8xm4HxxUhuH/6AkHkAObH84Ke0QzrFR7Um5U2yrhdzUAd9/CVTkwmsCOVeQ47W1P8psBg0kxetXLT1/Q=
X-Received: by 2002:a6b:7310:: with SMTP id e16mr10721685ioh.107.1580516208390;
 Fri, 31 Jan 2020 16:16:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:2c07:0:0:0:0:0 with HTTP; Fri, 31 Jan 2020 16:16:47
 -0800 (PST)
In-Reply-To: <20200131223547.GA7334@amd>
References: <CAKR_QVLJZPDfjbQ4CBDv62ok0qG4jq_M_Baq6eaot6GzrKMMwA@mail.gmail.com>
 <20200131223547.GA7334@amd>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Sat, 1 Feb 2020 01:16:47 +0100
Message-ID: <CAKR_QVLKtkfVy5AAKj+ay0cQ2NPWrW7CPb8SGF6urD2ooM=VXQ@mail.gmail.com>
Subject: Re: [RFC] why do sensors break CPU scaling
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lm-sensors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2020, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2019-11-20 21:42:12, Tom Psyborg wrote:
>> Hi
>>
>> Recently I've needed to set lowest CPU scaling profile, running ubuntu
>> 16.04.06 I used standard approach - echoing powersave to
>> /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor.
>> This did not work as the
>> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq kept returning
>> max scaling freq.
>
> Noone noticed, right?
>
> If you still believe that's problem, you may want to look at
> MAINTAINERS file, and put sensors maintainers in the Cc list.
>
> Best regards,
> 									Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>

it is definitely a problem. i've installed radeon-profile and can
monitor both CPU and GPU temps from there without CPU scaling
breakage. CCing related list
