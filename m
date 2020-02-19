Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF14C34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C44624656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582125588;
	bh=n2W//jwppvyR6oszo8s2QetIue5Z98Pj5UrnNbG9Vpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I/+/X8hyAaDTdbuabscUup1X7V5paLQdCvYthSrC1WzCOQRIlg1ZsevXRdJzl0Pt2
	 mroPm8Prh0z+MIMNK4CJWvcer3AY/RUKR5cApm05l3KWwmV3JVSMWz+//+bgtTV0bN
	 oTwp63/8MjjWGhJC5edpV3FGJzSxG8+rz+gahtxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgBSPTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:19:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42082 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:19:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so451537otd.9;
        Wed, 19 Feb 2020 07:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+3HypG8MPZlCVq8NF/1pnld6WhQ7Qev4G7MICGX0f8=;
        b=WSaMJJsP7rWhOWay5xlXBaHJD5L2LWXd7q6zIfYxVPr+BohbJON0l6FvuSQQvgakrN
         IYLs7SORO34or30OlLxvWzYqjxVOLG9r+U0pO3DqGjzRCE713O6h3JDQGyNNXn/fFM7z
         9sH06QnpbTtuu9fFZhn+C6rEMy2GKZ0y+AaFagDtXcdjYFvFZJbP0h3vYDR006tRqWTh
         0yca4e/c4fomNmRKbIP75dLvphR05eT80vcpk8DAGGce8SpjeYoVNqWtbm2+r2v6n6cg
         j2WrHfmGRMKi62j9j/Cku0fuJOJM9TmwQ/ko3T6xHgFr0M8f3n2SStgvCiFspvHDneYH
         Tl3Q==
X-Gm-Message-State: APjAAAVfwkPkQpvL84xB1P+YmjncbYQBk/t8V1/KSlR6IQpfLY2GaIR6
        ZenwlxMDzce/THBeTUdDVg==
X-Google-Smtp-Source: APXvYqw7Q2E+ee6dnEwhNr85ShyimLpqfNxeaNDxSohaDwUzJ4J+PAU14izexHidqelCTonX3S8O6Q==
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr20412335otj.309.1582125585559;
        Wed, 19 Feb 2020 07:19:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm62827oid.30.2020.02.19.07.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:19:45 -0800 (PST)
Received: (nullmailer pid 9942 invoked by uid 1000);
        Wed, 19 Feb 2020 15:19:44 -0000
Date:   Wed, 19 Feb 2020 09:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Henry Shen <henry.shen@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        guillaume.ligneul@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        trivial@kernel.org, venture@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Henry Shen <henry.shen@alliedtelesis.co.nz>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add TI LM73 as a trivial device
Message-ID: <20200219151944.GA9881@bogus>
References: <20200212030615.28537-1-henry.shen@alliedtelesis.co.nz>
 <20200212030615.28537-2-henry.shen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212030615.28537-2-henry.shen@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 16:06:14 +1300, Henry Shen wrote:
> 
> The Texas Instruments LM73 is a digital temperature sensor with 2-wire
> interface. Add LM73 as a trivial device.
> 
> Signed-off-by: Henry Shen <henry.shen@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - add missing sign-off
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
