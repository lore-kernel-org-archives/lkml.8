Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C2FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B05421D80
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="uptIQwwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGBTSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:18:50 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA9AC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 12:18:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so24954034otv.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRIEBzGgN4d7YlR7st1P/jWdFL9XQ3Vl0E8DBG5inJM=;
        b=uptIQwwuu7LLhQ5BebZnRucA4yx79hkX9MsCaNgPXHc+4sW6fYb8Ma0WG/QZ6fYDkL
         7CdXciQXPoZxefKXg1aZlVZGomC5VgFvYZCCemrYwiAPfqPIaUh79kgKi/RAkg9NRpIv
         AjNvVa2FLRKmfGQ/C+ofSk4ZhzxoQdi9jDHGlirho0fHOyp+rCJ0YlEl11rhG/0s5zrE
         QI0PanE9bioGWA7kRhJuQwMURFJnvxBrc6k43Qo+XGhB+BEYvu00QTsAmH7fhkF+ZWxZ
         XHkhl2rsZQPDiwm67Y1VvB0XPSN50TfH5XsIbY8Us3IK3Vsy6Qv0fkUNBNL1oMFKSuLj
         zn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRIEBzGgN4d7YlR7st1P/jWdFL9XQ3Vl0E8DBG5inJM=;
        b=EsDN7fXmRCZuwpDNni4vdERZ2NZaKuJzzrTZIRaBfJ4kZ7to8oJo8Upq3oAbHfH13d
         yE3dK68KEijrhpMqz98FmhxYEh4jeOerNqlUcDEChmbAHYwvA6BHk+C9RGMUi76iIciv
         tlmwr5J3sl+Nal4T2eYbOCMwrOWiMfmGfqljj1//mTps7N8tNhf0AlHFTxOu2dHsUd8D
         eFwI9oHHtOz8imWlGEXIbC8+/uCj1VYiTSbwLgDp1OjmyZxUF/tL+rq30WEedECfNyjC
         E2hP18YlNexKwONCaBdiVdW54xsWqC9ZGwcu9ZWCtTHwwakw9xQVenDUxi+lRiGoOSvl
         Zcnw==
X-Gm-Message-State: AOAM530U+XUeyiVc6+8GWGMADwvmEThGODKja/Kj0A2qHUUPH7kmyv2T
        kLSjM9squFOhtoOm4ORPD6lGJZmq8dsesLOPxALYmQ==
X-Google-Smtp-Source: ABdhPJyE9o5qsn4mmfg/bTi/do0nytBCytI9l2XHtzasMOIfuZopADxFdFg4hQFCUv8pGK/sonqdb5SzWJU+UiPGXwM=
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr28599024oto.66.1593717529169;
 Thu, 02 Jul 2020 12:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200702103001.233961-1-robert.marko@sartura.hr>
 <20200702103001.233961-5-robert.marko@sartura.hr> <20200702133842.GK730739@lunn.ch>
In-Reply-To: <20200702133842.GK730739@lunn.ch>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 2 Jul 2020 21:18:38 +0200
Message-ID: <CA+HBbNGcV0H4L4gzWOUs8GDkiMEOaGdeVhAbtfcT5-PGmVJjfA@mail.gmail.com>
Subject: Re: [net-next,PATCH 4/4] dt-bindings: mdio-ipq4019: add clock support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 3:38 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +  clock-frequency:
> > +    default: 100000000
>
> IEEE 802.3 says the default should be 2.5MHz. Some PHYs will go
> faster, but 100MHz seems unlikely!
This MDIO controller has an internal divider, by default its set for
100MHz clock.
In IPQ4019 MDIO clock is not controllable but in IPQ6018 etc it's controllable.
That is the only combination I have currently seen used by Qualcomm.
>
>      Andrew
