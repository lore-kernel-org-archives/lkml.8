Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8866C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934D92064A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589321484;
	bh=jBqBef9XLnqslPGgRh5X3riqMVgudThQ4Oif/Z1EIFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qF/rm8oRd1O21tpt//wp99FE4vfSRwEv/dpm1iNpbXcHmi/7qFuQ5Ae2KE/3nbhOQ
	 LNt2uAzf/CA5Zk3FNVNR6zI9oraHSy3LEkA0pemIzd2RqlPBnCe3GOJjnqXnjx4K5r
	 s07iL3vyHZ5Qc+7CWuhlORH8ORJjITtfVC42Gixw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgELWLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:11:23 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:41175 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELWLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:11:22 -0400
Received: by mail-oo1-f65.google.com with SMTP id t3so3050709oou.8;
        Tue, 12 May 2020 15:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vb85lby5smdr9lABRmv+r/bmfnu8fDinRBVbOkh3wjw=;
        b=jd0vC5nbi5YJJV1KRO2I5T8dUm4/IlTzNfAiF3mdCg356Yq1zayJe5ttuBwFE4bt2u
         lkw+tAjIE0D7krRF5HfSZcvp6YUFK/8qL1tDZ/+7PsYgTBF1rOiCGtEVmgFZ3ajeIoFV
         Fg+AJnd+4fJ0O6WEXmSb7JSpk/MuUS1afx8SkqJrzI1QK5ZeIMbVlsu05k5M5QCeTKbE
         d3qSr7fP44y1i5AjwyqGVtXC17LWIKyBS1hWTBkhCf2Es0E8E18a7Y5unDwWJXCU9KOP
         BG+ATr9+O4NJG97k1qWEEXDffMwZOndWhEJ9c67cqwqFAhzdRsJgckoJxStcF2QE64YO
         moUw==
X-Gm-Message-State: AGi0PuaEgPgEmQfSAS6eIvYu37acZO7pJxzjqL3zzBNcTNYiy97Rnu9+
        bcx/qiHD5H4Zw8Sxl/7d21qM20M=
X-Google-Smtp-Source: APiQypJDa6xxDF1mECnAsxooolHAenXcUzoYJryZ/jaOLAe4RkkE9Z5kOjIQF1ih/KxpCTGR6wXarg==
X-Received: by 2002:a4a:3556:: with SMTP id w22mr13971182oog.20.1589321481994;
        Tue, 12 May 2020 15:11:21 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm1055089otd.77.2020.05.12.15.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:11:21 -0700 (PDT)
Received: (nullmailer pid 25223 invoked by uid 1000);
        Tue, 12 May 2020 22:11:20 -0000
Date:   Tue, 12 May 2020 17:11:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     mani@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mcoquelin.stm32@gmail.com,
        linux-kernel@vger.kernel.org, alexandre.torgue@st.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/6] dt-bindings: arm: stm32: Document Stinger96
 compatible
Message-ID: <20200512221120.GA25157@bogus>
References: <20200503154215.23654-1-mani@kernel.org>
 <20200503154215.23654-4-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503154215.23654-4-mani@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 May 2020 21:12:12 +0530,  wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Document devicetree compatible of Shiratech Stinger96 board.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
