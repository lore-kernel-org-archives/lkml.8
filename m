Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE19206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFQPZU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:25:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44638 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgFQPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:25:18 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jlZwB-0001eJ-Cp
        for linux-kernel@vger.kernel.org; Wed, 17 Jun 2020 15:25:15 +0000
Received: by mail-pf1-f197.google.com with SMTP id 137so2029686pfw.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qyyiMmv9qYUSuKaCbblPmkDJA2AJx3BvYMLY89xY8b4=;
        b=rQRBPuWzCFLJjNA9NtqnsQQsm+bIH7PRFHbaoKFGgKTDwQeJ+UlwZX07ouGpSdLbSP
         bfxHxCe5u8ZUSobVd3in/e8zBavH85Us/JOTSBn9FDwm62LAVixitgEAKAzVeQk+GZWk
         LPHM9g6/n30Sac8i4+CUeOSCCdBN/P3nL8xWjClWphodhfQiANHF8xUnwI09wbiJx8IF
         yhfzJeB3rptQXzd+iUDpCd7py3lIyZQXHoExeuJmoYK/gV97XvIS3jAzfE9EfovvlgD9
         azuP/G1gdSzoPIZQZcjr85ldIbt3NMSOdVvNrZhBFoSaObNtHHECeP5YooS82eeRJR3T
         hNww==
X-Gm-Message-State: AOAM531fYGftfUr3gidivcLGtSVGek092NfUN4XzNxZLzzoLTR+HYZiq
        wx4t5wx4ltH47qB9NEof0Q4U8tXLJZ/aUoOsDaU54G51WaFbiZGWykkR4ivx5aJYImLe0aAvbkj
        olmnKEI7/7aC6RBqXKnIPnTXpJsOsMe2BYfZah+QuCA==
X-Received: by 2002:a65:594b:: with SMTP id g11mr365411pgu.168.1592407514031;
        Wed, 17 Jun 2020 08:25:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyAnJqzykyq6Qh4y8k+2SiK49GevfzYs41NQ2z60sL/wWRIIaLoTPE/TH4irNzfB/JqLYESQ==
X-Received: by 2002:a65:594b:: with SMTP id g11mr365379pgu.168.1592407513540;
        Wed, 17 Jun 2020 08:25:13 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id l3sm203953pgm.59.2020.06.17.08.25.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 08:25:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 2/2] ALSA: hda/realtek: Add mute LED and micmute LED
 support for HP systems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hbllhzz2m.wl-tiwai@suse.de>
Date:   Wed, 17 Jun 2020 23:25:10 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <486196C0-891B-47BA-8A5A-A9B65D27E7E5@canonical.com>
References: <20200617102906.16156-1-kai.heng.feng@canonical.com>
 <20200617102906.16156-2-kai.heng.feng@canonical.com>
 <s5hbllhzz2m.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 17, 2020, at 19:55, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Wed, 17 Jun 2020 12:29:02 +0200,
> Kai-Heng Feng wrote:
>> 
>> There are two more HP systems control mute LED from HDA codec and need
>> to expose micmute led class so SoF can control micmute LED.
>> 
>> Add quirks to support them.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> I guess this can be applied independently from the patch#1?
> If so, I'll queue this for for-linus branch.

Yes please. Thanks!

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
> 
>> ---
>> v3:
>> - No change.
>> v2:
>> - Wording.
>> 
>> sound/pci/hda/patch_realtek.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 0587d1e96b19..cd1a3619806a 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -7473,6 +7473,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>> 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
>> 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
>> 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
>> +	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
>> +	SND_PCI_QUIRK(0x103c, 0x8729, "HP", ALC285_FIXUP_HP_GPIO_LED),
>> 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_LED),
>> 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
>> 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
>> -- 
>> 2.17.1
>> 

