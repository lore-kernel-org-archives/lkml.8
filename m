Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A37C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC9E246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582823741;
	bh=dicBS6zafBbgSnJAQWrwzDvzmsffy9hKvFk1BSU9h0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tidb9fkx5ss5fIcejKEmEMVd46ySKgBzPi0qo87NjaUNr0v8olo8rUVo1gBsjJE60
	 n9JhW86yfIsC3NW3I/IFGWnTCh1m8x4HgPIdAcIMD+0PuQ5neXrrvSfGGBCr/whBxL
	 eTSZA+dlNXnoM1puWMbeBpn4FI/4CnrwbiLHlVtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgB0RPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:15:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43727 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgB0RPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:15:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so4023013oif.10;
        Thu, 27 Feb 2020 09:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E2s4W1sTyFGQwdK13Lex3fESSAYc6q6IIVmN459eOYE=;
        b=oZVECPMtVgCSnQ+V1WcBQR1Iu9T9nQ2rMlSWt4qGKNVQX2RDMXSJFEpVxCqoajoF3U
         UFQWthP89RWgAdmP3D5SgRQvwL+1uKWjEEmXwFs/TQ/tvjTVeOvYsXe4w3BRHw1BHmJg
         DNau5Q5w1/muK1J3yspT6pGEsfNd9LxZONlNdp1tVoLwLs8QBrn+pv3zRbTzBBwLLb6M
         yQzYRli6F0ct4yULiaSEZq/uzpAuQ4nuUSkM77qygXULhfxu25FryTrndP4LbiLx6d1C
         IKz/BpLMVU1dokedaYOf+6wAMz1UWkCgbHcYAY5yRfja/pRYGBjbZrcXDyaC4V9lx4Fk
         n/4w==
X-Gm-Message-State: APjAAAWsQzQx7m65dg9ptN3YQd+p7ZBx5XwOpzxdWa4gxjC71ZdW+8eZ
        lJBuAn450vRbQ/53hwRDAQ==
X-Google-Smtp-Source: APXvYqzPY/x9+leT8mGPZrSZwA6cJInd+YOsSLBRuvxwItyWmhZNQAKo6BVOMNji/xfmQgysRVoyAQ==
X-Received: by 2002:aca:b9c2:: with SMTP id j185mr59225oif.112.1582823739377;
        Thu, 27 Feb 2020 09:15:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t9sm2108218otm.76.2020.02.27.09.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:15:37 -0800 (PST)
Received: (nullmailer pid 14499 invoked by uid 1000);
        Thu, 27 Feb 2020 17:15:36 -0000
Date:   Thu, 27 Feb 2020 11:15:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v9 1/5] dt-bindings: media: add pclk-sample dual edge
 property
Message-ID: <20200227171536.GA14418@bogus>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
 <20200226053238.31646-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226053238.31646-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 13:32:34 +0800, Jitao Shi wrote:
> Some chips's sample mode are rising, falling and dual edge (both
> falling and rising edge).
> Extern the pclk-sample property to support dual edge.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  Documentation/devicetree/bindings/media/video-interfaces.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
