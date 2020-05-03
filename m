Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA86AC47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5F9206EB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588521337;
	bh=vYm1fNjpZI+FuscA2OgR34WkS9bRGzrvR2zVT4s7Fuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EuCB0tzeliEg+cpGQ36b1Ph+enGfYX4af3sLGusk8V+S24/prq7DzfHsGnMNUd2sv
	 b7W5iPH9mEozlz0HnsDYj6Us2AqFCHkyBLIXKWebkP2tiTHBkzk/xTA8eK3uCwgt41
	 +yREQXUAugqP3UVUIy8eghYfoHxhzvXJm9cmjkBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgECPzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 11:55:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36333 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECPzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:55:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id s202so4465065oih.3;
        Sun, 03 May 2020 08:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9q8wbZYRPSqQx47Qv6StuG7MMHileffP2EgPKwq6m5E=;
        b=t5DDWpS/yRcEFlmh0Q2zcHYnNByLHgUWTojlDFl1OyTyeRSTnw598Q315QFNyDzGdV
         eGP6sVJOP4Gr5cAYdz+29Kyl5IYvWgFeU9etsdRXrevSnnd7MObzpHQi860o6nv8M394
         3HnUiT5ZqA0LW/fhbRcksfZmujDD8pL/JI4yZgQd+WJGMvudQFh1nImiZi68PwZBaY00
         ZCHI9KBXSvwtyZfh+tES+yNIrIsJiq8cWbSi6LssPaSpJhOzq/tsXjloPN+Id5N6PisJ
         5PgwZxbEHI+NFJqhbiDbWFKAuqkNCiOk2zwBq8PXxnBnvzdOAUg6NWray9LYD2bh/Nsc
         ZFHg==
X-Gm-Message-State: AGi0PuYUx9UqdKqZMRJ1DVcS+ozcIWgVJBn6ZUAEkNYgl5P0rk36+TGn
        hoWgRWd11KWil6rDW8rALEFDiA4=
X-Google-Smtp-Source: APiQypIUHBG+6CETz5iYd3KTYNZ/l+5zZP55EATPbVy0cOYyjC2WTEqT/392JI4+a6Me1XA+mwdXeg==
X-Received: by 2002:aca:7209:: with SMTP id p9mr6246139oic.168.1588521335438;
        Sun, 03 May 2020 08:55:35 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e15sm2515290otr.36.2020.05.03.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 08:55:34 -0700 (PDT)
Received: (nullmailer pid 20682 invoked by uid 1000);
        Sun, 03 May 2020 15:55:34 -0000
Date:   Sun, 3 May 2020 10:55:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 4/8] dt-bindings: phy: Convert Calxeda ComboPHY
 binding to json-schema
Message-ID: <20200503155534.GA20627@bogus>
References: <20200430211054.30466-1-andre.przywara@arm.com>
 <20200430211054.30466-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211054.30466-5-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:10:50 +0100, Andre Przywara wrote:
> Convert the Calxeda ComboPHY binding to DT schema format using
> json-schema.
> There is no driver in the Linux kernel matching the compatible
> string, but the nodes are parsed by the SATA driver, which links to them
> using its port-phys property.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/phy/calxeda-combophy.txt         | 17 -------
>  .../bindings/phy/calxeda-combophy.yaml        | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
> 

Applied, thanks.

Rob
