Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C64C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F1F2072C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgBKCN4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:13:56 -0500
Received: from mg.richtek.com ([220.130.44.152]:53942 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgBKCNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:13:55 -0500
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 21:13:54 EST
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(24508:0:AUTH_RELAY)
        (envelope-from <prvs=13081D10B8=jeff_chang@richtek.com>); Tue, 11 Feb 2020 10:13:50 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.45
        by mg.richtek.com with MailGates ESMTP Server V5.0(29549:0:AUTH_RELAY)
        (envelope-from <jeff_chang@richtek.com>); Tue, 11 Feb 2020 10:04:43 +0800 (CST)
Received: from ex1.rt.l (192.168.8.44) by ex2.rt.l (192.168.8.45) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 Feb 2020 10:04:42 +0800
Received: from ex1.rt.l ([fe80::557d:30f0:a3f8:3efc]) by ex1.rt.l
 ([fe80::557d:30f0:a3f8:3efc%15]) with mapi id 15.00.1497.000; Tue, 11 Feb
 2020 10:04:42 +0800
From:   =?iso-2022-jp?B?amVmZl9jaGFuZygbJEJEJUAkMkIbKEIp?= 
        <jeff_chang@richtek.com>
To:     Mark Brown <broonie@kernel.org>,
        Jeff Chang <richtek.jeff.chang@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: MT6660 update to 1.0.8_G
Thread-Topic: [PATCH] ASoC: MT6660 update to 1.0.8_G
Thread-Index: AQHV2w0GcMtTuyakxUCJKOCjmW3FI6gUSfWAgAD90+A=
Date:   Tue, 11 Feb 2020 02:04:42 +0000
Message-ID: <a9895e583c9b47608aeb3e29d7852f47@ex1.rt.l>
References: <1580787697-3041-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20200210185121.GC14166@sirena.org.uk>
In-Reply-To: <20200210185121.GC14166@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.94.128]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mark:

Thanks for your replying.

This INIT SETTING is always be set, and we don't want anyone to modify it.

What should I do is just apply them to be hard code into the driver? I cannot use event a table to descript it like below?

static const struct codec_reg_val e4_reg_inits[] = {
        { MT6660_REG_WDT_CTRL, 0x80, 0x00 },
        { MT6660_REG_SPS_CTRL, 0x01, 0x00 },
        { MT6660_REG_AUDIO_IN2_SEL, 0x1c, 0x04 },
        { MT6660_REG_RESV11, 0x0c, 0x00 },
        { MT6660_REG_RESV31, 0x03, 0x03 },
        { MT6660_REG_RESV40, 0x01, 0x00 },
        { MT6660_REG_RESV0, 0x44, 0x04 },
        { MT6660_REG_RESV19, 0xff, 0x82 },
        { MT6660_REG_RESV17, 0x7777, 0x7273 },
        { MT6660_REG_RESV16, 0x07, 0x03 },
        { MT6660_REG_DRE_CORASE, 0xe0, 0x20 },
        { MT6660_REG_ADDA_CLOCK, 0xff, 0x70 },
        { MT6660_REG_RESV21, 0xff, 0x20 },
        { MT6660_REG_DRE_THDMODE, 0xff, 0x40 },
        { MT6660_REG_RESV23, 0xffff, 0x17f8 },
        { MT6660_REG_PWM_CTRL, 0xff, 0x15 },
        { MT6660_REG_ADC_USB_MODE, 0xff, 0x00 },
        { MT6660_REG_PROTECTION_CFG, 0xff, 0x1d },
        { MT6660_REG_HPF1_COEF, 0xffffffff, 0x7fdb7ffe },
        { MT6660_REG_HPF2_COEF, 0xffffffff, 0x7fdb7ffe },
        { MT6660_REG_SIG_GAIN, 0xff, 0x58 },
        { MT6660_REG_RESV6, 0xff, 0xce },
        { MT6660_REG_SIGMAX, 0xffff, 0x7fff },
        { MT6660_REG_DA_GAIN, 0xffff, 0x0116 },
        { MT6660_REG_TDM_CFG3, 0x1800, 0x0800 },
        { MT6660_REG_DRE_CTRL, 0x1f, 0x07 },
};

Just hard coded??


Thanks & BRs
Jeff Chang
Tel 886-3-5526789 Ext 2357
14F, No. 8, Taiyuen 1st st., Zhubei City,
Hsinchu County, Taiwan 30288



-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org]
Sent: Tuesday, February 11, 2020 2:51 AM
To: Jeff Chang <richtek.jeff.chang@gmail.com>
Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com; matthias.bgg@gmail.com; alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; jeff_chang(張世佳) <jeff_chang@richtek.com>
Subject: Re: [PATCH] ASoC: MT6660 update to 1.0.8_G

On Tue, Feb 04, 2020 at 11:41:37AM +0800, Jeff Chang wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
>
> 1. add parsing register initial table via device tree.
> 2. add applying initial register value function at component driver.

OK, so there's still a problem with the whole concept of putting "initial register settings" in the device tree - this is clearly not idiomatic for an ASoC driver.  If there are machine specific settings that need to be done unconditionally (eg, values controlled by external passive components) there should be specific properties for them.  If there are runtime options these should be normal ALSA controls with the default values being whatever the hardware defaults are.  If there are things that should just always be set no matter what then they should just be hard coded into the driver.
************* Email Confidentiality Notice ********************

The information contained in this e-mail message (including any attachments) may be confidential, proprietary, privileged, or otherwise exempt from disclosure under applicable laws. It is intended to be conveyed only to the designated recipient(s). Any use, dissemination, distribution, printing, retaining or copying of this e-mail (including its attachments) by unintended recipient(s) is strictly prohibited and may be unlawful. If you are not an intended recipient of this e-mail, or believe that you have received this e-mail in error, please notify the sender immediately (by replying to this e-mail), delete any and all copies of this e-mail (including any attachments) from your system, and do not disclose the content of this e-mail to any other person. Thank you!
