Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C02206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEivLkFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbgCLHKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:10:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45846 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgCLHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:10:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id 2so2775039pfg.12;
        Thu, 12 Mar 2020 00:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljw1ounoCZTVG+RnME8ZEWoXQjwz4MM2v65DKn4hE/c=;
        b=HEivLkFSubwB666Df2bxBcldTFyNFCcVeJlLB4IE3SXpNB+MYnRL5cmEKoaGnwdB6R
         5AkNJPZ5rOOl23MD0YeEH7MvuVXq+VUPa+LrQsLriASOMMX5Go6dFIBbdLm5rAZH83h2
         bp61TPv78yl6qw4W8Jeoc5NykErt4zo36Q2R4CvHHG0RjhQMTbtzqGz4EfuvYbv0/ZpM
         mGihoQP12Xn1+VwAqI/55fLE2YrIdLOyQuwqp7cbfbK57RF5s4prOe726uWlLI4vbnkA
         pZva6NJCRNH0hh8E6KdFBMwmwEBiVnLai38PfkOW5sm0Xok0E4jguOiTrXGJ/V1n3TsC
         OjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljw1ounoCZTVG+RnME8ZEWoXQjwz4MM2v65DKn4hE/c=;
        b=WPS+n7j5nl8Ib9lfl9XJfWI8BG0AcXdPsbFBmWnkh5tJro8AS2/5GFX02KhoAEkPYe
         L98ZVjsYguW7cHJCpksZNoTo67a6hwRCtUsJzd/Dqmm+D+3+xralUlfTC7J4bXibKTXz
         R+pcrSOFJb/ZCcIaoM374JM1yxu0Nyd6LP1bx7BAQdgdCFLWRtTV9El6Ct8tAEMhTBQ6
         38NuXs5YfwYb5jniUFMi1ldLUPSkySxCXXzdQLkHJ9NyYkPUFtK8y2xL0dipQTnGeOLO
         VzumR0iV7O+LjyZESrN1K0rACToGzxbdIOBwEWcY+MSKbBhgWZkHmWt1w126b12ub9Ll
         YO+g==
X-Gm-Message-State: ANhLgQ1Tz+wB1uL3amKlh78vCbXV3Rof+5DomcgaKHphPjo2YChQ1jEO
        ZjYs6p29kJojsuW3iEUiGXo=
X-Google-Smtp-Source: ADFU+vsa8Kf3tsY8FS7mPDY4biE2SeexdcM7YCIk/K/oVtDeAHxnIOxoQhr5MChQiCBGU9DYXPmQ4g==
X-Received: by 2002:a63:f44d:: with SMTP id p13mr6613839pgk.113.1583997009092;
        Thu, 12 Mar 2020 00:10:09 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 134sm627049pfy.27.2020.03.12.00.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 00:10:08 -0700 (PDT)
Date:   Thu, 12 Mar 2020 12:40:06 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     allison@lohutok.net, baohua@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        festevam@gmail.com, gregkh@linuxfoundation.org, info@metux.net,
        kernel@pengutronix.de, kgene@kernel.org, khilman@baylibre.com,
        krzk@kernel.org, kstewart@linuxfoundation.org,
        linus.walleij@linaro.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux@prisktech.co.nz, nsaenzjulienne@suse.de, rjui@broadcom.com,
        s.hauer@pengutronix.de, sbranden@broadcom.com, shawnguo@kernel.org,
        tglx@linutronix.de, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v4] clocksource/drivers/timer-cs5535: request irq with
 non-NULL dev_id
Message-ID: <20200312071006.GA5415@afzalpc>
References: <e47ba222-bf4e-d13c-fbd3-6e7952097188@linaro.org>
 <20200312064817.19000-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312064817.19000-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subject was not supposed to have version info, happened by mistake, this
is an incremental patch on top of v3 that has been applied to the
timers/drivers/next branch.

Regards
afzal
