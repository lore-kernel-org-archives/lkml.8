Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADDFC4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7CB20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582730486;
	bh=icNUGw+8jCJYdKySY2axKM8VSXIJ4Aoc/LbwObFhmsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bCiGFhMw8iXexmBgn4ugGZT0rvfnoU0xOcrestF3B0JCFnR5yUC0NfzI2b6lCQx0o
	 l9sYDnDL+ahsRI+oE3nPRffi0ZYPdED03y2CCrsRM7TBjTjsJPVgwqEmbDsLphBTDc
	 eNjVYArP0VWFcgCrbxho53KqFsqVW26p0yFxve6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgBZPVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:21:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42639 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgBZPVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:21:25 -0500
Received: by mail-oi1-f194.google.com with SMTP id j132so3353538oih.9;
        Wed, 26 Feb 2020 07:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GmR3MdaCGyVwm72nEz3XbzIqX5lVd7f4sUKQMFOYdvk=;
        b=BoPxAAF3Ux0q/t5uOChOfYL5A2cRQSYw1SlACMRASPA6JAG7JSLzOXH5gRB/9n3kUY
         Z35J9eJEliaj8Mkhlh0hIIlLv+BJ/annRMzdgRLNvkGodKS9VpTk0LdgYbqm+vvH+CFr
         +B87Mp6I3YU2vFZhVdlgjXD9hmJr8mLEdI3DuI3FfnXajx46Z/2OwfnUCf2yKAayCzaN
         MlBW0LIRpzv3EzR+LyCLLTniS10/LfwDitfQm84Izq5xQ3ee5pNCEqgoZqWovftZhetc
         2+9GQN0hMa6Y6BTmLI5XaLSWo3CKsdJG7snJlDl0wVgtNylXUOosdDIXd+LQyIxGaaiU
         LGsQ==
X-Gm-Message-State: APjAAAUpYkxYxW+wE19EHVIKeOjdIOVEL70tYYQhljHrQWrlHSru6I6V
        //tajqZRv5wklgyCkq66xw==
X-Google-Smtp-Source: APXvYqxuEUieMlzM/vscfnnAnRm10zUyhU9fU+Moe+9Ni33jZvHACFKoPWwEWTwKsYYoFrg0KrSvoA==
X-Received: by 2002:aca:a857:: with SMTP id r84mr3426091oie.41.1582730484600;
        Wed, 26 Feb 2020 07:21:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 76sm857000otg.68.2020.02.26.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:21:23 -0800 (PST)
Received: (nullmailer pid 25778 invoked by uid 1000);
        Wed, 26 Feb 2020 15:21:23 -0000
Date:   Wed, 26 Feb 2020 09:21:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: ti: k3-udma: Update for atype
 support (virtualization)
Message-ID: <20200226152123.GA25719@bogus>
References: <20200218143126.11361-1-peter.ujfalusi@ti.com>
 <20200218143126.11361-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143126.11361-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 16:31:25 +0200, Peter Ujfalusi wrote:
> In UDMA each channel can use different ATYPE value which tells UDMA how
> the addresses in the descriptors should be treated:
> 0: pointers are physical addresses (no translation)
> 1: pointers are intermediate addresses (PVU)
> 2: pointers are virtual addresses (SMMU)
> 
> When virtualized environment is used then the dma binding should use
> additional cell to configure the desired ATYPE for the channel.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-udma.yaml   | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
