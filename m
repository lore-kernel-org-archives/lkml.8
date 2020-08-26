Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE9EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55902078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJKXUCKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHZSrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZSri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:47:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A50C061574;
        Wed, 26 Aug 2020 11:47:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so2806504wme.5;
        Wed, 26 Aug 2020 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D57dolGTFX8v+JSJMimsZsPo892At7jmlTSKaIouZRc=;
        b=WJKXUCKu7ELeDjPAWaUvA7KJ8xKQvMDlENGdkbYjPxuoV7aNFdf/3m0u8DIsj8CVcK
         TXxuqIS1lQiQ6NBKt6MYSbv9FLUtL3PRg4UYZamlgpNBp4wvqurPMHfy7fQTFBKwG1Wr
         PYWX0mMWb2lGy//v4OHgIHwiz3N/7FbsBz6UBqKPBixjpJN2OyIlK9AAT37WqkcMH0bH
         qOa9phXnTQ0UhUTr04shNijrGcKSpzWI775t7JM80P4SP09kesYqcx/uvZAXOUVasFXY
         tDsxy64RmwUewlfbFSk+Sr0eePRstqj8/C/BwUtECATgFs2GnM8FF/iJtFlLVsHmQ9Le
         otFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D57dolGTFX8v+JSJMimsZsPo892At7jmlTSKaIouZRc=;
        b=JOkNJqgBgrbLgtKB+ZiaBrfAVMLPM+xgUsl1lVhutpIDis3KR+b7vHaz4mvWy0eFgJ
         EzjAOFkNvfmU7OYf2dHM11poEVZkXqYpw07ep7cF7nJtr4UX8aZdwZ7atnPUGsVVClx1
         YpC7vxnZZfgY5HZMajUzfcXle072F7KXiBG8jHpACBPd6hGQCzJNddPsnOVDkAX7MG3U
         ZDsToYBrP2fBthxbNlfBSadOAbD4qkhsT+D7KmAtv02PdXXL4c5wUDzCDrwHitmlR7AW
         qBBElOX+6yAveFLoDV1n/ie6BTVg8Ni6unk7ETre6F3cMQ505LhMieN9X8Sh5WurrXNQ
         dX2Q==
X-Gm-Message-State: AOAM531j+pftSe7nfv+tZtaRnsDTSMCNhXFJmBqzoqdHzORmW6/qnUv6
        wnz408eqe47IQ/kWjlYvTGxcroX6L8w8GC7r
X-Google-Smtp-Source: ABdhPJw69AzzA9zfGvv9pxDBZurdq/t6BT1gbGPFx5KNuGtVDs59OvggbzjBc1e0qQkEU8q87VoV8A==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr8182119wmi.48.1598467656114;
        Wed, 26 Aug 2020 11:47:36 -0700 (PDT)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id b131sm7796870wmc.8.2020.08.26.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:47:35 -0700 (PDT)
Date:   Wed, 26 Aug 2020 23:47:31 +0500
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     b.zolnierkie@samsung.com, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: fb: Correcting the location of
 FRAMEBUFFER_CONSOLE option.
Message-ID: <20200826234731.3a9d0da8@a-VirtualBox>
In-Reply-To: <20200824145155.42502-1-bilalwasim676@gmail.com>
References: <20200824145155.42502-1-bilalwasim676@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All, 

On Mon, 24 Aug 2020 19:51:55 +0500
Bilal Wasim <bilalwasim676@gmail.com> wrote:

> fbcon doc mentions FRAMEBUFFER_CONSOLE option to be under
> Device Drivers->Graphics Support->Frame buffer Devices->
> Console display driver support->Framebuffer Console Support,
> while its under Device Drivers->Graphics Support->
> Console display driver support->Framebuffer Console Support.
> 
> Correcting it in the docs.
> 
> Signed-off-by: Bilal Wasim <bilalwasim676@gmail.com>
> ---
>  Documentation/fb/fbcon.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index e57a3d1d085a..a7b487cba307 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -20,8 +20,8 @@ A. Configuration
>  ================
>  
>  The framebuffer console can be enabled by using your favorite kernel
> -configuration tool.  It is under Device Drivers->Graphics
> Support->Frame -buffer Devices->Console display driver
> support->Framebuffer Console Support. +configuration tool.  It is
> under Device Drivers->Graphics Support-> +Console display driver
> support->Framebuffer Console Support. Select 'y' to compile support
> statically or 'm' for module support.  The module will be fbcon.
>  

Can this simple patch be merged? 

-Bilal
