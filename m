Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F674C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B79D20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgBLGdu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:33:50 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39369 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgBLGdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:33:50 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01C6Wl64029615, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01C6Wl64029615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 14:32:47 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 14:32:47 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 14:32:47 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::1832:8abc:ec2d:974f]) by
 RTEXMB01.realtek.com.tw ([fe80::1832:8abc:ec2d:974f%6]) with mapi id
 15.01.1779.005; Wed, 12 Feb 2020 14:32:47 +0800
From:   Kailang <kailang@realtek.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Benjamin Poirier <benjamin.poirier@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon 7th quirk value
Thread-Topic: [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon
 7th quirk value
Thread-Index: AQHV4KAyVK0d0c4RkUCatRD1s4Jmc6gVFbAAgAAJ9ACAAJRvkP//fXAAgAHpSsA=
Date:   Wed, 12 Feb 2020 06:32:46 +0000
Message-ID: <e3d27837151c46debf6d9c5af37f7460@realtek.com>
References: <20200211055651.4405-1-benjamin.poirier@gmail.com>
        <20200211055651.4405-2-benjamin.poirier@gmail.com>
        <b23abac0-401c-9472-320c-4e9d7eab26de@perex.cz> <20200211081604.GA8286@f3>
        <ab7a0abd24df485d8f8cc3723403a44f@realtek.com> <s5ho8u54h19.wl-tiwai@suse.de>
In-Reply-To: <s5ho8u54h19.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.105.169]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, February 11, 2020 5:20 PM
> To: Kailang <kailang@realtek.com>
> Cc: Benjamin Poirier <benjamin.poirier@gmail.com>; Jaroslav Kysela
> <perex@perex.cz>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon
> 7th quirk value
> 
> On Tue, 11 Feb 2020 10:10:50 +0100,
> Kailang wrote:
> >
> > Hi,
> >
> > Speaker 2 connect to DAC 0x2 was Lenovo requested.
> > This was tune for EQ setting.
> > I didn't know more for this.
> 
> Thanks, that was my expectation, too.  Applying EQ to built-in speakers is an
> oft-seen workaround for laptops to avoid the possible hardware damage.
> 
> Now the question is whether this obvious level of lowering is the expected
> result.
> 
> Kailang, could you try to ask Lenovo about it?

I have confirmed with our Lenovo AE.

> 
> 
> Takashi
> 
> >
> > BR,
> > Kailang
> >
> > > -----Original Message-----
> > > From: Benjamin Poirier <benjamin.poirier@gmail.com>
> > > Sent: Tuesday, February 11, 2020 4:16 PM
> > > To: Jaroslav Kysela <perex@perex.cz>
> > > Cc: Takashi Iwai <tiwai@suse.de>; Kailang <kailang@realtek.com>;
> > > alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1
> > > Carbon 7th quirk value
> > >
> > > On 2020/02/11 08:40 +0100, Jaroslav Kysela wrote:
> > > [...]
> > > > >
> > > > > In summary, Node 0x17 DAC connection 0x3 offers the loudest max
> > > > > volume and the most detailed mixer controls. That connection is
> > > > > obtained with quirk ALC295_FIXUP_DISABLE_DAC3. Therefore, change
> > > > > the ThinkPad X1 Carbon 7th to use ALC295_FIXUP_DISABLE_DAC3.
> > > >
> > > > The volume split (individual volume control) will cause trouble
> > > > for the UCM volume control at the moment which is the target for
> > > > this device to get the digital microphone working. If there is no
> > > > possibility to share DAC, it would be probably more nice to join
> > > > the volume
> > > control in the driver.
> > > >
> > > > Have you tried to use 0x03 as source for all four speakers?
> > >
> > > Front speakers are fixed to 0x02. Node 0x14
> > >   Connection: 1
> > >      0x02
> > >
> > > >
> > > > Why PA handles the rear volume control with the current driver
> > > > code in the legacy ALSA driver? It should be handled like standard
> > > > stereo device. I'll check.
> > >
> > > The device comes up with "Analog Stereo Output" profile by default.
> > > I changed it to "Analog Surround 4.0 Output" to test controlling each
> channel individually:
> > >
> > > > > pavucontrol controls are reported with the device configured
> > > > > with the "Analog Surround 4.0 Output" profile.
> > >
> > > >
> > > > You should also test PA with UCM.
> > >
> > > Please let me know what do I need to test exactly? I'm not familiar with
> UCM.
> > >
> > > ------Please consider the environment before printing this e-mail.
> >
