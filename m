Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0463EC4BA2E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C503824670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582755962;
	bh=+YTMcwhhHCHswAX1vO9XE89PfP2x9nnUsKUIhlfEIvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QtCeACDWVIAW5vgJfOElwfxhkyRJus3cNR5YseoFxdSPPU7unTnDWyG/q7JWKO04j
	 3fbEMS/qpmMH6Guqy0XrNmy+uJzi43JPwhy/sRUx/lyssTF1Y0P2Ne/z6bZgSns3vr
	 sqqckRaR5z/H9th+rW+ART0tADFTo0qx3yYkPzBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBZW0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:26:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43361 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgBZW0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:26:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so1202848oif.10;
        Wed, 26 Feb 2020 14:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWbO1l0dKYrwXhur6BhA0nbAdawh07B/aU89gTQHOJU=;
        b=CMYgWuLYdiQzXZXzX3QtnFveOFeKxcEsbUlJDiOZTX6/s0brfcflqY2UO4Q0lC1A08
         TzVPcpaFDo+sgDImYG1jfs7s+nleGkl5epG/pIq4C4k3u/fa8IIo06dlGCXMpHhWShXp
         3wNYVWc48FhKVuuBvMisFkr00Jhr611wEzisHH+LFpRRUGAA6viATV5AGHuKktCK0j2k
         gvZE0UX6/nfoiiHNy07Jv/jzxR24YEsCEwFMFRprcVe+YV0ImGkBk69FXQzxA1wfPhRK
         JNXANsUzcNI+iUxyDd+vK9UmBTpT1VIvhcc9kPLL+5iP6s87CGFKYWM7VFSosr8HQAev
         f8Fw==
X-Gm-Message-State: APjAAAUREkw7woHpA2CHvjC7zG20sEXQQBNoR4aRM+wZ8fJXwxtSS3e9
        x9f63gzeevSBDY/pLtyxIg==
X-Google-Smtp-Source: APXvYqx9QlL3+RzQlSfMukZq151Bwi6bn55GU8EJxQB41VDbp0tf0aW65Uy6p/nC0ulip1LyOvHk5Q==
X-Received: by 2002:a54:4091:: with SMTP id i17mr1023289oii.99.1582755960672;
        Wed, 26 Feb 2020 14:26:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm1241692otp.14.2020.02.26.14.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:26:00 -0800 (PST)
Received: (nullmailer pid 13339 invoked by uid 1000);
        Wed, 26 Feb 2020 22:25:59 -0000
Date:   Wed, 26 Feb 2020 16:25:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sunil Mohan Adapa <sunil@medhas.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for
 PocketBook International SA
Message-ID: <20200226222559.GA13288@bogus>
References: <20200223031614.515563-1-megous@megous.com>
 <20200223031614.515563-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223031614.515563-2-megous@megous.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2020 04:16:12 +0100, Ondrej Jirman wrote:
> Call it "pocketbook".
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
