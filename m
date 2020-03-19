Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0B4C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFAE2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584637991;
	bh=VQabmcWRG9vOI5KpeRbcCzMjxb8TEzKrlFtpwOv+BRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qyifh/FXaoOQS1nHeXrjxiizYEI1Ss5Y3WbRRS0na7qq5cwHGOzoldw3xjvo3kXI8
	 f8LY2o8F1XBrTOD9Ct2rqjtO7y1cbAv3nLB1zK1PIlLUe1mWDDVggHcoCFRQo0tzjr
	 i/ySvTHy4BycUHm9LwdJLiek/TawpJY34tl1sFb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgCSRNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:13:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35883 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCSRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:13:10 -0400
Received: by mail-io1-f65.google.com with SMTP id d15so3082383iog.3;
        Thu, 19 Mar 2020 10:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vaMeRGcAwte1RmEGSngS2OcQrt9TNWs2C+uDaacmCzY=;
        b=YTmNw5XF8sWkNuQfilCTH6Tiv5DpdiMZ5yHrfD5yCsxuwUVj/gb3W7zBp2e1yF++c1
         TqCSBJNXReiNG3S2hEe12YC+jbNFmLvVZLYPXXnguRTLwSOMFgglpXW8mjsTt7vP8H4R
         tqQSbT8GT3u3oeSomUpCkCDvfwiKmy3AWSOjYFY6yv7EZYFNwWZdlvwKmKEIYwKcTsLi
         JHOdcbIMrLgE8OA/j9LZde4GgyhKMvJWxBNzddx0tufxCVQJLaJSyNHVHkve7smEftZh
         jSf/gRY7ETiwzyjYzvuxv2HOYuhq+mJ0ABO23hBQYxxfxif9jN+K5OrcStGejZGZLaDl
         2TuA==
X-Gm-Message-State: ANhLgQ3zm4pRim628Hou3/g/zdktmBnrC6uAS9wYBLvx4+aRSHmu2XbY
        btkI8yzV/eI/MRSwul6HFQ==
X-Google-Smtp-Source: ADFU+vsNzhhlAgAANEzR2hL4ECz0qv+I1PFFy4PjVP6P9NnX2JFAcIQgt4cGP2efDTKjZcnzATPDWw==
X-Received: by 2002:a6b:5a0c:: with SMTP id o12mr3606837iob.137.1584637987422;
        Thu, 19 Mar 2020 10:13:07 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j23sm923575ioa.10.2020.03.19.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:13:06 -0700 (PDT)
Received: (nullmailer pid 19540 invoked by uid 1000);
        Thu, 19 Mar 2020 17:13:05 -0000
Date:   Thu, 19 Mar 2020 11:13:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     kishon@ti.com, heiko@sntech.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: phy: convert phy-rockchip-inno-usb2
 bindings to yaml
Message-ID: <20200319171305.GA19150@bogus>
References: <20200318192901.5023-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318192901.5023-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 20:29:00 +0100, Johan Jonker wrote:
> Current dts files for Rockchip with 'usb2-phy' subnodes
> are manually verified. In order to automate this process
> phy-rockchip-inno-usb2.txt has to be converted to yaml.
> 
> Changed:
>   Removed unused "rockchip,rk3366-usb2phy" support.
>   Replaced example with something that has SoC support
>   in the kernel.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/phy/phy-rockchip-inno-usb2.txt        |  81 -----------
>  .../bindings/phy/phy-rockchip-inno-usb2.yaml       | 149 +++++++++++++++++++++
>  2 files changed, 149 insertions(+), 81 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.example.dt.yaml: usb2-phy@e450: '#phy-cells' is a required property

See https://patchwork.ozlabs.org/patch/1257721
Please check and re-submit.
