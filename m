Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F20BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169FA20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468430;
	bh=lRerF/SA41TN2mvoUla+0+oziRMYObnjXEvz39m4tts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ejEn/8YsthsZE8btHrdKnEoHIrPOwJ/kAhkqZWrcsOEcn5Li+hSuUHPGFRmgpax/l
	 P/hZtbDQpx6YbL5cHvHOrXbAhr99OONhCpqHfQ0D1E49b/hsNgwUrAbffUfR3qdjPS
	 BiRNbdBRzlFTXO0EjyPAkKk8S9V0wN3IHMidpaC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391761AbgF2WHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:07:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34626 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgF2WHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:07:05 -0400
Received: by mail-io1-f68.google.com with SMTP id m81so18915193ioa.1;
        Mon, 29 Jun 2020 15:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aTZ9B4mZOC3u6XhEvkIjDDJ8V9Z1CqSWn34awXXpFyU=;
        b=X5asjsrnX+MR/5pgyoE8BhQKLuA4RQYJ3NI/lv1PIi6qUQNXHEzEszVLrdkPH0FSwY
         RMd3c0q9IdS8nc3/JZuTcifqtY2f3c47LNEWq7U5lFRYYMilyw/LWA9dkANXbfnhXrAP
         figYAUp0dIiHzIpnR6IueXfrC+MQUehRZbtl6XamU+YJuH2DWVDkdiJTDEcm9k5OHR5c
         XqVKBrnwZ5VpziNB3IwMY+QceUiZ2/Fx2DWAWB4qrzlSA8bPLNeNpNg2iWxF+ZoA62dj
         GT+kP+NS63GlfpTMtmw3n5aC2vOw8x+qFC85n9LmsEzvCnljCNfwYTRywJBKln4MCecc
         XHuw==
X-Gm-Message-State: AOAM531AUFY1PNsGKMrreOo5VuF4q3BIHcnd094ulh86FxEj53EWpdZZ
        2giuiYiA/qzHUWID0fKBXA==
X-Google-Smtp-Source: ABdhPJwQPODKag52+jKjOlIgcMQ9ixhkEL1uQI1ey5yvtkF3Vx3wcQRTCGFf4L/38BTm3UO4PTFFCQ==
X-Received: by 2002:a6b:1496:: with SMTP id 144mr18986662iou.6.1593468424346;
        Mon, 29 Jun 2020 15:07:04 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id k3sm623934ils.8.2020.06.29.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:07:03 -0700 (PDT)
Received: (nullmailer pid 3026325 invoked by uid 1000);
        Mon, 29 Jun 2020 22:07:02 -0000
Date:   Mon, 29 Jun 2020 16:07:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        michals@xilinx.com, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH v5 1/8] dt-bindings: add documentation of xilinx clocking
 wizard
Message-ID: <20200629220702.GA3025945@bogus>
References: <1593194185-22394-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1593194185-22394-2-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593194185-22394-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 23:26:18 +0530, Shubhrajyoti Datta wrote:
> Add the devicetree binding for the xilinx clocking wizard.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v4:
> change to yaml format
> 
>  .../bindings/clock/xlnx,clocking-wizard.yaml       | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/xlnx,clocking-wizard.yaml#


See https://patchwork.ozlabs.org/patch/1317919

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

