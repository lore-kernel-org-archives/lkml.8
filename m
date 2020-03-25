Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC6AC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DBB20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zbj6ldZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCYJTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:19:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41933 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:19:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so1923930wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jNQsElt5CknsQbyuzbClTNd1rNuCD5PB0IFY7FEkEZE=;
        b=Zbj6ldZYm/mR4aIkxVyvY0IPEf0i16ypXx5eYF0TkoVSDTejJNAwc128AVd2WXPFvo
         xZ4lSV5Z37VyDD4C0CeoUTKuDVd97oJKvHvnUYhKiNnQf0iMWhCO8Jr2TQgTe8tIOtdM
         6humiowd7FhUMmlsTlfTvB6RKGIWWCqQ7EVNY6qNUHIJZTFtA+WcFM8HGw/gPSmA2DVJ
         zcBaHh6jKvUjRHNl5Rd/1CWV8sZ51VL+znHwfW2zFnzcM0MUB2ME0GFN828xxmA5BQBT
         K9PL+VfT2szihueuddUB3PiYHcUerLFe4r+gqKQW7/X7MJslYafLSu9W/qEWxyA0VQUI
         WbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jNQsElt5CknsQbyuzbClTNd1rNuCD5PB0IFY7FEkEZE=;
        b=G1+nfQkYoN4QFWkW07TsiHsJAlmt+/adMRaR/wUmuM4c6pXqKvCsYJRAIGQJe49TkH
         jX7fnPI2E414sKTvROBt9Vp2B/bfv4CISZPozH0syptqdORYhcKIvxHcDi6a2HG7yb0E
         YcKleWN1DVIa/I43st7XTwvN0DrdmtSyJQWLuJ4hi7w8IJEemlfA/Mnn/y1HIfN5Yhe4
         nIDOvBrYQ65upcwU6TB+hjBu7yZX+FDUcKDNkmJlc4P2RTMxLZu/0WqSXQeE0c9psqv0
         QyI5a38lVq6DX7f3JLgIqUoHRKcZe1T99hXIKFWY9G5cih81R+/tOfjDmLbLL9Ct3FgH
         a8tg==
X-Gm-Message-State: ANhLgQ3lyxvboeVuMSM97+PJ8XFZT/8q9FwJ2mw7pA+apB1132acpjlo
        b7qiR+506Esd8Dao21xNs5gG1g==
X-Google-Smtp-Source: ADFU+vt92TEy1uQV/pgVv75Mxe1VsUGqvn6nRZAGARmxAmaHNRKw1/pBPR5pqT6ZOGKIR2rc2xfxew==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr2228715wrw.235.1585127955840;
        Wed, 25 Mar 2020 02:19:15 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id o9sm33495181wrw.20.2020.03.25.02.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:19:15 -0700 (PDT)
Date:   Wed, 25 Mar 2020 09:20:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net, p.paillet@st.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: mfd: Convert stpmic1 bindings to
 json-schema
Message-ID: <20200325092004.GF442973@dell>
References: <20200304094220.28156-1-benjamin.gaignard@st.com>
 <20200310211849.GA13562@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310211849.GA13562@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020, Rob Herring wrote:

> On Wed, 4 Mar 2020 10:42:20 +0100, Benjamin Gaignard wrote:
> > Convert stpmic1 bindings to json-schema.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > ---
> > version 5:
> > - move $ref regulator.yaml under a patternProperties
> > - move remain fixed strings under properties field
> > 
> > version 4:
> > - move on uppder node $ref: ../regulator/regulator.yaml 
> > - move fixed strings under properties field
> > - remove unneeded () in patternProperties
> > - keep ldo3 separate from other ldo properties
> > Note:
> > - 'st,mask-reset' property stay in each subnode, I don't find
> >   the syntax to avoid dupliquate it. 
> > - ldo6-supply and all possible *-supply are describe by this regular
> >   expression: ^(buck[1-4]|ldo[1-6]|boost|pwr_sw[1-2])-supply$":
> > 
> > version 3:
> > - put $ref under allOf keyword
> > - for each regulator node add the list of supported regulator properties
> > 
> >  .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 --
> >  .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ----
> >  .../devicetree/bindings/mfd/st,stpmic1.yaml        | 339 +++++++++++++++++++++
> >  .../bindings/regulator/st,stpmic1-regulator.txt    |  64 ----
> >  .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 -
> >  5 files changed, 339 insertions(+), 164 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Can you take this please Rob?

It would save an IB and PR.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
