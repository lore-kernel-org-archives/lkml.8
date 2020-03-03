Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D944AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBCB2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583244328;
	bh=J1emoIeLNl8O1qxo8m9mZ78N9IXYmUonT+bDUdjfoZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0wffKhqxXH6hsKPA4oef2/8Fra4AIlSNKmZ1pbhzW0eqJM0CX3TS7Q8MvJwCgrSqc
	 f3lsM2/GIjuzBjCrNUW+6U4hToqMOFIwrFr7kUVEVw6TX2P6l1qJ+DC7bpH+fCaKHX
	 3buJQSlWDs3QfD4TsU5lMeTJWIEvTMcyV7aj0pf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgCCOF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:05:27 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39584 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:05:27 -0500
Received: by mail-oi1-f195.google.com with SMTP id r16so3093597oie.6;
        Tue, 03 Mar 2020 06:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jbQGA6dYjSwP62J+F4COay7zaK+oh5Bs7zMzSTsHDA=;
        b=GkxUeVilffvxhAcjMZDVAaY5vGUd5e+LgQSIFaEpbBtFNA5/nM4RPL0vyWfLpS9Bxl
         GORlkXZQZT1lx+iiBa5PZKgobZta7AiAJz4nuF4FaEggFnGO36+UjlIgpmPInzElMhU5
         Eut/OdXfxs0IqiTzGKSRoWV9oQHoXghIFordYeQ29ddbWI1Kf7ggrzmug6gpEUwAzIsz
         9xuuCl9wAjx8whNRUiCTNNJ4l8U8OgUPt5N3e/1uIDugSiE6EXQyfd9EvR3F/JkUmmOd
         uxO8zYHyHJxgxVZTOtId/BvP6RR/w0rSjFbKBQLHPM6/AGY7xGt1p263OcseIyXmJ5o+
         THCQ==
X-Gm-Message-State: ANhLgQ0ncw7CJ9pMBImWsWgQgBBjwc4a0x0kElpvsaQ/wLLAjVKU3EcF
        Njm4EurOXh2FaFBNIwLZ3w==
X-Google-Smtp-Source: ADFU+vttXS1Py6bbTK9e5rZkoBNj2Je8lemdxTIY/n2cP/smJ3TW98j1PCb9hPEhtc/qkXNAeDeYJg==
X-Received: by 2002:aca:be56:: with SMTP id o83mr2583399oif.25.1583244324891;
        Tue, 03 Mar 2020 06:05:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n19sm7672257oig.57.2020.03.03.06.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:05:23 -0800 (PST)
Received: (nullmailer pid 20776 invoked by uid 1000);
        Tue, 03 Mar 2020 14:05:22 -0000
Date:   Tue, 3 Mar 2020 08:05:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, dri-devel@lists.freedesktop.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: Re: [PATCH v4 01/13] dt-binding: gce: add gce header file for mt6779
Message-ID: <20200303140522.GA20576@bogus>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1583233125-7827-2-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583233125-7827-2-git-send-email-dennis-yc.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 18:58:33 +0800, Dennis YC Hsieh wrote:
> Add documentation for the mt6779 gce.
> 
> Add gce header file defined the gce hardware event,
> subsys number and constant for mt6779.
> 
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |   8 +-
>  include/dt-bindings/gce/mt6779-gce.h          | 222 ++++++++++++++++++
>  2 files changed, 227 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/gce/mt6779-gce.h
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
