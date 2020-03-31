Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F7C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211772080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585692523;
	bh=JNfSQ/OkaeYa3+uL5kdeWARaiKwfYOeggeXrpQx/bEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r7r9p544SvoUtsR9uOgNTFxXiEm8SKfB9oBod3gUvRoWXDnsh0FaL278O0AH5AN/F
	 YGt+AA7R9RqhTgi4JkCAxCwmeHP8erqFtk/dlih/OVT0YKJU+OreL9f8jr0U+K8keV
	 t6cV6AzmJhVpZoOyKxGnxlmfCelFnk4k+Lw++X1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgCaWIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:08:42 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39603 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgCaWIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:08:42 -0400
Received: by mail-il1-f196.google.com with SMTP id r5so21071157ilq.6;
        Tue, 31 Mar 2020 15:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zq6lnen4wO1ZG0dffCWm2RGQcT8LeYtwqJqjBTsJ3GA=;
        b=eyOpYOkyi/Ki9Ol46+Ro1+utE0pwDMe/Audj+4uvgc3x2QJdsCilQ1CCRmNndpPbYD
         SbvSaQSyEVAb7VRZkCXa3iHJfbrk0YOojzUIJHeWGs0o6YgZYtDNe1BBZ2GqDrDLKqQ5
         Tc3wVk95vQ9UBnVf3lHIkcLnEU3a6pziU2qhzVmCGkUbMy3cT9RYAMtZNnoowKPy/Xp1
         LC66DPB1l07Tw65eU4zijkZi0mOsRUd8AqI+ClRcXZgqUtxBq/G86kJWEMrhoKlIZIqJ
         /MY77k3BQTFdwPW18mukPBKDpSuutPZmSDKkWsZAvfbkUG/ZjmTXWVYCNbSTRt5OlxBb
         0kPQ==
X-Gm-Message-State: ANhLgQ0v3lCgGRlAxJ7FPGDDlpT5gH5YY7rmQpVSuHyg/D9w1g3UgHFM
        a2cWtcfpZDnECkPJHHRslA==
X-Google-Smtp-Source: ADFU+vvsqcZ/8hm+2F9xJLmsIK4neA63BSqusqM0rClIuHLAaTmsTnIJm6Qo7foDMZxypZHs0knNlw==
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr18753339ilc.202.1585692521393;
        Tue, 31 Mar 2020 15:08:41 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l3sm42738iob.31.2020.03.31.15.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:08:40 -0700 (PDT)
Received: (nullmailer pid 2535 invoked by uid 1000);
        Tue, 31 Mar 2020 22:08:39 -0000
Date:   Tue, 31 Mar 2020 16:08:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, benjamin.gaignard@st.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] dt-bindings: usb: dwc2: fix bindings for
 amlogic,meson-gxbb-usb
Message-ID: <20200331220839.GA2373@bogus>
References: <20200331083729.24906-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331083729.24906-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 10:37:29 +0200, Neil Armstrong wrote:
> The amlogic,meson-gxbb-usb compatible needs snps,dwc2 aswell like other
> Amlogic SoC.
> 
> Fixes: f3ca745d8a0e ("dt-bindings: usb: Convert DWC2 bindings to json-schema")
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 

Applied, thanks.

Rob
