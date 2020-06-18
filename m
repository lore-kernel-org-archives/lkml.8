Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2709FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3E8206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFRFPa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:15:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgFRFP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:15:29 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jlmtb-0006N1-2G
        for linux-kernel@vger.kernel.org; Thu, 18 Jun 2020 05:15:27 +0000
Received: by mail-pf1-f198.google.com with SMTP id r12so3474678pfr.16
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 22:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Oryf7hk+67tb3UImJgvZwYdxoGsfOvkQ24Y1LrEqeGA=;
        b=DRxqhKFrmOcTrCM44elhUlzrPEcNmcMk/VeY+agxxJ1cXUsZPn0gqEVEUfuODGFeB5
         LgIya1csjgqlS9sGDJHQldE2gIUil53wmQOu+/Crn6yA1WW/PCzNBShAzJSklimsFA/R
         52LPDQTBMkn0VymsyvqMIcGzBOPpTjorYBybhytK5MyUPxzyWdPKRWyKEf94uRv/+d+D
         q6nx9QVPuW0NQsxKehW/Eq0IR+Co6xIoQwYk1cRerUZjCuzPfR891cWLyPp6gKcsSzPZ
         2ouhgY6643nYg9LK/cJcQ4p5BbZSuUNabbDiS41aCOSPg6Ft+mcUg7ZUfzevSf+if1SF
         799g==
X-Gm-Message-State: AOAM533VDn5FpsZTU4I/hxcL0b0P5cAUFF+Wc10ARHcg9LX9FFVqNB/w
        OSjrQt1hx8zjOFU4eC9ZH4WYJqWs0VJyfjawAgWxLu3TUOgalvpTWkt3X6kWs6NbnUus+gf8xSi
        3FKrj5sWqZX/e5mXEeVvvVWCaVNi5boEGyVdRGZP1Pg==
X-Received: by 2002:a62:1c5:: with SMTP id 188mr2035711pfb.213.1592457325688;
        Wed, 17 Jun 2020 22:15:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPhKHc/zO2b0ZW4HblJG3+QUuJrSPk2mjyXEpA7DdyHDAyDpTJ8iI4CZz4gF9Uemt1JS6Ysw==
X-Received: by 2002:a62:1c5:: with SMTP id 188mr2035686pfb.213.1592457325309;
        Wed, 17 Jun 2020 22:15:25 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id u25sm1414277pfm.115.2020.06.17.22.15.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 22:15:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/2] ALSA: hda/realtek: Add COEF controlled micmute LED
 support
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5h366tzo6x.wl-tiwai@suse.de>
Date:   Thu, 18 Jun 2020 13:15:21 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Hui Wang <hui.wang@canonical.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DB5A1DD9-4D61-466F-A7DE-4219534DFA4D@canonical.com>
References: <20200617102906.16156-1-kai.heng.feng@canonical.com>
 <s5hd05xzz3d.wl-tiwai@suse.de>
 <934401DE-7A4E-4B2C-8B06-E2AA203A9336@canonical.com>
 <s5h366tzo6x.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 17, 2020, at 23:50, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Wed, 17 Jun 2020 17:24:30 +0200,
> Kai-Heng Feng wrote:
>> 
>> 
>> 
>>> On Jun 17, 2020, at 19:55, Takashi Iwai <tiwai@suse.de> wrote:
>>> 
>>> On Wed, 17 Jun 2020 12:29:01 +0200,
>>> Kai-Heng Feng wrote:
>>>> 
>>>> Currently, HDA codec LED class can only be used by GPIO controlled LED.
>>>> However, there are some new systems that control LED via COEF instead of
>>>> GPIO.
>>>> 
>>>> In order to support those systems, create a new helper that can be
>>>> facilitated by both COEF controlled and GPIO controlled LED.
>>>> 
>>>> In addition to that, add LED_CORE_SUSPENDRESUME flag since some systems
>>>> don't restore the LED properly after suspend.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> 
>>> Thanks for the quick follow up, the issues I pointed were fixed.
>>> 
>>> But, now looking at the code change again, I'm no longer sure whether
>>> it's the right move.
>>> 
>>> Basically, the led cdev should serve only for turning on/off the LED
>>> as given.  But your patch changes it to call the generic mixer
>>> updater, which is rather the one who would call the led cdev state
>>> update itself.  That is, it's other way round.
>>> 
>>> IMO, what we need is to make all places calling
>>> snd_hda_gen_add_micmute_led() to create led cdev, and change those
>>> calls with snd_hda_gen_fixup_micmute_led().
>> 
>> Ok, so it's the same as patch v1.
>> How should we handle vendors other than HP?
>> Only create led cdev if the ID matches to HP?
> 
> It's fine to create a LED classdev for other vendors, too.  But the
> problem is that it wasn't consistent.  With the LED classdev, we
> should use only cdev, instead of mixing up different ways.

Ok, now I get what you meant...

> 
> I wrote a few patches to convert those mic-mute LED stuff to classdev,
> including some cleanups.  The patches are found in
> topic/hda-micmute-led branch of sound git tree.  Could you check it?
> 
> Note that it's totally untested.  Also it doesn't contain yet
> LED_CORE_SUSPENDRESUME, which should be done in another patch in
> anyway.

Other than LED_CORE_SUSPENDRESUME, it works great!

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> 
>>> It'll be a bit more changes and likely not fitting with 5.8, but the
>>> whole result will be more consistent.
>> 
>> A bit off topic, but do you think it's reasonable to also create led cdev for mute LED, in addition to micmute LED?
>> I just found that the LEDs are still on during system suspend, and led cdev has the ability to turn off the LEDs on system suspend.
> 
> Yes, it makes sense, too.  But the playback mute handling is a bit
> more complicated than the mic-mute LED because it's implemented with a
> vmaster hook.  I'll take a look later.

Thanks. I'll be happy to test it.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi

