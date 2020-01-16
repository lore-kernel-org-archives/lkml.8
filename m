Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE59C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A212075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1/1y8yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgAPNVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:21:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46547 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgAPNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:21:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so19079891wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9a0ta5lrGoeyoipzLe+HUzaZ0nihQnaveFNO7wTkFmU=;
        b=U1/1y8yQqO9X76PyOApBQmpCTQJYJ9BIDbApVLQFLDxdVbW/Ipo+lVWU1dJRCbumPy
         X/N16BSTfsfvTNsV2LSVJxYRZ+LNvvFL5hcIr0Mv2lZTv3c1lioD/HUWM6oP0xNUnZHZ
         87rxUSfLZ00fMH3si7H8addT8iWSze3JxklBT79g1FoLOzuC9UQIJXH5bjkvUV4xYrb/
         ksAs8C4TJhI8H4tDfbSddWQnUzAs2GeRvafJvX2yCbSOUowLAUM6L1mrpfDPndBZgPdz
         UngCkSpdwN9bs6POe2inK/gmmj+JNT1yItaJEzgUN/dMhWxkp2+0JWcvBGTpShHVufRM
         SmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9a0ta5lrGoeyoipzLe+HUzaZ0nihQnaveFNO7wTkFmU=;
        b=XW/7XiZmtZlxHxOwFPYUFArG4oY1psNk0CDXXXFR1CmY94ohVjF4PWUcJk5v+1IPC0
         bZPZkRS/m/8gg36sE3qR2v6Qe7trKvECl7CvVyBP/JeIi0Uab95FD1qgSI7Ts4384ooo
         f8xiSlgteMCZ27XWIL9fYXtQloJYvQCIk6BE7c2WIiY7AJXNowIzmTjDOMW1nGExjl7i
         BnzzKAUHYkCY78mdPDnGGjfMLyUQjaFaMus+AO0ea0KF75DWZI63qHJQ9kC4QVY3Qhoj
         5M/XLHw7IuxXmTcf3ixde+c0HDmYsSa3v9KV2YT4v388VxMXs9hFVrQ1PtjAYs3xwIRJ
         XHlA==
X-Gm-Message-State: APjAAAUNK8Uu72MZXVuNlrctUFH7YywZXBW6RfoosaWPT659wSbJ6+Y5
        Nta+H3TgbVAC0zI0yIHuzt2ZArnFb4g=
X-Google-Smtp-Source: APXvYqwc1dHs1dJ3fhG24TLjVHnEua2OCpacoAPAhYpBReFWPs3xxHs2J/gatR8HH87kqOmDjImhHA==
X-Received: by 2002:adf:e591:: with SMTP id l17mr3085364wrm.139.1579180893816;
        Thu, 16 Jan 2020 05:21:33 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id d8sm28561759wrx.71.2020.01.16.05.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:21:33 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:21:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] mfd: madera: Wait for boot done before accessing any
 other registers
Message-ID: <20200116132148.GI325@dell>
References: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
 <20200106102834.31301-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200106102834.31301-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jan 2020, Charles Keepax wrote:

> It is advised to wait for the boot done bit to be set before reading
> any other register, update the driver to respect this.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
