Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506F0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2363320720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y9s8HvF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgGHMov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:44:51 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46973 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgGHMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594212290; x=1625748290;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=OTNllXcKj4ng7MVkeNDPreWgKHAYgBPWbIJhVTn13l4=;
  b=Y9s8HvF+hCMSoaAQakVkeA0l2TfkQSV6J5N+daSaiyZDWpNqb3TLv4DW
   hY/T/pUK4NNZ4/uzh5ZdiCbT6Awp8sOW/hunQjxWU0Od+rcF3htX5sTfQ
   5Uu/j119azMYvSxHqwxld9rJ4bjudTCfugm8G6QDXsDLFIhMoTlJBEeA7
   9ZE8fkXoo2s8myC/WhHwgMXvoUlcZ+qcBpnqmymCFTx2odVWtEDrP6oT8
   zKIT1oGV248VC0yPIYPsR3bDfAyMCHYQkrqkm7H/GxqvkEY4LVxplBKOw
   xujHPYR5Uc0q7SLdyR+Z4zakyDBxEgcmeJSyCsFYfLvjEf6xoy262FGQ0
   w==;
IronPort-SDR: CuzNpjIFcAEmk38J+M3T4zdKgyBMGsUID/XJR4JPM5QuFke8G6G2kAYXNO85r2FQXHNB2mB+V0
 +loFoCzDd7NjritOeFX6+B4UTRx3DO2Jt2cdTHMbNTIci/rQr/aPrGgt1Z5tx+qQXo9s0zgEk9
 TmBJPYwNwnwuT2R2of2AYaaQx8NFsDXkHDWx6NHEApxU0t7Nx/m2HFqVGO/5sFJy6/8Hb1Iru3
 houzyi+Af/ofkhnUJdOPra7L9xotByap1RGDSju3csSslPxVHwVCaS3p6QhwPpJIbvlZYMBATg
 dUw=
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="86648297"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2020 05:44:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 05:44:48 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 8 Jul 2020 05:44:21 -0700
Subject: Re: [PATCH v2] Replace HTTP links with HTTPS ones: Documentation/arm
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, <corbet@lwn.net>,
        <mchehab+samsung@kernel.org>, <alexandre.belloni@bootlin.com>,
        <robh@kernel.org>, <j.neuschaefer@gmx.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200626194408.61245-1-grandmaster@al2klimov.de>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <daf3937c-faab-1b3b-e60a-f7deda68bc0c@microchip.com>
Date:   Wed, 8 Jul 2020 14:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626194408.61245-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 at 21:44, Alexander A. Klimov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>    If not .svg:
>      For each line:
>        If doesn't contain `\bxmlns\b`:
>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>            If both the HTTP and HTTPS versions
>            return 200 OK and serve the same content:
>              Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>   Changes in v2:
>   Undone all handhelds.org changes and 0 of 0 wearablegroup.org changes.
> 
>   Documentation/arm/arm.rst                     |  8 ++---
>   Documentation/arm/keystone/overview.rst       |  4 +--
>   Documentation/arm/microchip.rst               | 30 +++++++++----------

For Microchip changes, which is larger chunk:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

>   Documentation/arm/sa1100/assabet.rst          |  2 +-
>   .../arm/samsung-s3c24xx/overview.rst          |  4 +--
>   5 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/arm/arm.rst b/Documentation/arm/arm.rst
> index 2edc509df92a..4f8c4985191f 100644
> --- a/Documentation/arm/arm.rst
> +++ b/Documentation/arm/arm.rst
> @@ -48,12 +48,12 @@ Bug reports etc
>   ---------------
> 
>     Please send patches to the patch system.  For more information, see
> -  http://www.arm.linux.org.uk/developer/patches/info.php Always include some
> +  https://www.arm.linux.org.uk/developer/patches/info.php Always include some
>     explanation as to what the patch does and why it is needed.
> 
>     Bug reports should be sent to linux-arm-kernel@lists.arm.linux.org.uk,
>     or submitted through the web form at
> -  http://www.arm.linux.org.uk/developer/
> +  https://www.arm.linux.org.uk/developer/
> 
>     When sending bug reports, please ensure that they contain all relevant
>     information, eg. the kernel messages that were printed before/during
> @@ -169,7 +169,7 @@ ST506 hard drives
> 
>     Previous registrations may be found online.
> 
> -    <http://www.arm.linux.org.uk/developer/machines/>
> +    <https://www.arm.linux.org.uk/developer/machines/>
> 
>   Kernel entry (head.S)
>   ---------------------
> @@ -204,7 +204,7 @@ Kernel entry (head.S)
>     compile-time code selection method.  You can register a new machine via the
>     web site at:
> 
> -    <http://www.arm.linux.org.uk/developer/machines/>
> +    <https://www.arm.linux.org.uk/developer/machines/>
> 
>     Note: Please do not register a machine type for DT-only platforms.  If your
>     platform is DT-only, you do not need a registered machine type.
> diff --git a/Documentation/arm/keystone/overview.rst b/Documentation/arm/keystone/overview.rst
> index cd90298c493c..3e4b2f8f5e8b 100644
> --- a/Documentation/arm/keystone/overview.rst
> +++ b/Documentation/arm/keystone/overview.rst
> @@ -16,7 +16,7 @@ K2HK SoC and EVM
>   a.k.a Keystone 2 Hawking/Kepler SoC
>   TCI6636K2H & TCI6636K2K: See documentation at
> 
> -       http://www.ti.com/product/tci6638k2k
> +       https://www.ti.com/product/tci6638k2k
>          http://www.ti.com/product/tci6638k2h
> 
>   EVM:
> @@ -31,7 +31,7 @@ K2E  -  66AK2E05:
> 
>   See documentation at
> 
> -       http://www.ti.com/product/66AK2E05/technicaldocuments
> +       https://www.ti.com/product/66AK2E05/technicaldocuments
> 
>   EVM:
>      https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
> diff --git a/Documentation/arm/microchip.rst b/Documentation/arm/microchip.rst
> index 9c013299fd3b..4786dd68d325 100644
> --- a/Documentation/arm/microchip.rst
> +++ b/Documentation/arm/microchip.rst
> @@ -26,44 +26,44 @@ the Microchip website: http://www.microchip.com.
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-1768-32-bit-ARM920T-Embedded-Microprocessor-AT91RM9200_Datasheet.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-1768-32-bit-ARM920T-Embedded-Microprocessor-AT91RM9200_Datasheet.pdf
> 
>       * ARM 926 based SoCs
>         - at91sam9260
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6221-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9260_Datasheet.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6221-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9260_Datasheet.pdf
> 
>         - at91sam9xe
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6254-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9XE_Datasheet.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6254-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9XE_Datasheet.pdf
> 
>         - at91sam9261
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6062-ARM926EJ-S-Microprocessor-SAM9261_Datasheet.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6062-ARM926EJ-S-Microprocessor-SAM9261_Datasheet.pdf
> 
>         - at91sam9263
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6249-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9263_Datasheet.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6249-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9263_Datasheet.pdf
> 
>         - at91sam9rl
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/doc6289.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/doc6289.pdf
> 
>         - at91sam9g20
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001516A.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/DS60001516A.pdf
> 
>         - at91sam9g45 family
>           - at91sam9g45
> @@ -73,7 +73,7 @@ the Microchip website: http://www.microchip.com.
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6437-32-bit-ARM926-Embedded-Microprocessor-SAM9M11_Datasheet.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6437-32-bit-ARM926-Embedded-Microprocessor-SAM9M11_Datasheet.pdf
> 
>         - at91sam9x5 family (aka "The 5 series")
>           - at91sam9g15
> @@ -84,19 +84,19 @@ the Microchip website: http://www.microchip.com.
> 
>             * Datasheet (can be considered as covering the whole family)
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11055-32-bit-ARM926EJ-S-Microcontroller-SAM9X35_Datasheet.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11055-32-bit-ARM926EJ-S-Microcontroller-SAM9X35_Datasheet.pdf
> 
>         - at91sam9n12
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001517A.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/DS60001517A.pdf
> 
>         - sam9x60
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/SAM9X60-Data-Sheet-DS60001579A.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/SAM9X60-Data-Sheet-DS60001579A.pdf
> 
>       * ARM Cortex-A5 based SoCs
>         - sama5d3 family
> @@ -109,7 +109,7 @@ the Microchip website: http://www.microchip.com.
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11121-32-bit-Cortex-A5-Microcontroller-SAMA5D3_Datasheet_B.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11121-32-bit-Cortex-A5-Microcontroller-SAMA5D3_Datasheet_B.pdf
> 
>       * ARM Cortex-A5 + NEON based SoCs
>         - sama5d4 family
> @@ -121,7 +121,7 @@ the Microchip website: http://www.microchip.com.
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/60001525A.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/60001525A.pdf
> 
>         - sama5d2 family
> 
> @@ -135,7 +135,7 @@ the Microchip website: http://www.microchip.com.
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
> 
>       * ARM Cortex-M7 MCUs
>         - sams70 family
> @@ -173,7 +173,7 @@ the Microchip website: http://www.microchip.com.
> 
>             * Datasheet
> 
> -          http://ww1.microchip.com/downloads/en/DeviceDoc/SAM-E70-S70-V70-V71-Family-Data-Sheet-DS60001527D.pdf
> +          https://ww1.microchip.com/downloads/en/DeviceDoc/SAM-E70-S70-V70-V71-Family-Data-Sheet-DS60001527D.pdf
> 
> 
>   Linux kernel information
> diff --git a/Documentation/arm/sa1100/assabet.rst b/Documentation/arm/sa1100/assabet.rst
> index a761e128fb08..eef26909686a 100644
> --- a/Documentation/arm/sa1100/assabet.rst
> +++ b/Documentation/arm/sa1100/assabet.rst
> @@ -6,7 +6,7 @@ Please see:
>   http://developer.intel.com
> 
>   Also some notes from John G Dorsey <jd5q@andrew.cmu.edu>:
> -http://www.cs.cmu.edu/~wearable/software/assabet.html
> +https://www.cs.cmu.edu/~wearable/software/assabet.html
> 
> 
>   Building the kernel
> diff --git a/Documentation/arm/samsung-s3c24xx/overview.rst b/Documentation/arm/samsung-s3c24xx/overview.rst
> index e9a1dc7276b5..b2eae4d86c96 100644
> --- a/Documentation/arm/samsung-s3c24xx/overview.rst
> +++ b/Documentation/arm/samsung-s3c24xx/overview.rst
> @@ -140,7 +140,7 @@ Adding New Machines
>     Read the kernel patch submission policies as well as the
>     Documentation/arm directory before submitting patches. The
>     ARM kernel series is managed by Russell King, and has a patch system
> -  located at http://www.arm.linux.org.uk/developer/patches/
> +  located at https://www.arm.linux.org.uk/developer/patches/
>     as well as mailing lists that can be found from the same site.
> 
>     As a courtesy, please notify <ben-linux@fluff.org> of any new
> @@ -148,7 +148,7 @@ Adding New Machines
> 
>     Any large scale modifications, or new drivers should be discussed
>     on the ARM kernel mailing list (linux-arm-kernel) before being
> -  attempted. See http://www.arm.linux.org.uk/mailinglists/ for the
> +  attempted. See https://www.arm.linux.org.uk/mailinglists/ for the
>     mailing list information.
> 
> 
> --
> 2.27.0
> 


-- 
Nicolas Ferre
