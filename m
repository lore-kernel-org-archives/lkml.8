Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E70CC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A4720722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lb0cHine"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCTKV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:21:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46293 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTKV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:21:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200320102154euoutp024207acd91109d38fab86738e27b7b1a6~9_-6izFYB2291422914euoutp02r
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:21:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200320102154euoutp024207acd91109d38fab86738e27b7b1a6~9_-6izFYB2291422914euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584699715;
        bh=vsiaxb3UbMoYLi/8/LuwCyfdOfq+4wO5tSZR1A3RFu8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Lb0cHine5Hbivlp+mWs3KiMsTTWlQOvNVNfCRN+l/AbPLhkqoYpn8T+WAxDQTVdnW
         59hmVhrLb//7hkvUAhar5lc9vZB8bHlfFDdNLyh78sYG7H8jL14OrYwlaN9oKPTtZF
         v+9Z6VyMHLm+e9aDi0qrZdcTNxLPkZ9xzrgrKILc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200320102154eucas1p2703151a38b51d852a78bd0c0bab6c977~9_-6NKSTq3252132521eucas1p2O;
        Fri, 20 Mar 2020 10:21:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AF.25.60679.249947E5; Fri, 20
        Mar 2020 10:21:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200320102154eucas1p12520a84d49a7ec8180f0c342a4a85bbd~9_-5zWn3O1516215162eucas1p16;
        Fri, 20 Mar 2020 10:21:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200320102154eusmtrp2ebd7036fd5ca60024c2ceb34c7170e19~9_-5yajhD2045220452eusmtrp2R;
        Fri, 20 Mar 2020 10:21:54 +0000 (GMT)
X-AuditID: cbfec7f4-516ed9c00001ed07-36-5e749942428d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.1A.07950.249947E5; Fri, 20
        Mar 2020 10:21:54 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200320102153eusmtip2553727ff41905f696b855ca5df88450b~9_-5FwZJF1867518675eusmtip26;
        Fri, 20 Mar 2020 10:21:53 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] misc: cleanup minor number definitions in c file
 into miscdevice.h
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, miguel.ojeda.sandonis@gmail.com,
        willy@haproxy.com, ksenija.stanojevic@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, jonathan@buzzard.org.uk,
        benh@kernel.crashing.org, davem@davemloft.net, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <bfdc5915-406a-4faa-2e4c-08b6d9b795b2@samsung.com>
Date:   Fri, 20 Mar 2020 11:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200311071654.335-2-zhenzhong.duan@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuzuzM6O0ctusPZVUrBQ90B724dJDSiJuBFH0JYLKKScNH9WO
        WkaF5eaKPd2s1UXNDE17uGqyumomRmpvy15uRfaAslZIk0RLa8dR8tvv3PM/53/+cAVGb+Om
        Crvj4iVTnBhj5HxZZ1P/k6Cw7PhtC+uzA4gnq5wlg9Ymnvw4dpwhOU/MLEm57ODIiW8BxFH3
        gSfOWymIfHK/54k985aGtNXkcKTd5uFJvvM0Iu/u3+XIOZcHkYcPnmlJZkMGS1xPy7Ur9XRg
        qI2nvwesiH6p+6ihX0qKGFpZ0q6hLvs7njobZlHnm2qGXq7r1NCTHrOW3s69ztP2vH208oWF
        pac7yxAtvtbH058V0zfgLb7LI6SY3YmSaUFouG9UuqWK2+ted6Cpu5BLRvkr0pGPAHgJ9LU8
        ZtORr6DHxQh6+it5tehF0Np1YaTzE0GBrUozOmJ59gKpjSsIskrrtWrRhWDwfAajqCbicCjq
        tSKF/XEQnEk+yygiBtsYSM0rHxZxeClkWK4Oi3Q4FG6m1HIKs3gWtH4/OqyZhDdDT8cdraqZ
        APeyP7MK++Dl0GJW9zDYAO7PFzUqz4CqrpxhM8DPBSjsyxq5ezW8vnObUXkifGtWkiocAH9d
        yrAyUOqNkPZ1ZLoKwZVzQ5yqWgZvHw94WfBazAVHzQIFAa+C5swYFf3gddcE9QY/sDptjPqs
        g7RUvbpjNpQVlXGjrumuEuYsMtrHJLOPSWMfk8b+3zYfsVeRQUqQYyMleXGctD9YFmPlhLjI
        4J17YiuQ97s+GGrurUY1f3Y0Iiwg43hdVqq8Ta8VE+Wk2EYEAmP01wVFep90EWLSQcm0Z7sp
        IUaSG9E0gTUadCEFnVv1OFKMl6Ilaa9kGu1qBJ+pyUg3eDDtfeja7pnYMz96/eRT4qPc+k2H
        ngc2rmE6Pr0aeNs9zh0WcinBsj8w5A+9gSPW6nE0uXmt2hwd3NGf23O0Lftj7pTWXSWL/JKE
        8227DKvflC/eaA07HFU7vZTfWDpnsCWZW9F3MvHX/Xl5jk5rsbnw18sjjmUNotv6lTM4Ao2s
        HCUumseYZPEftgNrBqoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+XbOzpnW5DQVP0TKDpgRON3U/BZrVHQ54I+KIKLsMus0I+dq
        Z5OMCmvWYoa3FuowG5TitNCVLc2Vt1JTy5xWaPeyxFwXTYpmRZsa7N/D+z7PjxdeASay8cMF
        BzJ0rDZDmU4TgXjP385XMWtKdbviBu6SyF1ix9Gfog4SfTt1GkNlfTk4MlyuJVDupwhU63xL
        IscdA0Dvh1+TyGK+w0MDt8sINFTsJpHVkQfQy+77BDrf6Aaot8fFR+aWQhw19tv5q0SM5+8A
        yUx7igAz6nzHY0ZtlRhTbxviMY2WlyTjaIliHM8bMOayc4zHnHPn8Jnmi1dJZqj8MFP/xIgz
        eWN1gKmq+Uky368v3ERtF8u1Gr2OjUzTcLqV9A4JkoolMiSWJsjEkviknSukiXSsQr6PTT+Q
        yWpjFXvEaSbjLeLQcPKRjokKIhtYV5pAgABSCdDoegJMIFAgoioAvDlayDcBgXcRATtrM2ed
        YPj7qYmYdcYB/OE0k75FMLUHVk4VAR+HUDEwP7sA80kYVYzB1vr3vNmiFcCvnjbMZxHUClho
        rJ4phJQC3jA0ET7GqSj4ePzkjBNKbYPtDZY5ZwF8UDqC+ziAksOuHPuMg1HR8He5a47D4PDI
        Jd4sL4K3PpdhBUBk8cstfonFL7H4JVaAV4MQVs+pVWpOKuaUak6foRLv1aivA++bODp+1TcA
        05ctbYASAHq+sOQMt0vEV2ZyWeo2AAUYHSKMUXlHwn3KrKOsVrNbq09nuTaQ6D2uEAsP3avx
        Pl2GbrckUZKEZJKk+KT45YgOE56lWlNElEqpYw+y7CFW+7/jCQLCs8GlyCr+zaXyeRNjx1IN
        ayPmDy6rC0rYQL5oamYfyu/pc+8GbDzREIYXJJe/bYyPm5qOFuZvHrLz+rKkiy9cO0jbB/en
        JSw6Zb2mWL0E9T5KOdYVVPoV8qXrJj9OulKsZtkU3b/6jcJtezY1trX9uCe6ykWtT930YWS5
        k+y+UlM3QuNcmlKyDNNyyn8XkiAuPAMAAA==
X-CMS-MailID: 20200320102154eucas1p12520a84d49a7ec8180f0c342a4a85bbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200311071746eucas1p184ac8a39702757fd5541ea518a6cd923
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200311071746eucas1p184ac8a39702757fd5541ea518a6cd923
References: <20200311071654.335-1-zhenzhong.duan@gmail.com>
        <CGME20200311071746eucas1p184ac8a39702757fd5541ea518a6cd923@eucas1p1.samsung.com>
        <20200311071654.335-2-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/20 8:16 AM, Zhenzhong Duan wrote:
> HWRNG_MINOR and RNG_MISCDEV_MINOR are duplicate definitions, use
> unified HWRNG_MINOR instead and moved into miscdevice.h
> 
> ANSLCD_MINOR and LCD_MINOR are duplicate definitions, use unified
> LCD_MINOR instead and moved into miscdevice.h
> 
> MISCDEV_MINOR is renamed to PXA3XX_GCU_MINOR and moved into
> miscdevice.h
> 
> Other definitions are just moved without any change.
> 
> Link: https://protect2.fireeye.com/url?k=5cdcd693-0116e324-5cdd5ddc-0cc47a3003e8-9aee128ff3e02503&u=https://lore.kernel.org/lkml/20200120221323.GJ15860@mit.edu/t/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Build-tested-by: Willy TARREAU <wtarreau@haproxy.com>
> Build-tested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  arch/um/drivers/random.c         |  4 +---
>  drivers/auxdisplay/charlcd.c     |  2 --
>  drivers/auxdisplay/panel.c       |  2 --
>  drivers/char/applicom.c          |  1 -
>  drivers/char/nwbutton.h          |  1 -
>  drivers/char/toshiba.c           |  2 --
>  drivers/macintosh/ans-lcd.c      |  2 +-
>  drivers/macintosh/ans-lcd.h      |  2 --
>  drivers/macintosh/via-pmu.c      |  3 ---
>  drivers/sbus/char/envctrl.c      |  2 --
>  drivers/sbus/char/uctrl.c        |  2 --
>  drivers/video/fbdev/pxa3xx-gcu.c |  7 +++----
>  include/linux/miscdevice.h       | 10 ++++++++++
>  kernel/power/user.c              |  2 --
>  14 files changed, 15 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
> index 1d5d305..ce115fc 100644
> --- a/arch/um/drivers/random.c
> +++ b/arch/um/drivers/random.c
> @@ -23,8 +23,6 @@
>  #define RNG_VERSION "1.0.0"
>  #define RNG_MODULE_NAME "hw_random"
>  
> -#define RNG_MISCDEV_MINOR		183 /* official */
> -
>  /* Changed at init time, in the non-modular case, and at module load
>   * time, in the module case.  Presumably, the module subsystem
>   * protects against a module being loaded twice at the same time.
> @@ -104,7 +102,7 @@ static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
>  
>  /* rng_init shouldn't be called more than once at boot time */
>  static struct miscdevice rng_miscdev = {
> -	RNG_MISCDEV_MINOR,
> +	HWRNG_MINOR,
>  	RNG_MODULE_NAME,
>  	&rng_chrdev_ops,
>  };
> diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> index c0da382..d58278a 100644
> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -22,8 +22,6 @@
>  
>  #include "charlcd.h"
>  
> -#define LCD_MINOR		156
> -
>  #define DEFAULT_LCD_BWIDTH      40
>  #define DEFAULT_LCD_HWIDTH      64
>  
> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> index 85965953..99980aa 100644
> --- a/drivers/auxdisplay/panel.c
> +++ b/drivers/auxdisplay/panel.c
> @@ -57,8 +57,6 @@
>  
>  #include "charlcd.h"
>  
> -#define KEYPAD_MINOR		185
> -
>  #define LCD_MAXBYTES		256	/* max burst write */
>  
>  #define KEYPAD_BUFFER		64
> diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> index 51121a4..14b2d80 100644
> --- a/drivers/char/applicom.c
> +++ b/drivers/char/applicom.c
> @@ -53,7 +53,6 @@
>  #define MAX_BOARD 8		/* maximum of pc board possible */
>  #define MAX_ISA_BOARD 4
>  #define LEN_RAM_IO 0x800
> -#define AC_MINOR 157
>  
>  #ifndef PCI_VENDOR_ID_APPLICOM
>  #define PCI_VENDOR_ID_APPLICOM                0x1389
> diff --git a/drivers/char/nwbutton.h b/drivers/char/nwbutton.h
> index 9dedfd7..f2b9fdc 100644
> --- a/drivers/char/nwbutton.h
> +++ b/drivers/char/nwbutton.h
> @@ -14,7 +14,6 @@
>  #define NUM_PRESSES_REBOOT 2	/* How many presses to activate shutdown */
>  #define BUTTON_DELAY 30 	/* How many jiffies for sequence to end */
>  #define VERSION "0.3"		/* Driver version number */
> -#define BUTTON_MINOR 158	/* Major 10, Minor 158, /dev/nwbutton */
>  
>  /* Structure definitions: */
>  
> diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
> index 98f3150..aff0a8e 100644
> --- a/drivers/char/toshiba.c
> +++ b/drivers/char/toshiba.c
> @@ -61,8 +61,6 @@
>  #include <linux/mutex.h>
>  #include <linux/toshiba.h>
>  
> -#define TOSH_MINOR_DEV 181
> -
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Jonathan Buzzard <jonathan@buzzard.org.uk>");
>  MODULE_DESCRIPTION("Toshiba laptop SMM driver");
> diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
> index b1314d1..b4821c7 100644
> --- a/drivers/macintosh/ans-lcd.c
> +++ b/drivers/macintosh/ans-lcd.c
> @@ -142,7 +142,7 @@
>  };
>  
>  static struct miscdevice anslcd_dev = {
> -	ANSLCD_MINOR,
> +	LCD_MINOR,
>  	"anslcd",
>  	&anslcd_fops
>  };
> diff --git a/drivers/macintosh/ans-lcd.h b/drivers/macintosh/ans-lcd.h
> index f0a6e4c..bca7d76 100644
> --- a/drivers/macintosh/ans-lcd.h
> +++ b/drivers/macintosh/ans-lcd.h
> @@ -2,8 +2,6 @@
>  #ifndef _PPC_ANS_LCD_H
>  #define _PPC_ANS_LCD_H
>  
> -#define ANSLCD_MINOR		156
> -
>  #define ANSLCD_CLEAR		0x01
>  #define ANSLCD_SENDCTRL		0x02
>  #define ANSLCD_SETSHORTDELAY	0x03
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index d38fb78..83eb05b 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -75,9 +75,6 @@
>  /* Some compile options */
>  #undef DEBUG_SLEEP
>  
> -/* Misc minor number allocated for /dev/pmu */
> -#define PMU_MINOR		154
> -
>  /* How many iterations between battery polls */
>  #define BATTERY_POLLING_COUNT	2
>  
> diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
> index 12d66aa..843e830 100644
> --- a/drivers/sbus/char/envctrl.c
> +++ b/drivers/sbus/char/envctrl.c
> @@ -37,8 +37,6 @@
>  #define DRIVER_NAME	"envctrl"
>  #define PFX		DRIVER_NAME ": "
>  
> -#define ENVCTRL_MINOR	162
> -
>  #define PCF8584_ADDRESS	0x55
>  
>  #define CONTROL_PIN	0x80
> diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
> index 7173a2e..37d252f2 100644
> --- a/drivers/sbus/char/uctrl.c
> +++ b/drivers/sbus/char/uctrl.c
> @@ -23,8 +23,6 @@
>  #include <asm/io.h>
>  #include <asm/pgtable.h>
>  
> -#define UCTRL_MINOR	174
> -
>  #define DEBUG 1
>  #ifdef DEBUG
>  #define dprintk(x) printk x
> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
> index 74ffb44..4279e13 100644
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -36,7 +36,6 @@
>  #include "pxa3xx-gcu.h"
>  
>  #define DRV_NAME	"pxa3xx-gcu"
> -#define MISCDEV_MINOR	197
>  
>  #define REG_GCCR	0x00
>  #define GCCR_SYNC_CLR	(1 << 9)
> @@ -595,7 +594,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
>  	 * container_of(). This isn't really necessary as we have a fixed minor
>  	 * number anyway, but this is to avoid statics. */
>  
> -	priv->misc_dev.minor	= MISCDEV_MINOR,
> +	priv->misc_dev.minor	= PXA3XX_GCU_MINOR,
>  	priv->misc_dev.name	= DRV_NAME,
>  	priv->misc_dev.fops	= &pxa3xx_gcu_miscdev_fops;
>  
> @@ -638,7 +637,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
>  	ret = misc_register(&priv->misc_dev);
>  	if (ret < 0) {
>  		dev_err(dev, "misc_register() for minor %d failed\n",
> -			MISCDEV_MINOR);
> +			PXA3XX_GCU_MINOR);
>  		goto err_free_dma;
>  	}
>  
> @@ -714,7 +713,7 @@ static int pxa3xx_gcu_remove(struct platform_device *pdev)
>  
>  MODULE_DESCRIPTION("PXA3xx graphics controller unit driver");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS_MISCDEV(MISCDEV_MINOR);
> +MODULE_ALIAS_MISCDEV(PXA3XX_GCU_MINOR);
>  MODULE_AUTHOR("Janine Kropp <nin@directfb.org>, "
>  		"Denis Oliver Kropp <dok@directfb.org>, "
>  		"Daniel Mack <daniel@caiaq.de>");
> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> index becde69..42360fc 100644
> --- a/include/linux/miscdevice.h
> +++ b/include/linux/miscdevice.h
> @@ -31,14 +31,23 @@
>  #define DMAPI_MINOR		140	/* unused */
>  #define NVRAM_MINOR		144
>  #define SGI_MMTIMER		153
> +#define PMU_MINOR		154
>  #define STORE_QUEUE_MINOR	155	/* unused */
> +#define LCD_MINOR		156
> +#define AC_MINOR		157
> +#define BUTTON_MINOR		158	/* Major 10, Minor 158, /dev/nwbutton */
> +#define ENVCTRL_MINOR		162
>  #define I2O_MINOR		166
> +#define UCTRL_MINOR		174
>  #define AGPGART_MINOR		175
> +#define TOSH_MINOR_DEV		181
>  #define HWRNG_MINOR		183
>  #define MICROCODE_MINOR		184
> +#define KEYPAD_MINOR		185
>  #define IRNET_MINOR		187
>  #define D7S_MINOR		193
>  #define VFIO_MINOR		196
> +#define PXA3XX_GCU_MINOR	197
>  #define TUN_MINOR		200
>  #define CUSE_MINOR		203
>  #define MWAVE_MINOR		219	/* ACP/Mwave Modem */
> @@ -49,6 +58,7 @@
>  #define MISC_MCELOG_MINOR	227
>  #define HPET_MINOR		228
>  #define FUSE_MINOR		229
> +#define SNAPSHOT_MINOR		231
>  #define KVM_MINOR		232
>  #define BTRFS_MINOR		234
>  #define AUTOFS_MINOR		235
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 7743895..98fb659 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -27,8 +27,6 @@
>  #include "power.h"
>  
>  
> -#define SNAPSHOT_MINOR	231
> -
>  static struct snapshot_data {
>  	struct snapshot_handle handle;
>  	int swap;
> 
