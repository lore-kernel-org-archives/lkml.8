Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8220C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7CF207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578955883;
	bh=8SHYSRecd7dCl94Zj6wkFgy4DRadS7RUP6CTF0ssh9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p6FjPa4ZGRFPM2Neud87sIi1FOeyIRDKepIl2xWasMXM7MHQeTjEQJqy9RwwddoPj
	 vF7+0S/eHy6jWMfymX3NbddN1x5DZQCgGDuqCdft/1tv+BDyVSHe12G7PJt8RwzwAx
	 6VIwo9U++gRIRHRuN2itn+Zk2eIbbXWv6QT0M3yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAMWvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:51:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38086 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgAMWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:51:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so8527756oth.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+TjdMcFXIkLDz7Ope3oNQdtKGj6YfaXsPTt/MuhULpU=;
        b=uckpTdqbRHJG16+BbiLPTmpn6Zekci1ONWsxZos7SsSWwSg3DoK4mmZi+IrluZG4Wb
         MSuYzjypKFyU/LcQtyu2kmLPilbDRovF5oIQz5XWRI64E6vXI5wJQORQwMgifibZbYLZ
         VEerI6R7QeA55CRuqA/jU3aEyOXLENYaTLUs0nxcEpxGTA6XeE29+hDAdCo6Vzm8Ckgc
         etC0mNEaj6bdvI6sDn4RHxLrMghZuxlEul/Suw7DdAEt1cAZ/GxCoQ6pSJsbWXSlmQLy
         mIyNQi/C9ck0ZsjksaYOGtZU6t3Ui4UY3w/IvtCNGxEMJmvTFXf1OAwny/OdruhvhIMo
         V1bA==
X-Gm-Message-State: APjAAAWewQcVNCfVSXB3Qv5mfBG6iK46sdzts+131xLATp3Y1Mohoplg
        3t6dn4TyijgCEIIUWezrKnFgB2I=
X-Google-Smtp-Source: APXvYqyqySohVtTNJx8gpLgYZwAN+tLwr5zNAtOhtLcKy0NToTVa3FFY3CRs5sU3qf4vOnaaOhYwjg==
X-Received: by 2002:a9d:70d9:: with SMTP id w25mr15526428otj.231.1578955881775;
        Mon, 13 Jan 2020 14:51:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i3sm4654470otr.31.2020.01.13.14.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:51:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:51:19 -0600
Date:   Mon, 13 Jan 2020 16:51:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, georgi.djakov@linaro.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com,
        viresh.kumar@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: interconnect: Add OSM L3 DT bindings
Message-ID: <20200113225119.GA15922@bogus>
References: <20200109211215.18930-1-sibis@codeaurora.org>
 <20200109211215.18930-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109211215.18930-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 02:42:12 +0530, Sibi Sankar wrote:
> Add bindings for Operating State Manager (OSM) L3 interconnect provider
> on SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,osm-l3.yaml    | 61 +++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,osm-l3.h    | 12 ++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,osm-l3.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
