Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77080C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B48F208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582230585;
	bh=fNNsB5ino+La+/VeE+Cq/VqWJOnIIE5Z8PRYl3wsYkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AahZMVYBEbeHe31cIivifCbEEhiQoiHq0dYa03peI0nNxFnj4/GB6BwWU3gUxs41q
	 5+8g7zx+O3R62Ihkj9m3Gx1BP4+NW3QvW2Vrnw8FrP2Z4gOPOqB8R1yWxNhp9QVVQ0
	 0XDFA1sS1322sibTNKsRcH5i6+FO4LPotSPUHaSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgBTU3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:29:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40309 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgBTU3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:29:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so4934810otr.7;
        Thu, 20 Feb 2020 12:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4y11Rw9Quj6ChkrwsaKBH1Q0T5iRPrjR3ZQy3ZsS7xA=;
        b=FbWe4zUQWBCMiYMQk4Aq7wIpvwLessLCQtKFGEPG0mDAsiB9+V4L+koSYw0YOxcFwz
         +kIHgw8RmN9eYNsvN3EDYdnwoq5MCfkr3+l9Xhrhh4d58h3jE2J1topti8d/DUZRXz7I
         tJ6qWdLBbYHJD30VM88Rj8TyVieowdBM4jcIT6SK2RNFBNSJ8EzCSGIcyJVB2Qx/HjhD
         4LZWxjDeT5w1NDlzBSTu4Df/uz8eGK9t470106G3BoUFq+vfo4rCJ6+xWqNHL1RSpyit
         nkZ+EJrcS23jdQD1Me28oZbzz7o481t+QRSI/AES1A2UFEk2zg1m7d2FCVZ3mn0wUVAg
         E76Q==
X-Gm-Message-State: APjAAAUPaMTgebIYSJKt0fU5MDGb3u2RzxWkt8fvZD7Ql0XUu9mCIYcR
        mY+tFHiJ4kwj4viMwaQJrA==
X-Google-Smtp-Source: APXvYqxqNmvtY+8v4lmPFwBx32CjiYTpN6LA3c1fXpwH+kIAQ9BKjTQ21m1UkbGpGxeL1RGLpLDftw==
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr23581373oti.251.1582230581148;
        Thu, 20 Feb 2020 12:29:41 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l207sm128716oih.25.2020.02.20.12.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:29:40 -0800 (PST)
Received: (nullmailer pid 7275 invoked by uid 1000);
        Thu, 20 Feb 2020 20:29:39 -0000
Date:   Thu, 20 Feb 2020 14:29:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alexandre.torgue@st.com, robh@kernel.org,
        mark.rutland@arm.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com
Subject: Re: [PATCH v3] ASoC: dt-bindings: stm32: convert sai to json-schema
Message-ID: <20200220202939.GA6480@bogus>
References: <20200219161733.9317-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219161733.9317-1-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 17:17:33 +0100, Olivier Moysan wrote:
> Convert the STM32 SAI bindings to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
> Changes in v2:
> - use pattern for compatible of child nodes
> - rework dmas and clocks properties
> - add "additionalProperties"
> 
> Changes in v3:
> - move clocks properties for st,stm32h7-sai compatible, to 'else' clause
> ---
>  .../bindings/sound/st,stm32-sai.txt           | 107 ----------
>  .../bindings/sound/st,stm32-sai.yaml          | 193 ++++++++++++++++++
>  2 files changed, 193 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/st,stm32-sai.example.dt.yaml: sai@4400a000: 'clock-names', 'clocks' do not match any of the regexes: '^audio-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1240792
Please check and re-submit.
