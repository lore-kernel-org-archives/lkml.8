Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E4FC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FC32082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586540196;
	bh=aY96hvBXNhiT65QU9KqPZPHlSXnFEDlVxamdD7LFtAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ctfeLW7GVBUtTiTbzP8fWmrouBPChBKWZWS8MyfFOCLJKjJC2ZLxn2cIWUlxU4vFV
	 BgKyN+WSnwNsyNpi47j3//FvGCA2fCkIfkHxxLXDv8lMiaezhGy3Uuc4qdAKISKDAe
	 wAyx/P0y6eRULA1HZQjMGAd5f6a2F86LMqNIMNWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDJRgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:36:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40866 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgDJRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:36:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id q2so2488335otk.7;
        Fri, 10 Apr 2020 10:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kssj1wITYRFq+YYk9S6XmdagGwSQwnZ2pdBZ58b9W2U=;
        b=umFyUYpLw848vZCa6db7JAOfh4RXh3/Jvlt/FLTvoUUh3Rb3on1+InRe16oSiU7AYN
         wrMBP2oq++AzlYXXUzbsSY2gtWZq26E6i6oYval66gFggctbWMPAZjck5L8mofqSsWpD
         v1jLzKpcQi3BMNoOrS2dfHXC0YtCdvP0lfo/IUMorYOyjf1v0jCMPNlD0w5JWnCdQEhy
         LfyoDDTbq0mZc8M3LXT8w4HoQYq8W9Nm/+k6Rznj3BfXyCXS8DVOf3N6ULVyZIlsA5YA
         bwpQQIiK/ebyMHnW3hxKPL0T5L7B+yVzCgpg0Uxqpu28qUCBLzRoS+PEDUPfVJS/8mVF
         736g==
X-Gm-Message-State: AGi0Pub1Ym/661Hoz1cBu+2Mf3u+ONxcooUDGK/+98tP25Su4/zhd7rB
        btazZJOqc5PkuP1Y7SvLQw==
X-Google-Smtp-Source: APiQypJRsXEEAdg3zxrOIYnNN3A/bp6+1SPF81f8l0UyoKWAhK5Elh8UzZPnGRQfKpe/JCDOyYnsdQ==
X-Received: by 2002:a9d:6ac3:: with SMTP id m3mr4647264otq.175.1586540194370;
        Fri, 10 Apr 2020 10:36:34 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id o128sm1536880oih.41.2020.04.10.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:36:33 -0700 (PDT)
Received: (nullmailer pid 7240 invoked by uid 1000);
        Fri, 10 Apr 2020 17:11:02 -0000
Date:   Fri, 10 Apr 2020 12:11:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH 2/4] dt-bindings: clk: sprd: add mipi_csi_xx clocks for
 SC9863A
Message-ID: <20200410171102.GA7186@bogus>
References: <20200330071451.7899-1-zhang.lyra@gmail.com>
 <20200330071451.7899-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330071451.7899-3-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 15:14:49 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> mipi_csi_xx clocks are used by camera sensors.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
