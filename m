Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED3DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C01208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbgGmYgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgHEELY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgHEELY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 00:11:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4065CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 21:11:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so24518655ply.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 21:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxlzhilvpbhmfegLmBqfpD7CzDK63zsBFUHMpLeOrf8=;
        b=gbgGmYgF0YdpUhrBT8h1liSj6kuTwlC09ocfWaO9eU591HVmlnn6hPetkmf8DTum1C
         C846wjQ71ar6b4ov/10B1KDvxHju+an47hQbzDQUasqRTkIZZCGe0LixtP1tlZ2Z3hHn
         AQznHxv1cBeKx0Urr4pBV6hGdRKoF6luQGbvpgrkaR4s67QjIW9QcDZ75tJ4RaFZWfNM
         D/nME9nSSyN3Hm79JBIdOZT/dgrKl/Z7u/BgmLir2lxu+p40to+W0krkBfzmUkt/D1A3
         OO/X4H8EXfiPS4XFlwKi0TS5vJ+dtgfdSeyAfIMR+w1b9+/YoYD04ANWhfZ3RYyNIx+n
         PBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxlzhilvpbhmfegLmBqfpD7CzDK63zsBFUHMpLeOrf8=;
        b=A/PraC7SAokqaYdKRbv9docyq+fZrYfo0FJQBRahp4wDG/dnIrExJ/irXNDtJXg5dZ
         x6gALQY66fpToxGagpktejG3fWycF7B99P7geAEC5C0ORpumNGZ3U1AoWIyYSZOgLlpY
         qx4Cb+qBcMtiHGIMq2q840P6BCROEztyEHnLfC0pT7PtDbQmdxyKrMjtyzKmsxZwZVWH
         ZzYppPbaTkHcoApOEI9HVJZKz5wRqRh0lumHZLaEX/pXZINbAs75dW1V9z7wYM0WiyP0
         hPa+dYGqwqT2v0Nf/d/erm2mqPdbQ13fsCwz9t0+DAMv3K5rpdweR4+YB04zb0CF59AY
         c28g==
X-Gm-Message-State: AOAM531arEcHXcl0Lj1sVykn72ym2H9WRgKUfo2p7KDx31ugrMRyYdC4
        6dPU2uWqPeRd+lMciKvscrXwSRCzNaw=
X-Google-Smtp-Source: ABdhPJzpXE7rX9+PiFNYZWRcw3RheNt5DShOYBGze0ylmEzhCuKl6oc5Z0S0RvMEH6h/H7A7bvvoOA==
X-Received: by 2002:a17:902:9001:: with SMTP id a1mr1377741plp.124.1596600683704;
        Tue, 04 Aug 2020 21:11:23 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x127sm1108891pfd.86.2020.08.04.21.11.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 21:11:23 -0700 (PDT)
Date:   Tue, 4 Aug 2020 21:11:11 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: fsl_sai: Refine enable and disable sequence
 for synchronous mode
Message-ID: <20200805041111.GB10174@Asurada-Nvidia>
References: <1596594233-13489-1-git-send-email-shengjiu.wang@nxp.com>
 <1596594233-13489-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596594233-13489-3-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:23:53AM +0800, Shengjiu Wang wrote:
> Tx synchronous with Rx:
> The TCSR.TE is no need to enabled when only Rx is going to be enabled.
> Check if need to disable RSCR.RE before disabling TCSR.TE.
> 
> Rx synchronous with Tx:
> The RCSR.RE is no need to enabled when only Tx is going to be enabled.
> Check if need to disable TSCR.RE before disabling RCSR.TE.

Please add to the commit log more context such as what we have
discussed: what's the problem of the current driver, and why we
_have_to_ apply this change though it's sightly against what RM
recommends.

(If thing is straightforward, it's okay to make the text short.
 Yet I believe that this change deserves more than these lines.)

One info that you should mention -- also the main reason why I'm
convinced to add this change: trigger() is still in the shape of
the early version where we only supported one operation mode --
Tx synchronous with Rx. So we need an update for other modes.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

The git-diff part looks good, please add this in next ver.:

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

Btw, the new fsl_sai_dir_is_synced() can be probably applied to
other places with a followup patch.
