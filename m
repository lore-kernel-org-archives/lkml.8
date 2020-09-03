Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE0C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAA720758
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599150357;
	bh=v5aIi0e1FXBbyCluSXSNaXG/z5exYLBqPfVwBQQjzvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JA9pRdf81KAR5X18EsqK9DFZ837mAXeWpOi/lixInZvVmmsD96DW0DsiI1FBOwu5m
	 0PCJpNWR2WUhlZsAAD56GM2J1VTabSYVKo/Ntn4giTJGEcEKZxq7vL6lLvwDT6pKxq
	 pzf8pYGo3th/BNwools5qN2zQ6oT3FoSOjZhiSqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgICQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:25:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35917 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgICQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:25:53 -0400
Received: by mail-io1-f67.google.com with SMTP id d190so3543242iof.3;
        Thu, 03 Sep 2020 09:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8jt+cUDaZci8tpRGrJa6zJYHwfmbG1TGKRsV7gB184I=;
        b=deBZDbGxrtjDy+wOcfY8MFN86v4U3gVW+NEL+e9mX+l3KrdKzgd95JoAQFjfjZC8FR
         8psIm3pvZEQL5ESjzomyT6+I8+ADyx8ffdY/rW2PnCcb0qZmEflnuwy2vtUlEGwOjS6v
         5iqGUb5FQ1jDl0f8m8sPBU41Kcy6NJ1RGTpusl+HhbKVV1kKc+abby7cRGjbldZg9CEi
         keBP5y9H87UFDQ5bmBsL0PvXJImbFIvYa2BTr1GYteq4/Tn9h7QX4cO+0afmVlA++OHb
         1mBsFkEyMgBQDWW640vs5x/bFV1+GV4IHWO2WHsxBzsY5l2K3rTx8IHdnh68utmiI7rY
         UASA==
X-Gm-Message-State: AOAM531HxiFHgyqyGqw3tQQSRe/9Y2KZqEr0EgZOq4HNQlN7QjMTUMxf
        yEJGCtixXbiS5KLu1HcIOA==
X-Google-Smtp-Source: ABdhPJx2GD67DiFTiJR2VCPdhrfyE0nzINKBHCeWwYhpSGJBofkBOU8blidOuSPf6Wo3XJBSEbwcLw==
X-Received: by 2002:a05:6602:3cb:: with SMTP id g11mr3815840iov.70.1599150352443;
        Thu, 03 Sep 2020 09:25:52 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id o1sm1733260ils.1.2020.09.03.09.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:25:51 -0700 (PDT)
Received: (nullmailer pid 2896293 invoked by uid 1000);
        Thu, 03 Sep 2020 16:25:50 -0000
Date:   Thu, 3 Sep 2020 10:25:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 5/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core
 C.TOUCH 2.0
Message-ID: <20200903162550.GA2896127@bogus>
References: <20200831082917.17117-1-jagan@amarulasolutions.com>
 <20200831082917.17117-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831082917.17117-6-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 13:59:15 +0530, Jagan Teki wrote:
> PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> PX30.Core needs to mount on top of this Carrier board for creating
> complete PX30.Core C.TOUCH 2.0 board.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
> Changes for v2:
> - new patch
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

