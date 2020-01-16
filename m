Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB7FC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FD32075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvE1YVwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAPNfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:35:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35850 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgAPNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:35:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3849397wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ex5iQAOgOE6sJdpP0UDJP/wplcXOALsRuy3uUtlLaZk=;
        b=qvE1YVwT35KAeibCSPNMT/6IWonjdnLnAq1kCZSEo2b6CAJEN9devCVU4H5nrBg2rO
         v4d7PuV0IkaKNwVaPYX6jabBbx/jR9M39wGOm+HZHZNqIgGZN76fsJvUlDZufuLHPvOJ
         HXr/9CHED1bnmgkT9sgFnuN1mKu7ErycVEgs83sk7SIZ2GoCxuZTB1LUP7Luz76nf7oe
         +cfe3FbC79HZVuUG7Yj315LHG7QVX3BJoTY/1cLlNnHpW2KyYbDRQMYehIQ4UW/9qX+M
         37YsSC5z93n/8D+dDEAGa0xl9vvuSt9ruOiCzeE2BTKLh6bs2lxvVksLKYBVwmUurDHz
         CowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ex5iQAOgOE6sJdpP0UDJP/wplcXOALsRuy3uUtlLaZk=;
        b=tX9ZH/9IX+bNtOblNrkLL9lfXtBKXO5XHeT6HVBd9nHK5OlqJZDxjkYka/gLb0YIHr
         5NfoX3Oy4RWgVtEWKKGCTBQKwluLpJ0w53etjE2NLrXilvW0mXedUkgVKvpdFV/MQByP
         uavrPXdCwEA9cJIkZ2n8WlfXbs6uGV/k/muSbXICyweLFCsZyr/CRtwA5CJbfztzMF0Z
         DVhe/mkAJ4Lyi2f3aa7SXScqm98E4C0IOFYI5uts3Zzf+QKpABhTVWr5wFGVZkDUl3Wn
         2/cOvUFqU4EW65Po1p5Pds+OXQN7EyWnIYxUTfVBvGkK/1DGKFNY0tNincdC3/VnFwv3
         uigg==
X-Gm-Message-State: APjAAAVE6KRB3HGGXX3ywbll8QRoAkkoUh22Y8SctOo6W2OHHZ7ZpGse
        TTW87uN7BcND1TyHeYWcZgaw8r1aVOg=
X-Google-Smtp-Source: APXvYqzGsGr1esnWAtuowtgwjETYSUMAmmdt6JTJvoDok/p5abyr1h1lybNOYRUwc3ulCQlDtT9X5g==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr6217830wml.49.1579181730878;
        Thu, 16 Jan 2020 05:35:30 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id u18sm28884904wrt.26.2020.01.16.05.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:35:30 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:35:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     support.opensource@diasemi.com, linux@roeck-us.net,
        robh+dt@kernel.org, stwiss.opensource@diasemi.com,
        Adam.Thomson.Opensource@diasemi.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/3] mfd: da9062: fix watchdog compatible string
Message-ID: <20200116133546.GR325@dell>
References: <20200108095704.23233-1-m.felsch@pengutronix.de>
 <20200108095704.23233-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108095704.23233-2-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Marco Felsch wrote:

> The watchdog driver compatible is "dlg,da9062-watchdog" and not
> "dlg,da9062-wdt". Therefore the mfd-core can't populate the of_node and
> fwnode. As result the watchdog driver can't parse the devicetree.
> 
> Fixes: 9b40b030c4ad ("mfd: da9062: Supply core driver")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/mfd/da9062-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
