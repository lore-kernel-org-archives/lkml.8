Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D6AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36F02073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590775071;
	bh=sbPRcISlDpWBtftR4h3wYCsfvZUDWr2QszIgheNXQQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GYDZ0+6T+pnOen6rrkgeasiPctPAj2gQpgMsSI4HOHA3txeUJWN9WE3O6MK7bs9H7
	 2/KsheYrWZ6xQZtjsYcxzWZOHqjMWTgiMlSh0opbT/FVBZjN1gLgTa5Dp2S4fE5xNw
	 5iye93fqJtIzqgAP0HYPUXft/iByeoXp3/BVfCIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgE2R5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:57:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39911 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgE2R5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:57:47 -0400
Received: by mail-il1-f193.google.com with SMTP id p5so2245646ile.6;
        Fri, 29 May 2020 10:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/pXc+ePu+QYMx2cjFaJHgCjEzuENDcwSMz9BqycUark=;
        b=LHysiqoiAPusPYCTlcazkm5WsKm9gq1R8Fv4TBVzQAk9owpsjvlNH4/MCKCcxoPuRj
         2vkYZ8C9OrCCRZNsIZ6TiMV79w2TKyzXvKxr7W/Tcwvwutvo62qzb9d9OHp45zYWPtSu
         /dkREsOz1IwEVXM3fI3D2J8jAQMk9woSDd4Dqwe7KH2kOGoFTKjXAMSOO22HOs7apt1v
         ufSZIzhrpLaIYHxLcHFwF8dsYBI61QW2CLOAAtR1QKYyKNLHiru3mBT38tu1lKYFMxnt
         2SSk40FM3xCkpIks+pY8YXdGsdiE61BLETjtM8rrg8r6BSzyfD37hAEMZXlcgKpSGqoC
         r1FQ==
X-Gm-Message-State: AOAM532gAoqWZqAVwOsbxc2RmRsJrZp18ed/YZSFxe5tiiP13stED78G
        Lz5zHE0XnWAVuuS2qYAVPDIgxMqmsw==
X-Google-Smtp-Source: ABdhPJwuVIAyKDF0spGr1Nv/7tua2LLnhPBnySsop1jAmmnE2HWivqD4vgeFMAWZ3vyt6Ya55/Ts9w==
X-Received: by 2002:a05:6e02:4c8:: with SMTP id f8mr7353922ils.174.1590775066768;
        Fri, 29 May 2020 10:57:46 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l21sm5335208ili.8.2020.05.29.10.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:57:46 -0700 (PDT)
Received: (nullmailer pid 2658350 invoked by uid 1000);
        Fri, 29 May 2020 17:57:43 -0000
Date:   Fri, 29 May 2020 11:57:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     mgautam@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rojay@codeaurora.org,
        linux-kernel@vger.kernel.org, skakit@codeaurora.org,
        msavaliy@codeaurora.org, robh+dt@kernel.org
Subject: Re: [PATCH V7 2/3] dt-bindings: geni-se: Add interconnect binding
 for GENI QUP
Message-ID: <20200529175743.GA2658270@bogus>
References: <1590560864-27037-1-git-send-email-akashast@codeaurora.org>
 <1590560864-27037-3-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590560864-27037-3-git-send-email-akashast@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 11:57:43 +0530, Akash Asthana wrote:
> Add documentation for the interconnect and interconnect-names properties
> for the GENI QUP.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in V5:
>  - Add interconnect property for QUP wrapper (parent node).
>  - Add minItems = 2 for interconnect property in child nodes
> 
> Changes in V6:
>  - As per Rob's comment added minItems = 2 for interconnect-names.
> 
> Changes in V7:
>  - No change.
> 
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Applied, thanks!
