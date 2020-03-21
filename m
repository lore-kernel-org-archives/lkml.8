Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BEBC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CAE2076E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgR0zv4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgCUWKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:10:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34478 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgCUWKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:10:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so5376571pfj.1;
        Sat, 21 Mar 2020 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4XgCRitv/LTNpRZ/C/gVivhHXGiXohKXS/283T0EpRM=;
        b=SgR0zv4i/P14m5FFWm9cdRdEuZtmtZFwFoPcdzRmk6FB67IkKjnk+X92lAtv89+tso
         Cv2xe8VY3NDtiXpVvWshx8TTertc4ljLajygeqhXEBufr27s8L+X81gGJv5N50QBAnSV
         +nK6PH8Qo/S0DfkVyc2vmWmmAuCC58WFDtM9lmdGaOS+LwN+fM5gJ53vKGveN9PraijI
         ceXquytHDqPY7DnbVj2IpLerNT5DdrocWwiZbhaKq7hi8PJHQ031I3Q0nt2coDaF9sIC
         TvNjmhsQ9nniLZ1Db6iI8JZtdKJn6c5H/liXsuXVXIXbuI6JWM6SssuAacJDXIt05rQZ
         1olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XgCRitv/LTNpRZ/C/gVivhHXGiXohKXS/283T0EpRM=;
        b=ScWbKsBnIzY5SM37GgMQYZd/PTt+wr2A3NeI+GWKP8n41jo7BgZiJSD/FN4+5sJBMe
         uo4+qUoOe8ZKn2LcghUYL2iiIlI9i9y4F+wskyaOYS+cBTbSTbTbDqBbcNhxJlUz5glD
         4qxcYQgz4nhQ2OPF5ihiGb+gHmKz3iXx8HJgQGGiWZTFchOwtharlw63ckB3i4urBGBZ
         BDxAcYlv8r6hExOSCwpeIQuYQUHtypNcXyri6YC7hDc1GTXDRPNveWduQkzy0+YVPpB4
         WgpiTIqeptzwR70X5AhEfUoZ215Md7KU2IfaedaC8pVQhdoDHLjTV19lo+yy0mLrtPvb
         xqhQ==
X-Gm-Message-State: ANhLgQ3BUP3Gp9izWsekxzEXtTgxOX+z396nHu0OLOR6N3eoCCJ1IbG1
        oP/dLrj/lMsfwtP8rKnFRyE=
X-Google-Smtp-Source: ADFU+vtbo7IB3mnsY1zpO1R51fj9JMzNeuAKQpg1R/U+NzayMOGmHHgKY20xYoD4SXetf+0mel2ybA==
X-Received: by 2002:a62:16c4:: with SMTP id 187mr16564776pfw.325.1584828603238;
        Sat, 21 Mar 2020 15:10:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6sm8348775pgj.7.2020.03.21.15.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Mar 2020 15:10:02 -0700 (PDT)
Date:   Sat, 21 Mar 2020 15:10:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com
Subject: Re: [PATCH v3 2/2] docs: hwmon: Update documentation for isl68137
 pmbus driver
Message-ID: <20200321221001.GA22274@roeck-us.net>
References: <cover.1584720563.git.grantpeltier93@gmail.com>
 <1588e5e89d6a9623464036cf8fbdb9b18785894b.1584720563.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588e5e89d6a9623464036cf8fbdb9b18785894b.1584720563.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:16:47AM -0500, Grant Peltier wrote:
> Update documentation to include reference information for newly
> supported 2nd generation Renesas digital multiphase voltage regulators.
> Also update branding from Intersil to Renesas.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/isl68137.rst | 541 ++++++++++++++++++++++++++++++-
>  1 file changed, 533 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/isl68137.rst b/Documentation/hwmon/isl68137.rst
> index a5a7c8545c9e..cc4b61447b63 100644
> --- a/Documentation/hwmon/isl68137.rst
> +++ b/Documentation/hwmon/isl68137.rst
> @@ -3,7 +3,7 @@ Kernel driver isl68137
>  
>  Supported chips:
>  
> -  * Intersil ISL68137
> +  * Renesas ISL68137
>  
>      Prefix: 'isl68137'
>  
> @@ -11,19 +11,405 @@ Supported chips:
>  
>      Datasheet:
>  
> -      Publicly available at the Intersil website
> -      https://www.intersil.com/content/dam/Intersil/documents/isl6/isl68137.pdf
> +      Publicly available at the Renesas website
> +      https://www.renesas.com/us/en/www/doc/datasheet/isl68137.pdf
> +
> +  * Renesas ISL68220
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68221
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68222
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68223
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68224
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68225
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68226
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68227
> +
> +    Prefix: 'raa_dmpvr2_1rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68229
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68233
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL68239
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69222
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69223
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69224
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69225
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69227
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69228
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69234
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69236
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69239
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69242
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69243
> +
> +    Prefix: 'raa_dmpvr2_1rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69247
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69248
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69254
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69255
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69256
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69259
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69260
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69268
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69269
> +
> +    Prefix: 'raa_dmpvr2_3rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas ISL69298
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas RAA228000
> +
> +    Prefix: 'raa_dmpvr2_hv'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas RAA228004
> +
> +    Prefix: 'raa_dmpvr2_hv'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas RAA228006
> +
> +    Prefix: 'raa_dmpvr2_hv'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas RAA228228
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas RAA229001
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
> +
> +  * Renesas RAA229004
> +
> +    Prefix: 'raa_dmpvr2_2rail'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +      Publicly available (after August 2020 launch) at the Renesas website
>  
>  Authors:
>        - Maxim Sloyko <maxims@google.com>
>        - Robert Lippert <rlippert@google.com>
>        - Patrick Venture <venture@google.com>
> +      - Grant Peltier <grant.peltier.jg@renesas.com>
>  
>  Description
>  -----------
>  
> -Intersil ISL68137 is a digital output 7-phase configurable PWM
> -controller with an AVSBus interface.
> +This driver supports the Renesas ISL68137 and all 2nd generation Renesas
> +digital multiphase voltage regulators (raa_dmpvr2). The ISL68137 is a digital
> +output 7-phase configurable PWM controller with an AVSBus interface. 2nd
> +generation devices are grouped into 4 distinct configurations: '1rail' for
> +single-rail devices, '2rail' for dual-rail devices, '3rail' for 3-rail devices,
> +and 'hv' for high voltage single-rail devices. Consult the individual datasheets
> +for more information.
>  
>  Usage Notes
>  -----------
> @@ -33,10 +419,14 @@ devices explicitly.
>  
>  The ISL68137 AVS operation mode must be enabled/disabled at runtime.
>  
> -Beyond the normal sysfs pmbus attributes, the driver exposes a control attribute.
> +Beyond the normal sysfs pmbus attributes, the driver exposes a control attribute
> +for the ISL68137.
> +
> +For 2nd generation Renesas digital multiphase voltage regulators, only the
> +normal sysfs pmbus attributes are supported.
>  
> -Additional Sysfs attributes
> ----------------------------
> +ISL68137 sysfs attributes
> +-------------------------
>  
>  ======================= ====================================
>  avs(0|1)_enable		Controls the AVS state of each rail.
> @@ -78,3 +468,138 @@ temp[1-3]_crit_alarm	Chip temperature critical high alarm
>  temp[1-3]_max		Maximum temperature
>  temp[1-3]_max_alarm	Chip temperature high alarm
>  ======================= ====================================
> +
> +raa_dmpvr2_1rail/hv sysfs attributes
> +------------------------------------
> +
> +======================= ==========================================
> +curr1_label		"iin"
> +curr1_input		Measured input current
> +curr1_crit		Critical maximum current
> +curr1_crit_alarm	Current critical high alarm
> +
> +curr2_label		"iout"
> +curr2_input		Measured output current
> +curr2_crit		Critical maximum current
> +curr2_crit_alarm	Current critical high alarm
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_lcrit		Critical minimum input voltage
> +in1_lcrit_alarm		Input voltage critical low alarm
> +in1_crit		Critical maximum input voltage
> +in1_crit_alarm		Input voltage critical high alarm
> +
> +in2_label		"vmon"
> +in2_input		Scaled VMON voltage read from the VMON pin
> +
> +in3_label		"vout"
> +in3_input		Measured output voltage
> +in3_lcrit		Critical minimum output voltage
> +in3_lcrit_alarm         Output voltage critical low alarm
> +in3_crit		Critical maximum output voltage
> +in3_crit_alarm          Output voltage critical high alarm
> +
> +power1_label		"pin"
> +power1_input		Measured input power
> +power1_alarm		Input power high alarm
> +
> +power2_label	        "pout"
> +power2_input	        Measured output power
> +
> +temp[1-3]_input		Measured temperature
> +temp[1-3]_crit		Critical high temperature
> +temp[1-3]_crit_alarm	Chip temperature critical high alarm
> +temp[1-3]_max		Maximum temperature
> +temp[1-3]_max_alarm	Chip temperature high alarm
> +======================= ==========================================
> +
> +raa_dmpvr2_2rail sysfs attributes
> +---------------------------------
> +
> +======================= ==========================================
> +curr[1-2]_label		"iin[1-2]"
> +curr[1-2]_input		Measured input current
> +curr[1-2]_crit		Critical maximum current
> +curr[1-2]_crit_alarm	Current critical high alarm
> +
> +curr[3-4]_label		"iout[1-2]"
> +curr[3-4]_input		Measured output current
> +curr[3-4]_crit		Critical maximum current
> +curr[3-4]_crit_alarm	Current critical high alarm
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_lcrit		Critical minimum input voltage
> +in1_lcrit_alarm		Input voltage critical low alarm
> +in1_crit		Critical maximum input voltage
> +in1_crit_alarm		Input voltage critical high alarm
> +
> +in2_label		"vmon"
> +in2_input		Scaled VMON voltage read from the VMON pin
> +
> +in[3-4]_label		"vout[1-2]"
> +in[3-4]_input		Measured output voltage
> +in[3-4]_lcrit		Critical minimum output voltage
> +in[3-4]_lcrit_alarm	Output voltage critical low alarm
> +in[3-4]_crit		Critical maximum output voltage
> +in[3-4]_crit_alarm	Output voltage critical high alarm
> +
> +power[1-2]_label	"pin[1-2]"
> +power[1-2]_input	Measured input power
> +power[1-2]_alarm	Input power high alarm
> +
> +power[3-4]_label	"pout[1-2]"
> +power[3-4]_input	Measured output power
> +
> +temp[1-5]_input		Measured temperature
> +temp[1-5]_crit		Critical high temperature
> +temp[1-5]_crit_alarm	Chip temperature critical high alarm
> +temp[1-5]_max		Maximum temperature
> +temp[1-5]_max_alarm	Chip temperature high alarm
> +======================= ==========================================
> +
> +raa_dmpvr2_3rail sysfs attributes
> +---------------------------------
> +
> +======================= ==========================================
> +curr[1-3]_label		"iin[1-3]"
> +curr[1-3]_input		Measured input current
> +curr[1-3]_crit		Critical maximum current
> +curr[1-3]_crit_alarm	Current critical high alarm
> +
> +curr[4-6]_label		"iout[1-3]"
> +curr[4-6]_input		Measured output current
> +curr[4-6]_crit		Critical maximum current
> +curr[4-6]_crit_alarm	Current critical high alarm
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_lcrit		Critical minimum input voltage
> +in1_lcrit_alarm		Input voltage critical low alarm
> +in1_crit		Critical maximum input voltage
> +in1_crit_alarm		Input voltage critical high alarm
> +
> +in2_label		"vmon"
> +in2_input		Scaled VMON voltage read from the VMON pin
> +
> +in[3-5]_label		"vout[1-3]"
> +in[3-5]_input		Measured output voltage
> +in[3-5]_lcrit		Critical minimum output voltage
> +in[3-5]_lcrit_alarm	Output voltage critical low alarm
> +in[3-5]_crit		Critical maximum output voltage
> +in[3-5]_crit_alarm	Output voltage critical high alarm
> +
> +power[1-3]_label	"pin[1-3]"
> +power[1-3]_input	Measured input power
> +power[1-3]_alarm	Input power high alarm
> +
> +power[4-6]_label	"pout[1-3]"
> +power[4-6]_input	Measured output power
> +
> +temp[1-7]_input		Measured temperature
> +temp[1-7]_crit		Critical high temperature
> +temp[1-7]_crit_alarm	Chip temperature critical high alarm
> +temp[1-7]_max		Maximum temperature
> +temp[1-7]_max_alarm	Chip temperature high alarm
> +======================= ==========================================
