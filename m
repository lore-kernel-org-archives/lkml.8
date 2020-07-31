Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A290C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9322076B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596224176;
	bh=B65sW0H+uUHkgyDhUiECp6DwAZm3btlQpGTlkYkao8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LNyZOqOW4aLcyOoMaWof2rLPiPlRpeBMichPYcmgG8QEiCLhQyqum35uZ/UcnTQU/
	 sVFLxoozS/MNcpvMUbE9UioP/H6e9FP/cpIcYxDdFZF+lCW6TwAhrPT8aFaFL4jG3x
	 Im16ArQafijt3ekCzC7n64aFlbeyKFzgxGLWw83s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgGaTgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:36:14 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40656 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgGaTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:36:13 -0400
Received: by mail-il1-f195.google.com with SMTP id x1so5953133ilp.7;
        Fri, 31 Jul 2020 12:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wab/tJu5E5sJ5/QDRPXn9ffk/Ado7aM/lOvbhkRuf2o=;
        b=nVAVmDfnvg0/AqPSLc177jsJwK0fQSZbyLz2RxEUOhGNMMIbB/U8gFoDfwU1GokKkM
         S2UytBhPmbjbpwKS7VxOMr2mhSp+4cQpWaBBLjMMiMpzDwvGm38tZQAvh0mbQTD+CADp
         sEgRR7FXOsTC16xBk+uwUQl19PbymHD1K4RnY5d1vlbKTE5z3FYmmSewr1RasgOWShtY
         2OFOiTUocFsFwkK5HvvuPlb3s0rC0XRg4BJMbvLUJ+GYwMCvKC7wtyP/8GJcE2zHqjGj
         Dw1bvi9fX7AHY9UkfLYp/MffX57ihPYylfENbWYrFlBcGq6aERoBJH9crve8p1bC9EQd
         Qhrg==
X-Gm-Message-State: AOAM532ebL9LvORM6iQCQD1D3pAvnoChFA5+fIo0bvJDb6pvLP0t0nzK
        52XVr7s7KTV2odkP2TYl4A==
X-Google-Smtp-Source: ABdhPJxd3lQOTaVRgxLwJUQxUo45C+8bAgkoIH99FoVPc4CMnGqeFkTWOBiQJFT3e7AswKOHVk7nWQ==
X-Received: by 2002:a05:6e02:dd1:: with SMTP id l17mr5194141ilj.136.1596224172324;
        Fri, 31 Jul 2020 12:36:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h1sm5079948iob.8.2020.07.31.12.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 12:36:11 -0700 (PDT)
Received: (nullmailer pid 643496 invoked by uid 1000);
        Fri, 31 Jul 2020 19:36:09 -0000
Date:   Fri, 31 Jul 2020 13:36:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcin Sloniewski <marcin.sloniewski@gmail.com>
Cc:     heiko.stuebner@theobroma-systems.com, mcoquelin.stm32@gmail.com,
        lkundrak@v3.sk, linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@st.com, a.fatoum@pengutronix.de,
        linus.walleij@linaro.org, allen.chen@ite.com.tw,
        linux-arm-kernel@lists.infradead.org, stephan@gerhold.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, mani@kernel.org, sam@ravnborg.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: arm: stm32: document Odyssey
 compatible
Message-ID: <20200731193609.GA643298@bogus>
References: <20200731143053.44866-1-marcin.sloniewski@gmail.com>
 <20200731143053.44866-2-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731143053.44866-2-marcin.sloniewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 16:30:52 +0200, Marcin Sloniewski wrote:
> Document device tree bindings of Seeed SoM and carrier board.
> 
> Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

