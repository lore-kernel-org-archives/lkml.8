Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2E1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D48215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIHAkh/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgIHIuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbgIHIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:49:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B939C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:49:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so16424257wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J4HAK0c1l5GwduZQoYMUPrX1mha+AY2sz5+a6cm2mu8=;
        b=cIHAkh/vQ3/3Rywf5EJthCLuliPcfErIQ6ZTz8bWODvnWB1RAeaUEyTKNyN1I2V0cj
         u0JvkXrkkclcbMKKkry2aU9NenljEbljjHTObJDUUBiYSiSts0uhgI29E1+04pgEkCqj
         YonmvKtyIwPmE7cu3iw9V2VH634nxeQfWD6HUama+geStseQ4ydJPjjkaYwoHFdmVJI0
         4YltIwGtuRIIWbU/QZd7lvnOcq7Rn9XYd0xNUuWAkteMaE9onRo57Dnelrd40yV2xg3E
         ccxKg67eJJuM59LKkE9y10fpEQ2KSuSZZ+2OJwEbCjZobdbwsj9D8t/Em1n1sisqquMY
         FTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J4HAK0c1l5GwduZQoYMUPrX1mha+AY2sz5+a6cm2mu8=;
        b=nftAqNrYVsx3lK2LK3KzBJtTSyIYOlz/Zims0iItF+iv4/RocrJ88x6Ph40I6fTI8V
         E6HrDc3gr45DunnWii5aXSyCnpaRpo5sR1tMhIF+ExBJX/qe1/LQ1I7u0BPHZM0SzaCm
         0rWcY3bK11cg74Xsfd06kjxHUCjUTSJ6VvIQxeHszV2ZrJHH3CSFlNYoF54oblkFvrip
         Umxx/FyLW1g54gpdAFqqFlgSD2hQ5fQG0CBuCynVz/nkFhdVfTXp0Mrkbt0FmfzSl3++
         jpALB2qxN7V+ZuDVS7l3ujh9rU2GLSS4gAZ9rXZdK0+jVpDBCtMol3IL2k2F+k0ZtT2p
         +0TA==
X-Gm-Message-State: AOAM531UPq+/N35p1xTk1e8DD1ct6ylgqhmESKW/NJKwa9OukqDErMSz
        YRBrZdGuGx0nbRBC6R22mjVadA==
X-Google-Smtp-Source: ABdhPJz205f6JGKH/S/bJd0DZN1uTPiMjyRhGT0YNOmaVucYJLEfyU3sABk8lrrgOfQhRkGcBDwbvA==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr3128266wmj.112.1599554996012;
        Tue, 08 Sep 2020 01:49:56 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id c145sm28910402wmd.7.2020.09.08.01.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:49:55 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:49:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Subject: Re: [PATCH 16/28] wireless: marvell: mwifiex: init: Move
 'tos_to_tid_inv' to where it's used
Message-ID: <20200908084953.GJ4400@dell>
References: <20200819072402.3085022-17-lee.jones@linaro.org>
 <20200831155151.0DCB5C4339C@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200831155151.0DCB5C4339C@smtp.codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > 'tos_to_tid_inv' is only used in 2 of 17 files it's current being
> > included into.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  In file included from drivers/net/wireless/marvell/mwifiex/main.c:23:
> >  In file included from drivers/net/wireless/marvell/mwifiex/cmdevt.c:26:
> >  In file included from drivers/net/wireless/marvell/mwifiex/util.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/txrx.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/11n.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/wmm.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/11n_aggr.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/join.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/sta_cmd.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/sta_ioctl.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/sta_event.c:25:
> >  In file included from drivers/net/wireless/marvell/mwifiex/uap_txrx.c:23:
> >  In file included from drivers/net/wireless/marvell/mwifiex/sdio.c:27:
> >  In file included from drivers/net/wireless/marvell/mwifiex/sta_tx.c:25:
> >  drivers/net/wireless/marvell/mwifiex/wmm.h:41:17: warning: ‘tos_to_tid_inv’ defined but not used [-Wunused-const-variable=]
> >  41 | static const u8 tos_to_tid_inv[] = {
> > 
> >  NB: Snipped for brevity
> > 
> > Cc: Amitkumar Karwar <amitkarwar@gmail.com>
> > Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> > Cc: Xinming Hu <huxinming820@gmail.com>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> The patch creates two duplicate arrays, this makes it worse than it was
> before.

We have a choice (and you don't like either of them). :)

Either add the variable into the file(s) they are used or tell the
compiler that it's okay for other files to declare but not used them
(mark as __maybe_unused).

What is your preferred solution?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
