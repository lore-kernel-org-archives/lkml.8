Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5939C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74115206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586540661;
	bh=NzY5vOWWuQUYRQgthUZFnpFjROcRtToCuD2grSEo0xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g9YX6uQybh9k4gF4i2lchZFAWxFBRwzT+QA7ucpziBYW5SEMhghE11R5yK+gjt4L3
	 q7oPo4PyaMV1N+InIV2gXiuZ0CkPF07TAiaXhx6n3usEHA9crICXJKKO2uookYxymc
	 HbiL/AjKqR5LecRG5lhZ2jy5kJKOtGXPiGFzKYGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJRoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:44:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38120 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:44:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id w2so1982405oic.5;
        Fri, 10 Apr 2020 10:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSwNy1tJz4LnthkNz4eu29xiKtjPqkQs8epKrYetAcA=;
        b=P/XoaKpbxh4nWdAoXnFFv6hQicq5t+5xe13Fpvmxa4Z9s+Luoow31b+yFb5CFzU8D7
         DltVUMZzCeTeWj20RljyWE+tDSzeCAs87/LhTGjblyCHPYVZDIojpbAds7LaCQcCvMe+
         2IXrBw5LRQeAWhzwwB+aCwxMDeNZbnhXmMWHtioqPe7klIcF228cvMrXaaBO1tE9ohyT
         /IwFIaLsOdZZlEI9lt6uhUyh2EQIJfqKWkddERmucC5qD5CJ49uKJHvRrFBS+vd5VGN6
         fVr93Ngm5aSFmZFxyUApT0Sj5/gP+OB1UsSGHjYDQWxEMIXltaad67qvOpA4ifWGani7
         yWXQ==
X-Gm-Message-State: AGi0Pua1Th+EukpIMjXcbSbA4jh2IkckPalBwhK6+EiZHmiLd1nTFS77
        zjGMluTUMnz7Zb5nvrf/Yw==
X-Google-Smtp-Source: APiQypL2ZJu/xdLEJ0I6dA8ilTA3Y6JVALbbZMRVcfLcQccXYD6tcxnLAOWU7dYVvd9Ls/XBydO1gg==
X-Received: by 2002:aca:d68a:: with SMTP id n132mr4324743oig.40.1586540657449;
        Fri, 10 Apr 2020 10:44:17 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id m13sm1270005otf.15.2020.04.10.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:44:16 -0700 (PDT)
Received: (nullmailer pid 21853 invoked by uid 1000);
        Fri, 10 Apr 2020 17:44:11 -0000
Date:   Fri, 10 Apr 2020 12:44:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: sound: tegra-wm8903: Document new
 nvidia,headset property
Message-ID: <20200410174411.GA21788@bogus>
References: <20200330204011.18465-1-digetx@gmail.com>
 <20200330204011.18465-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330204011.18465-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 23:40:10 +0300, Dmitry Osipenko wrote:
> Some devices have a 4-pin headset jack instead of 3-pin microphone jack.
> The new boolean nvidia,headset property tells that the Mic Jack represents
> the state of a headset microphone. This additional hardware description is
> needed because microphone detection procedure differs in a case of a 4-pin
> jack from a 3-pin jack.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
