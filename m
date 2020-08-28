Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB4C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B082080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598653239;
	bh=+huswx3cUSjOQM67FOq/UnLNFaUBg01XnDsJO4m5zp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rRCSEPJ/B6XoX6lpyKRun2p6grMZTNet0u5HnR8frZRUmjG+tcvKt2KercpaPr8+r
	 fo0VsM3I+7yPxMIauGz5whSLyMbSW93Q/jFgnZ02xhKPtKEeyQ0rHTM7xsDI1M0HuF
	 8nhBfDIahZhsfaKKAgb1KcTaedRRMlP8gQIsCxMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH1WUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:20:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35474 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1WUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:20:37 -0400
Received: by mail-il1-f196.google.com with SMTP id q14so1982396ilm.2;
        Fri, 28 Aug 2020 15:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84tiJNvqXLzWGNNKW4M8qslA98P8c5Z+XOkx6/PTE94=;
        b=Gvg2Up2dBSUOnwl5REcqowZ2JYOnoEybsi1bhghEh1g1LdW8k/hZTdLM19fTMzwG9H
         sTgR1ClSlXOTdHJog8EwzdtEIUBgNIk5IFQAgqFmXUzuT6QMcZYqTWlpkJAxunvPGeqs
         HNtiZ4p3TISvum74JKTAzGh4dIe/g+XdEnmbMhqtYoQGpNn6FpB8WjOO95og4ZuI5evB
         Qab/fDdEs/FZAAxjLeox1OXabPyf1O6AlZ9rgG/Y4RHYSwlxnJidzhzp5DbcToIcIv0Q
         +UHg2CLdHJLKjlHky+mOSClDdL62TqiNqWzW8osUdiMLl4tWz8PYAyI0imi+NgPeJvU5
         nFLw==
X-Gm-Message-State: AOAM531Tuy0S0PWMDfQoV1D91+k4WkdHb2FcqcCvTG0Gc/cXHzJGaNLz
        91rX7c1Ud/+KkcvLvCTr+Q==
X-Google-Smtp-Source: ABdhPJzCtRKSR3U3/rpXQVJxYIvZY+tOqpqfk8joLqp/qOw1Q/Iywr+mAqA/6IsF4a2siLlyxHqGFQ==
X-Received: by 2002:a92:48da:: with SMTP id j87mr902382ilg.78.1598653236093;
        Fri, 28 Aug 2020 15:20:36 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 3sm352652ily.31.2020.08.28.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:20:35 -0700 (PDT)
Received: (nullmailer pid 3507112 invoked by uid 1000);
        Fri, 28 Aug 2020 22:20:33 -0000
Date:   Fri, 28 Aug 2020 16:20:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Grant Feng <von81@163.com>
Cc:     linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, linux-leds@vger.kernel.org, robh+dt@kernel.org,
        dmurphy@ti.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] DT: leds: Add an optional property named
 'shutdown-gpios'
Message-ID: <20200828222033.GA3506139@bogus>
References: <20200825082206.26575-1-von81@163.com>
 <20200825082206.26575-2-von81@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825082206.26575-2-von81@163.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 16:22:06 +0800, Grant Feng wrote:
> The chip enters hardware shutdown when the SDB pin is pulled low.
> The chip releases hardware shutdown when the SDB pin is pulled high.
> 
> Signed-off-by: Grant Feng <von81@163.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-is31fl319x.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
