Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE18C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D43620675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594104581;
	bh=PHNsfQwpamJ0em4X4EGxxtcaN0JvIAKa+/CHKaRsmcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hz99CysKYiSQr/WlM09MSyPANHDNyX2e2e/4OXQcibl2CGqz98AUBT8dMFQlQCDcl
	 pVR/FIjoidUIWNALYbqqhuPwk9Bgsn3rMCELFHF30lIAWSa25Kiv/duPaH3L/IMlFN
	 9HaqdRpSsMR/oFDfIt+AU7ZUqEsNcWiGCGoiCKLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgGGGtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:49:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34918 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgGGGtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:49:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so43774186wmf.0;
        Mon, 06 Jul 2020 23:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReuA5VQaVY/VFMmqRSAHaxxKix3yxHr6btejvUHKbHQ=;
        b=ShFURUeL5o6XdWQICkc1ej+wLhVjF40Ns/AXF1d/esF+DfvxKMjj8r/fCW3KW/kchh
         iicSx27cMeAropIEsKGUVhTB+OKOLjjj9UNoPgZuoAANhc9z3nYA8a0WsH/5HApfoIcK
         Gq/53p01AIqsXciYq+pTkSsy6i51FSVASDWRXdE2WTyVGpwi1uQTJNw5Zpl6LhOdRQEp
         uhJsmG2YATbNwmJjKKSxRrDqZYaz3tQtlbTFwd0r0+LzjI2Rth8R7eoFl4veOA/o0Qii
         D8VKFCun5NR1vnqtjpWdHJa7UQCdx7rvIRc/1Es2IjCe9iiBpHqVSxNbXtG4QWrB45jx
         JpsQ==
X-Gm-Message-State: AOAM531g+KKqhqYAKicfVYN3JtIIoAGKmZWqUpGl9e7Rk6sVsh/jcRD/
        28KbTElhvsQeQ489DNnH0y4=
X-Google-Smtp-Source: ABdhPJwzjJCeYUKeawowVxH0kbFnJSkCEeak2MJl+4jXiRnTqMCEYtdPytyfVmzNDKLtluvU1c0Q/w==
X-Received: by 2002:a1c:a5d6:: with SMTP id o205mr2503783wme.125.1594104573464;
        Mon, 06 Jul 2020 23:49:33 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id n14sm27897942wro.81.2020.07.06.23.49.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 23:49:32 -0700 (PDT)
Date:   Tue, 7 Jul 2020 08:49:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v3] ARM: dts: exynos: Remove DMA controller bus node name
 to fix dtschema warnings
Message-ID: <20200707064930.GE15031@kozik-lap>
References: <20200705181754.13284-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200705181754.13284-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 08:17:54PM +0200, Krzysztof Kozlowski wrote:
> There is no need to keep DMA controller nodes under AMBA bus node.
> Remove the "amba" node to fix dtschema warnings like:
> 
>     amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Keep the alphabetical order in exynos4210-universal_c210.dts, as suggested by Marek
> 
> Changes since v1:
> 1. Remove the bus, as suggested by Marek
> ---
>  arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
>  arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
>  .../boot/dts/exynos4210-universal_c210.dts    |  28 ++--
>  arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
>  arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
>  arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------

Thanks for testing and reviews. Applied.

Best regards,
Krzysztof

