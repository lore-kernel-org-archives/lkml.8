Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1303C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA2C206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq3QGiTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgFBOHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgFBOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:07:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563A8C08C5C0;
        Tue,  2 Jun 2020 07:07:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o6so5127464pgh.2;
        Tue, 02 Jun 2020 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIkaVHtmcI7ZAayN2rp02gz9INiaKKtMhPyk6d6P6pM=;
        b=Qq3QGiTbEF+puo1ZXtzIaWPT7MuJKYI0butXpXyTBvJlvOlZ/Tmfrh4atIYuL/CJ/7
         C5BjwCj1LjayEuABGjeU8WJKEoHsaKNXj5ZIdmDOwdm2Ye76KM2/U1LilloMhV84g+aM
         qTT4o6gmiMey+CcbpQgJuciwkq8Yw6lirxeORPmrE7QJrjegvHt0GmZaGK3jA3BDDZ52
         fSI4XmQJmzLxvPB6JpxU6lAeN8PLQ3+oqScGyMswOKNMedE/aINJh7lY7gNfmXmbvZKx
         NsTXOVcJ93A/xZwMPxe+M5ZNQla56maPMKmygI2MUPROXsg8ViJMCn97L2uCAeXgzXaB
         oe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIkaVHtmcI7ZAayN2rp02gz9INiaKKtMhPyk6d6P6pM=;
        b=olnolkCOQz/PDFTAIIrmgbtfgUjwu+grsYfIBfNXrxFDRG1eM6qvSYsFIVj1vDmB4g
         GzQ2jYqdzc382FZIA+catiUkj495jWGFyPEirWvcjfF2TY+gOf4GpIAWCijxdxx0D78v
         1UJciGgV8H40N+yamC6/gCMAtdes9hR/gnIMd7vpV3/4QAPAYmUfruuXMOYKCdwrUUhf
         NMr1bEs0AqwfFFFalRwd0jMNu/9dQTx4vNsTdprpHrNLDBnDatbyvTTLFGGMpodvRpuj
         W1x2tcSHb/wrzcYBEAdlbvXqcQdDGlq++AkfFGYOwl8n3/ToffS5Af8ZTtoqSEqoUrsW
         TqaQ==
X-Gm-Message-State: AOAM530IRhxOhXc1wOtpvPGxRtylz4+qBiLFE4c5Nr/0Od7CEJqw5D/A
        gbSLE4SoP93lCmpoJcqPn/I=
X-Google-Smtp-Source: ABdhPJz9vk/G08Em341SldnNjxuUXxoI4581YnYvZk6LKwI1LPpc2ydRpBmuTkE19qAWFKWKHWgPQQ==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr24856949pfn.183.1591106867824;
        Tue, 02 Jun 2020 07:07:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l23sm2525732pff.80.2020.06.02.07.07.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 07:07:47 -0700 (PDT)
Date:   Tue, 2 Jun 2020 07:07:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: bt1-pvt: Declare Temp- and Volt-to-N poly when
 alarms are enabled
Message-ID: <20200602140746.GA82514@roeck-us.net>
References: <20200602091219.24404-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602091219.24404-1-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:12:19PM +0300, Serge Semin wrote:
> Clang-based kernel building with W=1 warns that some static const
> variables are unused:
> 
> drivers/hwmon/bt1-pvt.c:67:30: warning: unused variable 'poly_temp_to_N' [-Wunused-const-variable]
> static const struct pvt_poly poly_temp_to_N = {
>                              ^
> drivers/hwmon/bt1-pvt.c:99:30: warning: unused variable 'poly_volt_to_N' [-Wunused-const-variable]
> static const struct pvt_poly poly_volt_to_N = {
>                              ^
> 
> Indeed these polynomials are utilized only when the PVT sensor alarms are
> enabled. In that case they are used to convert the temperature and
> voltage alarm limits from normal quantities (Volts and degree Celsius) to
> the sensor data representation N = [0, 1023]. Otherwise when alarms are
> disabled the driver only does the detected data conversion to the human
> readable form and doesn't need that polynomials defined. So let's declare
> the Temp-to-N and Volt-to-N polynomials only if the PVT alarms are
> switched on at compile-time.
> 
> Note gcc with W=1 doesn't notice the problem.
> 
> Fixes: 87976ce2825d ("hwmon: Add Baikal-T1 PVT sensor driver")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>

I don't really like the added #if. Can you use __maybe_unused instead ?

Thanks,
Guenter

> ---
>  drivers/hwmon/bt1-pvt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
> index 1a9772fb1f73..1a5212c04549 100644
> --- a/drivers/hwmon/bt1-pvt.c
> +++ b/drivers/hwmon/bt1-pvt.c
> @@ -64,6 +64,7 @@ static const struct pvt_sensor_info pvt_info[] = {
>   *     48380,
>   * where T = [-48380, 147438] mC and N = [0, 1023].
>   */
> +#if defined(CONFIG_SENSORS_BT1_PVT_ALARMS)
>  static const struct pvt_poly poly_temp_to_N = {
>  	.total_divider = 10000,
>  	.terms = {
> @@ -74,6 +75,7 @@ static const struct pvt_poly poly_temp_to_N = {
>  		{0, 1720400, 1, 1}
>  	}
>  };
> +#endif /* CONFIG_SENSORS_BT1_PVT_ALARMS */
>  
>  static const struct pvt_poly poly_N_to_temp = {
>  	.total_divider = 1,
> @@ -96,6 +98,7 @@ static const struct pvt_poly poly_N_to_temp = {
>   * N = (18658e-3*V - 11572) / 10,
>   * V = N * 10^5 / 18658 + 11572 * 10^4 / 18658.
>   */
> +#if defined(CONFIG_SENSORS_BT1_PVT_ALARMS)
>  static const struct pvt_poly poly_volt_to_N = {
>  	.total_divider = 10,
>  	.terms = {
> @@ -103,6 +106,7 @@ static const struct pvt_poly poly_volt_to_N = {
>  		{0, -11572, 1, 1}
>  	}
>  };
> +#endif /* CONFIG_SENSORS_BT1_PVT_ALARMS */
>  
>  static const struct pvt_poly poly_N_to_volt = {
>  	.total_divider = 10,
