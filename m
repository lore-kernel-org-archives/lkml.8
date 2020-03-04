Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE6020828
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XLNUFzp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgCDVV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:21:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37364 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCDVV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:21:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1613443pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=8NHt2u1Odi1sTAbIxzHtP/yeJUTD5DFnU/KItPM3ljg=;
        b=XLNUFzp7y3HaOKVjXaLfh5lEnmPG/smFCciNkihcc1WIvT68eoHMtMgHPa2QtybPFN
         UScU8BW/PGirxc+d/af21Ay1wLbOuCIVSxOF3hx3NuRJI9nXzmaLPEKhFOjBAdW1c1nK
         5V6/b2JkGOXfocvg3SVUxWyuFFZ7PLkq1exYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=8NHt2u1Odi1sTAbIxzHtP/yeJUTD5DFnU/KItPM3ljg=;
        b=iI63BWsRCRFOGAMvaJdkctWHR4pmvsi0kupTZvIGk/eQgFG3LKJyy39506rcH7KlQQ
         IW3mn0NU+7YjSjNOwNImGQZljEirAP2FzSgsMB64vCy29lg09QaueXeNzm2z5JlJY764
         BKoZrRFQa9rHBwkvxnM3WULYKV0MJcuI2YNIvqJnQaTdEzoQcsqWvnhjuXM1SIe3HwRU
         Gf7IAxRhf9lNaVeAkeMo3m+IHFkEcwUJrmL1Ofs7wONg6aHJ0MQobFMVl9hpopZGhHQS
         HR/ZsEr0mO5HH+MEaY7KiB1JwqYYrCrG2kNvNpOF4eMolyIjb7x6gBTZIBLTRNHKa4u2
         hfEg==
X-Gm-Message-State: ANhLgQ1xohLOIJqf284Ufu2U1W+NoOX2r2IUqJ4RaIO9m5Yn/hPc6fUz
        Ws1GPrVsfnreCZpTxItAttOcBw==
X-Google-Smtp-Source: ADFU+vvVksMIvscwJ60U1wNHvcXkdywaFwvp9amWgt7M25BGgkzXqzfMpjX+sg+A+d00rVzlySrLDw==
X-Received: by 2002:aa7:914b:: with SMTP id 11mr5065657pfi.69.1583356918146;
        Wed, 04 Mar 2020 13:21:58 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 129sm24711920pgf.10.2020.03.04.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:21:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200304105638.1.I9ea0d337fcb927f52a28b20613b2377b6249c222@changeid>
References: <20200304105638.1.I9ea0d337fcb927f52a28b20613b2377b6249c222@changeid>
Subject: Re: [PATCH] arm64: dts: sc7180: Add unit name to soc node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 04 Mar 2020 13:21:56 -0800
Message-ID: <158335691640.7173.2382800196583275089@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-03-04 10:56:56)
> This is just like commit a1875bf98290 ("arm64: dts: qcom: sdm845: Add
> unit name to soc node") but for sc7180.
>=20
> For reference, the warning being fixed was:
>   Warning (unit_address_vs_reg): /soc:
>   node has a reg or ranges property, but no unit name
>=20
> Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for =
SC7180 soc")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
