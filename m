Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49CC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B53E2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbO7fa9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCIVTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:19:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33438 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgCIVTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:19:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id m5so5306928pgg.0;
        Mon, 09 Mar 2020 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CSeop4EP+cHMLCfdhjpEDfNo8WqTVWutCfl/33ROm+Q=;
        b=pbO7fa9huNww+H4GhUCnFSIZbuh3Sf/rqL+W+gTUIf64t4U2IixcH4BPbnCSE8qcFS
         UFQeQYt3s3zs0VatDi9JjRoQ89980G7DbXdtTb6Xv+TFK984PRq8TwylqphaXkExjt9e
         Xz5NNdc5nN8xwtUgWFNoCG93FRrBhJ+/l9IckYff3HQvEitnWoNN14NCKsfJ2OD9gS4W
         k+FppLDxkIPBUWhYWJxUiM8VHQ73wgCCs51Fniu84mN3YqmRggft2jiivrPTxzEEvtdq
         Ui+ObyGCQmX3LzvkIZNhar5QHwGH5uWiu5+IlvyBg1k+SwlLEZI4g9HVM7oMwISqFxyo
         6law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CSeop4EP+cHMLCfdhjpEDfNo8WqTVWutCfl/33ROm+Q=;
        b=ApSjgcWLaZYdUD9WX52ufNSsZ5K0OTlst9Lw5XNi+Q9WpBJQSCY522WgH25j2+wo8p
         9WCQqFhtmiKYvOWXx5TVF69RHVfRdIhpDbp3V35aRejba1U1COO/jsqKAHjA99HTuiAj
         CltQHyqCpalhAn/ifwuAlJQ3OLIws+UP4sIhoPPElH846VKu+H0E0v4wCsdYeuGl022K
         JLjStQZLHpM1VgsbgBOhjfgT8EmOUUk6NHGK5zJ0L7eQP/LwGPvZvuMVWNAbBwMGXThA
         3r3pOdfuAbFdeuVCdJ4S0/EvWrwq7Mh4lzgYQu7q6flNYjn9mn8yha4TRRHJTf3KMf1n
         UKqw==
X-Gm-Message-State: ANhLgQ3JeuzpUKju67E7dthmfvumiJraE45qM/Mc00VRSu+/FxoKrdby
        bry/wtOp8x43KzkJrCRCOA8=
X-Google-Smtp-Source: ADFU+vsg7KizeYcWAnahiuG5JhDpW4TK4b4no2mIFhQ7Xz1jVWgPmRVkedECb5+Or6RlRlgKY30Ong==
X-Received: by 2002:a63:8f17:: with SMTP id n23mr19033927pgd.161.1583788776473;
        Mon, 09 Mar 2020 14:19:36 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d10sm448423pjc.34.2020.03.09.14.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 14:19:35 -0700 (PDT)
Date:   Mon, 9 Mar 2020 14:19:44 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> In order to support new EASRC and simplify the code structure,
> We decide to share the common structure between them. This bring
> a problem that EASRC accept format directly from devicetree, but
> ASRC accept width from devicetree.
> 
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, then driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index cb9a25165503..780455cf7f71 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -51,6 +51,11 @@ Optional properties:
>  			  will be in use as default. Otherwise, the big endian
>  			  mode will be in use for all the device registers.
>  
> +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> +			  Ends, which can replace the fsl,asrc-width.
> +			  The value is SNDRV_PCM_FORMAT_S16_LE, or
> +			  SNDRV_PCM_FORMAT_S24_LE

I am still holding the concern at the DT binding of this format,
as it uses values from ASoC header file instead of a dt-binding
header file -- not sure if we can do this. Let's wait for Rob's
comments.
