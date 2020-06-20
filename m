Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4627CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC0A22DBF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="St45XTuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbgFTCoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbgFTCoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:44:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9AEC0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:44:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k1so4768411pls.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLWT276u2aO9qAHRs8E3h1+NnyUeXGvQciwY1qNzilY=;
        b=St45XTuKxoL4qMh9JNrnVKhDLmDM/4iTL6bjKrYy6QLHEttboehyDjG/4XA+Gsf0G8
         /FxzQPFCADOTO4HhEohMQFuErk9XKheVZxB0wabwPgFl8XhHeVJmWC+O80H6XV+9I5y9
         fN11ubcOXio/kR1AC7BNPDb6DObr/oVvnTiiLcPTIAB7ixfyTnPaqAlZTu72XIBJEp+O
         LYwzPMmErpNCUiEcmHaLOCZReZEhoe7hfTcBOAAip/9v8I0NTKU2b76BUe8L88yaCoiN
         RYtUhjLps0ByxhH9miMu9OUZd+OgSyjvwtMNp1bikf8oYlYWQKFyZIKS1WiB7QB+k3sm
         n7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLWT276u2aO9qAHRs8E3h1+NnyUeXGvQciwY1qNzilY=;
        b=FiEM3+hTfezyizvLqrf3zqOC/5HfPVJRckwYE9X7EA7Ex1Zhsf5OeOrw2xx+Bz09Hd
         vYmTjv9kTCDPYLkabxQ3LfhXmPp40lhk39r2plyV1AB87IMnaYuIzOtFFjMvDViBtJbN
         YGlBFh/OSE6RyFXUR8MWgww/uDyoKduSE/lKbg4Aa8JfrRBwz9wjAqE2lm1dxCk3ASMu
         294t6t/dD7wSKVCOvvwhIpOtfIiae1gczJJNDT0TB2JDl2eoR1RTCHF+gpwacIkhAFdO
         CgAhly8DFbrpoiIxoe+1kyk1Q8ydlid9Pjw42sZadXcHq369br8jeUPOiPqE/8fwoe4i
         7MGA==
X-Gm-Message-State: AOAM533SEq/rU0ggw0K1S0A7h6kd+SsJrskqkd1XibQJ4v01oiU4Hrtu
        lkAevEidk5ePiqOs0kchzhYe
X-Google-Smtp-Source: ABdhPJz6e7aQ/jZVXcpBHCTWXtwI2uKAN2v8I1+qswnVkdxua9YKvO35sIeZLTi24n5yfLWTxU4m7g==
X-Received: by 2002:a17:902:7b90:: with SMTP id w16mr10287749pll.339.1592621040019;
        Fri, 19 Jun 2020 19:44:00 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:629d:f5bf:4d81:efb6:335e:3953])
        by smtp.gmail.com with ESMTPSA id w10sm6113168pgm.70.2020.06.19.19.43.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2020 19:43:59 -0700 (PDT)
Date:   Sat, 20 Jun 2020 08:13:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     wg@grandegger.com, kernel@martin.sperl.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Message-ID: <20200620024351.GA18455@Mani-XPS-13-9360>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200618085533.GA26093@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618085533.GA26093@mani>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:25:33PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On 0611, Marc Kleine-Budde wrote:
> > On 6/10/20 9:44 AM, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This series adds CAN network driver support for Microchip MCP25XXFD CAN
> > > Controller with MCP2517FD as the target controller version. This series is
> > > mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
> > > I've trimmed down the parts which are not necessary for the initial version
> > > to ease review. Still the series is relatively huge but I hope to get some
> > > reviews (post -rcX ofc!).
> > > 
> > > Link to the origial series posted by Martin:
> > > https://www.spinics.net/lists/devicetree/msg284462.html
> > > 
> > > I've not changed the functionality much but done some considerable amount of
> > > cleanups and also preserved the authorship of Martin for all the patches he has
> > > posted earlier. This series has been tested on 96Boards RB3 platform by myself
> > > and Martin has tested the previous version on Rpi3 with external MCP2517FD
> > > controller.
> > 
> > I initially started looking at Martin's driver and it was not using several
> > modern CAN driver infrastructures. I then posted some cleanup patches but Martin
> > was not working on the driver any more. Then I decided to rewrite the driver,
> > that is the one I'm hoping to mainline soon.
> > 
> 
> So how should we proceed from here? It is okay for me to work on adding some
> features and also fixing the issues you've reported so far. But I want to reach
> a consensus before moving forward.
> 
> If you think that it makes sense to go with your set of patches, then I need an
> estimate on when you'll post the first revision.
> 

Ping!

> > Can you give it a try?
> > 
> > https://github.com/marckleinebudde/linux/commits/v5.6-rpi/mcp25xxfd-20200607-41
> > 
> 
> Sure thing. Will do.
> 
> Thanks,
> Mani
> 
> > Marc
> > 
> > -- 
> > Pengutronix e.K.                 | Marc Kleine-Budde           |
> > Embedded Linux                   | https://www.pengutronix.de  |
> > Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
