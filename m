Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A89C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BD12080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585690221;
	bh=6b/vAtNS66kDJ88IVr2u+L3GVzgM3jxzSfg9R7/PmXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2dRNfI991W7UXxktzkAGpQb9/TWslATiFWW9uC8h1hljWOigLsWple6wfnSPewi0U
	 z5fYx5OrJ3OyMzdbSxTePBJckX1Eib5cLz2DtqT9A+5uWrVK0BjFwfDAfQtHhsNz/7
	 8XFvB6fj0A4QrkAta53Y87JgfD5x3++844vew7Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgCaVaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:30:20 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39073 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaVaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:30:20 -0400
Received: by mail-il1-f194.google.com with SMTP id r5so20975296ilq.6;
        Tue, 31 Mar 2020 14:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hgde7gIab0A9AJlPfRAbxdOzxdpC6QBuQyWWHDDG1s8=;
        b=CKHoRIF2X/YCHvUhyIS/icQUe8hdGZlIlhy7nu/SKlrvk8f8tfn373L7A6/OgdF+h2
         YYid2ZlLix8UP+0+eBQ5OptQoKJW2GAk79HFp2mLLLL7+xJ0ndufXs8k7865xXtPwatX
         daq3/wrDpalBVTJYnPx5sOwbTtEYXRgUPrxX4sYoWxMgEpzMJucdCJrfwHrP+681sAVX
         a7naRvJMDXy4pV203FN9NZX9wMElqsbgLSnG4ocSYUSJMVC7wjXNLqifIXiNDQCss1rN
         fVzxUAJP2jkrj+iyYijouHRERXWeBbe3NwFhuPVVfC8jOtjP+80feWOUpL97Su3tH7Ib
         bBFA==
X-Gm-Message-State: ANhLgQ137bWauT6Z/h0QDcV0OA6e4ACsHJ3eYXIdPJKI6annDpqrd6PE
        ydPQl4xC89WIwuzki+AX1g==
X-Google-Smtp-Source: ADFU+vu1BYo0UPKQXSA6GKj/6abEkzFRO5nrM14lwT3cYsl1D0tV1MA1I6gmRcQjxC2STIxV/8Y8gw==
X-Received: by 2002:a92:8f81:: with SMTP id r1mr18614381ilk.51.1585690219360;
        Tue, 31 Mar 2020 14:30:19 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q17sm23336ilk.48.2020.03.31.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:30:18 -0700 (PDT)
Received: (nullmailer pid 32705 invoked by uid 1000);
        Tue, 31 Mar 2020 21:30:17 -0000
Date:   Tue, 31 Mar 2020 15:30:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: convert rockchip vop
 bindings to yaml
Message-ID: <20200331213017.GA32448@bogus>
References: <20200325103828.5422-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325103828.5422-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 11:38:27 +0100, Johan Jonker wrote:
> Current dts files with 'vop' nodes are manually verified.
> In order to automate this process rockchip-vop.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changes v4:
>   Change description
>   Replace compatible oneOf by enum
>   Change interrupts description
>   Remove resets minItems
> 
> Changes v3:
>   Change description
> 
> Changes v2:
>   No new properties
> ---
>  .../bindings/display/rockchip/rockchip-vop.txt     |  74 ------------
>  .../bindings/display/rockchip/rockchip-vop.yaml    | 124 +++++++++++++++++++++
>  2 files changed, 124 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
