Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAE5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153FF206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586888092;
	bh=sOim1Pn7iT7iYIL4ZQgyu2fS2DZG5DMNzgEbIoaSysA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r7H2zpUyxU0+DZ22Ch13oEUIH+MH/QN/6qFeES3qaD/Faj1iraAi9jP4MWsAumw69
	 /tZl99ehfbcOJmZqB5s+d27IOS+xYrTnd61FkNPJXl3vdH697fyUaIspoH4wLIdAQV
	 07Laz5GlF3gkeGoxGy3wMmeBAvmoXwblYH2OoI4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503684AbgDNSOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:14:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33735 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503671AbgDNSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:14:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id j26so414481ots.0;
        Tue, 14 Apr 2020 11:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vo+OgfcLNvRkk7b5MXN+3p/k/pIzdHE7xLuHzqtnamk=;
        b=aetBvNee6921I484h0Ks6mj4ZkbFiZS/lHjtqYW9UfHY0WVWBHwez3goyP1DBHBJqO
         XKiu6/aiv42PDl8pBXE69kCZwVnkCTrpfNV6QFSe2vqbsSjFMsFYTn1NeAzvz/FQ7LV2
         eTSoaQmeqRBrqRHVDQctih53Z0iJEXaDeXoOvRbznQUhlq+HsQiinfXIvdkJ+HrA3pzv
         wrFXZC2V5bFI7VlYuvILIZs77kuJeDLLISRRmutIr0TZDnwDv1wD6zV9RV07cjDjG2Lt
         dkIUJCwcXF6q0qQciN3UGOPJzvSGimtFQnhGuHJ/QVlQPkFGm3mTjpReQA9C/DbiHN09
         FJPw==
X-Gm-Message-State: AGi0PubUps7WhEajzHfxPUpsj2+p4zDRO+lsDtcdcCmKmnGxHbkaBzOt
        rxmWy5L24bw4FZ8fnEUIiZRsALs=
X-Google-Smtp-Source: APiQypKVLpJlG8c1B5PJ1L+aaHIRDG6Xc7WJ9Gk7A+JotcjqcV7ZsbWp8UQdCQSVEqQaQL3Ly19FYg==
X-Received: by 2002:a9d:5187:: with SMTP id y7mr18979852otg.159.1586888085983;
        Tue, 14 Apr 2020 11:14:45 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o73sm5658056ota.77.2020.04.14.11.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:14:45 -0700 (PDT)
Received: (nullmailer pid 17428 invoked by uid 1000);
        Tue, 14 Apr 2020 18:14:44 -0000
Date:   Tue, 14 Apr 2020 13:14:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, frankc@nvidia.com, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, helen.koike@collabora.com, digetx@gmail.com,
        sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 5/9] dt-binding: tegra: Add VI and CSI bindings
Message-ID: <20200414181444.GA17346@bogus>
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-6-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585963507-12610-6-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 18:25:03 -0700, Sowjanya Komatineni wrote:
> Tegra contains VI controller which can support up to 6 MIPI CSI
> camera sensors.
> 
> Each Tegra CSI port from CSI unit can be one-to-one mapper to
> VI channel and can capture from an external camera sensor or
> from built-in test pattern generator.
> 
> This patch adds dt-bindings for Tegra VI and CSI.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.txt        | 73 ++++++++++++++++++----
>  1 file changed, 60 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
