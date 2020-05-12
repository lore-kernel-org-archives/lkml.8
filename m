Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3056C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E3C206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589295465;
	bh=1/hPsfcZs5Y8EjeVEzoycUhidXcnl2B8kam/Bd6wXXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P4RrkAcAtyk60CGX6jMmCd6ASQBu5DXFGRdk16Wg4bHjeNQSBc/6CafKdFGcWYr2G
	 fRInzACwO3Ot1qcK9249hTPcGCGA2xW/2A3iagK+T2KK/5dLNYUzbf80k16suYEAfs
	 JBXz7FdsP8RFOhxhHopeB+Xx6BObdo5LbrOj0Kdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgELO5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:57:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43765 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgELO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:57:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id i22so1859981oik.10;
        Tue, 12 May 2020 07:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0RjlmR6YuJe5OFTdNqr/waaHWAV5lpqikYC4DfnGsDg=;
        b=pr6MKC9GgJBdwIC7i4YNF05bQvQmjsUlayk2pWP2UNW1Q8TnPgva1GD4JiMqqEn88r
         jIBq/7HsLr526WqCF8giU9Yzff750GZT4oEL9DtVmBJ+H35ND5OsxEZr61X6+8BzfWLh
         YtnmS34FRvh3m4W+RvUaGLdTYyqIB7aGwOnhMmf/KQU9YW6OQUWbDmJX1c48pc9LpUbE
         Yd3FuDhuLI4D3ZdhC9mzqGfp1mOEdctpptzaKWB6T+RIQNZgokM/mqeZg9RUAT4ayaq4
         3DdrJ8f5NxTnaAgN4/iVlCVc3JqALXU3SJ4CJijTyWCwpka8BcWMAqv2+5XcTmpLUt7g
         y2ew==
X-Gm-Message-State: AGi0PuZNoPjL7QdSaYjywzP1pWnqdo+197oaK6oANkHWer661kwfCLJP
        43H5e2DPZD9LLgZtyiKyEQ==
X-Google-Smtp-Source: APiQypK611Fjk8XOJF2hXT2tzKw9uv0/tp3+vM3Z12fb7KSgcfstQYqV42iyNBPHT0pWjJ1kOCMV3A==
X-Received: by 2002:aca:816:: with SMTP id 22mr22840562oii.51.1589295462251;
        Tue, 12 May 2020 07:57:42 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m27sm220241oom.22.2020.05.12.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:57:41 -0700 (PDT)
Received: (nullmailer pid 4113 invoked by uid 1000);
        Tue, 12 May 2020 14:57:40 -0000
Date:   Tue, 12 May 2020 09:57:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Message-ID: <20200512145740.GB25671@bogus>
References: <1588207921-20604-1-git-send-email-Anson.Huang@nxp.com>
 <158865854354.11125.10611865219975766594@swboyd.mtv.corp.google.com>
 <DB3PR0402MB39164125CABC889C5DEE5D8AF5A70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39164125CABC889C5DEE5D8AF5A70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 11:32:42AM +0000, Anson Huang wrote:
> Hi, Stephen
> 
> 
> > Subject: Re: [PATCH V4 1/5] dt-bindings: clock: Convert i.MX6Q clock to
> > json-schema
> > 
> > Quoting Anson Huang (2020-04-29 17:51:57)
> > > Convert the i.MX6Q clock binding to DT schema format using json-schema.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > 
> > Please send a cover letter next time. Who is going to apply these patches? I
> > hope Rob? If you need an acked-by feel free to have mine!
> 
> OK, will have a cover letter next time for patch series.
> 
> Hi, Rob
> 	Are you going to apply this patch series? If no, can you advise who can apply it, thanks.

Yes, respin fixing interrupts in all the patches.

Rob
