Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48B5C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1D120760
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 18:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gy42z+6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgF0SWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 14:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgF0SWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 14:22:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ADFC061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 11:22:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r22so11802201qke.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wknXL/NZZBsk//od0+ACYvlDvjjEXtFODMTp/oomwis=;
        b=gy42z+6cy8ul5JraOk9jo44rONTJWYOz8zCY+b1cDGhklC9x1j9JQleDZ+cDg9XKIz
         kOLCc87SIQaieB795ZhReKG4MCPphuoFynjteK/os1Ff9I7E33uDizZD3UmQB4rk8vUB
         p3ucSkV7E4bPsKeajNlQ/T66NtHKQKCePNhLfDa4jkTinDcvVk41/7hnQ/gwwBftf8At
         MhFNLNGvzZHPnvwyUdzdhwDbJKblAAu5vuTFlx2ogyCElXnHjMiePc2f4fe6GwVYCcDv
         OCn1r4Gm1EIpUvW1CXvE3DEhKg7ed6aif/tw1n8Bh1mITbsMrH8uvDMQb8KDCPJk+H93
         Scsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wknXL/NZZBsk//od0+ACYvlDvjjEXtFODMTp/oomwis=;
        b=kV++5sV2yfnAQtZ6mDFIe6kSsnHV3euIRyuRbNtKmqiGs9mDHN2ROqqbb9V8RuehPy
         CPvUZXmbZwb4ZUBCg2steE8aJ1gaj+lKv43jFEAfpvvOK+nmY/bsG3Ct+SRF2jfsVUj9
         V01GSvH1RCp+uO9TeQmdonEsWWZbQ7oHV44l3LJ/F50ZsvY3S1VJRPf8Vb4XkPAa2jJ5
         qDJZp04t5PzPfihR2G6hOlq3uFiZUhZnw6atvSMsBCtQPlWNK2dS4gJbsGwSmZPO7ikD
         iuUY1podQmlN623lDojIDS2LSJlct0WCVeEtuOLqzFCCxnKn701+WY5+mmEH9ZbYgcQB
         ngGw==
X-Gm-Message-State: AOAM533wrYesi4GbKmIMQyMTqsMcxnsD9+J1yECaF3D4p3QpiguyA+a+
        uvXLk85+RGKOyDZ1zZ90ITgE7g==
X-Google-Smtp-Source: ABdhPJyMXt2Ydo4dC6F+leoChRx/t4i2wi/giZ/uvjrThjMGzcC5n4fP3Y0B6gfrNjz/A5fawt1+lQ==
X-Received: by 2002:a05:620a:1275:: with SMTP id b21mr8233352qkl.4.1593282149751;
        Sat, 27 Jun 2020 11:22:29 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id q5sm10310519qtf.12.2020.06.27.11.22.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jun 2020 11:22:29 -0700 (PDT)
Date:   Sat, 27 Jun 2020 14:22:28 -0400
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Pavel Machek <pavel@denx.de>,
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
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4.19 182/267] spi: dw: Return any value retrieved from
 the dma_transfer callback
Message-ID: <20200627182228.GA23327@maple.netwinder.org>
References: <20200619141648.840376470@linuxfoundation.org>
 <20200619141657.498868116@linuxfoundation.org>
 <20200619210719.GB12233@amd>
 <20200622205121.4xuki7guyj6u5yul@mobilestation>
 <20200626151800.GA22242@maple.netwinder.org>
 <20200626200710.GK1931@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200626200710.GK1931@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Fri, Jun 26, 2020 at 04:07:10PM -0400, Sasha Levin wrote:
>On Fri, Jun 26, 2020 at 11:18:00AM -0400, Ralph Siemsen wrote:
>>
>>So the following patch is needed as well, at least in 4.9 and 4.19, 
>>I did not check/test other versions. Mainline does not need this, 
>>since the code seems to have been refactored to avoid the 
>>duplication.
>
>Could you add your signed-off-by tag please? :)

Whoops, for some reason I snipped it out... sorry about that!
Here it is again, with the commit message tweaked for clarity.

Subject: [PATCH] spi: dw: Fix return value of dma_transfer callback

Earlier commit "spi: dw: Return any value retrieved from the
dma_transfer callback" changed the return code of mid_spi_dma_transfer()
from 0 to 1 in drivers/spi/spi-dw-mid.c.

A similar change is needed spi-dw-mmio.c for mmio_spi_dma_transfer()
function. Note this only applies to older branches, as mainline has
refactored the code to avoid duplication.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/spi/spi-dw-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

