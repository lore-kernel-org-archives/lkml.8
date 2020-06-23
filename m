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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2882C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823CD20772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn3y7skK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgFWGTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgFWGTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:19:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE32C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:19:37 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q22so6536581pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bwz1vrpVxlGgwtFKw237fp9M9eojls5v4/DP0A07JQ4=;
        b=fn3y7skKUEDp9iQkWtqczpoT5FaVQt4MtuOdi6Dsxzp58ItB1PqdXW44Cetlzw9217
         VD9r1GiTXD+bRBgr2+JXYX+1mKsJdMc3yw7u61oeMo39QT+FVS49ZsNzKse7Eh7oUiXv
         7F2obX235r6Akbk97F4qUQmhEo42odWWe+81tIuKp2gz4wXAM1bNfTQWam5P5oHIF2ON
         I0edcl8g20c+V5pTlzKkoezS2UL5ZT3GC5rmpFGrbzRVJFKLFXwWZI4E+Yq9w7jqUuqz
         SbuhT1LoYV5Anl/JBtDQFU7FTYTOkBPrW+4ARUOMMpjlPYpCvF34JvnCWxUmQSWB0nXv
         HE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bwz1vrpVxlGgwtFKw237fp9M9eojls5v4/DP0A07JQ4=;
        b=jWjUgWAn+UH4IinBXIEsDuiZxX38loINEUbEo50kRdeibzXW3hY6oIQg8ilzHPuMIY
         z460PsAwFBK8J75C78CRH4dJ42YO6pt8/7KPIjOnFxBzmgKW5qQ4GyZYYbF3HHcWsHLh
         2iTAoZDeiahFvkcXTMdLUZCDBtvQTl0F6xA8wQoQLrcvC0lYbTjqyPBrncX0tpe0CB2O
         sCF++Y/mD8ZHVEslraGTHB6/Y7vY54UnENcSL3WSNuiNN/gLjKV2h1S4KhtP1+WFdAtu
         6R0hiIY7ll6PK0yFpULLPNgjaI4StVAK4tsNMmPoTqgfkL4xeJXBc7bEmTbio9L78Sm4
         TeQQ==
X-Gm-Message-State: AOAM531hcvw0wRfiHIePAuC91knZdC0V933Of+xCUtguoKnBCl4XiyEU
        yOShYXolAzl/KN5vdNX5PAw=
X-Google-Smtp-Source: ABdhPJwUtGgLL8c5jtRRJm6AFuwIQf/CtCYTn5xkqG5AoImo/YewMgT5It9ubJgub3rXylkVIimJlA==
X-Received: by 2002:a62:19c4:: with SMTP id 187mr458732pfz.312.1592893177171;
        Mon, 22 Jun 2020 23:19:37 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id jz23sm1270689pjb.2.2020.06.22.23.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 23:19:37 -0700 (PDT)
Date:   Mon, 22 Jun 2020 23:19:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: fsl_mqs: Fix unchecked return value for
 clk_prepare_enable
Message-ID: <20200623061913.GB17085@Asurada-Nvidia>
References: <cover.1592888591.git.shengjiu.wang@nxp.com>
 <5edd68d03def367d96268f1a9a00bd528ea5aaf2.1592888591.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edd68d03def367d96268f1a9a00bd528ea5aaf2.1592888591.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:01:12PM +0800, Shengjiu Wang wrote:
> Fix unchecked return value for clk_prepare_enable, add error
> handler in fsl_mqs_runtime_resume.
> 
> Fixes: 9e28f6532c61 ("ASoC: fsl_mqs: Add MQS component driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
