Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C680C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EE72073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgGAIAU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:00:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50199 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgGAIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:00:19 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jqXfD-0007Fs-Ov
        for linux-kernel@vger.kernel.org; Wed, 01 Jul 2020 08:00:16 +0000
Received: by mail-pj1-f70.google.com with SMTP id h93so17858456pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GW8JJBP3OeAvfZkkdI4iX3hRICxg+YUixnYmOzaJcjw=;
        b=efWLXwc+pVeIfqa/QRFcVvkPhbS0AUpOkl2XgnCYhIYJwJCz/dq+/73luR9SoQ9Csl
         sVaN8sLUF2hS/po/wOgzMCu8FV5keLlq5ddDr9CpCykHzkVbMjjPr5F4eD2g5c/ixexx
         E86EJwk6rcCF2+IJhRd9N+OrPK2lXps8PNSKdnqBKI3iHPiMyBX/PX3tnpvAWg/kkFPF
         WsDbQaOder9GMibS4wZmU1DCyDQOk/Vf45aL+o40mMbN7mO9l4ow3usyvRW/CDcWfHWJ
         jLPD0K/341siKj/01wFCXiIwMZ5ZlCxqBi79u6zIjl0xzjy2N2JvtMKPaOIw34rqPn4X
         fq2A==
X-Gm-Message-State: AOAM530sbVTTgJMZo77o2PM7Nsw99qJZc3tdhVW/wrTDw++65m/CiCRV
        6ly4Er4vclKXXU1GVwzeTXctSMNL6oLhWiy8rs/bTvcB7ZOs/tQshi8AxZv/YMLpeN2C0ZmsxH2
        4uxCL85VQTz7bIwIs1H1bgYgbPJIJ1cAv8cHtJJKRpQ==
X-Received: by 2002:a17:902:e783:: with SMTP id cp3mr19843376plb.265.1593590414157;
        Wed, 01 Jul 2020 01:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV9agnsbKTHGvuQxcOeClpZMX08uYZcbhTp02OKxPn8O8KgWPCKecHkc6BCE5uO690zdpcfw==
X-Received: by 2002:a17:902:e783:: with SMTP id cp3mr19843335plb.265.1593590413720;
        Wed, 01 Jul 2020 01:00:13 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b10sm4915172pft.59.2020.07.01.01.00.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 01:00:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] ALSA: hda/realtek: Serialize setting GPIO LED
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hh7urg2bh.wl-tiwai@suse.de>
Date:   Wed, 1 Jul 2020 16:00:09 +0800
Cc:     tiwai@suse.com, anthony.won@canonical.com,
        Jaroslav Kysela <perex@perex.cz>,
        Libin Yang <libin.yang@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2A526AAE-1F25-44DB-8078-1E1A585B8629@canonical.com>
References: <20200701052138.6378-1-kai.heng.feng@canonical.com>
 <s5hh7urg2bh.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 1, 2020, at 14:46, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Wed, 01 Jul 2020 07:21:35 +0200,
> Kai-Heng Feng wrote:
>> 
>> If a system has two GPIO controlled LED, one for mute and another one
>> for micmute, and both of them are on before system suspend, sometimes
>> one of them won't be turned off by system suspend.
>> 
>> The codec doesn't seem to be able to control multiple GPIO LEDs at the
>> same time, so introduce a new mutex to serialize setting the LED, to
>> prevent the issue from happening.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> include/sound/hda_codec.h     | 1 +
>> sound/pci/hda/hda_codec.c     | 1 +
>> sound/pci/hda/patch_realtek.c | 3 +++
>> 3 files changed, 5 insertions(+)
>> 
>> diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
>> index d16a4229209b..3a1792bbb7ac 100644
>> --- a/include/sound/hda_codec.h
>> +++ b/include/sound/hda_codec.h
>> @@ -206,6 +206,7 @@ struct hda_codec {
>> 
>> 	struct mutex spdif_mutex;
>> 	struct mutex control_mutex;
>> +	struct mutex led_mutex;
> 
> Since it's only for Realtek codec, can it be better in alc_spec
> instead?

Ok, I found that the mutex just papers over the real issue.

The root cause is that led_set_brightness_nopm() use schedule_work() but the work queue doesn't gets flushed.
I'll fix it there properly.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi

