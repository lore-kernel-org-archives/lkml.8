Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94697C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A380F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHDJcJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:32:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43231 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:32:08 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k2tIj-0003hr-La
        for linux-kernel@vger.kernel.org; Tue, 04 Aug 2020 09:32:05 +0000
Received: by mail-pj1-f72.google.com with SMTP id s4so1790075pjq.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 02:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m7D3E+oljZppcXRqnOA0d+1JsK0dAh8esFkhEip7S3c=;
        b=TibPmGq4DXIbPzcE6QRFz6RU1vvxvbRd87hvSxthYyHBLZurYDKsq6KkWftZwTnI+s
         MHL8pPq/SdArVFlZsqFrJZXmpKW40g2xKXMh7ri3clED/DBk3p0Q+bwpBjK26WPELJlI
         OHr1UGgRDm+ElerOAKNsbdM4g6Iyl5g23DCT9TbmvJjYPxVhUBqDIpUoNEPMiMaIoSCM
         eN+NWA4x254acNbZ4+nUhrPTT/lbHya45dt/dImcQPCJzFw1SoeuL2INj7tkCDqZnJVO
         y/mpXB+EzlJ9ju8jS5nZ1Niv3EFG4cU1GgOIjoKaMM89gASNKhMhTf5nAK2lfj9Rm1Ll
         gK9A==
X-Gm-Message-State: AOAM531+hZMRpJdwxROWgKMKMcW6xTadokHGy8YOs3QNdso8vSCY2lle
        tSNSdLHaDi3rGfDoLG0rHlkp3/kLG27XrJvwSa6EqHBCRpFWq4RlkMJT8qm6BdESMA7kIJrIaOx
        3hd5ftmzS+pbeipoICXiaLQZqcWvKKsHlccrpfGDqsQ==
X-Received: by 2002:a62:6491:: with SMTP id y139mr19387363pfb.102.1596533524284;
        Tue, 04 Aug 2020 02:32:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyChQbl3Sq1PVoc/sQokj4EO+tLCMI48/uyJjuiqnk70WW4RrmMYu1sGVfmrT+s694MpWx8dA==
X-Received: by 2002:a62:6491:: with SMTP id y139mr19387332pfb.102.1596533523824;
        Tue, 04 Aug 2020 02:32:03 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 22sm21501192pfh.157.2020.08.04.02.32.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:32:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] ALSA: hda/hdmi: Add pins with jack detection support
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hv9hy235r.wl-tiwai@suse.de>
Date:   Tue, 4 Aug 2020 17:31:59 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Nikhil Mahale <nmahale@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <41E2234E-451C-4C14-833A-E24C650EDEE1@canonical.com>
References: <20200804072926.16897-1-kai.heng.feng@canonical.com>
 <s5hv9hy235r.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 4, 2020, at 17:04, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Tue, 04 Aug 2020 09:29:25 +0200,
> Kai-Heng Feng wrote:
>> 
>> HDMI on some platforms doesn't enable audio support because its Port
>> Connectivity [31:30] is set to AC_JACK_PORT_NONE:
>> Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
>>  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>  Amp-Out vals:  [0x00 0x00]
>>  Pincap 0x0b000094: OUT Detect HBR HDMI DP
>>  Pin Default 0x58560010: [N/A] Digital Out at Int HDMI
>>    Conn = Digital, Color = Unknown
>>    DefAssociation = 0x1, Sequence = 0x0
>>  Pin-ctls: 0x40: OUT
>>  Unsolicited: tag=00, enabled=0
>>  Power states:  D0 D3 EPSS
>>  Power: setting=D0, actual=D0
>>  Devices: 0
>>  Connection: 3
>>     0x02 0x03* 0x04
>> 
>> Those pins were filtered out by commit 116dcde63806 ("ALSA: HDA: Remove
>> unconnected PCM devices for Intel HDMI"). However, jacks that support
>> detection won't have the issues the commit addresses.
>> 
>> So still add the pin if it supports jack detection.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Which platform did show the problem?

An HP desktop.

> 
> I'm reluctant to apply this change as it would potentially break the
> existing system.  If we must to apply, maybe it's safer to apply it
> conditionally to the limited devices.

Hmm, I find it's a bit hard to match a specific device, because the ID seems to be rather generic:
Codec: Intel Kabylake HDMI
Address: 2                      
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x8086280b         
Subsystem Id: 0x80860101
Revision Id: 0x100000

Should we use DMI string instead?

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>> sound/pci/hda/patch_hdmi.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index cd46247988e4..db3a5148bd40 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -1701,7 +1701,8 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
>> 	 * all device entries on the same pin
>> 	 */
>> 	config = snd_hda_codec_get_pincfg(codec, pin_nid);
>> -	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
>> +	if ((get_defcfg_connect(config) == AC_JACK_PORT_NONE) &&
>> +	    !(caps & AC_PINCAP_PRES_DETECT))
>> 		return 0;
>> 
>> 	/*
>> -- 
>> 2.17.1

