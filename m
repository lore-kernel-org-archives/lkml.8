Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62406C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306E020719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584997053;
	bh=D2cbdShCODquqCBryijBYxIhzFM0KeH90GsIDkb7Cxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ASgrGO/ZFU+s6Asd1TPL6Q1OMgJeA1S0thD8veTwZ2N5oVfN/JaJ5HklyHgwiC35q
	 aMGVwMEjUelIbY3rYTvRmT60n8eBEQ7VQMeCtaYLBgn40BMQu8AVztpTQYJeR/KDg2
	 P/VufBDP8gnHGuvmnHqhlv2F0c8cwCik7cfeUv10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCWU5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:57:32 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40728 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:57:31 -0400
Received: by mail-il1-f194.google.com with SMTP id j9so1664099ilr.7;
        Mon, 23 Mar 2020 13:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kkn5EGTezo8ZFHctqjxTWCUCQ8fH8TBmzJoGFQsyB0Y=;
        b=PFO07sXOOyeW5MilM3HbmROhSDEmjh5wUivR8yaAv2YUQW/sv8iWykIEDQ/OV+iwoT
         2yghkvVH5DEXeos53WOMIVeYeQTZHk3+o3x0yWrHp7gQNWEk63W99DXi+Xw5oZou3VAc
         hNeBbHqcJ/q1P6D6GEX/lUTenhe0Ap+PiHs7czHiwL3bogmIURGBFpfAqt8ed6y7U+9f
         U2K06BA+SAMal2+E3kIKllsn3ce7/mg66vh91739EEMBlaq6xHttaheFd2ry4EphEWxZ
         FwbnjWNmk7+2ha2qMYEkRVtsYyA+8NA5RBgTAuS/MmbAcFs8jMWb/rovVeXHUYE5SswE
         HfUg==
X-Gm-Message-State: ANhLgQ2b0tnwc5FD7fr4JnuKkXxNvLY3VlHVdRLcA2NOPwZG3dqbTMtU
        dDqdehtj2Bu/Q6mmFYEN9w==
X-Google-Smtp-Source: ADFU+vvJN17ww3Kq6G+mwPlpLsur5WoDK9OW/d/FPWP8DVcsZFStapwkb4RQqHcjZ9cBECU42YwWAw==
X-Received: by 2002:a92:8159:: with SMTP id e86mr21748700ild.60.1584997051139;
        Mon, 23 Mar 2020 13:57:31 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s66sm100140ilc.9.2020.03.23.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:57:30 -0700 (PDT)
Received: (nullmailer pid 8001 invoked by uid 1000);
        Mon, 23 Mar 2020 20:57:27 -0000
Date:   Mon, 23 Mar 2020 14:57:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/3] dt-bindings: leds: Add binding for sgm3140
Message-ID: <20200323205727.GA4038@bogus>
References: <20200309203558.305725-1-luca@z3ntu.xyz>
 <20200309203558.305725-3-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309203558.305725-3-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 09:35:57PM +0100, Luca Weiss wrote:
> Add YAML devicetree binding for SGMICRO SGM3140 charge pump used for
> camera flash LEDs.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since RFC:
> - new patch
> 
> I'm not sure about the completeness of this binding as it doesn't
> mention the led subnode at all.
> The only existing led yaml binding is leds/leds-max77650.yaml which
> mentions the subnode but duplicates properties from documented in 
> leds/common.txt.

It's common.yaml now. Reference it from a child node defined here.

> 
>  .../bindings/leds/leds-sgm3140.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
