Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155D1C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F6E20DD4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594683296;
	bh=jtL/x8QaeJYBVX26qVxdc9Gf42pQ1Umn1+ig/5qqPB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GVVipv93aAeb8pZxd5I1Ycs+pXPy0V/9udmKnPCkqpUDjJzZ9aZD6XRT2mXTUrXLW
	 ODR6lVeX5W1PB+w3g+8fg9uMM8jtqoMlfepsbp+xp8J84SGJBLK2YGcFV//95BLFL3
	 Tk4jNUafQpGZLTUvnRvS0v2bnbNq0VZu/KSUjvGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGMXez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:34:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35627 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:34:55 -0400
Received: by mail-io1-f68.google.com with SMTP id v8so15417843iox.2;
        Mon, 13 Jul 2020 16:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h09mBGtHi8i5lSRssVJKTabDr88RFU9DFJVpDRWqOyY=;
        b=na4Iy3kB395xsmp6N5sYOQOW3e7HZQhIpTfQ714D7a/M2AWkN5Nt5zJtK9czQ2qfmo
         a89/z71p+LCFvHI8Ppo+I0rd/XJ/v3jVUOJjL1nVcF3TGROIBWb13IoFtelReT3B8bR/
         JOxR0vsvklo3RRSTY9UvoMWYtt+e8xUDk9S1PXjSqtMLkMjh5/qbq7jFmJoatAUNlu8t
         17XvilSBNnGFuN3WCZsavShfD6hJpLViGeTTkaFIji20ow5RyYOZ22HX0gH/Ng7oX8Iw
         zVBBBbmmIEGGjb74gx6jhseI+UJCZRniKL++wDCOiqcw7rZ/D6w8NizUwFO0Tk32xTkB
         NNhw==
X-Gm-Message-State: AOAM532+MTXtiRQBtEg52nSxD1vduz9AxFZM3gIscn20ZpOY9B9L0rAU
        oHBOw/5Ok0VUvX6VUvU+sw==
X-Google-Smtp-Source: ABdhPJwfI7+jWURn6sHIGYi1OZze4wchDmNC/r88ULrNM/NVokDGIeeAUfetYg1n5a5T/nSqq97g0g==
X-Received: by 2002:a05:6638:d8b:: with SMTP id l11mr2765494jaj.124.1594683294403;
        Mon, 13 Jul 2020 16:34:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s18sm8922933ilj.63.2020.07.13.16.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:34:53 -0700 (PDT)
Received: (nullmailer pid 928397 invoked by uid 1000);
        Mon, 13 Jul 2020 23:34:52 -0000
Date:   Mon, 13 Jul 2020 17:34:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-media@vger.kernel.org,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 08/16] dt-bindings: media: document
 mediatek,mt8183-vcodec-enc
Message-ID: <20200713233452.GA928367@bogus>
References: <20200713060842.471356-1-acourbot@chromium.org>
 <20200713060842.471356-9-acourbot@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713060842.471356-9-acourbot@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 15:08:34 +0900, Alexandre Courbot wrote:
> MT8183's encoder is similar to MT8173's.
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
