Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 23:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EABE207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591312219;
	bh=Tx3hinUPkXeFvB43SWg1oFptpyIyCAQ+fOPi5bUG+vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LBNW07rfwuNRMJvguqPPvPiwWnl/M9Evwh4VC9wNwbZOLj4EKBwI7v8kMkIqt1L9+
	 Xkyz0xgvVQU9Cib/y0lKxY57yYeOOiSetGkU7HwbnvSHk70SjDMtjvTUiueuvDBHkQ
	 hRFmxlT6P4c+1/48YJtRHbNOZCs+O0DCAYaxgODo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgFDXKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:10:18 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35359 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFDXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:10:17 -0400
Received: by mail-il1-f195.google.com with SMTP id l6so7802285ilo.2;
        Thu, 04 Jun 2020 16:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q7WJQlBvPEBNqlkXqh4qqiqq6Tsxm/g6xj5WhRd10ss=;
        b=HTtzHABrPXlLogU9Mq8gYd8QZts2NMuppw7Bvmwzn1jrWs+uBvo3UCspcnrFWU7NKJ
         vOgcV73Awos+M+xURSla0lMH1VEzN8CUKeZsMj61MqUSWiKvd6Rzn8c/axJfytpiZMul
         +JJ8goomDcRzDV+AB+zUdD7KD7IKz+0qMg6Dq9D6eX/sGXjChFb06aMOBY/m2rSbkADg
         VisaJTEcXR54J73Y8Ue9JFCh4gz7cf2y2RO460kTFQlsjSEdFlkMxVle+BIwUjn5iOjk
         pJZzXV4RcWSwrcTQ2njjmUjwgiV19G25YifzfrGL7P9DwuxLiL89MgeOWcDBBtbeP7yf
         2YVg==
X-Gm-Message-State: AOAM533ESvMbmHvP9oSsvMTX0ZoQxjFC8MAMZoPTM1VgCzPwcKY0j1U3
        TgO7Wt8YzfXiJLV1pp4mdQ==
X-Google-Smtp-Source: ABdhPJxhRoC5EOIby2CxjIhKZV+cKt0e7Y/t4WAVSnQAJtSBXYT9d9Kfk+hw4tsTbwWNT980FXxeZw==
X-Received: by 2002:a92:c101:: with SMTP id p1mr6258008ile.239.1591312216303;
        Thu, 04 Jun 2020 16:10:16 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 199sm2162773ilb.11.2020.06.04.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 16:10:15 -0700 (PDT)
Received: (nullmailer pid 20793 invoked by uid 1000);
        Thu, 04 Jun 2020 23:10:14 -0000
Date:   Thu, 4 Jun 2020 17:10:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Steve Lee <steves.lee@maximintegrated.com>
Cc:     ryan.lee.maxim@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, steves.lee.maxim@gmail.com,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, ryans.lee@maximintegrated.com,
        devicetree@vger.kernel.org
Subject: Re: [V7 PATCH] dt-bindings: Added device tree binding for max98390
Message-ID: <20200604231014.GA20757@bogus>
References: <20200602084337.22116-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602084337.22116-1-steves.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jun 2020 17:43:37 +0900, Steve Lee wrote:
> Add DT binding of max98390 amplifier driver.
> 
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> ---
> 
> Changed since V6:
> 	* Re-confirm yaml dt binding check
> 	* Add minimum and maximum value for each temperature_calib and r0_calib
> 	* Add maxim prefix for naming.
> Changed since V5:
> 	* Change txt to yaml and fix up the examples.
> Changed since V4:
> 	* No changes.
> Changed since V3:
> 	* No changes.
> Changed since V2:
> 	* No changes.
> Changed since V1:
> 	* Modified sample text in example
> 
>  .../bindings/sound/maxim,max98390.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
