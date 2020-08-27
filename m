Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD58C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EF92080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzvYTWj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgH0Twl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Twk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:52:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C62C061264;
        Thu, 27 Aug 2020 12:52:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i13so3201453pjv.0;
        Thu, 27 Aug 2020 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K5jvVD4VIIV8wGZrtcs6gpFqN1LA4X86PyXeJdT5ovU=;
        b=QzvYTWj9d4lEogerahxM0ZR+vIxQTSzo/Y838zEuYdmgIVy9eTYpCqI40gbfr9VnX7
         GlnRCgy8B7q43Le64oQSMqm/eBAsDEf3loKMX8sqz+a7kHVGoo7augbihKj3FTl3ryI9
         xUR5g2lIhcjLRBfxnuHLOdu0pwi8SfKXN60YVmhWiDEsf0B66BjUDP93KWqY0+HSaU8L
         MPy+UIq+X2gl5gmK4g1+JsBDEUWXQXXGpmouWJpPR9m5GqeEthIblcCgqAdOEbSsXuEi
         2wchWTvGScayYk5djgFb4tidiJ05/Q+7W+pqBHrZbykZ9HXy9MTsdQ/+bJrsba/yo7tH
         gutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K5jvVD4VIIV8wGZrtcs6gpFqN1LA4X86PyXeJdT5ovU=;
        b=eifeR3plG266INlUCHtYjkwbZdQDkC8iH0CMoHVh9heniN/Rkj5YZmjT2J6ILFUBrE
         SgS0OAEXRvm0eagZ7HZX+RGIX8OiJotFT2ZT0EUjQBCY5SsZqiCJFWLl2g9MYAykbg56
         QUrICx9pAMZAfVUAi5KvISXiWIvMXs6bXo7wKO2DOy/9dUkUquoR0DNpGFVPAf26D6jR
         FM4d0lGHledllQYAukuQmO0UY4cXKbgkvFgDJ2lGf9IxlrNZqQPvHVRlXoqVNcDRNY3d
         DbNOZUVxRtnlbHXlhJMceaa7nQ7OO8K7TrtyEyxuJNqJdlcJavxMOlsXXRfbj3+2wa3I
         LH2g==
X-Gm-Message-State: AOAM531wwg0fe5yQ5WnqhdwGFxV9VqPwbh5vm0gRWhL0XiFeFYoA6eDY
        pbLfEa2ok4qYCSepbxMP+I7iFzSs560=
X-Google-Smtp-Source: ABdhPJwzsW013QhY4Rc3g/9/WBIEMyvJj0rYHJRY3+3oNim+C0DctJzYy/ABbFGpXjDNvPXcv8NWFw==
X-Received: by 2002:a17:90a:aa8a:: with SMTP id l10mr428350pjq.110.1598557959593;
        Thu, 27 Aug 2020 12:52:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a200sm3661988pfd.182.2020.08.27.12.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 12:52:39 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:52:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     lemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (k10temp) Create common functions and macros
 for Zen CPU families
Message-ID: <20200827195238.GA233879@roeck-us.net>
References: <20200827054242.2347-1-wei.huang2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827054242.2347-1-wei.huang2@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:42:41AM -0500, Wei Huang wrote:
> Many SMN thermal registers in Zen CPU families are common across different
> generations. For long-term code maintenance, it is better to rename these
> macro and function names to Zen.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/k10temp.c | 56 +++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 8f12995ec133..f3addb97b021 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -73,22 +73,24 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
>  #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
>  
> -/* F17h M01h Access througn SMN */
> -#define F17H_M01H_REPORTED_TEMP_CTRL_OFFSET	0x00059800
> +/* Common for Zen CPU families (Family 17h and 18h) */
> +#define ZEN_REPORTED_TEMP_CTRL_OFFSET		0x00059800
>  
> -#define F17H_M70H_CCD_TEMP(x)			(0x00059954 + ((x) * 4))
> -#define F17H_M70H_CCD_TEMP_VALID		BIT(11)
> -#define F17H_M70H_CCD_TEMP_MASK			GENMASK(10, 0)
> +#define ZEN_CCD_TEMP(x)				(0x00059954 + ((x) * 4))
> +#define ZEN_CCD_TEMP_VALID			BIT(11)
> +#define ZEN_CCD_TEMP_MASK			GENMASK(10, 0)
>  
> -#define F17H_M01H_SVI				0x0005A000
> -#define F17H_M01H_SVI_TEL_PLANE0		(F17H_M01H_SVI + 0xc)
> -#define F17H_M01H_SVI_TEL_PLANE1		(F17H_M01H_SVI + 0x10)
> +#define ZEN_CUR_TEMP_SHIFT			21
> +#define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
>  
> -#define CUR_TEMP_SHIFT				21
> -#define CUR_TEMP_RANGE_SEL_MASK			BIT(19)
> +#define ZEN_SVI_BASE				0x0005A000
>  
> -#define CFACTOR_ICORE				1000000	/* 1A / LSB	*/
> -#define CFACTOR_ISOC				250000	/* 0.25A / LSB	*/
> +/* F17h thermal registers through SMN */
> +#define F17H_M01H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0xc)
> +#define F17H_M01H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)
> +
> +#define F17H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
> +#define F17H_CFACTOR_ISOC			250000	/* 0.25A / LSB	*/
>  
>  struct k10temp_data {
>  	struct pci_dev *pdev;
> @@ -168,10 +170,10 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>  			  F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
>  }
>  
> -static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
> +static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>  {
>  	amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -		     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
> +		     ZEN_REPORTED_TEMP_CTRL_OFFSET, regval);
>  }
>  
>  static long get_raw_temp(struct k10temp_data *data)
> @@ -180,7 +182,7 @@ static long get_raw_temp(struct k10temp_data *data)
>  	long temp;
>  
>  	data->read_tempreg(data->pdev, &regval);
> -	temp = (regval >> CUR_TEMP_SHIFT) * 125;
> +	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
>  	if (regval & data->temp_adjust_mask)
>  		temp -= 49000;
>  	return temp;
> @@ -288,8 +290,8 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>  			break;
>  		case 2 ... 9:		/* Tccd{1-8} */
>  			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> -				     F17H_M70H_CCD_TEMP(channel - 2), &regval);
> -			*val = (regval & F17H_M70H_CCD_TEMP_MASK) * 125 - 49000;
> +				     ZEN_CCD_TEMP(channel - 2), &regval);
> +			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
>  			break;
>  		default:
>  			return -EOPNOTSUPP;
> @@ -438,7 +440,7 @@ static int svi_show(struct seq_file *s, void *unused)
>  {
>  	struct k10temp_data *data = s->private;
>  
> -	k10temp_smn_regs_show(s, data->pdev, F17H_M01H_SVI, 32);
> +	k10temp_smn_regs_show(s, data->pdev, ZEN_SVI_BASE, 32);
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(svi);
> @@ -448,7 +450,7 @@ static int thm_show(struct seq_file *s, void *unused)
>  	struct k10temp_data *data = s->private;
>  
>  	k10temp_smn_regs_show(s, data->pdev,
> -			      F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, 256);
> +			      ZEN_REPORTED_TEMP_CTRL_OFFSET, 256);
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(thm);
> @@ -528,8 +530,8 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
>  
>  	for (i = 0; i < limit; i++) {
>  		amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -			     F17H_M70H_CCD_TEMP(i), &regval);
> -		if (regval & F17H_M70H_CCD_TEMP_VALID)
> +			     ZEN_CCD_TEMP(i), &regval);
> +		if (regval & ZEN_CCD_TEMP_VALID)
>  			data->show_temp |= BIT(TCCD_BIT(i));
>  	}
>  }
> @@ -565,8 +567,8 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		data->read_htcreg = read_htcreg_nb_f15;
>  		data->read_tempreg = read_tempreg_nb_f15;
>  	} else if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
> -		data->temp_adjust_mask = CUR_TEMP_RANGE_SEL_MASK;
> -		data->read_tempreg = read_tempreg_nb_f17;
> +		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
> +		data->read_tempreg = read_tempreg_nb_zen;
>  		data->show_temp |= BIT(TDIE_BIT);	/* show Tdie */
>  		data->is_zen = true;
>  
> @@ -578,15 +580,15 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			data->show_current = !is_threadripper() && !is_epyc();
>  			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE0;
>  			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE1;
> -			data->cfactor[0] = CFACTOR_ICORE;
> -			data->cfactor[1] = CFACTOR_ISOC;
> +			data->cfactor[0] = F17H_CFACTOR_ICORE;
> +			data->cfactor[1] = F17H_CFACTOR_ISOC;
>  			k10temp_get_ccd_support(pdev, data, 4);
>  			break;
>  		case 0x31:	/* Zen2 Threadripper */
>  		case 0x71:	/* Zen2 */
>  			data->show_current = !is_threadripper() && !is_epyc();
> -			data->cfactor[0] = CFACTOR_ICORE;
> -			data->cfactor[1] = CFACTOR_ISOC;
> +			data->cfactor[0] = F17H_CFACTOR_ICORE;
> +			data->cfactor[1] = F17H_CFACTOR_ISOC;
>  			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
>  			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
>  			k10temp_get_ccd_support(pdev, data, 8);
