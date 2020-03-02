Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E47C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C261824673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583191747;
	bh=ahpf1EotaEJQRqpkKyEK6/B8hTNM1TIvzQevKfubgFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FSKaxu20oq2gH8cHhLf4R5v4tJcKsDI/KNDo8WqfsgyACWh6C0gUYa07vh0RBu7V5
	 +HrJLWYi4rRwNDjiqkA+t6SoaRVvVODsqBet10ebubohYp0R2JvItVH5cfla9O5lo8
	 YSBk0WgcDviKjn+IcD3Fz0zlPpfbLnPwYlvJ82m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCBX3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:29:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42668 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBX3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:29:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so1124292otd.9;
        Mon, 02 Mar 2020 15:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NS6hER+VVAnGHZWWvDFXB42+gq+sW8+/QdX9Qb/AI7g=;
        b=UsFYuuv3MJ6SQ3Vecp60psP+Csx6U2ujet35Mu/CoAtwIwXTB40vRLlC6/ziZgN2bM
         8mIL7YzTDC9w+C2DIp4JMEViUV3opXYqGvmIhZs/XMYp78QYgnfNtSCN+AH5ReYwcg7i
         qnAi2MdDQRHZeXMnW4w8RNobgHnly5jr/yWeFYPkpa+9iLrEnMJ7D3F7lcjWSRKVBj+W
         68QuToTGhmKCfjLf50ufawvesQg9kF+JA5aRQyuWdup3EHnDTUEBkdbZZr/XppOK/rak
         NMrorLCycPbhqYG6bcLcGJUKUjNdoVTIdKEy7Ry9QnO6YsuiDoHlKNNZTUhpBCyPUIqD
         bppQ==
X-Gm-Message-State: ANhLgQ2l5caFyrVve9U/3UrOPuAJzDORrvpcFpYc6UMU6X2LGlGEJFjw
        yFtG5JuwFZAXe29BVYC9zg==
X-Google-Smtp-Source: ADFU+vsUt55eBcvqYE0rSpf9oRYffX/uXs52slphFkLEkbKH37ioBPr+eiRmTNq+O9nX9CF5FnnZAQ==
X-Received: by 2002:a9d:6446:: with SMTP id m6mr1231470otl.122.1583191745239;
        Mon, 02 Mar 2020 15:29:05 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m69sm7061077otc.78.2020.03.02.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:29:04 -0800 (PST)
Received: (nullmailer pid 4498 invoked by uid 1000);
        Mon, 02 Mar 2020 23:29:03 -0000
Date:   Mon, 2 Mar 2020 17:29:03 -0600
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
Subject: Re: [PATCH v11 2/6] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
Message-ID: <20200302232903.GA4460@bogus>
References: <20200228081441.88179-1-jitao.shi@mediatek.com>
 <20200228081441.88179-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228081441.88179-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 16:14:37 +0800, Jitao Shi wrote:
> Add property "pinctrl-names" to swap pin mode between gpio and dpi mode. Set
> the dpi pins to gpio mode and output-low to avoid leakage current when dpi
> disabled.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
