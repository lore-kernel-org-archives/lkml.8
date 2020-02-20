Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BC2C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6075A24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBTIIR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:08:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35761 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgBTIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:08:16 -0500
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4gsX-0001GT-LA
        for linux-kernel@vger.kernel.org; Thu, 20 Feb 2020 08:08:13 +0000
Received: by mail-pl1-f198.google.com with SMTP id h8so1775135plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ap9U+phFzhqWDo4fgbwK0bHCPUbHZGx2Chn9f/utSqE=;
        b=adQNWT5pv6twjhGFYQi25oZ9TWtPASIL9dTJXwbWexeuqaZi1qlRtmFQ7dxvU+l5Ej
         rH7dgMh3N9u8udCAqlh2PoALUrbZoX7VcZSAQR1wiG7DPshmg3+xmLUeIOtas/TbV0CV
         wvIBrI3bhvFEaO2YVC8XK4ItxmSgZck/c+XlV3iJQJR0veLploIB6Gp9WM7PL9+3A4of
         PKOWha3L35eI05lB2vx2s40KFRwIVeZXQVWGu6yWRGZOQ3hp6B2/TR/F1MIP8e4QMa9I
         N53dSkWxxEdGVE19TLz44RAEyiqEh6RiEGiNkBVkoXgrMdr0YxEFuITZlpR2td0OVscw
         gcMg==
X-Gm-Message-State: APjAAAXdNPsW+8fY0mcFK993mXWRhaTYXjUDxbYMsfyUlUeAnGIu+t0E
        48yjedxnJiPgQLpMEA3kfV8FxSg+whAdktvxOjWxWM5HaBDut7/GC34+zQ/IsfNkt0VzZpWPdYg
        pIAE0wizYsZdXGbVv1wTQD9VEfArwOAG67GtxenqLHQ==
X-Received: by 2002:a63:3f85:: with SMTP id m127mr32163667pga.15.1582186092303;
        Thu, 20 Feb 2020 00:08:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5CB2MYi46pbLazZTtP3PKhLmyTFeQsVGMXYGM8GaSr/DT/ckFZWcNpfje4HaQNdbg8P3+gw==
X-Received: by 2002:a63:3f85:: with SMTP id m127mr32163647pga.15.1582186092011;
        Thu, 20 Feb 2020 00:08:12 -0800 (PST)
Received: from 2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net (2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net. [2001:b011:380f:3214:b828:48d4:ee3d:9937])
        by smtp.gmail.com with ESMTPSA id w11sm2415060pgh.5.2020.02.20.00.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 00:08:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Hard Disk consumes lots of power in s2idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
Date:   Thu, 20 Feb 2020 16:08:06 +0800
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-ide@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <235CF4F8-19BF-4B00-8C92-E59CB2D476A7@canonical.com>
References: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
 <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

> On Feb 20, 2020, at 02:36, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> Hi Kai,
> 
> On Wed, 2020-02-19 at 22:22 +0800, Kai-Heng Feng wrote:
>> Hi Srinivas,
>> 
>> Your previous work to support DEVSLP works well on SATA SSDs, so I am
>> asking you the issue I am facing:
>> Once a laptop has a HDD installed, the power consumption during
>> S2Idle increases ~0.4W, which is quite a lot.
>> However, HDDs don't seem to support DEVSLP, so I wonder if you know
>> to do proper power management for HDDs?
> What is the default here
> cat /sys/power/mem_sleep
> s2idle or deep?

It defaults to s2idle.

> 
> Please follow debug steps here:
> https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux
> 
> We need to check whether you get any PC10 residency or not.

Yes it reaches PC10. It doesn't reach SLP_S0 though.
The real number on S2Idle power consumption:
No HDD: ~1.4W
One HDD: ~1.8W

If the SoC doesn't hit PC10 the number should be significantly higher.
That's why I think the issue is the power management on HDD itself.

Kai-Heng

> 
> Thanks,
> Srinivas
> 
> 
>> 
>> Kai-Heng
> 

