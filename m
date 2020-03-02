Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A28C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BE824673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583191786;
	bh=KMS+iJD9rRBJTUf5jnkw8gEV9qQ0wRZawugNdFZdK+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oUCOUuuJM3608S6iCKBuyyYU+HReNpYvEDFlKwPdQc+HuvBZ8faneeve5qDtCdJOC
	 adCb+X65bwiHtNQ8Q/DbQf0cSy90lqHw8kRsiLFUbpQAty0/QSNizdjs560Ckgt2l1
	 k2Yhs1+7Bthm6wJIcEyFLKQZ6gpgsjqbJgMsjw4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCBX3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:29:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34547 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:29:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id j16so1181809otl.1;
        Mon, 02 Mar 2020 15:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bL4crR0QltZVzCb64PaSDViplJhkuKW5x/Yz6zKqjUM=;
        b=O2DViKIQ6w8Fn2YmzSkpUZSnkOCNvSlYW46DK/aigesz7s+95AgN6j3qmsTaX4ukxB
         wQyopRS76LfOhjmuMopo8Ni5YbGD/APMUwrx9wLWgXGHzCFgcY+ot/R/RA5maqi5V+bW
         qP7NYar7uN/kd4OjgMfgC+7gXUw0msgR5co+5UFHUoDDaPVv0ncY2zxtkUIsp/lCDJXN
         zwqPaPujm1/ZjGYaaKQ8as6yktji6neiCu9ukEgp/KDoy6rVae6R4eFqvXMQC/JWKVQY
         4yZHvNqMYwwNbdrA2M2HNg7M9vtmBkQpfYV/PI/l+RweRUml58WJGCzs1Spdb5aYdu8v
         apWw==
X-Gm-Message-State: ANhLgQ1/pxhbCbwbgCOjuK4s2CQ7cmDdzwU9LhzuDqSU6y6w14VGbluL
        XhSy+VKVJpTmYc1Sx2ZuOQ==
X-Google-Smtp-Source: ADFU+vuIYp3sLPsyMdTfFaP1I6L8Bzm3bqP7VA7nzk6Wvk1TBOMDG6BACKkVaDwUxNRMG3Vc8bts9Q==
X-Received: by 2002:a9d:6446:: with SMTP id m6mr1232961otl.122.1583191782350;
        Mon, 02 Mar 2020 15:29:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m23sm3437121otq.37.2020.03.02.15.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:29:41 -0800 (PST)
Received: (nullmailer pid 5546 invoked by uid 1000);
        Mon, 02 Mar 2020 23:29:40 -0000
Date:   Mon, 2 Mar 2020 17:29:40 -0600
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
Subject: Re: [PATCH v11 3/6] dt-bindings: display: mediatek: dpi sample data
 in dual edge support
Message-ID: <20200302232940.GA5490@bogus>
References: <20200228081441.88179-1-jitao.shi@mediatek.com>
 <20200228081441.88179-4-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228081441.88179-4-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 16:14:38 +0800, Jitao Shi wrote:
> Add property "pclk-sample" to config the dpi sample on falling (0),
> rising (1), both falling and rising (2).
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt     | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
