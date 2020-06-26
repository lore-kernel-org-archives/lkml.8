Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD910C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9E420702
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxn6Zawd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgFZPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgFZPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:18:03 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1CFC03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:18:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z63so9054534qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0S3+/lb8kTzTF7FG+GaZo7TfixBDNtLBveukGJJz1OA=;
        b=pxn6ZawdwN+2yWmx04djJWqqXdCzmPwgL9uoMrdcjCFQHtH0kzj7+OCDwo0NOmsffI
         9MOHjqXADtuM6Eonqp4mO8OVha8dQsqVFHr/fsbKSPzfb4VeCRa4Y/AvLZD/8V0uU5i/
         rv7kDng9weKxmLnpPFfwzd+LfObFbsB8K1spR8cRZCUarMngFTeSX5Ld3FXEvhPHGkUk
         LU2sSRqEKa84G2P38oJ3kPczTjj+h65ZLaeQKCHPmv2RIhcv8wLQ4cFpausDgh4rvWK3
         Xu76inpSAyo5OgQIz5cRPF4yA2kxbxvNbAD9bugtRDyE8P2IpIUbA7E40aEAZewiExcE
         yOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0S3+/lb8kTzTF7FG+GaZo7TfixBDNtLBveukGJJz1OA=;
        b=g8j9HO15oyfDw7dDUU+KiUTmZgJ8svvunMlzMBAUfwjfZBH9B10O7PXYiHWxj5hBep
         pAxW+xGI8NZ5ABOcp/627dUuQZb2/ytCvfYT81hvxVMSCWPYjQ/71TmkHg4KVvRT+f1M
         A3J7tQjrOu03+taukhTrek9zmmEvP02lohk0x5GesDfm9Hacw3ooPzwKnbvLSdcS+JgB
         ySLnQ1iol8n3BkawdJqW939ZAG9fOnd7UMnck6i5dFmunY3Wyh/mzW4iJACrtLfVh5zq
         yr7SC8+IK8QQLND5LK7QbHWSYuGKsxHFxoJ7e6VNpFPoY4m2OjVOZ4iK0uSS8hycVsfL
         8X1g==
X-Gm-Message-State: AOAM530i2N8SrpM0zQKQpAQNIoSpQER2SOYICRrAD6FZzc04bfCK+r5V
        hXVUK5a9+5vnGW0p1U4Ne2DPMA==
X-Google-Smtp-Source: ABdhPJyxJJEEnnxsuDhIU/toh+dHV3q9cCmOXXFJqgFN0cKJYvcOuPUsKnfNvqaMB58IcRJE4TEmhg==
X-Received: by 2002:a37:7683:: with SMTP id r125mr1013064qkc.39.1593184682285;
        Fri, 26 Jun 2020 08:18:02 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id 79sm173640qkd.134.2020.06.26.08.18.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 08:18:01 -0700 (PDT)
Date:   Fri, 26 Jun 2020 11:18:00 -0400
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Pavel Machek <pavel@denx.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 182/267] spi: dw: Return any value retrieved from
 the dma_transfer callback
Message-ID: <20200626151800.GA22242@maple.netwinder.org>
References: <20200619141648.840376470@linuxfoundation.org>
 <20200619141657.498868116@linuxfoundation.org>
 <20200619210719.GB12233@amd>
 <20200622205121.4xuki7guyj6u5yul@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622205121.4xuki7guyj6u5yul@mobilestation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge, Pavel, Greg,

On Mon, Jun 22, 2020 at 11:51:21PM +0300, Serge Semin wrote:
>Hello Pavel
>
>On Fri, Jun 19, 2020 at 11:07:19PM +0200, Pavel Machek wrote:
>
>> Mainline patch simply changes return value, but code is different in
>> v4.19, and poll_transfer will now be avoided when dws->dma_mapped. Is
>> that a problem?
>
>Actually no.) In that old 4.19 context it's even better to return straight away
>no matter what value is returned by the dma_transfer() callback.

This patch changes the return dma_transfer return value from 0 to 1, 
however it was only done in spi-dw-mid.c func mid_spi_dma_transfer().

There is an identical function in spi-dw-mmio.c that needs the same 
treatment, otherwise access to the SPI device becomes erratic and even 
causes kernel to hang. Guess how I found this ;-)

So the following patch is needed as well, at least in 4.9 and 4.19, I 
did not check/test other versions. Mainline does not need this, since 
the code seems to have been refactored to avoid the duplication.

Regards,
-Ralph

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index c563c2815093..99641c485288 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -358,7 +358,7 @@ static int mmio_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 		dma_async_issue_pending(dws->txchan);
 	}
 
-	return 0;
+	return 1;
 }
 
 static void mmio_spi_dma_stop(struct dw_spi *dws)
-- 
2.17.1

