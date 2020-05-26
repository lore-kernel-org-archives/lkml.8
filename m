Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37178C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABE12084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590532255;
	bh=PpRWmt4lrIvfVs00wdTSZmjmEeIY+ONMcpNUSA4V3kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x5Gjg5/xTLr90YbauTbWJZPlS/rI+yYMBVVl9yQ4O3o5I1nnN7MonT6Rv+Y+OFZZ7
	 xg7olq6WBD0w9ras6GM6WcLLVknZW6b8bUsaxpVLyilotizxguVBXjwvxUA8tYQJ9N
	 oYyEYF2EVJUdCThgh9zvdotAp3HucZR797XVfuh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392045AbgEZWax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:30:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35600 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZWax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:30:53 -0400
Received: by mail-io1-f65.google.com with SMTP id s18so9915257ioe.2;
        Tue, 26 May 2020 15:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rXv9v6cApyCHg24WwJoLLuZ6GgPfJ2x03E4A6LfYfrI=;
        b=mLGdpvVJYdhN9gkq0l0WfYpThMQdXsXWkK2uQ90EzB8di9By3JV6qHB1rQ60hwhAcs
         KpDbZ63bwxsZInFmflh7eWVTydxSjYkmdSXVcuc1kwzzFVp47g5IZNcQxuCXqN/WqviB
         MHCiWOUkNJ/4Dd8cg84/1aKeQsw9pBtGe0EGoZMxdDuv7vPEeuxiqq1RurJHNIi0UY9Y
         aBARNU3axMHVPUwFR/4Uq8JMlr5NbjYi3caas/NR0C2OIdvTxUj/3eWJ9ad+8xe6yhkd
         DnWDiZYkMDbIXJlI9lAtMQQDMMQ3dTZenlvF9SNwwv7X490ajLhkbBTTQ/1lxzU3NUat
         UeIg==
X-Gm-Message-State: AOAM533X/9SyixY0tVGe58sWJhrcODdvKFO/pfJN06/vsQdQVCAaldsV
        AF8dfZ7LWgasn6kxxj/DDw==
X-Google-Smtp-Source: ABdhPJyfX3x2ll9BPborU/rs1EacdVehwUlTCaxQeIXf0m5LHFmkGxuQBVY+bykp6NSE7rdUNRa5Mw==
X-Received: by 2002:a6b:5c19:: with SMTP id z25mr2442629ioh.119.1590532252279;
        Tue, 26 May 2020 15:30:52 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z75sm681163ilc.50.2020.05.26.15.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:30:51 -0700 (PDT)
Received: (nullmailer pid 502906 invoked by uid 1000);
        Tue, 26 May 2020 22:30:50 -0000
Date:   Tue, 26 May 2020 16:30:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V5 2/5] dt-bindings: clock: Convert i.MX6SX clock to
 json-schema
Message-ID: <20200526223050.GA502855@bogus>
References: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
 <1589328684-1397-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589328684-1397-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 08:11:21 +0800, Anson Huang wrote:
> Convert the i.MX6SX clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
> Changes since V4:
> 	- add descriptions for interrupts and each item of it.
> ---
>  .../devicetree/bindings/clock/imx6sx-clock.txt     | 13 ----
>  .../devicetree/bindings/clock/imx6sx-clock.yaml    | 70 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
> 

Applied, thanks!
