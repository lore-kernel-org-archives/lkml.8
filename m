Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CBEC3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4486F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582057393;
	bh=GwyhkRUcZ6A3Zga4N/oeteeJ944XfngcqZbqD7zgeO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H5uZp/eK3tjhxHIep/VRe87o9aLTY3ZodiqSc8u7aJzFYBD+ohYgFp+WXNJOucep3
	 CSyJETXxdnwPfOSJSZDL64ulD+/vgvG/dwAXoIz3g2lBdbOavnp5MfFen7sRjjPPVe
	 hj1Jh7+paBBoY4qXCr+EKXcNo5V4u3rBZtUQGLqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgBRUXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:23:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38597 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRUXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:23:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id z9so20845322oth.5;
        Tue, 18 Feb 2020 12:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KXAg/34S3FvFzX0pQBHTJXGpiExV3W+ihyd1Dn2Mhvs=;
        b=j6mDCElbdhjw0x3QGzBEbpz7T1GVrcmo4ShEAwA4CvfsDI8ktqPbGbupKvpnJgMi7U
         Nb+a1TX5x+JYA7ULQ5ETUSv8Mr9t6wO8c3F9nMhdKvi8/yfGTfyDVFTL4qZ/C7sWNiia
         B6FR5HdO4Ygsy9AnBFbRc8vyW8dtJKWTDSsK9AnT3Q5NQ51y6bLv3uVXr6h7CF4RO+Gr
         vb9ppeWph643ww2NGMxq3g/qh8f07j2ZdKaLqLwJ+eMIeDkTxLKKszA/YZzf8baV8GhG
         VVRUC4AOyKXAcJW2pzqmkbPXZkLUn6RJGcJzhOHeWL7bcQnSJk44R8HHT7pDZylwVg8O
         0u7A==
X-Gm-Message-State: APjAAAXAUplHU2vyerVyhO1QEZpzVSX2HtZ+SXDCVc6cQDMt7KGvu8V6
        WuBhLsM4ogHZZ5HozzE2Fg==
X-Google-Smtp-Source: APXvYqyzvxFzvOCeCS4HedEasKA6K6wnQhBPGg7dbaFVPmVQk7FQtsqWZXQE/aGzUFgd7ormvX924Q==
X-Received: by 2002:a9d:7305:: with SMTP id e5mr16273114otk.64.1582057390643;
        Tue, 18 Feb 2020 12:23:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r13sm1525277oic.52.2020.02.18.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:23:10 -0800 (PST)
Received: (nullmailer pid 4455 invoked by uid 1000);
        Tue, 18 Feb 2020 20:23:09 -0000
Date:   Tue, 18 Feb 2020 14:23:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH 30/34] ASoC: dt-bindings: Bump sound-dai-cells on
 sun8i-codec
Message-ID: <20200218202308.GA4022@bogus>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-31-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-31-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:42:46 -0600, Samuel Holland wrote:
> The generic ASoC OF code supports a sound-dai-cells value of 0 or 1 with
> no impact to the driver. Bump sound-dai-cells to 1 to allow using the
> secondary DAIs in the codec.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.example.dt.yaml: audio-codec@1c22e00: #sound-dai-cells:0:0: 1 was expected

See https://patchwork.ozlabs.org/patch/1238984
Please check and re-submit.
