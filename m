Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2660C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B87206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589301497;
	bh=cphcUYST00oaRsfCQHAkJjxh25yMpbNWhWOsledJB8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KeeWO48egxaBp3T4OkPpbsB4E+cvCCuYQKrF9A8VXCB7iCbXOiy9oD9CM7LsTkJjF
	 D/zQMP4qWYCBxSsTz1p21gsMjNTThQ5vnN/q2BbnlihPatS5trhxwLEK3/38/Li1h4
	 PqmoA1Nb0seL6imQjemo5wxkTyX2VbO2NeFFMIY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgELQiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:38:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37581 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgELQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:38:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so18774436oij.4;
        Tue, 12 May 2020 09:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KeYFuchHUV4oG06etMyeWZGVdFDkZmCFlBwg/KVFhKU=;
        b=SAt1UeBxLzNYJdgUvd6eiGityBwAvJ+YoQgfTHv1Lz8w0FpF3UiUa3xaBrY2n6ZXlX
         js3Iusop16pk3IniX7nlxX8NMm5S7Yowt4KbrvBJiI1+Baz9nXw+VyjdJWB/GE6NQRqM
         Eq6Sx6gK8HWex7CcK/8g1wQwk2Eflq2SuOGFmjAfAxVMOpS/Ej7fURzlM1VUv5z0FTiR
         0zW1aRfxyvnLeYg/ED1Wex6BFwd4rWhJaq2bbXZcVAQ/jQ5lG2i5Z89hM7W7GtFB+Ks3
         VtTU4Xw7YUNbGWhMfFjFSDth6cimxrKnuMOYEc6bFIebXi1sZ8OHrxtMqLiJu6wrCIbV
         ynNA==
X-Gm-Message-State: AGi0PubTO3BSVoz/FgCzXCSCoh0aUs0R4u9fJB53B1zUlRyCnaxnvAM6
        Um6OS9CTNKDNEWANJuCheA==
X-Google-Smtp-Source: APiQypKIND1xo73jiriB4lL8f7Yv7R7T6ZKHMlotm4ARjozaBncOmDZy+ZFpBOhARLLZciwC/lXy8A==
X-Received: by 2002:aca:3cc6:: with SMTP id j189mr20111395oia.137.1589301494954;
        Tue, 12 May 2020 09:38:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 34sm144510otq.67.2020.05.12.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:38:14 -0700 (PDT)
Received: (nullmailer pid 12285 invoked by uid 1000);
        Tue, 12 May 2020 16:38:13 -0000
Date:   Tue, 12 May 2020 11:38:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Xiubo.Lee@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, timur@kernel.org, perex@perex.cz,
        nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] ASoC: fsl_esai: Add new compatible string for imx8qm
Message-ID: <20200512163813.GA12151@bogus>
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <307a82c80c27b807165e1f532dd9aecbad9b2eae.1588320656.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <307a82c80c27b807165e1f532dd9aecbad9b2eae.1588320656.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 16:12:06 +0800, Shengjiu Wang wrote:
> Add new compatible string "fsl,imx8qm-esai" in the binding document.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
