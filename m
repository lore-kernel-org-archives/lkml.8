Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8A220781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRH6zfCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbgGVSrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgGVSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:47:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79CC0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:47:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so2888021wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9uIMnNiW1J/fPcTrkBy02J2f4zbMTNbT/H46HboavW0=;
        b=MRH6zfCJDTuWzbHixxBHkUtlOfZcOoyaP5qWJeYl/Y1ydjc57lVUt15/Z3rNPFOM+Q
         eXhkDkS0tbDYbGmgk8fEVeOcibbTwXF0hUtDZ5uYZJ62pOmZSrFdfI/AWl9GzDgCywDV
         iGqMiHeRbNf1fqCXtmzFXdJnHaPmkbK/aa5MquDlKt0K0OO1546+odLXa1bXZCmJaOlY
         Q8TVlYjYa64EETTLNI2kPk11umtXwq1ZKw83jM1kdkjH8XYfj9bQDHvl+tL7mDHRArV7
         Gg6sMpvQKCvSrrUWRN1poYxCDFFn2V7ET7nKnyoquU4C163Hn3qRellu6eWHCNuUUACd
         QesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9uIMnNiW1J/fPcTrkBy02J2f4zbMTNbT/H46HboavW0=;
        b=pdx025ajTywS8yUC6iQv8BGZspKNa4yOzNVJ+rF2omHKBXAz96pRmI2KB5ZTRRJsvE
         CZXqkTqPz8o17uzEz5k/R1wi386OhdYp8Tkemm4jPrK8oyWnFs++yGkUNmyWG957ZSCh
         dlF+LNGmZJq3ynRkAr1nRMVfarUpi/BgsnbcQbF/wzcvTl4yFTMrXxFLioUVAyyuPY/P
         lCo0zB5GcaSITUojR9fe6OsIECvazVPYoPxSBEi8FuXJZOnCvvy0JAFxvM5ssEp7f+ym
         QUUTuJeKUBn1ZabVqVlJPQCBIZQ+pubvVpibJtqMNXlVTXs3w3pGbYyJGiJsS/omzG/6
         MBZQ==
X-Gm-Message-State: AOAM532KJd2a4hWo8+BfoGzorNW44klIc9ogwcSJPdLNzomye1clMKvZ
        uyM/aoSVudktJetS8OTgvUPiZg==
X-Google-Smtp-Source: ABdhPJxtohXqDYKUnUrficjmG8NBPqZ8wqdKCOq3VgpWcXwuze5DIM+i6c7rpgpveF9E0C2ZYuoOGA==
X-Received: by 2002:adf:df89:: with SMTP id z9mr746733wrl.395.1595443634012;
        Wed, 22 Jul 2020 11:47:14 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id y11sm899839wrs.80.2020.07.22.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:47:13 -0700 (PDT)
Date:   Wed, 22 Jul 2020 19:47:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Rob Herring <robh@kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, tony@atomide.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH for v5.9] mfd: Replace HTTP links with HTTPS ones
Message-ID: <20200722184711.GI3533@dell>
References: <20200719195613.61458-1-grandmaster@al2klimov.de>
 <20200721161028.GA389086@bogus>
 <20200722065429.GI621928@dell>
 <df4b92a2-0c19-ca0e-7967-4ec059196835@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df4b92a2-0c19-ca0e-7967-4ec059196835@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020, Alexander A. Klimov wrote:

> 
> 
> Am 22.07.20 um 08:54 schrieb Lee Jones:
> > On Tue, 21 Jul 2020, Rob Herring wrote:
> > 
> > > On Sun, 19 Jul 2020 21:56:13 +0200, Alexander A. Klimov wrote:
> > > > Rationale:
> > > > Reduces attack surface on kernel devs opening the links for MITM
> > > > as HTTPS traffic is much harder to manipulate.
> > > > 
> > > > Deterministic algorithm:
> > > > For each file:
> > > >    If not .svg:
> > > >      For each line:
> > > >        If doesn't contain `\bxmlns\b`:
> > > >          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > > > 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> > > >              If both the HTTP and HTTPS versions
> > > >              return 200 OK and serve the same content:
> > > >                Replace HTTP with HTTPS.
> > > > 
> > > > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > > > ---
> > > >   Continuing my work started at 93431e0607e5.
> > > >   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> > > >   (Actually letting a shell for loop submit all this stuff for me.)
> > 
> > I'm guessing something went wrong with your submission, as Rob's reply
> > is the first time I saw this patch.  Did your bot send it to me?
> Yes,
> https://lore.kernel.org/lkml/20200719195613.61458-1-grandmaster@al2klimov.de/

Could you [RESEND] it please.  It doesn't appear to be in my Inbox.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
