Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE85C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E9420721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590516166;
	bh=FpAErRht9TdqgOIKx0JJHVn83d0Hgq6QodrXwgpzNtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zbf+/xk6qEAJ7yScFzs8IZi3rSQBY3BUNf/njZ12FglZDsfqgYTGdsC7vy2PUKqFy
	 r4LN4q+AsveCEU+BG2m/CVDMNNGmuKJAmcy9kLaMNGyUichRNNCN6usPr3tE3qQrBb
	 Ia112+yQcebgL0WIgZGniTDv+cyg5ItMzZ0r2yYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgEZSCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:02:46 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33487 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgEZSCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:02:45 -0400
Received: by mail-il1-f195.google.com with SMTP id y17so19209851ilg.0;
        Tue, 26 May 2020 11:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YebaOmD7Ju0D8dp8+Jh6rQ27XVMpKBTe+xY/yyi+R5c=;
        b=lk3Gh6R/n9kXq4mPiQtOWhE7K/WYgX5w/V64GvoEHFgErUyyDb4XZKqeaQz0Onf9wX
         DD6Pir329ADffVIxbOCZc93ZB3w00GowVjD/uNu7PjGu9aSYsA0z3hV6qqpusUHPmWdD
         yqmIjttXyZ6h1WBlwyLy2ZC7qZ45M3TfzBeXRm3M0/WuvBHX0LwsSK8GBegr7NFMA1ng
         ftzoqnl1tipikjZFEci394/LXqXxS7IdTYRqNzNt7KvMKX8XdHunCEAr/ajPLGAUbsmO
         uxCGERBv+nEpRnIiuZYysgsVAu43qcl74k0lN3v3Kae6x5/tYCEAM6uy3Fq+DMFOw0pX
         SNow==
X-Gm-Message-State: AOAM530fbpDOOiWXDgtmFb0ecTBo7LSToOEnlOWg2CFFIMuEKWNuHucU
        aAQGEO1RVYLcwrxmWYeMiA==
X-Google-Smtp-Source: ABdhPJzHpsHTbs1kNcS5W7S2W7j2Tz56qjTVrOe7LVapF32Ul2j79RUmxJxaOWK3AAyJg24lmEWqow==
X-Received: by 2002:a92:ce8e:: with SMTP id r14mr2366787ilo.265.1590516164859;
        Tue, 26 May 2020 11:02:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j90sm339624ilg.70.2020.05.26.11.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:02:44 -0700 (PDT)
Received: (nullmailer pid 76101 invoked by uid 1000);
        Tue, 26 May 2020 18:02:43 -0000
Date:   Tue, 26 May 2020 12:02:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-mediatek@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <kernel@pengutronix.de>,
        srv_heupstream@mediatek.com, James Liao <jamesjj.liao@mediatek.com>
Subject: Re: [PATCH v15 01/11] dt-bindings: mediatek: Add property to mt8183
 smi-common
Message-ID: <20200526180243.GA75958@bogus>
References: <1590051985-29149-1-git-send-email-weiyi.lu@mediatek.com>
 <1590051985-29149-2-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590051985-29149-2-git-send-email-weiyi.lu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 17:06:14 +0800, Weiyi Lu wrote:
> For scpsys driver using regmap based syscon driver API.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../devicetree/bindings/memory-controllers/mediatek,smi-common.txt      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
