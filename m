Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E6BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6BC2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589468116;
	bh=ka/YSNfwRKICyw1t84+GRIfL+FWpHfm4NGEIGpUJN78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ueHh0Tp8hredUNSTup33P5aFE5s1wi7VF9FqrCCxdAkaxRVVNuMFNiiEi99CCyVys
	 5ZLzU4qbdAcrrrNPKADj/jwVm5jnRlalQElB+gcslnW7lNS38fCxx5jZ5C9QOLFV/D
	 tk9PVgzwVDbqUDgqmmKe8C7+jSdiUtLuHP4qGc8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgENOzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:55:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38690 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgENOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:55:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id j145so2937764oib.5;
        Thu, 14 May 2020 07:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6GKTQ1hvayQx5OvCaJHWXeEsZVK5jinIl8AV+xK1lWo=;
        b=lTcyUiGFFkdMuuqbO77J4nqP46ynWyY76DXx+7ZogbFgicQk1O8HJJtXsVmMUVA3yl
         rCDqfPIDGm97lJYBseSrNTRrHK5c9vMlyu7vZsdAKITPYQawz688v0QGv9Bw5GZyYrj5
         WKKTbP+JTezvPFeLTSKg3XohduuPZINxAhTszS7Vj8s6db4SPD/FTRMbazKKwMlc110A
         ZtXXZw54oZAbwDLNaNIb7Ji+rCXkggw9WtJfkwnQ6evHFE1e+fABzKFX4Sn0QmX3SMWv
         m69pBih2BYuRwWZ++qRjP8+DaaOF5U8sAlk/nFxDZnDzwqUtqhECQfQ3wCb8Z0co4cbb
         JAXA==
X-Gm-Message-State: AOAM532eIFqtA6HyR8+SO3z6aAgTIvbJpcSnpuNlowDSmL900pnj4NiL
        t+QMooUHxNNSSWreLIQuFEfRbeM=
X-Google-Smtp-Source: ABdhPJzPExS9+yhGzaOvpYeJu0M9Sj6OuOpDB5AsKxDZI3H8LoAnJ+egHuHqWQI81CVMcYTdbNgB0g==
X-Received: by 2002:aca:aa91:: with SMTP id t139mr2198536oie.176.1589468114895;
        Thu, 14 May 2020 07:55:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u17sm837801ote.63.2020.05.14.07.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 07:55:14 -0700 (PDT)
Received: (nullmailer pid 28709 invoked by uid 1000);
        Thu, 14 May 2020 14:55:13 -0000
Date:   Thu, 14 May 2020 09:55:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add odroid-c4 bindings
Message-ID: <20200514145513.GA28489@bogus>
References: <20200506080702.6645-1-narmstrong@baylibre.com>
 <20200506080702.6645-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506080702.6645-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 May 2020 10:07:01 +0200, Neil Armstrong wrote:
> Add the board bindings for the Hardkernel Odroid-C4 single board computer.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
