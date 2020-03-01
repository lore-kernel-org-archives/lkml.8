Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689EAC3F2D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36788222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583080264;
	bh=ERPfdKj2oIeEjhrOYyy9Db071ji3eYYbwbOcXxgReTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IwRc+POeMFVMCUIEvYyNQ3ehxLItXZqpBRGz/t5EOHm8odL99OTDFJ/2mRFgjlbes
	 gyzPEvt3szujfAadIZpPX8y/3rEr3NCHw9P/mEUQ9sg0SzKI/9eUYhyY+FItajI30a
	 4Mz/LYt9tY9HAmaGFRHC+pnMBB+XyDfpVqMFeIlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCAQbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:31:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38267 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:31:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id d6so4156869pgn.5;
        Sun, 01 Mar 2020 08:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OgwwkseIQNrVKk8KiHXZ8vpmf+IGjcntZ9v/XR+cspc=;
        b=WHni1f58kR5R7IV7FWXcSSB/8Dc4q5QRdIZoPhxkZ18hTbr7qCR/HP11VBOrhm+EZZ
         KIKHag71ZZbxP9+cbUyvi8sqnsgk/F9HJxPtgvuRWBV0CO6+blasI0Wm3Mz6WSv2MhLy
         E/EQSQApyPOgD5jQ5gXcAAllGJ/+W9Kfvbm8eRUdeemdZnhMWNZliHZo/QmUp1Kudfwn
         oJiMGDHxnDdJ508sa/NiUjgxfNosTBiwj/KBBVXCpn19AVFQU61fQ1qzg3UWWNQ5SROa
         flojmOGhg+JcQyQNJSKg7MUon/8cH1oFWQwdRQayOYc1AbVxgQvz3uKlWW+dJM4g8hul
         ODug==
X-Gm-Message-State: APjAAAUkgQyRhJOWmV5qUIwHAjcWwfeIt1Stu83rTIqL0fqrYg+H0/cd
        7W9Hm5Uu6mIiPqKZA8Kp/lbnTOjQLUA=
X-Google-Smtp-Source: APXvYqw8TrEi3h7yP2TvYfqIbWT7/xKtnJnzOX9Ojyo+t22DL5l6xGnwtZtgzpYTuMSk2E1KmTpFaQ==
X-Received: by 2002:a63:ed4d:: with SMTP id m13mr15016563pgk.350.1583080261654;
        Sun, 01 Mar 2020 08:31:01 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id p14sm16754585pgm.49.2020.03.01.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:31:00 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:31:00 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 6/7] firmware: stratix10-svc: add the compatible value
 for intel agilex
Message-ID: <20200301163100.GA7992@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-7-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-7-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:00:51AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add the compatible property value so we can reuse Intel Stratix10
> Service Layer driver on Intel Agilex SoC platform.
> 
Acked-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/firmware/stratix10-svc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 7ffb42b..d5f0769 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -966,6 +966,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
>  
>  static const struct of_device_id stratix10_svc_drv_match[] = {
>  	{.compatible = "intel,stratix10-svc"},
> +	{.compatible = "intel,agilex-svc"},
>  	{},
>  };
>  
> -- 
> 2.7.4
> 
