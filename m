Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8815BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDE6206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595525429;
	bh=dUp4zG0Nz7kiYMLma/fD8FPK4Iryj3VrkQhzFLdHfvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=alwOHnLkelmo2IJ71NJUWy+b5nb2wsT6w+R8bGS+VoGwx3xzNoJK3N2qOX8LJCXNs
	 2q4llmJR+KGBb6d5vYz6Bgvy0scl6SpW+KqGIS7B9guFX3Eyvl1v78AXFcVyEu/JbO
	 hUzEkWb4lKWE2tTay1CyIqMDr1H6fdtu4t6GsTqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgGWRa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:30:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37525 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgGWRa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:30:27 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so7111968iob.4;
        Thu, 23 Jul 2020 10:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qgUaFDrHbOILyfqT+XXpYvQaYA8JAqXoyvym0M5OCNc=;
        b=lTTSOLRSWeNSOzLU87DcFVywQARtrW28cCuG4swx3tYIw8uwTXAvSipWjr1uTBnGyd
         BapKRf/jwoKxMHOgqnm6SuoDyhccP4yRS/IR7MP4p5h6YKb4zi3m6ZsNT60imV943b2Y
         0fm0tsrXul1DBNC8omdt/5YOjVK5bTFCrGgI//bjuADLQkZbGSVTcNgOlb8yKuw+Et4+
         toMdF9IQbCG/vLGQwSYWBL0SLBNt059t5L3MTpm/lVtSB85hI4KpXQwhSacxh6u6Ni6x
         73zTtBSDL4NffkPTPJ4o4+8IpiC8nSxiQymjSdJpfPggJTQcdVrbCzV2M0p95ZAemkvp
         jwww==
X-Gm-Message-State: AOAM531v1t5Pi0ttcgehxKq/kBQPcBUnCQwK7FoL56JuWg1VmmtjksLb
        tAGuAmEtdgu8Xyctue/Z8Q==
X-Google-Smtp-Source: ABdhPJylOwNpPwC+R0uyMF+5XIFQygM3Vz+mhnN0DmIy3sNnVPVLqRvYsz6VE1ZOGHEXx8RYit1RbQ==
X-Received: by 2002:a5e:c607:: with SMTP id f7mr5920403iok.2.1595525426683;
        Thu, 23 Jul 2020 10:30:26 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d125sm1780712iof.32.2020.07.23.10.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:30:25 -0700 (PDT)
Received: (nullmailer pid 572932 invoked by uid 1000);
        Thu, 23 Jul 2020 17:30:24 -0000
Date:   Thu, 23 Jul 2020 11:30:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-arm-msm@vger.kernel.org, mka@chromium.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: media: venus: Add an optional power
 domain for perf voting
Message-ID: <20200723173024.GA572877@bogus>
References: <1595503612-2901-1-git-send-email-rnayak@codeaurora.org>
 <1595503612-2901-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595503612-2901-2-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 16:56:48 +0530, Rajendra Nayak wrote:
> Venus needs to vote for the performance state of a power domain (cx)
> to be able to support DVFS. This 'cx' power domain is controlled by
> rpmh and is a common power domain (scalable) not specific to
> venus alone. This is optional in the sense that, leaving this power
> domain out does not really impact the functionality but just makes
> the platform a little less power efficient.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml    | 6 +++++-
>  Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
