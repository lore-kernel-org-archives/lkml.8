Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA79C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1098620752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589235828;
	bh=PB7X/7iqZi9EnPJLEwX2aXz19tcZnl108oXOwniojk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eZBPbZCAIGKz6pWs2AU9is4r+a7Nf53kPhzaI97GC/1qJaQLXISTWomKyYMVAF17/
	 1M2Rp8DRYXPJxbQrbpEg8zsR77Xrqm19h2JffcwNyEfgokpZQDPMQuCyKIf8/+nIbY
	 Eadob28lP80lhdl651w9I3EpF9Lbj501cRkke1N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgEKWXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:23:47 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:45450 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgEKWXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:23:47 -0400
Received: by mail-oo1-f68.google.com with SMTP id p123so1141499oop.12;
        Mon, 11 May 2020 15:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxe0EOA/XjsvCOYJGRvTEs/nb3qiG6nQGta6RrJq/Uw=;
        b=EG71JIYEpOFSGCNU16DeBd9VCXlcMDRa9UE+R5iG1BNungU7q0i6FD+F858DoGPo2e
         u7iJFAIW0jTNyBQBBgD222Kt8iafyPEIFGfHgg7W9rcE5iaptSLc2se88+5bkDfdmorr
         jve2z7MHIITgS6P1MgkibEk8VKleOy60En6x/V3+uXawe0dgf4oZpxXiSSreiIrh/hLO
         MQwEGPSl7Opt3vlrv75buEyYPM83u8lxBcabDKtWvK7hZnOre0FMoIbAngrPL+eWaBXs
         mUv0tyOaKMke9nBwDdUIb1Meap2mHkU6kDVGPUEabTMy1T2kKCVMmhnMljObsvohTTp8
         Nw5w==
X-Gm-Message-State: AGi0PuZFhfrApLujmJvme0oKNCI1mMGWPPxA5Z2FYz3SAyhUK2AB0SbI
        w/0NPo4qur6ZGQvIhAG2oQ==
X-Google-Smtp-Source: APiQypLob/eP2oKEsV9pAwQJ50RcvSlTU8e85Wr858uT15YTqIwZKcW9krLHTwT1SrrSTo37eUE+gw==
X-Received: by 2002:a4a:8c0e:: with SMTP id u14mr15209996ooj.72.1589235826324;
        Mon, 11 May 2020 15:23:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l24sm2959923otf.59.2020.05.11.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:23:45 -0700 (PDT)
Received: (nullmailer pid 22894 invoked by uid 1000);
        Mon, 11 May 2020 22:23:44 -0000
Date:   Mon, 11 May 2020 17:23:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Add ENE KB3930 Embedded
 Controller binding
Message-ID: <20200511222344.GA22834@bogus>
References: <20200424221123.106527-1-lkundrak@v3.sk>
 <20200424221123.106527-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424221123.106527-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 00:11:22 +0200, Lubomir Rintel wrote:
> Add binding document for the ENE KB3930 Embedded Controller.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Addressed binding validation failure
> 
>  .../devicetree/bindings/mfd/ene-kb3930.yaml   | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
