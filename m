Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D902FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6E62253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583865673;
	bh=Ck3Z2DUi4J7kJJL1GeyA323OUte/zlDqXJuhcZsgVjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1fw6qWvZqGDJtQHPgCwy+gd/n9fKLO2QN6ogeYFQnVzp9DBHKoZJMPRYBPvP8s7jM
	 7CHnbWat0Rfe0RwghqzzOz2OMsosEdyKw8i8c74NOinlPN3C0kjya2OecVO31QeoJc
	 vQzBw5U8aOgenWupriJqXqEf9rL0xfOVXPu55PoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCJSlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:41:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43358 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:41:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id a6so6288993otb.10;
        Tue, 10 Mar 2020 11:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yilc9mhdFZvcfQin0GJ0eQvRcufzr/Dm7B4thkkaYHw=;
        b=FQeA8OBm7XuNoqtbmUQRPmLvDo7VOfvlDpUdgpCZwXfcXQqCwsV5sTOKIMVHcSJaoM
         bSefGwKzEN8c/lIWkazxMlDqWZPLX+2MXHPCl6p6ZGnIyVFUpLSeWQHGIFkmWeJGcamC
         GNBfPYYRw/BCkU/7MukVskqfxFeJSGSQ7EiV8wYrl3W/9WTIbyJM62Ep1cVECAA3dHuo
         zaXUZTvzL1XU2+36F+v9x9vuJSY/QB8ie5E4R39CUInG8PZeajSSR4G+GFhPp4QD6YHg
         Eg+WlAnyH2vtLQJzliLhu2jvNpk43y4QoaO4iUhKZt1ZWsSoS2/w29dA1nlXR2LezVcw
         O1Qw==
X-Gm-Message-State: ANhLgQ3QLa27OOL2siRzLZ94LfUMfxGfAdcXYbXYfVpCKt3nq4vZTspO
        vmBbrpuhEQTVvz0u4oNHNw==
X-Google-Smtp-Source: ADFU+vs/2TypjqEMN/AlYKRD1w+166WI1z9sKyXsLQjXpYLMyf6JNW7TSM5mm39EtFmpUM3Gntw1rA==
X-Received: by 2002:a05:6830:1b68:: with SMTP id d8mr17520762ote.56.1583865670711;
        Tue, 10 Mar 2020 11:41:10 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s22sm5984280otr.57.2020.03.10.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:41:10 -0700 (PDT)
Received: (nullmailer pid 2632 invoked by uid 1000);
        Tue, 10 Mar 2020 18:41:09 -0000
Date:   Tue, 10 Mar 2020 13:41:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     sboyd@kernel.org, Ansuel Smith <ansuelsmth@gmail.com>,
        John Crispin <john@phrozen.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: clk-rpm: add missing rpm clk for ipq806x
Message-ID: <20200310184109.GA2508@bogus>
References: <sboyd@kernel.org>
 <20200310143756.244-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310143756.244-1-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 15:37:56 +0100, Ansuel Smith wrote:
> Add missing definition of rpm clk for ipq806x soc
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Acked-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/clock/qcom,rpmcc.txt  |  1 +
>  drivers/clk/qcom/clk-rpm.c                    | 35 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,rpmcc.h        |  4 +++
>  3 files changed, 40 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
