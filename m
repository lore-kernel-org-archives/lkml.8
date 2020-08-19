Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19878C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050DA20639
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHSSKg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:10:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39206 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSSKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:10:34 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k8SXg-0001oc-3J
        for linux-kernel@vger.kernel.org; Wed, 19 Aug 2020 18:10:32 +0000
Received: by mail-pf1-f200.google.com with SMTP id d3so15505859pfh.17
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Je8zHXL3E4yI3+Q3331hn6P+qZfrANUnxzzTV6g5u4c=;
        b=E/H46FK8sDHyL40rMGz1VGJxAaUOqxAm3NX+1rfBHMwRSn745VFlsMfvFRADnZbHi5
         JR2mju5i6b0aK2EMWjPGFHWxbnNY3Ac2fN6I1X+GxqYZQRU4++JqfYm7OOqpe1mgr500
         BiIE5DNSj2MuFptlueTgwfgr/AxWEsJXbN/CZQBBfazo9qyFTfFnXzrKEGaqJFbBO8mV
         TY6UW+k2oRLg4bvRELj34BIkuVB4q603/+TlnmWOlGIfn1x6NiJON6ZTfPishOcn1Scm
         kLW/HHR1i9GHJT8J6gW+NNbWBS31MTR38BGndwkL39H4SU0l8SLaDwUvegYgbqWsIOSD
         mzJA==
X-Gm-Message-State: AOAM5333Pgxv0lwOJElQYf6SaxcY6JROOp7kO/xC8IjJ2uPkUKBlIqB7
        dRU8dJW2rDKCpAUu0sMXl7qbfDrWOPizntNrCxcPcXr3z9lmrwyoZfjXtNLQr4mFLioUfBU0hhJ
        RFasVV+eIq+c4pn9DyrenEXRQl9U1NPWDitv1s5imqg==
X-Received: by 2002:a63:488:: with SMTP id 130mr10710371pge.92.1597860630752;
        Wed, 19 Aug 2020 11:10:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzNb0fJeDpP/4/q3CDkMRjmU/MuofXu2/pplo0TwUEaQDklB48zes+bU2n69VEPG+Or0isYQ==
X-Received: by 2002:a63:488:: with SMTP id 130mr10710353pge.92.1597860630372;
        Wed, 19 Aug 2020 11:10:30 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id m4sm28353445pfh.129.2020.08.19.11.10.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 11:10:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] ALSA: usb-audio: Add prevent wakeup from s3 state trig by
 Lenovo ThinkCentre TI024Gen3 USB-audio
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5h364ih7vd.wl-tiwai@suse.de>
Date:   Thu, 20 Aug 2020 02:10:25 +0800
Cc:     penghao <penghao@uniontech.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>, alexander@tsoy.me,
        dan.carpenter@oracle.com, crwulff@gmail.com, gustavoars@kernel.org,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <74B3A9AD-8B49-4E5F-BE9F-BF88865304B7@canonical.com>
References: <20200819115757.23168-1-penghao@uniontech.com>
 <s5h364ih7vd.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 20, 2020, at 01:18, Takashi Iwai <tiwai@suse.de> wrote:
> 
> [ Adding a few more relevant people to Cc. ]
> 
> On Wed, 19 Aug 2020 13:57:57 +0200,
> penghao wrote:
>> 
>> TI024Gen3 USB-audio is controlled by TI024Gen3,when TI024Gens
>> enter sleep mode, USB-audio will disconnect from USB bus port,
>> wakup form s3 state
>> 
>> Signed-off-by: penghao <penghao@uniontech.com>
>> ---
>> sound/usb/card.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 696e788c5d31..6bdbb34009b3 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -658,6 +658,12 @@ static int usb_audio_probe(struct usb_interface *intf,
>> 	}
>> 
>> 	dev_set_drvdata(&dev->dev, chip);
>> +	/*
>> +	 *ALSA: usb-audio: Add prevent wakeup from s3 state trig by Lenovo
>> +	 *ThinkCentre TI024Gen3 usb-audio
>> +	 */
>> +	if ((usb_id->idVendor == 0x17ef) && (usb_id->idProduct == 0xa012))
>> +		device_set_wakeup_enable(＆dev->dev, 0);
> 
> Here it's no proper ASCII letter, and this must be broken.
> Please check the actual patch before submitting.
> 
> In anyway, before going further, I'd like to hear from other people
> whether this is really mandatory and appropriate.  And whether it's
> specific to that device, too (not other Lenovo devices?)

If USB remote wakeup on this device is broken then we need to fix it in USB core instead of USB audio.
We need USB and xHCI logs to understand the real problem here, the commit message doesn't contain enough information.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi

