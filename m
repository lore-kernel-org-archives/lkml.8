Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CE4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36379207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyfhdYXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgERSwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgERSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:52:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A29DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:52:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v63so5370476pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHsRyL8eiYlYHJa5uCVqQW9LciNEIDRKfuP+gda9x1Y=;
        b=dyfhdYXm4n0gy9np+W03BFusRSTd7VtjW+8PkcdsGSxtJz4guXAz37sSB8hMWjUGph
         zbDr6UdFU/HTP8pjg+drIGkkBBSVOQ37ReH9JLvb9yONunabVH65e6e23eGbkbGY19v9
         GYZEQHhy/JoXqdeSmftdi3L9aSvvTfzlZU/fAwO9dwPfGvDv9hafxxBGfPN/fWmMfVyh
         82VnVi2KZXkHpXzaJ4jUl/VE7wzOAmR4MdKOPCVflq5/SJemnEyWcSTYPEHQLslG6Lz+
         Z3ZA3TnxdgplAbEzKzHTm3aKJd+81u90aL+aUWFoGVkXrG15xE7IVQKaOjYT7wydzKos
         k4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHsRyL8eiYlYHJa5uCVqQW9LciNEIDRKfuP+gda9x1Y=;
        b=lKVGHYhPJxd+5BlDGRYpynBfNnqJRcfbHW72k1mzPprUIfKuq/s15p//WGHVNKdt4C
         mT8kgasuX6lKAVrTDIRBOVg7nVx3HlqvnLa5Zlo3yUaBk7QnvLrX5kgND04IHFOAlAiM
         7Vi8KbXpnMNkUwkTbllaSvYbIlIguL2yfS8QrFFTZDlNqB0yHfeu9Nrgjxhy+Z1wFr87
         +nMjHSVbtu3n+078d5w+e0geNeiS6HcU6bEfESUmVI11jbUaUtx7QKHR4BvcgSIsVx7g
         wbgLC4ILD08fZRe7BMQyou/Y2n9Gpnjx9xVEP6KYEjqw+zTZLrap0FjqFW1Js0abddSx
         8n+g==
X-Gm-Message-State: AOAM531CD6PGfjgoqm43Q8fRbmoLbokQ6qiZbiYGo0SAcPPgxWyzpYf9
        5Ok6GhcAWqrZ8F9YovUDWyd5xg==
X-Google-Smtp-Source: ABdhPJwuOK5f/6WvkScgGfZPG6iAsM8lfv6feBqqP52/8AtflODCDgQ3dim7PNYVoCPioH3FmWoAqg==
X-Received: by 2002:a63:f70e:: with SMTP id x14mr15583487pgh.394.1589827968132;
        Mon, 18 May 2020 11:52:48 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 3sm9698235pfo.27.2020.05.18.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:52:47 -0700 (PDT)
Date:   Mon, 18 May 2020 11:51:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Support ETMv4 power
 management
Message-ID: <20200518185124.GG2165@builder.lan>
References: <cover.1589539293.git.saiprakash.ranjan@codeaurora.org>
 <b0a2ac4ffefe7d3e216a83ab56867620f120ff08.1589539293.git.saiprakash.ranjan@codeaurora.org>
 <56a5563205da61c47eb4f8bbf6120e28@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a5563205da61c47eb4f8bbf6120e28@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 May 03:55 PDT 2020, Sai Prakash Ranjan wrote:

> Hi Bjorn,
> 

Hi Sai,

> On 2020-05-15 16:21, Sai Prakash Ranjan wrote:
> > Now that deep idle states are properly supported on SC7180,
> > we need to add "coresight-loses-context-with-cpu" property
> > to avoid failure of trace session because of losing context
> > on entering deep idle states.
> > 
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > ---
> > 
> > Resending this because the last patch sent here -
> > https://lore.kernel.org/patchwork/patch/1230367/
> > seems to have added "coresight-loses-context-with-cpu" to
> > replicator node instead of etm7 node.
> > 
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > index 4069bb1c93af..8b3707347547 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > @@ -1656,6 +1656,7 @@
> > 
> >  			clocks = <&aoss_qmp>;
> >  			clock-names = "apb_pclk";
> > +			arm,coresight-loses-context-with-cpu;
> > 
> >  			out-ports {
> >  				port {
> > @@ -1674,6 +1675,7 @@
> > 
> >  			clocks = <&aoss_qmp>;
> >  			clock-names = "apb_pclk";
> > +			arm,coresight-loses-context-with-cpu;
> > 
> >  			out-ports {
> >  				port {
> > @@ -1692,6 +1694,7 @@
> > 
> >  			clocks = <&aoss_qmp>;
> >  			clock-names = "apb_pclk";
> > +			arm,coresight-loses-context-with-cpu;
> > 
> >  			out-ports {
> >  				port {
> > @@ -1710,6 +1713,7 @@
> > 
> >  			clocks = <&aoss_qmp>;
> >  			clock-names = "apb_pclk";
> > +			arm,coresight-loses-context-with-cpu;
> > 
> >  			out-ports {
> >  				port {
> > @@ -1728,6 +1732,7 @@
> > 
> >  			clocks = <&aoss_qmp>;
> >  			clock-names = "apb_pclk";
> > +			arm,coresight-loses-context-with-cpu;
> > 
> >  			out-ports {
> >  				port {
> > @@ -1746,6 +1751,7 @@
> > 
> >  			clocks = <&aoss_qmp>;
> >  			clock-names = "apb_pclk";
> > +			arm,coresight-loses-context-with-cpu;
> > 
> >  			out-ports {
> >  				port {
> > @@ -1764,6 +1770,7 @@
> > 
> >  			clocks = <&aoss_qmp>;
> >  			clock-names = "apb_pclk";
> > +			arm,coresight-loses-context-with-cpu;
> > 
> >  			out-ports {
> >  				port {
> > @@ -1782,6 +1789,7 @@
> > 
> >  			clocks = <&aoss_qmp>;
> >  			clock-names = "apb_pclk";
> > +			arm,coresight-loses-context-with-cpu;
> > 
> >  			out-ports {
> >  				port {
> 
> 
> The previous version of this patch in QCOM tree seems to have added the
> property to replicator node instead of etm7 node, can you please drop
> that from the tree and apply this one?
> 

I'm not able to replace the old commit without rewriting the history of
the branch. So I've applied a patch ontop of the branch to fix this up
instead.

Please review the branch and let me know if there's any issues.

Regards,
Bjorn
