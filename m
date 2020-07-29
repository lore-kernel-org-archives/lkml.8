Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D888C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F5D2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ij1538Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgG2KMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2KMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:12:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F9C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:12:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so21016808wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bSsm6+ROJuALFtrMeDb0wI7w+MBuW+2ny+CK2brgpr4=;
        b=Ij1538JxqLS0UdP0Jjh1BbXniiGNONwUv2b91lvzhodcD6+3GivXfjfCMbiVnzG7tH
         J1N3wOko/e0eurEbY2u5ndm/PC4szSULthPh6VjSKsNTgXg6/lx+QAqHqn1D4qbGhzqY
         7QVabqfxJh38abML9IdJk523uyTzRoL4ewqzo3h15IaAUX+dZ1BbjujZQ5EGVzhOJud2
         mwmpIjhG5M2ZD7jRlKxLx9ONcLfOcXfup7A370tFDtd7I+B4uFhHW3NjDu+XTT5kNWoL
         KVnEChCeZrMm6mwjL3j4jScrdy4d5VOSXXhRtNJrRh95CYFaFwWx1ZjSL2QrHufnsAcn
         01vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bSsm6+ROJuALFtrMeDb0wI7w+MBuW+2ny+CK2brgpr4=;
        b=Ae3C0ZQhRUK87ctTYN3UTYoxrrKbuyN/QkLlcurMf5qmj7HvIUgTriztPOOHiZNUEG
         ctQ5TTCKElE8jVN70+0EwK0gb+O/837AUf4rn+Vfqd8POYe91RX3slirrlz982ezaz7m
         U3BXO7OQ0YDPewUGPoWR8DreL4g6vX6ZSlRhtpQChNeVrUvgHyQ0+UH3VUwDxJkEUOmW
         gmNb7DFzrnuGr5PSUZBnI2S4pbyuiOHIC+ptGk6OiTEZZCD2YNSCXARZGcVbnhCUercc
         0ExlHsdaSyJAUmXUrBlAWqx5ybvkkGMmCVkTx732HZd1rY+frQMq/Oc2bYKyjHTp+0ST
         AxGw==
X-Gm-Message-State: AOAM531AeR44TClA6xg5EEOL5SFZfXxPi9sWT9NBOGpFhF9Vi+W6GRHc
        lw4ZaWWUPXlR2LAIX/Hzb208/g==
X-Google-Smtp-Source: ABdhPJwGLdrFk0ZqZvAI8npA5oWpxSNsTa9TV+rybiC5akILllTcN6wlM4pLt1hPbpqJMl0Etya/+w==
X-Received: by 2002:adf:c142:: with SMTP id w2mr27468220wre.337.1596017568129;
        Wed, 29 Jul 2020 03:12:48 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id r16sm5677511wrr.13.2020.07.29.03.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 03:12:46 -0700 (PDT)
Date:   Wed, 29 Jul 2020 11:12:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 9/9] mfd: mt6360: Merge different sub-devices i2c
 read/write
Message-ID: <20200729101244.GH2419169@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-10-git-send-email-gene.chen.richtek@gmail.com>
 <20200727124306.GP1850026@dell>
 <CAE+NS354H-j5UKa+JxHzvwinpPN9QR176ugFVt+UYyJFsOMg0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS354H-j5UKa+JxHzvwinpPN9QR176ugFVt+UYyJFsOMg0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年7月27日 週一 下午8:43寫道：
> >
> > On Fri, 17 Jul 2020, Gene Chen wrote:
> >
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Remove unuse register definition.
> >
> > This should not be in here.
> >
> > > Merge different sub-devices i2c read/write function into one regmap,
> >
> > "I2C", "functions", "Regmap".
> >
> 
> ACK
> 
> > > because pmic and ldo part need crc bits for access protection.
> >
> > "PMIC", "LDO", "CRC".
> >
> 
> ACK
> 
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > ---
> > >  drivers/mfd/Kconfig        |   1 +
> > >  drivers/mfd/mt6360-core.c  | 229 +++++++++++++++++++++++++++++++++++++-----
> > >  include/linux/mfd/mt6360.h | 240 ---------------------------------------------
> > >  3 files changed, 204 insertions(+), 266 deletions(-)
> > >  delete mode 100644 include/linux/mfd/mt6360.h
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index a37d7d1..0684ddc 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -913,6 +913,7 @@ config MFD_MT6360
> > >       select MFD_CORE
> > >       select REGMAP_I2C
> > >       select REGMAP_IRQ
> > > +     select CRC8
> > >       depends on I2C
> > >       help
> > >         Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
> > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > index 3186a7c..97ef1ad 100644
> > > --- a/drivers/mfd/mt6360-core.c
> > > +++ b/drivers/mfd/mt6360-core.c
> > > @@ -14,7 +14,46 @@
> > >  #include <linux/interrupt.h>
> > >  #include <linux/mfd/core.h>
> > >
> > > -#include <linux/mfd/mt6360.h>
> > > +enum {
> > > +     MT6360_SLAVE_TCPC = 0,
> > > +     MT6360_SLAVE_PMIC,
> > > +     MT6360_SLAVE_LDO,
> > > +     MT6360_SLAVE_PMU,
> > > +     MT6360_SLAVE_MAX,
> > > +};
> > > +
> > > +struct mt6360_data {
> > > +     struct i2c_client *i2c[MT6360_SLAVE_MAX];
> > > +     struct device *dev;
> > > +     struct regmap *regmap;
> > > +     struct regmap_irq_chip_data *irq_data;
> > > +     unsigned int chip_rev;mt6360_data
> > > +     u8 crc8_tbl[CRC8_TABLE_SIZE];
> > > +};
> >
> > Make sure all of these entries are still used.
> >
> > > +#define MT6360_PMU_SLAVEID           0x34
> > > +#define MT6360_PMIC_SLAVEID          0x1A
> > > +#define MT6360_LDO_SLAVEID           0x64
> > > +#define MT6360_TCPC_SLAVEID          0x4E
> >
> > Can these be placed into ID order?
> >
> 
> ACK
> 
> > > +#define MT6360_REG_TCPCSTART         0x00
> > > +#define MT6360_REG_TCPCEND           0xFF
> > > +#define MT6360_REG_PMICSTART         0x100
> > > +#define MT6360_REG_PMICEND           0x13B
> > > +#define MT6360_REG_LDOSTART          0x200
> > > +#define MT6360_REG_LDOEND            0x21C
> > > +#define MT6360_REG_PMUSTART          0x300
> > > +#define MT6360_PMU_DEV_INFO          0x300
> > > +#define MT6360_PMU_CHG_IRQ1          0x3D0
> > > +#define MT6360_PMU_CHG_MASK1         0x3F0
> > > +#define MT6360_REG_PMUEND            0x3FF
> > > +
> > > +/* from 0x3D0 to 0x3DF */
> >
> > We don't need this in here.
> >
> 
> ACK
> 
> > > +#define MT6360_PMU_IRQ_REGNUM                16
> > > +
> > > +#define CHIP_VEN_MASK                0xF0
> > > +#define CHIP_VEN_MT6360              0x50
> > > +#define CHIP_REV_MASK                0x0F
> > >
> > >  /* reg 0 -> 0 ~ 7 */
> > >  #define MT6360_CHG_TREG_EVT          4
> > > @@ -220,12 +259,6 @@ static const struct regmap_irq_chip mt6360_irq_chip = {
> > >       .use_ack = true,
> > >  };
> > >
> > > -static const struct regmap_config mt6360_pmu_regmap_config = {
> > > -     .reg_bits = 8,
> > > -     .val_bits = 8,
> > > -     .max_register = MT6360_PMU_MAXREG,
> > > -};
> > > -
> > >  static const struct resource mt6360_adc_resources[] = {
> > >       DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
> > >  };
> > > @@ -310,11 +343,153 @@ static int mt6360_check_vendor_info(struct mt6360_data *data)
> > >       return 0;
> > >  }
> > >
> > > -static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
> > > -     MT6360_PMU_SLAVEID,
> > > +static const u16 mt6360_slave_addrs[MT6360_SLAVE_MAX] = {
> > > +     MT6360_TCPC_SLAVEID,
> > >       MT6360_PMIC_SLAVEID,
> > >       MT6360_LDO_SLAVEID,
> > > -     MT6360_TCPC_SLAVEID,
> > > +     MT6360_PMU_SLAVEID,
> > > +};
> > > +
> > > +static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
> > > +{
> > > +     u8 flags[4] = { 0x00, 0x40, 0x80, 0xc0 };
> > > +
> > > +     if (rw_size < 1 || rw_size > 4)
> > > +             return -EINVAL;
> > > +
> > > +     *addr &= 0x3f;
> > > +     *addr |= flags[rw_size - 1];
> > > +
> > > +     return 0;
> > > +}
> >
> > You need some comments in here to explain what's going on.
> >
> 
> ACK
> 
> Is this comment readable?
> 
> /*
>  * When access sud-device PMIC and LDO part which only addressed
> 0x00~0x3F, read and write action need crc for protection.
> 
>  * Addr[5:0] is real access real register address.
>  * Addr[7:6] use to store size, maximum 4 bytes.
>
>  * When received the Addr, ic can interpret real register address and size to calculate or check crc
>  * /

Don't you think this reads better?

No need for comments then:

 #define MT6360_ADDRESS_MASK 0x3f
 #define MT6360_DATA_SIZE_1_BYTE  0x00
 #define MT6360_DATA_SIZE_2_BYTES 0x40
 #define MT6360_DATA_SIZE_3_BYTES 0x80
 #define MT6360_DATA_SIZE_4_BYTES 0xC0

 static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
 {
 	/* Address is already in encoded [5:0] */
 	*addr &= MT6360_ADDRESS_MASK;
 
 	/* Encode size [7:6] */
 	switch (rw_size) {
 	case 1:
 		*addr |= MT6360_DATA_SIZE_1_BYTE
 		break;
 	case 2:
 		*addr |= MT6360_DATA_SIZE_2_BYTES
 		break;
 	case 3:
 		*addr |= MT6360_DATA_SIZE_3_BYTES
 		break;
 	case 4:
 		*addr |= MT6360_DATA_SIZE_4_BYTES
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	return 0;
 }

> /*
>  * CRC calculation
>  * total size is 2 byte and number of access bytes
>  * 2 bytes include i2c device address, r/w bit and address which want to access
>  * others for read or write data
>  * /
> 
> > > +static int mt6360_regmap_read(void *context, const void *reg, size_t reg_size,
> > > +                           void *val, size_t val_size)
> > > +{
> > > +     struct mt6360_data *data = context;
> > > +     u8 bank = *(u8 *)reg, reg_addr = *(u8 *)(reg + 1);
> > > +     struct i2c_client *i2c = data->i2c[bank];
> > > +     bool crc_needed = false;
> > > +     u8 *buf;
> > > +     /* first two is i2c_addr + reg_addr , last is crc8 */
> > > +     int alloc_size = 2 + val_size + 1, read_size = val_size;
> > > +     u8 crc;
> > > +     int ret;
> > > +
> > > +     if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
> > > +             crc_needed = true;
> > > +             ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +             read_size += 1;
> > > +     }
> > > +
> > > +     buf = kzalloc(alloc_size, GFP_KERNEL);
> > > +     if (!buf)
> > > +             return -ENOMEM;
> > > +
> > > +     /* 7 bit slave addr + read bit */
> > > +     buf[0] = ((i2c->addr & 0x7f) << 1) + 1;
> > > +     buf[1] = reg_addr;
> > > +
> > > +     ret = i2c_smbus_read_i2c_block_data(i2c, reg_addr, read_size, buf + 2);
> > > +
> > > +     if (ret == read_size) {
> > > +             memcpy(val, buf + 2, val_size);
> > > +             if (crc_needed) {
> > > +                     crc = crc8(data->crc8_tbl, buf, val_size + 2, 0);
> > > +                     if (crc != buf[val_size + 2])
> > > +                             ret = -EIO;
> > > +             }
> > > +     }
> > > +
> > > +     kfree(buf);
> > > +
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     else if (ret != read_size)
> > > +             return -EIO;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_regmap_write(void *context, const void *val, size_t val_size)
> > > +{
> > > +     struct mt6360_data *data = context;
> > > +     u8 bank = *(u8 *)val, reg_addr = *(u8 *)(val + 1);
> > > +     struct i2c_client *i2c = data->i2c[bank];
> > > +     bool crc_needed = false;
> > > +     u8 *buf;
> > > +     /* first two is i2c_addr + reg_addr , last crc8 + dummy */
> > > +     int alloc_size = 2 + val_size + 2, write_size = val_size - 2;
> > > +     int ret;
> > > +
> > > +     if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
> > > +             crc_needed = true;
> > > +             ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size - 2);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     buf = kzalloc(alloc_size, GFP_KERNEL);
> > > +     if (!buf)
> > > +             return -ENOMEM;
> > > +
> > > +     /* 7 bit slave addr + write bit */
> > > +     buf[0] = ((i2c->addr & 0x7f) << 1);
> > > +     buf[1] = reg_addr;
> > > +     /* val need to minus regaddr 16bit */
> > > +     memcpy(buf + 2, val + 2, write_size);
> > > +
> > > +     if (crc_needed) {
> > > +             buf[val_size] = crc8(data->crc8_tbl, buf, val_size, 0);
> > > +             write_size += 2;
> > > +     }
> > > +
> > > +     ret = i2c_smbus_write_i2c_block_data(i2c,
> > > +                                          reg_addr, write_size, buf + 2);
> > > +
> > > +     kfree(buf);
> > > +
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct regmap_bus mt6360_regmap_bus = {
> > > +     .read           = mt6360_regmap_read,
> > > +     .write          = mt6360_regmap_write,
> > > +
> > > +     /* due to pmic and ldo crc access size limit */
> > > +     .max_raw_read   = 4,
> > > +     .max_raw_write  = 4,
> > > +};
> >
> > Why isn't all of the above in a Regmap driver?
> >
> 
> Do you means split out like drivers/base/regmap/regmap-ac97.c?

Yes, I do.

[...]

> > > +     i2c_set_clientdata(client, data);
> >
> > Where is this used?
> 
> I can use device to get chip_rev from dev_get_drvdata.
> According to different chip_rev, I may need apply different way to do.
> 
> > Didn't you just move the definition into this file?
> 
> ACK, I will seperate move definition into this file to new patch

That's not the point I'm making.

You can't use 'data' outside of this file, so why are you setting it
inside the clientdata area?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
