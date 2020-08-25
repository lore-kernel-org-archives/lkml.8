Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD360C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9386520665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvyGmsYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYU0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:26:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D5EC061574;
        Tue, 25 Aug 2020 13:26:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so7611445pgh.6;
        Tue, 25 Aug 2020 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hViqvBMVikZrtzrVDOIX1RxTOt+cw+ucTuPZjUrSRMo=;
        b=CvyGmsYJE8o29oOkb16rdJUytyHwpjTL1ouL7mheA5ViFyotFWyMuusPvKOVIzBbao
         HN1Ig6W+VoQ7ji2J5SeTMm9hgcmbJGc974ulDXgx5Cu5KtSkkeFVuRWgpfBuOG9L5Inq
         SSuCNeAm67gf3igbQQwKf2DGmEFDS6hemU2rSlNvD7NYXFUMYqXTTedtriqLwljgcA7m
         nPHZIIFT7+9I2t85zlwF5+FrQLikhSIbSnacdWTSbVy8Drlv/Rq1VTHBytSUOsCcJpPT
         2TfQY0CnhmLmeH8JmHNmTA6lyAMr1ZFUn9cW9yaswKbCXx2xA4Bu/fTIU/lv14A92s4q
         VKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hViqvBMVikZrtzrVDOIX1RxTOt+cw+ucTuPZjUrSRMo=;
        b=G5Sh4SmITtEsIR7nd7T+JnvNSuBKXLWmfuygTpu5eCfF3lGaksRe+8APuUN/FJyrja
         rvlmroH+KHIw83Z+Fdxs87lzA4PwcF6sFknHMMr/2gGN200g+MshfcXcRZJ8/+mYtCcd
         Qh/QEOEHb6Jf47xAE8SFT4geWa1BBd161mkCfd4eTYP2UDhrcRPK15K5JqAXvfvtVt89
         H342QxezhRx8XxITEF++sFZNsNcmBJr7bJgvzOaOfLWyVmV7/aTswA1K5RatxixLXZVq
         X4FT7d9IksZRHBtw0L8Fwz11q8LGQhja46zMA7PUqAfdNwgv55S2jR/6tOzGHgry8EoL
         Gzxg==
X-Gm-Message-State: AOAM533CLC1Mx5SyoEgEVNY/Gtr7Rn9+yWSwhfGv+U2+SdPCsavY3Aqz
        87poku292zd8X1dEEy9vQ10=
X-Google-Smtp-Source: ABdhPJzQ5pw3dFa8nSlHXAXCWo8jZx7k/xr4WSZtGq0OJpfhKUc1gXp8HphomS3PeFnoTJql1GICUw==
X-Received: by 2002:a63:7e55:: with SMTP id o21mr8126549pgn.5.1598387210237;
        Tue, 25 Aug 2020 13:26:50 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x15sm82677pfr.208.2020.08.25.13.26.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 13:26:49 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:26:43 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH 4/5] ARM: dts: aspeed: minipack: Update 64MB FMC flash
 layout
Message-ID: <20200825202642.GA23335@taoren-ubuntu-R90MNF91>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-5-rentao.bupt@gmail.com>
 <20200825141808.GH3532@heinlein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825141808.GH3532@heinlein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:18:08AM -0500, Patrick Williams wrote:
> On Mon, Aug 24, 2020 at 02:19:47PM -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Set 64Mb FMC flash layout in Minipack device tree explicitly because the
> > flash layout was removed from "ast2500-facebook-netbmc-common.dtsi".
> > 
> > Please note "data0" partition' size is updated to 4MB to be consistent
> > with other Facebook OpenBMC platforms.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  .../boot/dts/aspeed-bmc-facebook-minipack.dts | 47 ++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

Thanks for the review, Patrick.


Cheers,

Tao

