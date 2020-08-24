Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4489C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B14220738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598264957;
	bh=OlnfrrAOCtt6dmRSOcO0sAL3Z8uKFnAPNnmGJCowrHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zRYPG+D5NlO/4b64qz4vgpFdRKO7OplBgziNi/xoxxlUBtyYVwRmslOLKMlHV6s39
	 SgHPY+vSogRBw6xd4xR72n2Gp1rkjAKl3DMY+S09T3TOyu/XL26amrisx1075YvOu0
	 b6+/2rVge9WQggxKn0HUmsHSBgxY+HrRMH+mUetk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHXK3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:29:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53295 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHXK3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:29:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id u18so7798458wmc.3;
        Mon, 24 Aug 2020 03:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p57SiOHtRbwlQupdrSnOey26LvkIUXQt92MycqtUZeg=;
        b=FIhBdwNVolmczHtQw2MRysZGAzTAdrzFNT+XmaCGSnf4t5vd4tOqn7AMRp+1hE3TtS
         0QE3MGRYlmXZCnPQBAF7qnm/AFYNiClOsQILZpgq2H1JcfIpNnF0ut2/0VTHR7m/Hq9f
         oq1X2+Wt2A+a5mpwUhHWDMMvVZDWPxsMxRlVi5OHttsTdM+TR1BHGCz7YY1HdDoNIg6A
         CZS2XcK5ygHgrzc0m23nbUJZ05cD9QvHh5b1vLrBhOxCgXnCvfZvkMVj7uLE5B4E0B4N
         lOuwJe5+HYl2Uf6NoFtYRtjnL/0Qp3PtH8k/PB6a1w+y1yRtnLNbHXZEEno0dWlHWlvO
         Ub4A==
X-Gm-Message-State: AOAM5326pKlxOcSCEqXkfMsbHLTpo6BMJVsaX0jxQzbTTElcpJ4dByl6
        lQMQyGnZ9FD+JdF2HgiJam5U6etYEBo=
X-Google-Smtp-Source: ABdhPJwdez4IYfFzgG6H0KX9gD8qOZkZmCVVDIP6EB9v9OZicoJ3QzuOPSBTE8b+JgNshOsxs6nMtA==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr5101014wmj.150.1598264950766;
        Mon, 24 Aug 2020 03:29:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id o125sm24625474wma.27.2020.08.24.03.29.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:29:10 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:29:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: zynqmp: Rename buses to be align with
 simple-bus yaml
Message-ID: <20200824102907.GC25860@kozik-lap>
References: <68f20a2b2bb0feee80bc3348619c2ee98aa69963.1598263539.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68f20a2b2bb0feee80bc3348619c2ee98aa69963.1598263539.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 12:05:42PM +0200, Michal Simek wrote:
> Rename amba-apu and amba to AXI. Based on Xilinx ZynqMP TRM (Chapter 15)
> chip is "using the advanced eXtensible interface (AXI) point-to-point
> channels for communicating addresses, data, and response transactions
> between master and slave clients."
> 
> Issues are reported as:
> ...: amba: $nodename:0: 'amba' does not match
> '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 	From schema: .../dt-schema/dtschema/schemas/simple-bus.yaml
> ...: amba-apu@0: $nodename:0: 'amba-apu@0' does not match
> '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 	From schema: .../dt-schema/dtschema/schemas/simple-bus.yaml
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> The only one problem with this patch is that it breaks paths in
> /proc/device-tree/.
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
