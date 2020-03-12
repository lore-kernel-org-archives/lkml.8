Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B9C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62185206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584026278;
	bh=/8fTxMFbD2pIIFtiaYwed7HV9jiPfyLfEJ1Kh/0PzVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VCe2/WjlwUfRGkN3d3dXft6IaQppMb1jIGDLpwv7h6fLD9wKfyY7zY5E+cqSC1gAA
	 uPdJOmnaSRwiVTkCmMoViNIt/jYn+jc2hfTOaLFIJL1W/nJ11g4sdH+eGhFfbZBOSt
	 UH3Qrf0gjHS539+Y/R3hnJUGvW6n93XIbYW7OQ/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgCLPR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:17:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47044 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgCLPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:17:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id a22so5788327oid.13;
        Thu, 12 Mar 2020 08:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHiigiRwWdeqsTTALfFLdUeJZ+/BBDh3z6SgaZUc3ZY=;
        b=hxmkl2UNItgX4D688vPbYm1ji3LDbawSCy3mKgzPXizuunK8zmpS/aaPLVxGSlqTy4
         6iOifX/qczNqwM9IZN0MQr+VMjMMOZpyt2sXVppmSbRerSsicik8vrGpWSjgK5FS1ZFZ
         nCNzsObasipj7jHHya/6v/e4QnWstukd3/7U7f4WjP/VZjDvsHSXxyI58jpyszub7Xt/
         iey4Oa7JP324ZN/t4hu5xwkbqgKnIa0qhwzSBj/Tq6lxw0VKhX7W8rc2X7yjY2/D31y0
         daAZNbRSXiC+CBDhb9wP05dxsDtaWOzye9KAmRJndF+xpFxWYfq15N0fxrD5nfSgfnob
         2mFg==
X-Gm-Message-State: ANhLgQ0pSYblDCbQ4JcfCYD/XavYzlc//QYN9fJ/L7ZHcvIzQRDhjvjM
        JB8KfAxxpup7WfJpCrlyTg==
X-Google-Smtp-Source: ADFU+vvYViH6zu1LQKfvsKC98PIW22YAry8cj86SwVNzzddHoLKUHC9/jtwAo4z7+fj1dyHXKjTVqw==
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr2886726oif.114.1584026274247;
        Thu, 12 Mar 2020 08:17:54 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q22sm1368687oic.22.2020.03.12.08.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:17:53 -0700 (PDT)
Received: (nullmailer pid 8236 invoked by uid 1000);
        Thu, 12 Mar 2020 15:17:52 -0000
Date:   Thu, 12 Mar 2020 10:17:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vinay Simha BN <simhavcs@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-binding: Add DSI/LVDS tc358775 bridge bindings
Message-ID: <20200312151752.GA7490@bogus>
References: <1583920112-2680-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583920112-2680-1-git-send-email-simhavcs@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 15:18:24 +0530, Vinay Simha BN wrote:
> Add yaml documentation for DSI/LVDS tc358775 bridge
> 
> Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
> 
> ---
> v1:
>  Initial version
> ---
>  .../bindings/display/bridge/toshiba-tc358775.yaml  | 174 +++++++++++++++++++++
>  1 file changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml:  while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 11, column 1
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
warning: no schema found in file: Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml: ignoring, error parsing file
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1252753
Please check and re-submit.
