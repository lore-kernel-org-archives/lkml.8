Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C08C55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B6E20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587416773;
	bh=eJI8SaHUVitkkNN3aDf1BFV7eBtN5QCsq3lm3QLB/S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fo5I3VCo5VUYTcjihhTLu6HqUtjeZGAzCsEBs3nsKR9QUWux2SugIl6eM0SMWgE6m
	 8vP5XAAgFioNbBFMt4GeGfBRgzWIt793joNbHzBZu3JLTpFaSQItTFuiC1Hv1XTSmN
	 Jg9N7wLPl5EWOMESsyAEGNPhE5uYo0Q8sL7UFus0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgDTVGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:06:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34890 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgDTVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:06:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id e20so9463155otl.2;
        Mon, 20 Apr 2020 14:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uB24L/EHWMUmjNtmjWGehiMAvY3CkKcJfhSvIbdPK9U=;
        b=Jh24/BHSllwbxsA5ZI0lDNDkUy8116arLayPug1/YIQxJa8kO654O/5WY9uRvnrXKK
         eMUjmWm1nU8SGvOyrczBweVtLHyE6VerVCi0gDc0nBA38Q7f8izU706DfPQEODSU1K0V
         q7gIJ5ZPyugghF1m6qFlrr4Dkb0Eta/FUBnoM49iPbE6lg25ph5vZzXxqAyNrAI+LZzq
         MnJxmMo+CoyerXIw0FBX7zSTAcWtS+OemebkGKxdkjfa4XNtQOS/zEa52tx1Rz11zzbh
         CH5Au6uA8kCxtJOmF2BUR+XZk9974d/bV4lrkniH7u6lIzjLcakVoAaengzZMkT/U46Z
         CVtw==
X-Gm-Message-State: AGi0PuboD+EXQl8AyJJ3Ir/PH74ZfiYkb6YZ9wQPjg8ZzPcJ05lW+yh4
        ESYOmXWPRCj5LccEO0/Fqw==
X-Google-Smtp-Source: APiQypJ61QuLn0gRFwjv7tBbNaZhcCNVOe5uH4hWnq+9Kov3OqipkZNTDsd+9hUszKj/zQnlos6E3g==
X-Received: by 2002:a05:6830:1b65:: with SMTP id d5mr10613823ote.141.1587416771097;
        Mon, 20 Apr 2020 14:06:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 33sm205505otn.50.2020.04.20.14.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:06:10 -0700 (PDT)
Received: (nullmailer pid 28621 invoked by uid 1000);
        Mon, 20 Apr 2020 21:06:09 -0000
Date:   Mon, 20 Apr 2020 16:06:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/7] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
Message-ID: <20200420210609.GA28583@bogus>
References: <cover.1586845137.git.shengjiu.wang@nxp.com>
 <396a73da2a2fa8b77d0b773d321500b3e504d919.1586845138.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396a73da2a2fa8b77d0b773d321500b3e504d919.1586845138.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 14:56:06 +0800, Shengjiu Wang wrote:
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX8MN.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.yaml  | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
