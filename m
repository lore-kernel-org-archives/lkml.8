Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CBDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A4920702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FabY7ftF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGGFIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGGFIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:08:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547ECC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 22:08:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so5687426ple.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 22:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+UI95l1NjQtL84FXutDU4Ky6htelMt/W5RLSG30AOlc=;
        b=FabY7ftFpQgr2PbvISTb0A6Y8y0eomX1VFrzE36jG7HJRpd0pIeXf6yMc8HbUp7U3H
         ZlI0VyXp7rTYj2/QxG2KGhvd3uN7wZ7ZytMEWcHO2Dkr1sl0bXQ/wlQTN1AUOeOvTtAM
         YndiBITGAm0w1aPbIwYyewqy5xvcau4jggaJR3sQEpxHUppqYz7HJslq1y8wy/5z3xuk
         IASUg2A/w+NB3PNKgCXFyokEZ8UaMSxpGAjn9UlyiaZVBg4IXw8c28L59Mei3ZQ0CG6O
         aDVbyHhcrQTHSY2OcNskZa5m6FCkRoOgoKkZ7nSB64gwFDJot+Ui5N4oXFQvuyHp1D0S
         n3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+UI95l1NjQtL84FXutDU4Ky6htelMt/W5RLSG30AOlc=;
        b=GxNQCNYgf4MsljBgMJybf5pNJxePZ29IXP7drtt2v8O6GL2jvY1jM/MmjYwc8QcJ9+
         8Hz7IXdiRs5A5B7wB0g0/m+3YOjYgmDFGKm5wXXr5ayAjpUrpM10nAeENBGk++uCAa22
         QZhcaiR3b1N1bumkQQnJnDHP0CXmjbiWNvcANwqir5wKiahm8N/2AGqbfbqa70cphv65
         dYGBCaMlwzRKEIg2bkjKTPoTrnKl5R5TagBL3tjlMHRIEtMmpyWnRNBAL1OEjgClzYWz
         cK8vz6Our+P1NzG162d7428NESpA5cBht6VM3n7eRM8gn+zhAMa+YBWJDNwG82YYngBG
         Rftw==
X-Gm-Message-State: AOAM531MKpf9PN43mLOHSFhQchtQwN6kttjq3avbrkOZHik7lwfsFUGO
        BxAOCIlEXOqL6Re1od1tO0l2MkZgKKM=
X-Google-Smtp-Source: ABdhPJyNCgjyPVrDt9gQMwviLg7kAe7piMq3EJ2aEFfumscMwQafobSfVLxi9F1dEIy3LXZ7LNL6FQ==
X-Received: by 2002:a17:90a:2d7:: with SMTP id d23mr2517517pjd.57.1594098520758;
        Mon, 06 Jul 2020 22:08:40 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f2sm19775905pfb.184.2020.07.06.22.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 22:08:39 -0700 (PDT)
Date:   Mon, 6 Jul 2020 22:08:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: remove ufs qmp phy driver
Message-ID: <20200707050837.GN11847@yoga>
References: <20200629145452.123035-1-vkoul@kernel.org>
 <20200629192416.GJ388985@builder.lan>
 <20200630045426.GO2599@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630045426.GO2599@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29 Jun 21:54 PDT 2020, Vinod Koul wrote:

> Hi Bjorn,
> 
> On 29-06-20, 12:24, Bjorn Andersson wrote:
> > On Mon 29 Jun 07:54 PDT 2020, Vinod Koul wrote:
> > 
> > > UFS QMP phy drivers are duplicate as we are supposed to use common QMP
> > > phy driver which is working fine on various platforms. So remove the
> > > unused driver
> > > 
> > 
> > This describes the current state, but the UFS QMP driver had a purpose
> > not that long ago and I would like the commit message to describe what
> > changed and why it's now fine to remove the driver.
> 
> Would below look better, also feel free to suggest as you have the
> more history on this :)
> 
> "UFS QMP driver is dedicated driver for QMP phy for UFS variant. We
> also have a common QMP phy driver which works not only for UFS but
> USB and PCIe as well, so retire this driver in favour of the common
> driver"
> 

How about:

"The UFS specific QMP PHY driver started off supporting the 14nm and
20nm hardware. With the 20nm support marked broken for a long time and
the 14nm support added to the common QMP PHY, this driver has not been
used in a while. So delete it."

Regards,
Bjorn

> > 
> > I'm happy with the patch itself (i.e. the removal of the driver) though.
> 
> Thanks
> -- 
> ~Vinod
