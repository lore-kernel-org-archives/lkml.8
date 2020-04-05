Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73317C2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2952076E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586051201;
	bh=g5QI1R7ozqSXKBwgsJXIODnVaFbqgNG18jl6deVExxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tijG9jEDa87mP12i1y93IDGbWoqFwq8gfTKjVksO3ZWsaqmqyFSluKriv2aHV8Skg
	 o9R9fwtqyLH/1uvb8EwhcTMliZqxC1EZj+Jkk+eai0u0ZhI8t9+R1pRUcwZKUxnAAm
	 /GfeDtZtx/AdhqEfASL3DnYXQlqIi3iS+YSj6eUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgDEBqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 21:46:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34464 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDEBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 21:46:40 -0400
Received: by mail-io1-f68.google.com with SMTP id f3so1899894ioj.1;
        Sat, 04 Apr 2020 18:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3Lho6K97w9WRhTNkYjAbrrHD3p1YY43+L3EXIQ/pEE=;
        b=F81WVMCKBuijZFO/ScW2BKNTC+jK9wI79V/80xF9zUqEOgslVfMlw/xcGaFUaR2US+
         O4GoLpTy7QpdSYB58l8tHOXQaDR2V/tmrjlpsGjGZC/UujqxnITsrXq8GDP7zlsNXWoC
         Ta12/InJ/c2HqpR7oqxpwARZDEyZO1J1bKyNhITX/0068PG62vtyJPJi0BNTE+iodf6q
         WCmwAe/xuVTjl7zm+eo8OqJ0fkoawYE1O7fMD7kmQETo0p8xM1LVZBfyUClTFssXmDJO
         QBZ5cQWTqC/b0YIJZV/K7ypUxEQL+ebEBM1iBli8O2VlMp3wmloRBc1tiLWA4Iz15wIr
         a5xw==
X-Gm-Message-State: AGi0PuZTcbNpwtVkVOCOoD9nnQqVJcxKB7sSjyX22bOnR4u3p0V3GhSq
        37L5KQcd2QB9VbWNj1jOYw==
X-Google-Smtp-Source: APiQypLelG1J8HkSU6o07wdDIyBKJ1mnyMJZg5hNJDP5+FYrwJNR0cE329KQNjmyIDhH876b4/xqBA==
X-Received: by 2002:a02:69d4:: with SMTP id e203mr3336713jac.12.1586051198975;
        Sat, 04 Apr 2020 18:46:38 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z17sm4470359iln.34.2020.04.04.18.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 18:46:38 -0700 (PDT)
Received: (nullmailer pid 11327 invoked by uid 1000);
        Sun, 05 Apr 2020 01:46:36 -0000
Date:   Sat, 4 Apr 2020 19:46:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: phy: renesas: usb3-phy: add r8a77961
 support
Message-ID: <20200405014636.GA11271@bogus>
References: <1585301636-24399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1585301636-24399-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585301636-24399-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 18:33:56 +0900, Yoshihiro Shimoda wrote:
> This patch adds support for r8a77961 (R-Car M3-W+).
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
