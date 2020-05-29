Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B27C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9387208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590781008;
	bh=z7ZR7hhgo/DzTMh/wyL0HjNLMwCgiFg7VAc9F6j2hoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rxzCl+mrJ1hnOO2DpQ6NrRe03tp7J4iemQP7yMWu9cZTubclwp/yD1txIfC/NgNmj
	 ONmQmMp80o+hzMoLDGzLs7kHgK66FeDY94YqS7pANEfTVT8ABzjopB+H1vve6FsW16
	 IPimqEengIQWsHDvW4I5TrJEoCrrQt3YQuSkJ79Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgE2Tgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:36:47 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36395 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2Tgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:36:46 -0400
Received: by mail-il1-f195.google.com with SMTP id 17so3664215ilj.3;
        Fri, 29 May 2020 12:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u4JJuz4TAar60F38SQZw2KBTCJrS5nElM3p5G9Nq7yQ=;
        b=kFAOC7/BdGdB+xX+accui/3ZkWeOykFfFrU57UP/RHW2Nroua+Zylk078lDBBojFgp
         eOVrX44wJT/CYsmrceni/AMXapgTtBEreRDFulDh5AGN/RwppdjIdlfRUYFE3MlA6m4Z
         +xnYgHzQbmII4E4mpea28SfCKrkSoD8J/WnfUBLJFsc6JVxYaNoDXQ9DtTmZIgHcoPsm
         CmCJAAf73OfCKg1yCSSMpPrkqQp7NbRPTC6lcO4f112bggwVSqOEnz6Fsc+AZ4CwbkmA
         YYS2tWEq1/PRp0eHW701PhJXHKeTXkVy0H+opkV3pxeySOAzK70opY4K8GlqPFEjmou5
         H7wA==
X-Gm-Message-State: AOAM533x7QHsmin+RC1zn0fAgn6A/s/m1cR/43EnktET4gEXiaSx97kw
        tIH8fLI3kH0oGYlCftoMnA==
X-Google-Smtp-Source: ABdhPJz+wV8UcwQ0Kd/c679Va6YB924PcALUTRcMGJuXlpRNr8Q7V/3QZdJFrUIiLqnJWf5HqXDRvQ==
X-Received: by 2002:a92:cd11:: with SMTP id z17mr7965249iln.12.1590781005909;
        Fri, 29 May 2020 12:36:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s15sm5239645iln.49.2020.05.29.12.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:36:45 -0700 (PDT)
Received: (nullmailer pid 2815499 invoked by uid 1000);
        Fri, 29 May 2020 19:36:44 -0000
Date:   Fri, 29 May 2020 13:36:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, shawnguo@kernel.org,
        Linux-imx@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH V3] dt-bindings: timer: Convert i.MX GPT to json-schema
Message-ID: <20200529193644.GA2815265@bogus>
References: <1590717882-20922-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590717882-20922-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 10:04:42 +0800, Anson Huang wrote:
> Convert the i.MX GPT binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- in compatible properties, group all the ones with the same
> 	  fallback to a single 'items' list using enum for the first entry.
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.txt       | 45 --------------
>  .../devicetree/bindings/timer/fsl,imxgpt.yaml      | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> 

Applied, thanks!
