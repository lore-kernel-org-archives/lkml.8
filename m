Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46282C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183B52166E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592427527;
	bh=cEFkHGxD202SZ+AuWLZ5iMHx0G9x6B6SCyKBwR6nlzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NHx4+5+JlR96J13nwem6m4jCyjSJ5bj8mmDQilQcrSV6sDgeOZvJMTAMVp4vB5ivY
	 7iO2254PnLTkwJQDOSk09UU/nzcSCDxCMGd9kPY7HbvVTxohUxdHBrf0tpBt0MxA8S
	 LbJjD49eSWId3ns0XuM2Pobu7bTsYLoYWLsN4scE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgFQU6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:58:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39727 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFQU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:58:44 -0400
Received: by mail-io1-f65.google.com with SMTP id c8so4590987iob.6;
        Wed, 17 Jun 2020 13:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n5+GZUdirVswnFvU4wT2xx2a+Rw6JyWRfqT+WnLPbag=;
        b=Z7J1Y5hArMY4T2RD7ceXeNRl2nEegzcOEDzljxlXXkCQM1JU8I+tMnZe36bpdU10qE
         PJGs1Vo12jDHHwzW7INoAdBMgYIH6N+152OM7HOCbNNYeAU6/lEDL+d+nQIYvuUxXadD
         undHe8VFiegfSGOw7VTGZOKvHK6B7HTIooR9EFU5mpifW8L95uX5fGdQPZ0m1h/+00lT
         ASxQT3/YcWxSA2cleJaW7IDvW5EKKKw1Yn/Uucc1PRBU5fuC/GZcJYlzgo0mzsMNaS8R
         cqC6oF4CPWx68G/vDlVKtLuFEdBKVxHTKC6R64V2oNfwz9f+O7FtjTOVfSt5Y2qw/nxL
         rlVQ==
X-Gm-Message-State: AOAM533cs9tX1zvWPIdxukaFxN9iQSepVhyr4vRoFLceoWEEBqWa22yM
        XiZJX9COGZ+OfZ4NAAKvuQ==
X-Google-Smtp-Source: ABdhPJyBGo5Nyzsm6YlLL0e2hYIFFOJ3PgI3JRk3HTg1U92I39z3vyxkZUw8rzafh/O07uJR5W/m2g==
X-Received: by 2002:a02:134a:: with SMTP id 71mr1181745jaz.118.1592427522763;
        Wed, 17 Jun 2020 13:58:42 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p11sm539692ioo.26.2020.06.17.13.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:58:42 -0700 (PDT)
Received: (nullmailer pid 2800672 invoked by uid 1000);
        Wed, 17 Jun 2020 20:58:41 -0000
Date:   Wed, 17 Jun 2020 14:58:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 03/13] dt-bindings: dma: pl330: Document the quirk
 'arm,pl330-periph-burst'
Message-ID: <20200617205841.GA2800620@bogus>
References: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com>
 <1591665267-37713-4-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591665267-37713-4-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020 09:14:17 +0800, Sugar Zhang wrote:
> This patch Adds the quirk 'arm,pl330-periph-burst' for pl330.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/dma/arm-pl330.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
