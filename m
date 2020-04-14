Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CADC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA57F2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586886915;
	bh=XAENhHp+YbHNiNuErwnZRDW4tyWhIVGy6wjwQie+iYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qLs4e5fHuDqdCtMfQEybV/FdYDW/JKuyEjJ82nptmJSFfRINHJbu7JKmXpSo5kOf4
	 eGKrM10ISHUvKFjBr7QfYuVz0xVmrpVlYiIK6YpckIbmxvmhPjGnCtTnmzcTNtUrc3
	 9zsT0+n9tssLP2v/nqbceLlMr4VqaM/g6AQt/k5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503093AbgDNRzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:55:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43853 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgDNRzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:55:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id j16so11190630oih.10;
        Tue, 14 Apr 2020 10:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WmmKKJer8lU0q9QBWs73faNQSjKIqIKtUb0QGBdgiWs=;
        b=tg5Y95RvMq3kDEg6BUPIVRdK08wz3epbROkljbX18n8+TDcSO7EgJE53h3JXv1KLfe
         iUk6o8RFGaDNlBJBkB3Anuf96mYiB6i/GE9hEwojUt3XEWE08qMJNBzIGrb40ic10Bxs
         Mn/P4I1wfdNCjiPBQfXWy+0nGn6iv8TeNznrv4Gb0DjrC6LZSZVqF1a56e7ROj9Azwcc
         lzhpHINZ/W2SKeXfqQA5v2IOHZBdixAFMV6EJFmr37CYS1VbSyJP2v+kIUHz/ByzezCe
         kbgvNLh+G0VglSvDYx9RO0Ln1qxePLKTOTSDJ3eo16Y7NGU+2sAt5g4O6ZU/q1KEboVw
         8wOQ==
X-Gm-Message-State: AGi0PuaY0sESQTyzzoIKPNAsLxO+yDPvyK9MMv6kdOQoiKKb/zIm3Nod
        u4LPSkHkWZknog+1VP+R7w==
X-Google-Smtp-Source: APiQypILy4aKwl7uq1CLY3J+ZRi+9a7o6R2wYnArtCL7+wAsFVa2mirF2SfcieW1NpBonuGelJVfYQ==
X-Received: by 2002:aca:b8c5:: with SMTP id i188mr15425303oif.2.1586886905055;
        Tue, 14 Apr 2020 10:55:05 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm3528238ots.38.2020.04.14.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:55:04 -0700 (PDT)
Received: (nullmailer pid 25880 invoked by uid 1000);
        Tue, 14 Apr 2020 17:55:03 -0000
Date:   Tue, 14 Apr 2020 12:55:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     ezequiel@collabora.com, mchehab@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: media: convert rockchip vpu bindings to
 yaml
Message-ID: <20200414175503.GA25028@bogus>
References: <20200403124316.5445-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403124316.5445-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Apr 2020 14:43:16 +0200, Johan Jonker wrote:
> Current dts files for Rockchip with 'vpu' nodes
> are manually verified. In order to automate this process
> rockchip-vpu.txt has to be converted to yaml.
> 
> Changed:
>   Add missing reg property
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/media/rockchip-vpu.txt     | 43 -------------
>  .../devicetree/bindings/media/rockchip-vpu.yaml    | 75 ++++++++++++++++++++++
>  MAINTAINERS                                        |  2 +-
>  3 files changed, 76 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/rockchip-vpu.txt
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
