Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB59C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C173E2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579629652;
	bh=JxsMGHlQ8K8P3LJ4xEZSbS0TerMr48G8ngBCyN92sV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IMDTi37wNuSyDKRYGGJGOUCRDg5fMw8hniyuU9gU3B3qrcO/IjYAB6m7BkTBQDtQL
	 0aFE1qcmPG+xxVs2hqCpcMWIo7CmEs+ZQ/1UWfHHdyRBfng/smzX7Ni1FZcaxCLV8Q
	 SF0NE/37x/o1tC9LCHrseKkrICwlueMUheE023xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgAUSAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:00:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39237 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:00:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id z2so3433561oih.6;
        Tue, 21 Jan 2020 10:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHRMSNRShRtBYrUTeMfWPqqYtpJg6IFNDf8AuiA+bOc=;
        b=n+LmMplYEYlLHgE+G4eaa1DcG7EVLz4Ey0pRlDITEjlK868k3jnp+nZ+WCkVTUmBmu
         /O8b9CVjDtC1mvAARCBGWsgRXpCvmnY3wTpZWEBQBMTzThaYAwc20VfZsHMQon2VVg/O
         vxPJhdty7QhEFE/RhgBwfERWR7NtWVb9YYlHMj1zWG7QS0vTk4Rin7fFGt/xxqWliT+V
         ks0j/C9CdECiBw5I3+kez/Weskd8wqubkhwh23OsCFIDFzxnD1mCz9ZzPf/5mJIlrWo/
         xY8s7oWEjzHDQ/MVd448cMJtNywIGtYngnwNQOlE6dpCewpv5rWYRNKNzxzeJDzDMU9i
         qdmw==
X-Gm-Message-State: APjAAAUx5NoMTsvwenYWrzAGu9sWnWnW9AHihVzaN16342WPkfm0WO+a
        EK9C9l0Qe6MU9bYP3ojhkA==
X-Google-Smtp-Source: APXvYqyzppaF7bza95PNQiTUkKlMxTicfaxYaeuVH01PjAK3i3op5l4C39g5wjarGMwofRV3547y0w==
X-Received: by 2002:aca:5fc6:: with SMTP id t189mr4028320oib.166.1579629650685;
        Tue, 21 Jan 2020 10:00:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l13sm13748338otq.78.2020.01.21.10.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:00:49 -0800 (PST)
Received: (nullmailer pid 858 invoked by uid 1000);
        Tue, 21 Jan 2020 18:00:48 -0000
Date:   Tue, 21 Jan 2020 12:00:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] dt-bindings: Add binding for IT6505.
Message-ID: <20200121180048.GA407@bogus>
References: <1579488364-13182-1-git-send-email-allen.chen@ite.com.tw>
 <1579488364-13182-4-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579488364-13182-4-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 10:44:33 +0800, allen wrote:
> Add a DT binding documentation for IT6505.
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml        | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/display/bridge/ite,it6505.example.dts:19.31-32 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/display/bridge/ite,it6505.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/display/bridge/ite,it6505.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1225618
Please check and re-submit.
