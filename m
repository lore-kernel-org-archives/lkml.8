Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A2AC33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A6320716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580135385;
	bh=bxq68SGZEPj9jpi3APMufWhNQ3RRYA40+sBQO2nxe+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W2xl3IEPyiHj9Q/TIDW4+DpZU8rX28PgezIK0OSu37gFgHp+mSVpKuwBAB+TvGX2E
	 B5Lsc3qdC37espf/YWYFQ0wD+RS+UAGpkmWOGQjG3UMI6ynao+Sy8E4hYWb1/Ge12v
	 kQDwqWFzosKDwm/eucgPqj3dgUJkK4mPFTu8xu14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgA0O3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:29:44 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45190 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0O3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:29:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id l7so6769577oil.12;
        Mon, 27 Jan 2020 06:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4bDe7p5lO4KINhYrTu+OYHhd26DPw/LYZ6CdLSLXKHM=;
        b=Lm/ZfUr7efO/+U3kex224yJyA0c/+PUOtsoxZ4IoqU4KbnyXWjPfjdQJ9vl7mOae8X
         9EpTApmxI/Tg9lsiiDB9kDTlRyb8TQUP8/7B6ZUQrdDQVaLaFk3lAL5rJwm9fBRIrfjd
         wykKf9u3KemR4g8KmNvSnwy/dRRb/8UgJVoKg8bNHdccVfJHXTt6GH3Do0rmHk3Ovczv
         9z8SDfaFmH1j1YJf9+UYvvgBjOgm9vyFUsosx5LJc5nbhfKmYFGGb1+kGwJYhRNjirLR
         nBFxbEk2aAQWghQaTTJZjAOoCg4ljj0w9dMpbeRh3H9D9LqJ0eJa9XLI38QGQQKt8UNJ
         stng==
X-Gm-Message-State: APjAAAWd5jtl8dGFNfpu3bS3BmXrpYWstOOEIfdkAREwAKVk+UrGd5pf
        HyRW1zPXZy8p1Ijx2xrf1Q==
X-Google-Smtp-Source: APXvYqyzZSLvp1ganhAJqIPTmgAZZt+s9TrSOix9chh8UUg49shFxxAcDVWGzOHjVBgKh0nBQrQ3gQ==
X-Received: by 2002:a54:4f04:: with SMTP id e4mr7262766oiy.111.1580135382917;
        Mon, 27 Jan 2020 06:29:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a5sm369420otl.45.2020.01.27.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:29:42 -0800 (PST)
Received: (nullmailer pid 4191 invoked by uid 1000);
        Mon, 27 Jan 2020 14:29:41 -0000
Date:   Mon, 27 Jan 2020 08:29:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: dwc2: add support for STM32MP15
 SoCs USB OTG HS and FS
Message-ID: <20200127142941.GA3436@bogus>
References: <20200124084131.23749-1-amelie.delaunay@st.com>
 <20200124084131.23749-2-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124084131.23749-2-amelie.delaunay@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 09:41:30AM +0100, Amelie Delaunay wrote:
> Add the specific compatible string for the DWC2 IP found in the STM32MP15
> SoCs.
> STM32MP15 SoCs uses sensing comparators to detect Vbus valid levels and
> ID pin state. usb33d-supply described the regulator supplying Vbus and ID
> sensing comparators.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
