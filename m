Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE04DC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BCC2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588795562;
	bh=jgUN3vH86IMh5mdQ2oTFFzDPwb5XgPKGZ/pa709lY+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TbHod8Ai67T4COgSGmQCt11pPmGzNPyfftYTf4msFBRzSKvglZ4oegAvaCfCdsTop
	 3x/igZBBQS1pd5XiXhA/dmHpYONP1/j1AmzLlh5gRk+nitYiqgfKyGDPBitlNMAG6F
	 zWezNcgJ0t8wmuhebW4B9+cIBegwCcpilq6qHEBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgEFUGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:06:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33649 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgEFUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:06:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id j26so2466920ots.0;
        Wed, 06 May 2020 13:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B63JfAS5DnOPIn359Mu4SF2juiHItV8fI+NFsKVSGD8=;
        b=DChIcMBiLpGLDrQEQ0IP/DMerBwX31AM3hgbGh3e3SQNqh61k4Ego6Uc6fwkmjYYvo
         aOMV+uX5Am41yjHEHZiTQEYbreT7d6o2EvF22u9o13ppd8TM6XWSoHV+AxDxUa/q0NkV
         EXcFMBEhQCmX7him5tdQGUBiKmD5fz3KHs8uV0ItJ9QKmfWTqSBy80TYbJF8KbaKolFZ
         nxVxgXFDGg/EdLRncS0XYc23OCN6bh5qa5N1nQYR3y7DMjLyuk/OHCDGF7MIq+e1SQ+M
         34SpGixsbZDDlE2eCVcyXL6Ge12iw1hrhE2+WHLcamwScfMFw5yIciXJuDiMhw5kCOMY
         NL+w==
X-Gm-Message-State: AGi0PuYqsbW0dpvKiP4fqD1X2uF8S00TUua+IJjQZBK380emkDE+evzC
        JYvWv/cIGgo/ZVwCjZt+sQ==
X-Google-Smtp-Source: APiQypIici0Rg+Y4p7bwcYXH235wYgoJGR0SXXaIzkdixkSakfukZtIjV7CDVl+EVrcArRIbhPWfrQ==
X-Received: by 2002:a05:6830:1e39:: with SMTP id t25mr7785497otr.114.1588795560432;
        Wed, 06 May 2020 13:06:00 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a22sm774402otf.42.2020.05.06.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:05:59 -0700 (PDT)
Received: (nullmailer pid 31500 invoked by uid 1000);
        Wed, 06 May 2020 20:05:58 -0000
Date:   Wed, 6 May 2020 15:05:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: power: meson-ee-pwrc: add support
 for  Meson8/8b/8m2
Message-ID: <20200506200558.GA31434@bogus>
References: <20200420202612.369370-1-martin.blumenstingl@googlemail.com>
 <20200420202612.369370-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420202612.369370-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 22:26:09 +0200, Martin Blumenstingl wrote:
> The power domains on the 32-bit Meson8/Meson8b/Meson8m2 SoCs are very
> similar to what G12A still uses. The (known) differences are:
> - Meson8 doesn't use any reset lines at all
> - Meson8b and Meson8m2 use the same reset lines, which are different
>   from what the 64-bit SoCs use
> - there is no "vapb" clock on the older SoCs
> - amlogic,ao-sysctrl cannot point to the whole AO sysctrl region but
>   only the power management related registers
> 
> Add a new compatible string and adjust clock and reset line expectations
> for each SoC.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/power/amlogic,meson-ee-pwrc.yaml | 74 +++++++++++++++----
>  include/dt-bindings/power/meson8-power.h      | 13 ++++
>  2 files changed, 72 insertions(+), 15 deletions(-)
>  create mode 100644 include/dt-bindings/power/meson8-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
