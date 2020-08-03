Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF27CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7485206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K186TuiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgHCFkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHCFku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:40:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AFDC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 22:40:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so11524042pfd.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FhbpD1GOOiuI1h2KLYGhIc+Q4nrSHyP4h81W7KBJFqA=;
        b=K186TuiUMKQPdqAxCXhqtmALF9pZVrrem7PSJKHN2TVp6X/DGU7ghf9/BJMgBlUhh9
         jS5/KukDzLHwp2Tdh4NSv/i8naoGe9A3lUIZtoYE8DaWtRKIWGLC17qgWRsBuZ3JbkXD
         oI8zW7cC4xb3BZI+vs/9AmJvJY9r0ii6/sp00L/jDAKIi60G5674s+5a07y3LVR+IYv+
         deXVnc3aHNRNX7yQY4FFTNiSAUxBcTIDHNsWd3W3SkG+OiQQgnX8qlAqr3PJu9juma9t
         ZOSyPHOQaDxAdPbVnDMa/p63b0pwNeNG3aWsDaeHmhNXIVHXLUvlwT1LaFoiZtLXcwQy
         s+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhbpD1GOOiuI1h2KLYGhIc+Q4nrSHyP4h81W7KBJFqA=;
        b=ibi0h9nFxXnXr0aquNnVM1+kJHMiS2IHzZJtM0jPrnzO0/vNUJB60U1aEES3T6KSLf
         4Af23xJhG2O96p0lIRhKtdjUpXN2+LJJlKJqL6TpBucydrY2i4jCJOepUoCINV/wBWTk
         TH51w0gx+uDxEOMhchs5beF8Ob+isV3GVnfcZ6tx/f4ZSORDn5d9Kao1owm2incFzqJM
         mbgqkgkxGcd1ucAm/I5+Dryk6KQftGrGJQPuFKH2XwM3ngfxDmj+2FOp/Y9IyOEsJkwv
         48LEbBGAj1p/evepzCgH25/FYweH1/SR/gX5rF4zRoZW5VJvau44LzZvhQL12W3vwnN+
         zi/Q==
X-Gm-Message-State: AOAM530ogVtIHnNgNRQivEFmz3h8ZuRWLv/JJxD5lymmnfn76Ns2KkCx
        +QvtiqX4Kd8XaB5Y6alBPMQ=
X-Google-Smtp-Source: ABdhPJwtNZAtl8+czzRAcH8w3sZ9OYQlR+w7v7GG79nlmxqjy27pa7NblOV/FHvTJ6hTl+lyzxlnOg==
X-Received: by 2002:a63:444b:: with SMTP id t11mr13955435pgk.134.1596433249969;
        Sun, 02 Aug 2020 22:40:49 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m190sm16926096pfm.89.2020.08.02.22.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Aug 2020 22:40:49 -0700 (PDT)
Date:   Sun, 2 Aug 2020 22:40:37 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
Message-ID: <20200803054037.GA1056@Asurada-Nvidia>
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:17:54AM +0800, Shengjiu Wang wrote:
> TX synchronous with RX: The RMR is no need to be changed when
> Tx is enabled, the other configuration in hw_params() is enough for

Probably you should explain why RMR can be removed, like what
it really does so as to make it clear that there's no such a
relationship between RMR and clock generating.

Anyway, this is against the warning comments in the driver:
	/*
	 * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
	 * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
	 * RCR5(TCR5) and RMR(TMR) for playback(capture), or there will be sync
	 * error.
	 */

So would need to update it.

> clock generation. The TCSR.TE is no need to enabled when only RX
> is enabled.

You are correct if there's only RX running without TX joining.
However, that's something we can't guarantee. Then we'd enable
TE after RE is enabled, which is against what RM recommends:

# From 54.3.3.1 Synchronous mode in IMX6SXRM
# If the receiver bit clock and frame sync are to be used by
# both the transmitter and receiver, it is recommended that
# the receiver is the last enabled and the first disabled.

I remember I did this "ugly" design by strictly following what
RM says. If hardware team has updated the RM or removed this
limitation, please quote in the commit logs.

> +		if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
> +			regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> +					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
> +		} else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
> +			regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> +					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);

Two identical regmap_update_bits calls -- both on !tx (RX?)
