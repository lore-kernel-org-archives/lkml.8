Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D677C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E615820674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmSuTZ6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgHTWcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgHTWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:32:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF8CC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:32:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b11so148398pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cqYejF0FPIa+d7AlSTm/Gc7YgLZloIvNKdqMBUt+AsY=;
        b=ZmSuTZ6KCJTKQKYPSjUEzF+uUSfIT436CakTl8Wsy2kuSFOCKhSZFNeBCpXzco52S5
         4Hs2YyW722vCbqGe6gp2y9myXYF2tYNIalRG2jhoX2/cyZAGdMOrE1magYkANmez1tkB
         WJzvolLoKBbHKRRGw8UYPOxKughFUpBFbelIKntmosFIOYkKVD1X59zjvpxAew/7dkN+
         /76RUY4lJF2MnQ4++9d31b9hChdA83/hAYV41+1UwncGCXplygCGZgsFiMQC1+PVYi2m
         6kluZlpaiDDUXJEeTXDU2yg5NXK2UUtGo0gmLTKDBKXQrrpwxO7E9qijtMURRvVMHul4
         JkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqYejF0FPIa+d7AlSTm/Gc7YgLZloIvNKdqMBUt+AsY=;
        b=kzL/llK1U9KXHBAwCJhTWAVwThLex3gea+JU9+xfPd3pWdIf+QbPDwn9YlfO3L8tEp
         pGZK9FdswiNt/w90ASr2vqHK/G71/rnQb0WT8fz9BAgELRpNwqNebMmFIimhngxa1m9p
         onsdqUtr1iXR349pi9qq441B6j8+AQRA8Yf2elEhplFPGVKV8eMZvgMgBtz7QeZHsh+n
         qq10Y/8S2PBvioQoJoInKTl67DzyGMtFdDTTGn8yFiIPMr/LlZbUEviFgdeeUunC7kJV
         GwU4aUoTUZMOCnflRi5gLDrysyWOY49c9waw3MQq3gSMFqML63pqiApzc4gpJ1AzJiRu
         eAmA==
X-Gm-Message-State: AOAM5302jnnd7N9ao3H4yOB2ebsrypK4KaJuZ/SABEDHONoAras7hUyv
        qwf0YfY/SgMZlUPLnHtZptGRXxH2wJd4RA==
X-Google-Smtp-Source: ABdhPJzIZKSmzqbOJ/OvBUM7dtVdBJmB4A1oPC9M9oRFcPdN/Poitr5UR9RtoyQf6dkCuvOxp8hm5g==
X-Received: by 2002:a17:902:82c1:: with SMTP id u1mr451157plz.224.1597962758478;
        Thu, 20 Aug 2020 15:32:38 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h19sm11668pjv.41.2020.08.20.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:32:38 -0700 (PDT)
Date:   Thu, 20 Aug 2020 16:32:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/9] introduce name service announcement rpmsg driver
Message-ID: <20200820223236.GB3938186@xps15>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731114732.12815-1-arnaud.pouliquen@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 01:47:23PM +0200, Arnaud Pouliquen wrote:
> The NS announcement is implemented by several backends, but could be
> considered as part the RPMsg protocol. 
> In this case it should be managed as a reserved rpmsg service and so
> implemented on top of the rpmsg protocol.
> 
> This series introduces the rpmsg_ns driver that handles the name service
> announcement. The virtio backend is updated in consequence to use this
> service.

I have started to review this set, comments will be spread over a few days. 

Thanks,
Mathieu

> 
> Applies cleanly on Bjorn rpmsg-next branch (ddd1930d6e3e)
> 
> Arnaud Pouliquen (9):
>   rpmsg: virtio: rename rpmsg_create_channel
>   rpmsg: core: add channel creation internal API
>   rpmsg: virtio: add rpmsg channel device ops
>   rpmsg: define the name service announcement as reserved address
>   rpmsg: introduce reserved rpmsg driver for ns announcement
>   rpmsg: virtio: use rpmsg ns device for the ns announcement
>   rpmsg: ns: add name service announcement service
>   rpmsg: virtio: use rpmsg_ns driver to manage ns announcement
>   rpmsg: ns: name service announcement endianness
> 
>  drivers/rpmsg/Kconfig            |   9 ++
>  drivers/rpmsg/Makefile           |   1 +
>  drivers/rpmsg/rpmsg_core.c       |  37 ++++++
>  drivers/rpmsg/rpmsg_internal.h   |  32 +++++
>  drivers/rpmsg/rpmsg_ns.c         | 175 +++++++++++++++++++++++++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 213 +++++++++----------------------
>  include/linux/rpmsg.h            |   9 ++
>  7 files changed, 325 insertions(+), 151 deletions(-)
>  create mode 100644 drivers/rpmsg/rpmsg_ns.c
> 
> -- 
> 2.17.1
> 
