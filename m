Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C213BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9688B2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597262841;
	bh=RCxnCPphzZF0NqcZFzm24hDa1iVxPj717eGeyeyYtow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jwbDBAdjHtotHMbd7vYSWVMulCFWVHuaXsu6jGnkEyf/hYome6ZLRJnrD6t/wcgCq
	 P08cJlkU92IMvkVcto6JLtIQEIepRJHjCsenumv5RSuvrwdIbol3Kc2dZLp0tiAPBS
	 LfB8fiqSUoG1Q9FPks7IjaNlseY15Txs8x/ljM4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHLUHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:07:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33514 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHLUHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:07:19 -0400
Received: by mail-io1-f68.google.com with SMTP id g14so4470768iom.0;
        Wed, 12 Aug 2020 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxHMhON1JG9ZFONE2veN/0itnMUh36BjPV6tUvv2D0Q=;
        b=D1SvGS4y1II9/HC3Jhr4kreXPxlWlaFbmek8NWMGE9OuZElapd2h8dZqKcIBjcvMg4
         zJIrIZpOv+rpmeMtBgxZSQbVdpf+dcYIY0mJR5+Ggo8nza9jsppNFK030mPQA4+tiUKC
         FXhbtcPSUnv1YfKYkra9SVfzQSgMs1JsUDqkkIwTsWiWjQFikaiyFjYI9LKymY+Pgmds
         yfwp1sQg0EnQRdEmsGzG2G2IRh7bAPzz7MZW9htUL1DHHNqJmJAQXsJ+KTenEG/r7FYd
         NqC6OKOvcZuLbzDNr9136qu4oNfN5V//4NF+ysm9H5s/pvzROM7Vju2PKEEZGqdLOUNA
         byUg==
X-Gm-Message-State: AOAM530Y8Xjgt9X9Xro1GcXNiJC4j/dCNqdGUu7JXgZwY8nPqgvZQaNV
        SM+EhURqDJMCARvUqDydog==
X-Google-Smtp-Source: ABdhPJxB0IOO/+sIXpqu3113Vv6ucgevf5fE6iKJeKfCPFqkh94bwjGUuUo+yjYcolHnEzfsUcyB3w==
X-Received: by 2002:a6b:c98b:: with SMTP id z133mr1468377iof.3.1597262838693;
        Wed, 12 Aug 2020 13:07:18 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t187sm1389892iof.54.2020.08.12.13.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:07:18 -0700 (PDT)
Received: (nullmailer pid 2618892 invoked by uid 1000);
        Wed, 12 Aug 2020 20:07:16 -0000
Date:   Wed, 12 Aug 2020 14:07:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        sricharan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: qcom: Add ipq8074 bindings
Message-ID: <20200812200716.GA2618840@bogus>
References: <1596706332-12957-1-git-send-email-gokulsri@codeaurora.org>
 <1596706332-12957-2-git-send-email-gokulsri@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596706332-12957-2-git-send-email-gokulsri@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Aug 2020 15:02:10 +0530, Gokul Sriram Palanisamy wrote:
> Document the new device-tree bindings for boards
> HK10-C1 and HK10-C2 based on ipq8074 SoC.
> 
> Signed-off-by: Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
