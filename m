Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD9FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D288E21D95
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594696462;
	bh=tunyV4JNDmSLtDlIDVpBCDOKGUhBVYKvKLuz8VeTR5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f06n/reGsQ41z+eME9yUZz6qOfexvcUx9780duFoFXMrMykGYy1//oNolhjM3WsEy
	 VdEUpwU2xSv240ds2HOcsiOL/e89OCTJ3lfaSAhMdMhvzWGBQi+O0XwBTqj7ICPYBZ
	 GVOw2ZuHd6HdwrCDFXqKXHX3WLtYVKKGsf3O9v/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGNDOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:14:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42525 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:14:21 -0400
Received: by mail-io1-f65.google.com with SMTP id c16so15803445ioi.9;
        Mon, 13 Jul 2020 20:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWIxzHqTyQlO7gsWJNB/FtRgRqh/Fa64GtgMJQmjQAI=;
        b=fzRamVLVbKWSpsg05d4lOrrXs0DXQlv9ShOZiUdno/G64/tbUGKbp1COWl8CE9+PHX
         iXr+AwkfI3alU/P6PLRBivnhiVxHBhk8SyMJA2qb37sS1KSmAEXdE5UX3EFuDX7XQhXn
         1IqAIvGmztjj/6dcCyrO/WUbtjPjKYuxRqUp4M/8VdqU1rdK4r8xKrpbzJqv032Ju9I0
         m32/tgxHH4pdxZWBg5pl5LWYNdV0ELzc45QK/P4sc2CrhHNjuC2HBUJyTjecXgNDgulV
         HKQXsoAXGQ4uyA5QWSyhXQN+i8EorWW8yXG9sYwxy6EHxeZ9A5FVnIw4ZH9Sv1eWXqAC
         0CNw==
X-Gm-Message-State: AOAM533DfCLMsBOiaecwrSLI472JxmoA6poZ09HT657/mz7kJD62hG0H
        0UdmAYDWoOPux7mzlQahLQ==
X-Google-Smtp-Source: ABdhPJzZshEumH0EQvkXRPvklR8XuOkvRLypvsondiqlyMqTl2ZwimUYIZHPbsD+MVIRTHyPYbjKEg==
X-Received: by 2002:a6b:640e:: with SMTP id t14mr2894003iog.39.1594696460267;
        Mon, 13 Jul 2020 20:14:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f18sm9266140ilj.15.2020.07.13.20.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 20:14:19 -0700 (PDT)
Received: (nullmailer pid 1221488 invoked by uid 1000);
        Tue, 14 Jul 2020 03:14:18 -0000
Date:   Mon, 13 Jul 2020 21:14:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: usb: ti,keystone-dwc3.yaml: Improve
 schema
Message-ID: <20200714031418.GA1221438@bogus>
References: <20200710113337.15954-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710113337.15954-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 14:33:37 +0300, Roger Quadros wrote:
> There were some review comments after the patch was integrated.
> Address those.
> 
> Fixes: 1883a934e156 ("dt-bindings: usb: convert keystone-usb.txt to YAML")
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../bindings/usb/ti,keystone-dwc3.yaml        | 51 ++++++++++++++-----
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
