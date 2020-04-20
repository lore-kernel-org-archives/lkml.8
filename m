Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC078C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858702071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587405897;
	bh=ndsuUZwJ2Aj7AyhZ3QVGf/gxEqvyaYgk9lf27oL6KwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xORpai/hl7N8myFsB3cFknmvX4DB/zxPvSi570fC9xtZXRpoqBMCkDzApuPW37fpA
	 O7G5dHr55cuRZUp+1XIbH5lQOBIPczZdU/XjDOD+YelJyuzZXyidKRhf187+Vh2GHF
	 OggRuoWj0bzjBpr5HLgf7Rbg/OncZsf8sa24Dxwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgDTSE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:04:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39333 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgDTSEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:04:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so8927004otf.6;
        Mon, 20 Apr 2020 11:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R9R3P8AxTY42i8eZbd/K2FLLSk3SQ9So4jiLRS8yUHA=;
        b=FnfkDdXX9NngpC62znj4OIyIzLRMKeTg4kW6IqzgYQ2ucuGMsVo6xDwPbSj67v8WDo
         g4BdQ7QZBWc7JnhhEVkWtYztP19w5kdxIab8DTeETe/m0mBeh2bIoE0YHHOqBiXAiZCm
         dRkZMM5KfFHJQtDthpkRfPS9qhzoNs8npfkzTvR44ussCzM3qkfnbVNiZx4o18ljITYc
         QQ39WWe+6Fey+OdbbgzH3noLGA79+4e/LFxiQ9xjonr+z4QHuz2lwWKjCOtCpYWIQn7+
         dOoJTZULD2DGeejp/GEZGjvuFaVjqFVm49XCqkbDU3Zg9Q6+D2HKA0xNiWgsZnNNRb+e
         SpfA==
X-Gm-Message-State: AGi0Pub3N5s4Rh4M83yGq/PVnfM8LWmcK9K0ro8yvjIJgRV0S0+4Bo4+
        zCg9tdqIKDNJB23P2a3V6w==
X-Google-Smtp-Source: APiQypIcphhGbEDkzBJSApE45bLtbLIzGEcM5dFbdISmqJoJZVgTVbNbQyDPIrlbVc68ecDTsveOkA==
X-Received: by 2002:a9d:6a98:: with SMTP id l24mr10210869otq.133.1587405890294;
        Mon, 20 Apr 2020 11:04:50 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r205sm17563oih.47.2020.04.20.11.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:04:49 -0700 (PDT)
Received: (nullmailer pid 22581 invoked by uid 1000);
        Mon, 20 Apr 2020 18:04:48 -0000
Date:   Mon, 20 Apr 2020 13:04:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     fabrice.gasnier@st.com, lee.jones@linaro.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: mfd: Document STM32 low power timer
 bindings
Message-ID: <20200420180448.GA20546@bogus>
References: <20200420121620.2099-1-benjamin.gaignard@st.com>
 <20200420121620.2099-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420121620.2099-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:16:15PM +0200, Benjamin Gaignard wrote:
> Add a subnode to STM low power timer bindings to support timer driver
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
