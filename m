Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73542C47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F64C2495B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588521306;
	bh=1lVj9O04pSrh4fKuFXpMuuTNgaBhbrz8sKMQK55Qixc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NDA2iuR7niTosmiP2u+SuNFdDQ8oI22s52h1SlfdJzkSr4e55XCoVTBAyEY1CWPoj
	 7k5VUxX9JVQAX+4jGRX4oMrURRxA/P0DCQBaPxct9OyAmWm2fSgy2pX5CwDBrYeA8B
	 G85vcaOedVchY4AvDk02dHGLUUjCSmWazsG3ERVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgECPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 11:55:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36562 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:55:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id t3so2919177otp.3;
        Sun, 03 May 2020 08:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1SJl+Zf+PXhgsQbG0N6jArE/8YWiS3AQ+7VS1y+nDYs=;
        b=kl82RmQXh0iwAMd0IPL6N1jgKpS4ZBI2vTx8EmY8zh93JWa00EV5tEeVeKHGQGET6d
         cvc7Olk6/H/WQ18AcINDotPJueCVCQ4PdECnPjjm3FUAIjuAt2E4jacuPhplEk7J7KXp
         U/j1tOOVwoPYGyMTc/wqTTDBSYYcK6tbnJUBZVoxa0+CGWc4IJ70D8Y0765mbTj7xfTC
         hgqYzj07w8Bejc16R7USyC//+jk3c20I/ehPG41ab3tUSiO+eMtP02/zZ39DE5Xo61Rt
         52cfQ8jBSjiklOKIiD/B57NNpruE0NpT829Vy/VnaJMpSehIb/MqZzegGs9EiwlXhE3b
         S0XA==
X-Gm-Message-State: AGi0PuaUfn56wApmqTl+cEAEjjUuGEDc/P19y+qwqgIFDh4nkhJpdTul
        ZMA2T6DIGMxRbdeWEVPNmQ==
X-Google-Smtp-Source: APiQypLt0OsGOy7bdAk4eX8ZfJHsyORJIwBTySAb9tpBQpijaTQl/DOvjAzwB99sHAw0bd0niLZoUA==
X-Received: by 2002:a9d:400d:: with SMTP id m13mr11156744ote.347.1588521303624;
        Sun, 03 May 2020 08:55:03 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q19sm2489210otf.6.2020.05.03.08.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 08:55:02 -0700 (PDT)
Received: (nullmailer pid 19190 invoked by uid 1000);
        Sun, 03 May 2020 15:55:01 -0000
Date:   Sun, 3 May 2020 10:55:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: Convert Calxeda clock
 bindings to json-schema
Message-ID: <20200503155501.GA19073@bogus>
References: <20200430211054.30466-1-andre.przywara@arm.com>
 <20200430211054.30466-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211054.30466-2-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:10:47 +0100, Andre Przywara wrote:
> Convert the Calxeda clock bindings to DT schema format using json-schema.
> 
> This just covers the actual PLL and divider clock nodes. In the actual
> DTs they are somewhat unconnected (no ranges or bus compatible) children
> of the sregs node, but for the actual clock bindings this is not
> relevant.
> 
> One oddity is that the addresses are relative to the parent node,
> without that being pronounced using a ranges property.
> But this is too late to fix now.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  .../devicetree/bindings/clock/calxeda.txt     | 17 ----
>  .../devicetree/bindings/clock/calxeda.yaml    | 82 +++++++++++++++++++
>  2 files changed, 82 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/calxeda.yaml
> 

Applied, thanks.

Rob
