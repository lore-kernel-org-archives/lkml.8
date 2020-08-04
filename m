Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014DDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD9020738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgHDLmL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:42:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgHDLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:42:11 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k2vKa-0002lF-Gi
        for linux-kernel@vger.kernel.org; Tue, 04 Aug 2020 11:42:08 +0000
Received: by mail-pj1-f69.google.com with SMTP id z8so1907982pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 04:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+MkR9k+K5AnlR4tpaB961yLWGon3VPfUxzAccVnmGDg=;
        b=AMSPlsSBIbYGr5LuImRUo+DRkxF2jsCgB5H3RjR/fZRiBiIxMDrCwO4m+g5jYkYeYC
         415+L2r+P8IKOl3paGRLY+MY2e4rzq9TdI9Vu1181HwlNwKz+TmB6KMUzHhlfQfIQPh5
         eFZH9GgG4ovUrCfEK8dXzJOH++V7mxSdTVmFEAbRS143IQVyYio7KEdoGdTw2Yf/ZaFq
         XInOWC1OCbmIAsm0FckmqkFhKqk2Yc8Qa7l8feu+RgaCsNWklyLNMhr8Q63hpX2ttfOP
         EvIo9nH+EAL27rVqoAXlH7oRGmJEBLR61UnOanGDqk6VxE6M7XDDPJnqRAu/G77L8MvC
         cMkQ==
X-Gm-Message-State: AOAM533bZavszt1yLdxt6VGNHPUxMNZ6eJq+FXOqKxi8was+095Ng9ZG
        FkgHrBPTzLRgDa4uGsC58TJp6H2bDIASYeOYj1yt5jT5CMpfnnl5pjYspTQzWdMi+5Sh99J5E+W
        wV4nn/emmCwU8kGH/A0uaCQBuNss/fLT4pN5Riy2YaQ==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr3899654pjb.111.1596541326955;
        Tue, 04 Aug 2020 04:42:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbf0hOnUK6qTvuV9gqQz088987sBR9Dm3KrCJpYfGojJAqMxgNdgLWjLBaxSgDIHUjz2Ovog==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr3899636pjb.111.1596541326539;
        Tue, 04 Aug 2020 04:42:06 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 3sm21315334pfv.109.2020.08.04.04.42.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 04:42:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] ALSA: hda/hdmi: Add pins with jack detection support
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hpn86213w.wl-tiwai@suse.de>
Date:   Tue, 4 Aug 2020 19:42:03 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Nikhil Mahale <nmahale@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <21676100-4D83-44F6-BB39-4FDFBDEAF462@canonical.com>
References: <20200804072926.16897-1-kai.heng.feng@canonical.com>
 <s5hv9hy235r.wl-tiwai@suse.de>
 <41E2234E-451C-4C14-833A-E24C650EDEE1@canonical.com>
 <s5hpn86213w.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 4, 2020, at 17:48, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Tue, 04 Aug 2020 11:31:59 +0200,
> Kai-Heng Feng wrote:
>> 
>> 
>> 
>>> On Aug 4, 2020, at 17:04, Takashi Iwai <tiwai@suse.de> wrote:
>>> 
>>> On Tue, 04 Aug 2020 09:29:25 +0200,
>>> Kai-Heng Feng wrote:
>>>> 
>>>> HDMI on some platforms doesn't enable audio support because its Port
>>>> Connectivity [31:30] is set to AC_JACK_PORT_NONE:
>>>> Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
>>>> Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>>> Amp-Out vals:  [0x00 0x00]
>>>> Pincap 0x0b000094: OUT Detect HBR HDMI DP
>>>> Pin Default 0x58560010: [N/A] Digital Out at Int HDMI
>>>>   Conn = Digital, Color = Unknown
>>>>   DefAssociation = 0x1, Sequence = 0x0
>>>> Pin-ctls: 0x40: OUT
>>>> Unsolicited: tag=00, enabled=0
>>>> Power states:  D0 D3 EPSS
>>>> Power: setting=D0, actual=D0
>>>> Devices: 0
>>>> Connection: 3
>>>>    0x02 0x03* 0x04
>>>> 
>>>> Those pins were filtered out by commit 116dcde63806 ("ALSA: HDA: Remove
>>>> unconnected PCM devices for Intel HDMI"). However, jacks that support
>>>> detection won't have the issues the commit addresses.
>>>> 
>>>> So still add the pin if it supports jack detection.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> 
>>> Which platform did show the problem?
>> 
>> An HP desktop.
> 
> Well, what I meant was about which codec.  And now I see it in the
> below.
> 
>>> I'm reluctant to apply this change as it would potentially break the
>>> existing system.  If we must to apply, maybe it's safer to apply it
>>> conditionally to the limited devices.
>> 
>> Hmm, I find it's a bit hard to match a specific device, because the ID seems to be rather generic:
>> Codec: Intel Kabylake HDMI
>> Address: 2                      
>> AFG Function Id: 0x1 (unsol 0)
>> Vendor Id: 0x8086280b         
>> Subsystem Id: 0x80860101
>> Revision Id: 0x100000
>> 
>> Should we use DMI string instead?
> 
> So it's a Kabylake, and I presume that it's rather an old machine.
> Is this for docking station or anything else?

The system is Comet Lake CPU so it's fairly recent. I think most Comet Lake platforms still use "Kabylake HDMI".

> 
> Basically the pin capability is rather fixed by the chip design while
> the pin configuration is set by BIOS.  And we follow the BIOS setup
> for determining which pins are actually alive.  That said, the bug is
> a BIOS bug.

Yes but sometimes vendors are reluctant to fix it because "Windows doesn't have this issue".

> 
> Note that PCI SSID bound with this codec might have a different
> number, so we might be still able to use the standard quirk table to
> pick up.

Ok. Will send v2 with a quirk list.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
>>> 
>>> thanks,
>>> 
>>> Takashi
>>> 
>>>> ---
>>>> sound/pci/hda/patch_hdmi.c | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>>> index cd46247988e4..db3a5148bd40 100644
>>>> --- a/sound/pci/hda/patch_hdmi.c
>>>> +++ b/sound/pci/hda/patch_hdmi.c
>>>> @@ -1701,7 +1701,8 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
>>>> 	 * all device entries on the same pin
>>>> 	 */
>>>> 	config = snd_hda_codec_get_pincfg(codec, pin_nid);
>>>> -	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
>>>> +	if ((get_defcfg_connect(config) == AC_JACK_PORT_NONE) &&
>>>> +	    !(caps & AC_PINCAP_PRES_DETECT))
>>>> 		return 0;
>>>> 
>>>> 	/*
>>>> -- 
>>>> 2.17.1

