Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC6C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD43720678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgANKPK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:15:10 -0500
Received: from mg.richtek.com ([220.130.44.152]:47898 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732372AbgANKLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:11:22 -0500
X-Greylist: delayed 1278 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 05:11:06 EST
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(24501:0:AUTH_RELAY)
        (envelope-from <prvs=1280D00DC8=jeff_chang@richtek.com>); Tue, 14 Jan 2020 17:53:50 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.45
        by mg.richtek.com with MailGates ESMTP Server V5.0(11231:0:AUTH_RELAY)
        (envelope-from <jeff_chang@richtek.com>); Tue, 14 Jan 2020 17:48:25 +0800 (CST)
Received: from ex1.rt.l (192.168.8.44) by ex2.rt.l (192.168.8.45) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Jan 2020 17:48:25 +0800
Received: from ex1.rt.l ([fe80::557d:30f0:a3f8:3efc]) by ex1.rt.l
 ([fe80::557d:30f0:a3f8:3efc%15]) with mapi id 15.00.1497.000; Tue, 14 Jan
 2020 17:48:25 +0800
From:   =?iso-2022-jp?B?amVmZl9jaGFuZygbJEJEJUAkMkIbKEIp?= 
        <jeff_chang@richtek.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Jeff Chang <richtek.jeff.chang@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Thread-Topic: [PATCH v6] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Thread-Index: AQHVyoF7zu59+m/eWUaAClqFZAQZ1KfpQb8AgACkdmA=
Date:   Tue, 14 Jan 2020 09:48:24 +0000
Message-ID: <36357249c6ed4a989cd11535fdefef6e@ex1.rt.l>
References: <1578968526-13191-1-git-send-email-richtek.jeff.chang@gmail.com>
 <s5htv4yfpnt.wl-tiwai@suse.de>
In-Reply-To: <s5htv4yfpnt.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.95.168]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Takashi:

Thank for your replying.

1.> +static int mt6660_component_get_volsw(struct snd_kcontrol *kcontrol,
> +  struct snd_ctl_elem_value *ucontrol) {
> +struct snd_soc_component *component =
> +snd_soc_kcontrol_component(kcontrol);
> +struct mt6660_chip *chip = (struct mt6660_chip *)
> +snd_soc_component_get_drvdata(component);
> +int ret = -EINVAL;
> +
> +if (!strcmp(kcontrol->id.name, "Chip Rev")) {
> +ucontrol->value.integer.value[0] = chip->chip_rev & 0x0f;
> +ret = 0;
> +}
> +return ret;

So, "T0 SEL" control gets always an error when reading?
Then can't we pass simply NULL for get ops instead?

Jeff : T0 SEL use snd_soc_get_volsw, it will not use this function.


2. So here both 24 and 32 bits data are handled equally, and...

....
> +ret = snd_soc_component_update_bits(dai->component,
> +MT6660_REG_TDM_CFG3, 0x3f0, word_len << 4);

... word_len is same for both S32 and S24 formats, so there can be no difference between S24 and S32 format handling in the code.
Meanwhile, the supported formats are:

> +#define STUB_FORMATS(SNDRV_PCM_FMTBIT_S16_LE | \
> +SNDRV_PCM_FMTBIT_U16_LE | \
> +SNDRV_PCM_FMTBIT_S24_LE | \
> +SNDRV_PCM_FMTBIT_U24_LE | \
> +SNDRV_PCM_FMTBIT_S32_LE | \
> +SNDRV_PCM_FMTBIT_U32_LE)

Are you sure that S24_* formats really work properly?

Also, the code has no check / setup of the format signedness.
Do unsigned formats (U16, U24, etc) really work as expected, too?


Jeff :  Yes, it works.



I will create a new patch later.

Thanks & BRs
Jeff Chang
Tel 886-3-5526789 Ext 2357
14F, No. 8, Taiyuen 1st st., Zhubei City,
Hsinchu County, Taiwan 30288



-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Tuesday, January 14, 2020 3:44 PM
To: Jeff Chang <richtek.jeff.chang@gmail.com>
Cc: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz; tiwai@suse.com; matthias.bgg@gmail.com; alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; jeff_chang(張世佳) <jeff_chang@richtek.com>
Subject: Re: [PATCH v6] ASoC: Add MediaTek MT6660 Speaker Amp Driver

On Tue, 14 Jan 2020 03:22:06 +0100,
Jeff Chang wrote:
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig index
> 229cc89..f135fbb 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1465,6 +1466,16 @@ config SND_SOC_MT6358
>    Enable support for the platform which uses MT6358 as
>    external codec device.
>
> +config SND_SOC_MT6660
> +tristate "Mediatek MT6660 Speaker Amplifier"
> +depends on I2C
> +help
> +  MediaTek MT6660 is a smart power amplifier which contain
> +  speaker protection, multi-band DRC, equalizer functions.
> +  Select N if you don't have MT6660 on board.
> +  Select M to build this as module.
> +
> +

One blank line too much here.

> --- /dev/null
> +++ b/sound/soc/codecs/mt6660.c
> @@ -0,0 +1,533 @@
> +// SPDX-License-Identifier: GPL-2.0 //
> +
> +// Copyright (c) 2019 MediaTek Inc.
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/version.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/delay.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +#include <sound/pcm_params.h>
> +#include <linux/debugfs.h>

Move linux/*.h above sound/*.h inclusion.

> +
> +#include "mt6660.h"
> +
> +#pragma pack(push, 1)

Actually packing makes little sense for those use cases.
As I mentioned earlier, packing is useful only for either saving some memory (e.g. for a large array) or a strict size definition like ABI.

> +struct codec_reg_val {
> +u32 addr;
> +u32 mask;
> +u32 data;
> +};

Is this struct used anywhere?  If not, kill it.

> +static struct regmap_config mt6660_regmap_config = {

This can be const.

> +static int mt6660_codec_dac_event(struct snd_soc_dapm_widget *w,
> +struct snd_kcontrol *kcontrol, int event) {
> +

A superfluous blank line.

> +static int mt6660_component_get_volsw(struct snd_kcontrol *kcontrol,
> +  struct snd_ctl_elem_value *ucontrol) {
> +struct snd_soc_component *component =
> +snd_soc_kcontrol_component(kcontrol);
> +struct mt6660_chip *chip = (struct mt6660_chip *)
> +snd_soc_component_get_drvdata(component);
> +int ret = -EINVAL;
> +
> +if (!strcmp(kcontrol->id.name, "Chip Rev")) {
> +ucontrol->value.integer.value[0] = chip->chip_rev & 0x0f;
> +ret = 0;
> +}
> +return ret;

So, "T0 SEL" control gets always an error when reading?
Then can't we pass simply NULL for get ops instead?

> +static int _mt6660_chip_power_on(struct mt6660_chip *chip, int
> +on_off) {
> +u8 reg_data;
> +int ret;
> +
> +ret = i2c_smbus_read_byte_data(chip->i2c, MT6660_REG_SYSTEM_CTRL);
> +if (ret < 0)
> +return ret;
> +reg_data = (u8)ret;
> +if (on_off)
> +reg_data &= (~0x01);
> +else
> +reg_data |= 0x01;
> +return regmap_write(chip->regmap, MT6660_REG_SYSTEM_CTRL, reg_data);

Hm, this looks like an open-code of forced update bits via regmap.
But interestingly there is no corresponding standard helper for that.
Essentially it should be regmap_update_bits_base() with force=1.

Mark?

> +static int mt6660_component_aif_hw_params(struct snd_pcm_substream *substream,
> +struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *dai) {
> +int word_len = params_physical_width(hw_params);
> +int aud_bit = params_width(hw_params);
....
> +switch (aud_bit) {
> +case 16:
> +reg_data = 3;
> +break;
> +case 18:
> +reg_data = 2;
> +break;
> +case 20:
> +reg_data = 1;
> +break;
> +case 24:
> +case 32:
> +reg_data = 0;
> +break;

So here both 24 and 32 bits data are handled equally, and...

....
> +ret = snd_soc_component_update_bits(dai->component,
> +MT6660_REG_TDM_CFG3, 0x3f0, word_len << 4);

... word_len is same for both S32 and S24 formats, so there can be no difference between S24 and S32 format handling in the code.
Meanwhile, the supported formats are:

> +#define STUB_FORMATS(SNDRV_PCM_FMTBIT_S16_LE | \
> +SNDRV_PCM_FMTBIT_U16_LE | \
> +SNDRV_PCM_FMTBIT_S24_LE | \
> +SNDRV_PCM_FMTBIT_U24_LE | \
> +SNDRV_PCM_FMTBIT_S32_LE | \
> +SNDRV_PCM_FMTBIT_U32_LE)

Are you sure that S24_* formats really work properly?

Also, the code has no check / setup of the format signedness.
Do unsigned formats (U16, U24, etc) really work as expected, too?

> +static inline int _mt6660_chip_id_check(struct mt6660_chip *chip)

Drop unnecessary inline (here and other places).
Compiler optimizes well by itself.

> +static inline int _mt6660_chip_sw_reset(struct mt6660_chip *chip) {
> +int ret;
> +
> +/* turn on main pll first, then trigger reset */
> +ret = regmap_write(chip->regmap, 0x03, 0x00);

It's MT6660_REG_SYSTEM_CTRL, right?

> +if (ret < 0)
> +return ret;
> +ret = regmap_write(chip->regmap, MT6660_REG_SYSTEM_CTRL, 0x80);
> +if (ret < 0)
> +return ret;
> +msleep(30);
> +return 0;
> +}
> +
> +static inline int _mt6660_read_chip_revision(struct mt6660_chip
> +*chip) {
> +u8 reg_data[2];
> +int ret;
> +
> +ret = i2c_smbus_read_i2c_block_data(
> +chip->i2c, MT6660_REG_DEVID, 2, reg_data);

Why avoiding regmap here?  This and chip_id_check() use the raw access by some reason...


thanks,

Takashi
************* Email Confidentiality Notice ********************

The information contained in this e-mail message (including any attachments) may be confidential, proprietary, privileged, or otherwise exempt from disclosure under applicable laws. It is intended to be conveyed only to the designated recipient(s). Any use, dissemination, distribution, printing, retaining or copying of this e-mail (including its attachments) by unintended recipient(s) is strictly prohibited and may be unlawful. If you are not an intended recipient of this e-mail, or believe that you have received this e-mail in error, please notify the sender immediately (by replying to this e-mail), delete any and all copies of this e-mail (including any attachments) from your system, and do not disclose the content of this e-mail to any other person. Thank you!
