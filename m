Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DCA24690
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMkIfWiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgA1OXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:23:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58461 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727097AbgA1OXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580221414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PoorEe3BgUIDWbZrCh3DXrBZXbNmAisrYa8c3ofYrmk=;
        b=jMkIfWiQAbnV+J4YyQxn09/sPidarpAjSJHoE6nCnldXRRD4zXMMwr/Xck9Jlwn7FLyhFY
        /n2grw5vXnL39f8MKBfVrZQfE11FtxhC0mkcBfOKYvGRhYkM3DjUb3eFxHWUbJGc54VA3t
        95n4vk/nd5WuuUAC/eRo0QebB0UFMZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-_nAqYHhBOiypkNJq-COWqg-1; Tue, 28 Jan 2020 09:23:32 -0500
X-MC-Unique: _nAqYHhBOiypkNJq-COWqg-1
Received: by mail-wr1-f72.google.com with SMTP id s13so645483wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 06:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PoorEe3BgUIDWbZrCh3DXrBZXbNmAisrYa8c3ofYrmk=;
        b=SaX/9t3YTJzIrNIdsbLRSQFsEKymG4RT5sZsCFhYz+pp/HGW6yGXo5dQ0/Uy5TzRTl
         rmdAckdiYrMW5sUtdpNieJGRxoV668aa4/Z6FHj44fzHjlB9w/Jgmo9lJkJf4pKwrJRF
         nnrx9lTXcrQKbGI9pazt6Kpp3XXd7Oi4RXadaPTem4zxSZJf1sBr8C8jMGI7hi/PnetW
         DU/zfm1Q69zgTuyNxBjBkOW6+AKUtJ+TNApLEk1bHDWbFs2KMrQWIlTWc/skqIHsbzAn
         g1hKVjTcPMXuSMRTQvgkwsbTUIkWO3DLgenl9YxEbifm+DQFDbdX1iV2ayXcX3leOyTw
         uESw==
X-Gm-Message-State: APjAAAXNWU6OL9Yn8MsbW9pMkRBghAOIB2qfG3Hfdyi/8G5A9qoy4eGu
        qAwjO5j3MtKXa+/G9LTfcl0JJWyw4mfaVSj3sCAd+6QCJkiH5ZMTV+sc7p54y8O3bgwpDCDom+O
        aHNdGkZDRSxq4IedHtyykK0qs
X-Received: by 2002:a5d:4983:: with SMTP id r3mr27273084wrq.134.1580221411397;
        Tue, 28 Jan 2020 06:23:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYw2chTdDz/2/YZKa8hws0FseLlswooyyiI+PyGP3EMBgoFWXFLA6gKBHI6Dwbt8wiSXVkSA==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr27273066wrq.134.1580221411179;
        Tue, 28 Jan 2020 06:23:31 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id s65sm3348672wmf.48.2020.01.28.06.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:23:30 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [v3] x86/tsc: Unset TSC_KNOWN_FREQ and TSC_RELIABLE flags on
 Intel Bay Trail SoC
To:     vipul kumar <vipulk0511@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Stable <stable@vger.kernel.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        x86@kernel.org, Len Brown <len.brown@intel.com>,
        Vipul Kumar <vipul_kumar@mentor.com>
References: <1579617717-4098-1-git-send-email-vipulk0511@gmail.com>
 <87eevs7lfd.fsf@nanos.tec.linutronix.de>
 <CADdC98RJpsvu_zWehNGDDN=W11rD11NSPaodg-zuaXsHuOJYTQ@mail.gmail.com>
 <878slzeeim.fsf@nanos.tec.linutronix.de>
 <CADdC98TE4oNWZyEsqXzr+zJtfdTTOyeeuHqu1u04X_ktLHo-Hg@mail.gmail.com>
 <20200123144108.GU32742@smile.fi.intel.com>
 <df04f43d-8c6d-7602-cb50-535b85cf2aaa@redhat.com>
 <87iml11ccf.fsf@nanos.tec.linutronix.de>
 <c06260e3-bd19-bf3c-89f7-d36bdb9a5b20@redhat.com>
 <87ftg5131x.fsf@nanos.tec.linutronix.de>
 <37321319-e110-81f5-2488-cedf000da04d@redhat.com>
 <CADdC98To8VKOUWnR+8zAJ04vgdc4vJoh2h96588+5XFer9YTJw@mail.gmail.com>
Message-ID: <329a2f7d-c5ed-6376-ec78-f00fa1ba41cd@redhat.com>
Date:   Tue, 28 Jan 2020 15:23:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CADdC98To8VKOUWnR+8zAJ04vgdc4vJoh2h96588+5XFer9YTJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-01-2020 12:47, vipul kumar wrote:
> Hi Thomas,
> 
> Please find attached logs with mainline kernel version 5.4.15 with patch.

So the suggested change seems to not work, that is strange.

Can you double check you are running the correct kernel and
add the following change and gather debug output ? :

--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -102,6 +103,8 @@ unsigned long cpu_khz_from_msr(void)
         /* Get FSB FREQ ID */

+ pr_err("tsc msr id match %ld lo 0x%02x\n", id - tsc_msr_cpu_ids, lo);
+
         /* Map CPU reference clock freq ID(0-7) to CPU reference clock freq(KHz) */
         freq = freq_desc->freqs[lo & 0x7];

Regards,

Hans



> On Fri, Jan 24, 2020 at 9:24 PM Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> wrote:
> 
>     Hi,
> 
>     On 1/24/20 12:55 PM, Thomas Gleixner wrote:
>      > Hans,
>      >
>      > Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> writes:
>      >> On 1/24/20 9:35 AM, Thomas Gleixner wrote:
>      >>> Where does that number come from? Just math?
>      >>
>      >> Yes just math, but perhaps the Intel folks can see if they can find some
>      >> datasheet to back this up ?
>      >
>      > Can you observe the issue on one of the machines in your zoo as well?
> 
>     I haven't tried yet. Looking at the thread sofar the problem was noticed on
>     a system with a Celeron N2930, I don't have access to one of those, I
>     do have access to a system with a closely related N2840 I will give that
>     a try as well as see if I can reproduce this on one of the tablet
>     oriented Z3735x SoCs.
> 
>     I'll report back when I have had a chance to test this.
> 
>     Regards,
> 
>     Hans
> 

