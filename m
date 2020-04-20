Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9811FC55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77358207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587415774;
	bh=bRVVITr3UcIwXyI028N/rAXq/+0KFjXboSJDCcFfTgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mUKaNZMAgeCHYgt8BzGdXbp88pypOZaOCWJvaFqExXdV2d6hKqPT7U4LdS709oqQw
	 WdFF+Yiriz40WJR4RWNbFxPKIs/Ppd8H4yxx+ThHugWPxBpux7YFZYt8LRXDD4q6sL
	 SHn0hSBwl5ROKsCryvT/o//Mb0kSq9gdKwh7sMeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgDTUte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:49:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41215 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTUtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:49:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id c3so9360278otp.8;
        Mon, 20 Apr 2020 13:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2T2FqVrKnElDHwOjrVabuxgD8SoX9DW7VweKw+qpwno=;
        b=ADAiY+W2OK0Ymqb/n5xyVkroY2DUHTE5vwpNYb8Yp8iFnYubBOxlALehugeyqiSULb
         HGa8v8ofnHNl6sc415xQyLvO903alieK7p7b96v3J7QPuj8TXyFuOQ8ENGFJT6jOkmDY
         Ptsy0UWvqxejW/Ck8kb/lr9YB/jttEPmmULMPuyVU+wlJf3Ah+N0fM99Gkn53ht+Ibkn
         3Z/2QEbqP23ZOkqQpNHikJVpfRHPfKCPhCci5NSTeLqySSa63yrz9cWmjTMvWG5bZ0gl
         43S++0mCO6NugtrjKt4VyHzX4erhbwadfzcNxpNgh1dqCcd6Z5CPST/H0cIsWFVUeHdO
         a2DQ==
X-Gm-Message-State: AGi0Puak48IW0DupXUGRDPiBZpRba9Jx/WkESI+ZkN0v8ELFZGDGKZjH
        D/3vfphS/SfJAJR7tsrbCQ==
X-Google-Smtp-Source: APiQypIpvrumibyLLGMFXdDeSHBRlkhHHz9YHc+SPLHyKps+ObwSQg5BBXV4vSVkCi1hWsc3nm5IZg==
X-Received: by 2002:a9d:6414:: with SMTP id h20mr11364349otl.286.1587415771091;
        Mon, 20 Apr 2020 13:49:31 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w62sm134033oia.32.2020.04.20.13.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:49:30 -0700 (PDT)
Received: (nullmailer pid 5070 invoked by uid 1000);
        Mon, 20 Apr 2020 20:49:29 -0000
Date:   Mon, 20 Apr 2020 15:49:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>, od@zcrc.me,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 03/13] dt-bindings: dma: Convert jz4740-dma doc to YAML
Message-ID: <20200420204929.GA5014@bogus>
References: <20200413152633.198301-1-paul@crapouillou.net>
 <20200413152633.198301-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413152633.198301-3-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 17:26:23 +0200, Paul Cercueil wrote:
> Convert the textual documentation for the Ingenic SoCs DMA Controller
> devicetree binding to YAML.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/dma/ingenic,dma.yaml  | 80 +++++++++++++++++++
>  .../devicetree/bindings/dma/jz4780-dma.txt    | 64 ---------------
>  2 files changed, 80 insertions(+), 64 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/ingenic,dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/jz4780-dma.txt
> 

Applied, thanks.

Rob
