Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A70CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695D120772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntaRcLow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgFWGRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbgFWGRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:17:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:17:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so9611477pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aRgKar6UhjVPbbeMviZl5LaaMbKjszzBO+Eoi1rtDeI=;
        b=ntaRcLow8nO0pWaGgySgikdwt4YMvOtBKNxrRwxoC1oZq6NHbWlPoPhyg5Wc0nNQQq
         liNy5Z/BjBVk5/jawKVHkCa52CTdka/HYUgKICPTjKMb0CRq0fy1SF2TDV+qlmhVROT9
         qO8Hgmu4BQnT3hctqsX1UnGty+OmjNUskMYhGHDorFPZCGZrZmPSPm+MxIcte9oYnAt0
         HMP6iauHOp9STPPXrvunv0Ztq1vot7Y5hHy4QNyHN63Q5GLy/9/UL5XBO2CxgdX/w8Hr
         ZWhSSyVLC6/zLAiV4Ob9ll4w01BuVKJSwBakDpD9BX1/oE2TPZDKOCi2ZlSquCfiCMMX
         fgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aRgKar6UhjVPbbeMviZl5LaaMbKjszzBO+Eoi1rtDeI=;
        b=ZzAZQaYUirIwsn60z73/QmDu4LkemcitVVQqlE5C/8ViTbQog7hyeao6bXhaFaYgln
         LE+F9wOGglh4RC+oX7Fjy3LYl6RGr6xQ58s15rQ1CPLWNRptmFe6cemP8DpItqVYemhV
         +QbNHrNCKkSU7GHSExIrtIjOBoYScegjQTImOMZe1UwmJ/WBlELSga94Cgp+Z9FFsAih
         ++NjVD0fR2d2yxhAuyyEwy01+t5CGTDkSSmC4qMwKwwcMt5GrCgtHwc/2dzhBtKab/zy
         ocZQyFqRxx9y39m4RT1gkTL7oe8vWNgi3nm0bu3d1cTkAqRY3YpuLGetGk3RAigjv08x
         nNUg==
X-Gm-Message-State: AOAM531D6mtIWxYcpBRHjIn9xue1Y5xa6a7a5qS1DlGpY2bDda9FjOH7
        69VgOVJ/iD1z7qzsYm+PB9E=
X-Google-Smtp-Source: ABdhPJwm3iPXSzpwN/FxG3dnBLyTWtXeYz4zMOZSGTqWgN9hRZz6rmb2HkE4A5XcbWeutGtmxHc2wg==
X-Received: by 2002:aa7:9738:: with SMTP id k24mr22282623pfg.44.1592893021976;
        Mon, 22 Jun 2020 23:17:01 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id l61sm1255318pjb.10.2020.06.22.23.17.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 23:17:01 -0700 (PDT)
Date:   Mon, 22 Jun 2020 23:16:36 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: fsl_mqs: Don't check clock is NULL before
 calling clk API
Message-ID: <20200623061635.GA17085@Asurada-Nvidia>
References: <cover.1592888591.git.shengjiu.wang@nxp.com>
 <743be216bd504c26e8d45d5ce4a84561b67a122b.1592888591.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743be216bd504c26e8d45d5ce4a84561b67a122b.1592888591.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:01:11PM +0800, Shengjiu Wang wrote:
> Because clk_prepare_enable and clk_disable_unprepare should
> check input clock parameter is NULL or not internally, then
> we don't need to check them before calling the function.
> 
> Fixes: 9e28f6532c61 ("ASoC: fsl_mqs: Add MQS component driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
