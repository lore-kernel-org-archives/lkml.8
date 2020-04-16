Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3899DC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148D9206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5qSb9/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbgDPCyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389177AbgDPCyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:54:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:54:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m21so981012pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UPEvNIRz7ZVEdgAP3PT5wmJSvqbFeHH3Q2cLjev+7EU=;
        b=V5qSb9/3I81zEFC3J3Zo6ImfMlBoyVDJdCfyJg7kJ+fJgsWtVDoSrO03u/AwVptJPi
         UH82vNwc9Avb1xQLJDidI8/U1UKLQ0FGTSfxZAeulj6MahNNkd3qgFwhNLquWj5y6nYN
         PorlQGm2Cur/h3Ol1HomoSLqVhzf+EEdEhyRQ7V5NGkDSJtT2P6Nok8pXKMfrQnaPqJW
         VxPWUoQPoRDILY1VKuJr+e5crXDhb5LZLPK3nLKhOiNG80ukMfemG2KuxDWL/YI5S972
         xDqPsFcObr1DAGmeOruRZOi5urAVlQHzTyC2FoA1cJ3uK2VsQzHzwHLFSH7jHiNvULuT
         rcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPEvNIRz7ZVEdgAP3PT5wmJSvqbFeHH3Q2cLjev+7EU=;
        b=GyMDQqCiUkhJOfArTwDKqqIKJ074GY4Q0QQN2QZb+YjmoYXmVW9US6kXCUftXja0dC
         YmOie4dHufBIbo2D5PHn39HEX9UYh9h5NNdy9EItfCR3UNQ71mIC1wFrCsCmW2eheS6Q
         jdlcaUIor+1IV1nhg35Sg7e1fXJMFVmVYmg0oYsKYOYv1OxWoo0Z7586D8BnnYBITYe8
         lVxBDeFsJfmT8vxhTPMYh+GvnjHv8BfSfxOuTACj3Xrj2BEcMe/E189SDJa0f9GLT0bn
         V19xp3QVi4uEH/gIhdJJJNdYieNTz53RQjlMu1I+3oPcuF84MLjbbJ1AuCPGm/MGN1V+
         qbEg==
X-Gm-Message-State: AGi0PubV/7kaiXTjYrQhV6vLwnZO/iFbNZ3w+exOQAHZionpK0XgeKtr
        x0dGfYyHAXjPA70pNLjehR4=
X-Google-Smtp-Source: APiQypKEQwGZlOW444FMmTm23Tk7d2s8RDsn9ZCVRKhKMJHAzOLuacSviFTQ8IhjRwvwgF52kpoXNQ==
X-Received: by 2002:aa7:8486:: with SMTP id u6mr28588066pfn.106.1587005641579;
        Wed, 15 Apr 2020 19:54:01 -0700 (PDT)
Received: from localhost (181.56.30.125.dy.iij4u.or.jp. [125.30.56.181])
        by smtp.gmail.com with ESMTPSA id x70sm14793067pfc.21.2020.04.15.19.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 19:54:00 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 16 Apr 2020 11:53:58 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/3] ARM: bcm2835: Switch to use %ptT
Message-ID: <20200416025358.GC30641@jagdpanzerIV.localdomain>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/15 20:00), Andy Shevchenko wrote:
[..]
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index da26a584dca0..a3e85186f8e6 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -182,16 +182,10 @@ rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
>  					RPI_FIRMWARE_GET_FIRMWARE_REVISION,
>  					&packet, sizeof(packet));
>  
> -	if (ret == 0) {
> -		struct tm tm;
> -
> -		time64_to_tm(packet, 0, &tm);
> +	if (ret)
> +		return;
>  
> -		dev_info(fw->cl.dev,
> -			 "Attached to firmware from %04ld-%02d-%02d %02d:%02d\n",
> -			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> -			 tm.tm_hour, tm.tm_min);
> -	}
> +	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &packet);
>  }

So can this be instead:

	struct rtc_time tm;

	rtc_time64_to_tm(time, &tm);
	dev_info(.... "%ptR", &tm);

?

If it can, then I'd probably say something like "can we then just use
rtc_time64_to_tm()"?

	-ss
