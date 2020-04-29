Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9CEC83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FE920737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZbdQf1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgD2B5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2B5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:57:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BBDC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 18:57:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n11so253705pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 18:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=piyFAQuE1nQbg6TLe0uPF76+MOhAF84QvXHI7/T29lI=;
        b=IZbdQf1arsR3leQH3qkMB/7zjjQNiHdLMfuqXBARYJxDJI0GWKrDArn1qrVOvNnTcd
         jNtWkvKsvdexhMVmVeYCMGbWXAO2guv1bNPNSVdoJnddu7oT9/jZL8z8n2Fj85Rh4nva
         H+izmnO9F/lum+wM/2TKvYmYeDLAPu9CRi0kMzBktOnYuln3Ep+WEGmb5207YDLIek17
         pCVah/bsAqmIec6gXibW5MZPHXo+uVvt9P9Xjm+xqtR631dwDP1pL7YqaTnQKsKNAvit
         lO4rNjKxOxoYYPRC484WnBIyQyzDi6cwcy5Oo3U2m4sPfYzxPA9T8XfHL7SJFRv6v9TU
         Vz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=piyFAQuE1nQbg6TLe0uPF76+MOhAF84QvXHI7/T29lI=;
        b=XMnMJOx6wd1b3qe4GFizHVp6pPCJn0OFIM53XOALrVAUzD5xy+RgGZ0aueyjPssOPF
         +0fxZi7l0HDGZh9r9KlrZk23iUkoj2Qxmcbcdtxear4kYg6LDShtV8PDq5vAVUFLtQA3
         OZ/Yq/S2GfW5IRkEtmRBB60DXg8GSw/3Oa2ORLR3v3m4VDJZvUtN7sDunIQW8B0qEjdU
         n7KA3u7yu/FuwFlnMXQXiJQemtgOTHV6IQcsZBIo3qyjnSw6pZ+5UNFDWQMwv/GomoAT
         7Hy5Xkvssf9HXJ0v3NgVtVzJQ9bdFoZ8pE2uHnLsvV/PuqJ2IbZ+DYwJrGDFDppVskj7
         IPsw==
X-Gm-Message-State: AGi0PubStdCdS4uoV+Tnmabro1YXZLEFibULqxieNETeD6TsnUvboR4j
        xuhfANsk0SHN9gV3myauuxhhcFqImIQ=
X-Google-Smtp-Source: APiQypJ8YEslaSIUMAz5iAgOMHXRXcLYU5tW9zTih3fsaaHOhEGTJzvS7w36/0kdqam3M6gdfAu8xA==
X-Received: by 2002:a63:df0c:: with SMTP id u12mr29713898pgg.387.1588125434585;
        Tue, 28 Apr 2020 18:57:14 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b24sm16226326pfd.175.2020.04.28.18.57.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 18:57:14 -0700 (PDT)
Date:   Tue, 28 Apr 2020 18:56:34 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_easrc: mark PM functions __maybe_unused
Message-ID: <20200429015632.GA15142@Asurada-Nvidia>
References: <20200428212847.2926376-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428212847.2926376-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:28:08PM +0200, Arnd Bergmann wrote:
> ifdefs are hard, and in this driver the suspend/resume functions are
> the only callers of some other helpers that trigger a harmless warning
> when CONFIG_PM is disabled:
> 
> sound/soc/fsl/fsl_easrc.c:1807:12: warning: 'fsl_easrc_get_firmware' defined but not used [-Wunused-function]
>  1807 | static int fsl_easrc_get_firmware(struct fsl_asrc *easrc)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> sound/soc/fsl/fsl_easrc.c:303:12: warning: 'fsl_easrc_resampler_config' defined but not used [-Wunused-function]
>   303 | static int fsl_easrc_resampler_config(struct fsl_asrc *easrc)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Remove the #ifdef and just mark the callers as __maybe_unused to
> suppress the warnings altogether.
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
