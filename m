Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E7F2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593669681;
	bh=hi9Y9/0kmE7oL+s9W44L8V1BELNv8ne95GsOncSLQgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zWUT+wkyN3uvAFZlw6wiT2hVKfykVK2uFjy0iJbuZkh0oFtvdLIGvtEUIbG1+BpDF
	 SXGyT+b4bn+YS7QK76zvIvw1fgBF8rdvpAeOzjBjkiBd0p+HERisdhc8R8lul8gygd
	 d03Ync10I20MQ4+WeKwLaLynftvuxvt4jCav9e3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgGBGBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:01:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33647 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGBGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:01:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id h28so22353723edz.0;
        Wed, 01 Jul 2020 23:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lh8nOJbCY3dntMrTsg/+G+LQq9DAGDc6JO+HAJfI85o=;
        b=Ce3r43SloDlJ5LMaa/k+5ABrs3d7Pu6Uu1Ug54Nd3Qhacy/JSAlpTRJ+4wfQKdzxE7
         9Q79lYBylxeBXWSvI8zc0Dk+Ig3ooJoaaz6YmRUSTTInyfwheG7Hpf0FNI9w4cU41SPJ
         WfiRRbU+7PoYFdp6uj3tUEzaoPF8a7yAC7aVLdIrh6uSqx3ZQJgAFf847WG7HMiFcVCT
         PzrYvc3QY2IAcoyBi2J8o6q3NfKY9MrX8G/zwZZzuTNlYEIV5oCsgGVSCVeHyIx27eS0
         YlgqDZRl5p/zs+09riQ1TA3OlKPIW2TQKI4B3CTMeQjXg5fUnkh3dtPPheImO/ALBU/K
         G6LQ==
X-Gm-Message-State: AOAM532r4B7CnzoaYyazLLbTxkJher2slrBj8gnVtQaJdsc8p5Pl7T2v
        jqW6+CaPNR7KEi7j/E3l0X8=
X-Google-Smtp-Source: ABdhPJytqNBKyu/7EesZQUeT1QVMje4jzUxwKQOO1ElwidZDiWnDP+YK1VCjC1i7ybpkImxk+ckfUg==
X-Received: by 2002:a50:f9c9:: with SMTP id a9mr34533109edq.89.1593669677760;
        Wed, 01 Jul 2020 23:01:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id r17sm8046146edw.68.2020.07.01.23.01.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jul 2020 23:01:17 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:01:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: Align DMA controller bus node
 name with dtschema
Message-ID: <20200702060115.GB4175@kozik-lap>
References: <20200629204442.17336-1-krzk@kernel.org>
 <CGME20200629205541eucas1p16e9c5848ed7ac84ca87c045f3a6f928b@eucas1p1.samsung.com>
 <20200629204442.17336-3-krzk@kernel.org>
 <3c1eb3fe-8eef-1f91-ff4e-3081a871fc80@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c1eb3fe-8eef-1f91-ff4e-3081a871fc80@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:34:52AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 29.06.2020 22:44, Krzysztof Kozlowski wrote:
> > AMBA is a bus so name the node with DMA controllers just as "bus" to fix
> > dtschema warnings like:
> >
> >      amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Do we really need a separate 'bus' for those DMA controllers?
> 
> IMHO they are not different from the hw perspective from the other 
> devices available on the SoC. A separate bus is a historical thing, they 
> work fine when moved directly under the 'soc' node. The separate bus 
> only mimics the way Linux organizes its drivers. This comment affects 
> both ARM and ARM64.

Good point, other boards keep them under SoC usually. Thanks for
feedback.

Best regards,
Krzysztof

