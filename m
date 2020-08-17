Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0176CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C215820760
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597701213;
	bh=Z5Q1YqTNGFVvEaftX/pCU+rjMro8VT5yFdI5A7IVDHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a3uTAHU4cBhFI7dJ/93gwjO0PDI4s22TGWy+L7xJMOD4k8UjuCTc7b/dfxAeXeb31
	 jrShE2AhiHZZOUY4yVag1gfPYjNJ3g8Vgz3qfrz94/rNz3R4R3pci9umckGeULvem8
	 69nJEfmWDshOMaLtuMoJh85gy+Yeocmmc/blqj88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgHQVxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:53:32 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33710 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgHQVx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:53:28 -0400
Received: by mail-il1-f195.google.com with SMTP id r13so11448937iln.0;
        Mon, 17 Aug 2020 14:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K0MBZ3ff1Lrj093EuPk59+KL9AiNGoiCQzLPeqa9FjI=;
        b=ecJe0cisUp5kWpYJxjjwwiWMha/h8wZtVJQKyvIqQiX3ZLVdJxEhm2qeb31jWWJTmC
         cYCsiCAZXBtUsGEsuHCpGFVv3oYkyL6T6V5RDY90ljW4Y7tR9CVIv6ld1GKNFKn9TUCo
         Cyb9ftRXjaZooqmpqnSeMrS7qqWC3pngVDBW5WZDOyiP1sWrKAU1CXSxd4mxXq5xcpyz
         QFlA9kgD30FdjJavPEsY7dY33EhBIIB0f3v77LPdziYbPjUSqd+kdug0yRdsfRVOWOpv
         rSuSuB0nQnATeCBRZ2TbonE94m8My6XbRSHrPVqztaZX0Jixt6y+VQP6BHw60QhRdHhc
         6rlQ==
X-Gm-Message-State: AOAM531zgnhsLv7hb5KhTatdyn3LPlxZWgW6VGVeP6qNJvFXvhs9JIie
        xZ+9LhsfjJYwSytIdk11Eg==
X-Google-Smtp-Source: ABdhPJxdet1AhMrLuocVe04RePHBDGwtg0ouAbeoFlf73so3cW8xW9b09tjlxnoH1Zlf/p9lfYPpVQ==
X-Received: by 2002:a05:6e02:c2e:: with SMTP id q14mr15985757ilg.286.1597701207712;
        Mon, 17 Aug 2020 14:53:27 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q14sm9665388ioi.48.2020.08.17.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:53:27 -0700 (PDT)
Received: (nullmailer pid 1637578 invoked by uid 1000);
        Mon, 17 Aug 2020 21:53:24 -0000
Date:   Mon, 17 Aug 2020 15:53:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        srv_heupstream@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v17 05/12] dt-bindings: soc: Add MT8183 power dt-bindings
Message-ID: <20200817215324.GA1637549@bogus>
References: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
 <1596705715-15320-6-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596705715-15320-6-git-send-email-weiyi.lu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Aug 2020 17:21:48 +0800, Weiyi Lu wrote:
> Add power dt-bindings of MT8183.
> Add an optional "mediatek,smi" property for phandle to smi-common
> node for power controller.
> Introduce properties for power domain sub nodes.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 81 ++++++++++++++++++++--
>  include/dt-bindings/power/mt8183-power.h           | 26 +++++++
>  2 files changed, 102 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt8183-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
