Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33471C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001662076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586887865;
	bh=/M1wkRgK0q9QZj94N8s9/wzcBiSn7xZpIUqYgIHBads=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xpvBkTt3GfElnAlHm3UFTstzmlD81TYO1jWMV20ZkojYBNTbeEHSd0g2n1GhBQlYJ
	 heEG/gHz17qOl6hERXADorfKogyMbBCbqyCIFP1CW7jhU54u9NlLOqOQ6ducmUfiDx
	 ZMCjrlGLBtM+Pt1Tv4Ywle8KClujgCgKrtoqyYHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503470AbgDNSLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:11:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35476 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503444AbgDNSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:10:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id b7so8676949oic.2;
        Tue, 14 Apr 2020 11:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oB5sk2MwSbhiUy+W0G0Bl9g/juUf3p/EcmLYPl57Few=;
        b=EPLmX7CdpsVtVPzojcNFk/zSCxQZc8E1Pw//KCxXfWaoErkFJHJh4bmrJzxnmHOijM
         lJ4TqumnZPTTrJW8meVoHKfRrXLOHrBYoBuY8wEfx6Tbef222BmXb/f6XthDbau6IXOV
         cYIvanL8Y/EKhyPzeszgJO7/MzLnHDWdEu4owSSAYpJp0RRBTesdKRr3LcjDqAJNjd+P
         gjIeLDVmDLfDnYfHQTyKQX/R80sNTMhxClA6J5jB4rtmuJQsMm5wVdf2t3WYGe6BKEZH
         NF4d9Vf7I5735QUD3PTQeTc29pc2NzvQHZEXbyukgKXEp9BjxBJA4BOn2i/9br51e7Rw
         LsMg==
X-Gm-Message-State: AGi0PuZmEavKhoXXeyax9BoCZIpRU+O4NMrKOtZXoKCvv8M2KbiKti+3
        PT2iFW/9+TxgQ2vdUrwtyg==
X-Google-Smtp-Source: APiQypJagr7RIdFhZKpzJ8Ju0BzkogCIDHrhONm+qQc9PewMhTDPXeiNeEO6zoqyX3sT8Lxvm+a4EQ==
X-Received: by 2002:aca:c3c1:: with SMTP id t184mr15433968oif.171.1586887856570;
        Tue, 14 Apr 2020 11:10:56 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s13sm6288868oov.28.2020.04.14.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:10:55 -0700 (PDT)
Received: (nullmailer pid 6753 invoked by uid 1000);
        Tue, 14 Apr 2020 18:10:54 -0000
Date:   Tue, 14 Apr 2020 13:10:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: timer: Add bindings for NVIDIA
 Tegra186 timers
Message-ID: <20200414181054.GA6655@bogus>
References: <20200403202209.299823-1-thierry.reding@gmail.com>
 <20200403202209.299823-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403202209.299823-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Apr 2020 22:22:03 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The NVIDIA Tegra186 SoC contains an IP block that provides a register
> interface for ten timers with a 29-bit counter that can generate one-
> shot, periodic or watchdog interrupts.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add required properties section
> - add additionalProperties: false
> - do not show status in example
> 
>  .../bindings/timer/nvidia,tegra186-timer.yaml | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
