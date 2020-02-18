Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A6C3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9232173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582061396;
	bh=HtBodpLnjDD/uilkpRi1NCIeKNmRMWICKcYnenWK4Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CnwKNS1FPyzmqbIxKiivqOJuT1tLSQvF8bR5ENaOcNXNIyZ9fRmrnDlI2PBeTK9va
	 lUFSaRp1QbqdcB/LImx04fFSzHypqtFBrTjLJEtfmFkjifYtvx+UfNYWfyIr4CiypY
	 1rNRMhxMYZ5X7TprjmRYgq/qSR/gmh2BJ6CFWDwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgBRV3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:29:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33190 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRV3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:29:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so21707598oig.0;
        Tue, 18 Feb 2020 13:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Pfah7bNbvhUUcDQljTX+t6XhrjRCKYEE9u9jUwdWpU=;
        b=Jxb8OrCW7zjzNaVzOGy9snZ857DxvCxzridDfqCFbR/i8LYaNJKVytkHcxQFQYwYS0
         JSZ87/cMHB5J+bwUomEZvZdtOlMQzisK3tRmmPrcrPBy5YxamnBAO3MclBMmg7xe2/n0
         CamrSTNTObnuf6OPTWN08uWuJTQKGoce0f3QguRC/J8cQW2AuGFwWUAYTm7oxt39moes
         4t/TgCzmTSN0BDtdaJllOdHDAOGVCJzREhGAGfagGxq1Y+NroMcNXld9b44pe04CMZ/v
         /fJkSkDGcKtrXqYQctBEhYGWBejvHsZSEhrKDIu049TyBOu4bYEZzd/9+l3Lif2A5KL+
         dSOA==
X-Gm-Message-State: APjAAAX7UgAy90zkqEGZxSiAjf+qcqOKMKJB6/El9UgeVJ0pzYSnonPI
        FWlfhpzWoqq5uWfL+PwbJg==
X-Google-Smtp-Source: APXvYqytbRlMgGgrgPO+2HqbA0TyZyd5tEElZaT89Wxzwxo8TcLIUlbqG/Bs5uZz6Af6akmzhm8gcw==
X-Received: by 2002:a05:6808:b22:: with SMTP id t2mr2582783oij.40.1582061394172;
        Tue, 18 Feb 2020 13:29:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r10sm1749580otn.37.2020.02.18.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:29:53 -0800 (PST)
Received: (nullmailer pid 6190 invoked by uid 1000);
        Tue, 18 Feb 2020 21:29:52 -0000
Date:   Tue, 18 Feb 2020 15:29:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, rampraka@codeaurora.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: Re: [RFC v4 2/2] dt-bindings: mmc: sdhci-msm: Add interconnect BW
 scaling strings
Message-ID: <20200218212952.GA6132@bogus>
References: <1582030833-12964-1-git-send-email-ppvk@codeaurora.org>
 <1582030833-12964-3-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582030833-12964-3-git-send-email-ppvk@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 18:30:33 +0530, Pradeep P V K wrote:
> Add interconnect bandwidth scaling supported strings for qcom-sdhci
> controller.
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
> 
> changes from RFC v3 -> v4:
> - No changes.
> 
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
