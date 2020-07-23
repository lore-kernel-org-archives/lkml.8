Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB700C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEB32067D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595538777;
	bh=Uc67512T8JH00FHtvtj5w8YdSkeYsHhk9jgY0xY516Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mbmg36VPtPDwVIoBG85yNjYPWcj81q0zaJSKFhm3heOrs12IwrrlIdrbdSawTTWmM
	 3FBwK1+7p0ObQu5h4DaZ7iVf7fpzo0bODfi26mGZc0Zh5YHzOw0bBnPI+QhWRsDoJB
	 V6JpFLP7acjkCKeF4zND4OFehj0ClKhaQ4IlgWHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGWVM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:12:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42633 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:12:56 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so7777976ioi.9;
        Thu, 23 Jul 2020 14:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IMBnZKsh48SKsX8jjKgPA2bqoA7i2K6aQrR+811fDqM=;
        b=bvwJB7x8wssdiT3s3ZdWFCz4E+2N8qLeaH1y13r7mFeEmemf60ert7TF0gzweRG2QF
         yKL8tsleFXjGASAMIRS/P7vzAvjc9Reg8rZhsX/+NmWlXi77RUrdRyjmJTv3DkS+us/r
         N5/Mud2xAYKz5383PqaLw0tNGR4zODcgHZE2OH+11zqKmpGQfkPo8jinRcKFQ6TvGrS3
         aQBdXt4cHxY7QWYuMf0wPsupxEyBJnj3qwsYBZw/b6/yzU0CFPiSk4elGtBVQLP0/jWR
         3vVzQRi386ekmOnlYDGoWhjrT1eEoZn52RDE4/RF0ZUIZRDt6Fysx6KAmmRUGUdfrjuL
         RqkQ==
X-Gm-Message-State: AOAM530ScqY+zpBim/PpQNYEJrtDY+06URX6meapU26enP3Ke/M0TrDd
        /PeKoq01NvWDeIslyRU4rQ==
X-Google-Smtp-Source: ABdhPJxloVcHKJ9XFGl9lzOl5yMefFdfF+hhlnC+m1/0kOnxSi4LDMpW6iKiBRM2GLSrNZ05MUVAPQ==
X-Received: by 2002:a02:cb92:: with SMTP id u18mr7016893jap.143.1595538775491;
        Thu, 23 Jul 2020 14:12:55 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r13sm1821041ila.85.2020.07.23.14.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:12:55 -0700 (PDT)
Received: (nullmailer pid 867917 invoked by uid 1000);
        Thu, 23 Jul 2020 21:12:53 -0000
Date:   Thu, 23 Jul 2020 15:12:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: ili9881c: add compatible string for
 Feixin K101-IM2BYL02
Message-ID: <20200723211253.GA867872@bogus>
References: <20200719170411.275812-1-icenowy@aosc.io>
 <20200719171007.276383-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719171007.276383-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 01:10:04 +0800, Icenowy Zheng wrote:
> Feixin K101-IM2BYL02 is a drop-in replacement of K101-IM2BA02 panel
> (which is already supported by panel-feixin-k101-im2ba02 driver) with
> the same pinout. It utilizes an Ilitek ILI9881C controller chip, so its
> compatible string should be added to ilitek,ili9881c file.
> 
> Add the compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
