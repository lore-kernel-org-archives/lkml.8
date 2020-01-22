Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3572C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA782071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579709412;
	bh=QCC5rwQVeJws+7ipSdxfGsVIlrbmKL3wMRFugklLNqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NY+MohPe3RqD4l9wgxzrXhFWiZ2C81B4CLudyrLBhwTE3HTfZJUJ7hSNd+F5MfqXd
	 ODCcdzkt725oBElQ3ZNEy/ikqdhbG/9aGOrfiUtlciWV7SvelfXCq74kLtdBdNG94z
	 vNafuFviimY8lsS15eF41MAUJoCxe9HFHChgL/rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAVQKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:10:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33317 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgAVQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:10:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so6774718otp.0;
        Wed, 22 Jan 2020 08:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TgzJ9ZutlYtvfAqgtYkqR4r+agw8THf+icQvm+26OKo=;
        b=p/WSlOHZYu1J04rw2VLiAHrNeWDfljkJ0AD88iAR7BE9m9aJYrSiUGt8xmOrrfpCnV
         ak81RU0yZ59Q8OS465x+e5q51ROOCpuFj2d0LlwgK7ItseEoneJ7cIkyVFvmABKJV2UR
         cEXDQ2Yw4hxX2ZY8LAWLlAhx3ULq/EQr7aAklVx4iS44gt3wLUMuR61D5q+hIdr85Xyx
         xR+6ZKdRdgr/jk5DEks6TCAbYWRblv5jtWsTMzzLUqKqTEqLpojJTwxL6IxOKS1/bkQO
         UM+ekHlXHsOuF6NYN0X9k95JnBbPpbMCiz9Jwh8vdXGorwWEM0jXqBzmWraVA0yVMzzx
         6GFg==
X-Gm-Message-State: APjAAAUoS96wt9YlJFZUBJSTmsQ3wA269XIovwyLLFjgemfgg/BTpIi1
        K5BhWtXFDxzejSCcf6eHOQ==
X-Google-Smtp-Source: APXvYqyOIAOrAEHzXYhJhhnCgRLpP7u3uvTd0SqsZnLeBC8DI/vNn4PSdtAK3tvJcEPEa+32hJ8dFA==
X-Received: by 2002:a05:6830:11d2:: with SMTP id v18mr8306701otq.151.1579709410683;
        Wed, 22 Jan 2020 08:10:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e65sm14911359otb.62.2020.01.22.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:10:10 -0800 (PST)
Received: (nullmailer pid 18272 invoked by uid 1000);
        Wed, 22 Jan 2020 16:10:08 -0000
Date:   Wed, 22 Jan 2020 10:10:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, vinod.koul@linaro.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        jshriram@codeaurora.org, tdas@codeaurora.org,
        vnkgutta@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: clock: Add SM8250 GCC clock bindings
Message-ID: <20200122161008.GA18205@bogus>
References: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
 <1579217994-22219-6-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579217994-22219-6-git-send-email-vnkgutta@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 15:39:52 -0800, Venkata Narendra Kumar Gutta wrote:
> From: Taniya Das <tdas@codeaurora.org>
> 
> Add device tree bindings for global clock controller on SM8250 SoCs.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.yaml        |   1 +
>  include/dt-bindings/clock/qcom,gcc-sm8250.h        | 271 +++++++++++++++++++++
>  2 files changed, 272 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8250.h
> 

Acked-by: Rob Herring <robh@kernel.org>
