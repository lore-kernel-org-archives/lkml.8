Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE2C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8740724655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579636787;
	bh=/mFATCCA7erNK/jjMjd5cjkzWafbp7nQlD26OrGdpz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZFBqKw9lui+WC7dSOpg4yNxXVqHTWwXUY+LZZgt78Z11R8WijklAdSuK7mwwPK3YV
	 LjH75+Cx6+cxRe9EIio88p/9hMApr1KMKNae6cjPlCk47KQW9ex40e8R5OEPzUkrp9
	 F+DO3wh+k5+gh/IpfAZy5cFcc3d+Gm0t//kNVYcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAUT7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:59:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44562 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgAUT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:59:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id bx28so4254035edb.11;
        Tue, 21 Jan 2020 11:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EfnQ+XKYizwj9MPIAzRJtjIVqLk9CK3TPy4MQG1Zm3w=;
        b=UgOCiTwIms6pYn4sFVJpTUXO7eEDdEI3ViBfgq+upU+fq2EApjZ15UaqE6503CPsnZ
         VxzJflR7mduRULDIzf1ydrxHssbV0HZUgEA3CSzDmW8j5I9RX4oCBEAivee2Xk6eXeid
         WybECVmtaEM6m5G+htbQdRc7P0br3MpAQ/a+GDYAgUj06YMy4UnAIl38GxI9/i/aKlPX
         tsUppiYVb+gJs/kCqjNPdKd4ixyD8idYQ/gtfuMoTx1B/S70pS+a7JqlCiquB+7UzVHD
         /xNTin4eNaZVx3/Uom1oCAxV7Wkvg+0iE57n++ndirOiyObiD4VCtYSFoBIEY4q8sl8W
         EO+g==
X-Gm-Message-State: APjAAAUpoGg1yfDWmwS/a7YlYOP3KZMSmz6Eyc/Y5NvA2kHTynG6CMFm
        TagywbZ4SSSi5Y4oyNbc5/4=
X-Google-Smtp-Source: APXvYqzLcCMV+S8XTliS6yB7SbvmW3d8ogdAc/uE6vbbr8i0gZpt+AiMsTun+gNhCzCvuBwSoVimZA==
X-Received: by 2002:a17:906:8593:: with SMTP id v19mr5983038ejx.377.1579636784558;
        Tue, 21 Jan 2020 11:59:44 -0800 (PST)
Received: from kozik-lap ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id u21sm1511345edv.43.2020.01.21.11.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 11:59:43 -0800 (PST)
Date:   Tue, 21 Jan 2020 20:59:41 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 10/20] ARM: exynos: Drop unneeded select of
 MIGHT_HAVE_CACHE_L2X0
Message-ID: <20200121195941.GC24380@kozik-lap>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
 <20200121103722.1781-10-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121103722.1781-10-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:37:12AM +0100, Geert Uytterhoeven wrote:
> Support for Samsung Exynos SoCs depends on ARCH_MULTI_V7, which selects
> ARCH_MULTI_V6_V7.
> As the latter selects MIGHT_HAVE_CACHE_L2X0, there is no need for
> ARCH_EXYNOS4 to select MIGHT_HAVE_CACHE_L2X0.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-samsung-soc@vger.kernel.org
> ---
> All patches in this series are independent of each other.
> Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be
> 
>  arch/arm/mach-exynos/Kconfig | 1 -

Thanks, applied.

Best regards,
Krzysztof

