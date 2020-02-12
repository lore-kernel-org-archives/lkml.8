Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5695CC352A3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F20B20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581473231;
	bh=MFsFnlq2S6uxhG9upwC1CR8rSIb7fz6f7VN5OiGDMQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L8gqZtNJo7jFBWosaM2CHSMCbzu0bg/jZFpzRBWpBH/MH/yzIb1HHv4f3q0GrG1wc
	 YjqmOD5Ak+sHjhzgNpk3IehTJsG27TsGjj8JAv9HpVbu/5QpgNuJfEOq4EvQwoQpxP
	 HDPB/CJs54cjqlBKNKJqWAElreKdWZOmGu38KBaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBLCHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:07:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36431 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLCHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:07:10 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so545566oic.3;
        Tue, 11 Feb 2020 18:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yODbBsnTEDmrfdz+vsR05ewOj9Bz3wnTGiDIXd+abU4=;
        b=NvMpWyrOjmIjdn0RSSwLIR6Bt+jgLk4A5MWlJlQx6sKsfUlSwRttZ/D+AULGrb+9/F
         u3nGbRMrCa7HLCH7+fY4OEYQbZuUf+OnX2sCWM5b9TGmMz9TC/Bk9Ofnp5bJesYhXgOA
         TuE8qNTBaBQYLFU/1alZ2Gt7aLMxOMe1bUbh0aBWZKthrh6mynUErtD3/GGlMh/eHYPm
         RMUwvE5PyOKKNnpdESxBiUZbgLZT1NWPprT4lphbdO+Ns02XnUaQ/S8nQKacnrw99eOa
         mGwRHxuuRAAwfjtpfNDlS451XbhJeegF+pTudzBOTzRQdlapeArHzKrbKRVoT3hMkvWX
         yV4g==
X-Gm-Message-State: APjAAAUV+JnPC9SO1CIvH3c+KxSROVAHhT+sSYi0c0Dxkt2m+LK2wH6O
        aCv8Fzt4XQrrO+uHuTc2wQ==
X-Google-Smtp-Source: APXvYqygIdfRIe2XyS98zlK/dv0nnDlqKCmVsF+EZNW/ykEyWFRmyAbAXMn1XkcMuJzgsaZ1u8ZgaA==
X-Received: by 2002:a05:6808:902:: with SMTP id w2mr4855591oih.170.1581473228069;
        Tue, 11 Feb 2020 18:07:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b15sm1849249otl.60.2020.02.11.18.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 18:07:07 -0800 (PST)
Received: (nullmailer pid 30071 invoked by uid 1000);
        Wed, 12 Feb 2020 02:07:07 -0000
Date:   Tue, 11 Feb 2020 20:07:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 1/5] dt-bindings: Document JZ47xx VPU auxiliary
 processor
Message-ID: <20200212020707.GA29808@bogus>
References: <20200211142614.13567-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211142614.13567-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 11:26:09 -0300, Paul Cercueil wrote:
> Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
> Ingenic is a second Xburst MIPS CPU very similar to the main core.
> This document describes the devicetree bindings for this auxiliary
> processor.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Update TCSM0 address in example
>     v3: Change node name to 'video-decoder'
>     v4: Convert to YAML. I didn't add Rob's Ack on v3 because of that (sorry Rob)
>     v5: - Fix 'reg' not in <addr, len> pairs
>         - Add missing include to devicetree example
> 
>  .../bindings/remoteproc/ingenic,vpu.yaml      | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
