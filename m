Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4304AC2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E2D206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589321449;
	bh=D3s/6Min8YqluMCtRz9aWH3YI8Ffjk4z/3wq6tgXPeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AtoYDM08QiES2mg10mLONr50S6t5G2AsMW169tpT6oztiXEKXVyeNCABL+T/31hot
	 NjUjObHdyqs2fMJ1ZUlTjDCvY2o67Q1h7IX4nN0E0EU+0SjGQKd/MU18EbaytTTVlr
	 QWldH7o6dEiyj7NY/8VAuR1FGcHkhINyaknKmuig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgELWKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:10:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36121 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:10:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id x7so18772085oic.3;
        Tue, 12 May 2020 15:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hLS7bp8T/22TjzypF5PGmB5dEY+3krp0hxJHV/JBg7g=;
        b=asYoPteozYKAMBMUJJfd7+z2MHI5v5Xzidd4Nr3VbAXCWWLfA6pp34ia9J8fHJ3xPl
         V79dua/bcLBJ3gMuzqidPmkyx/ykeqiUYoXr6Y8HOlb4ypuGoTcourx0u1jVF5NyitDx
         xTETKzwOAzka2FTLPR+76SnAS2BhqEzlsipJzQgq3uzWsvBtSKApk6/23syNjJu3jzyg
         HZC2iDNZNpeeCZPNbAaknAoRqmRU8V7Qb8gorFLHtO85P2xhOFHrBAYWwJlYtmis/tsh
         sT3mokldhRy+EMeJ4t31oLDsAF4IruJRUXAVhyvDUt1tAgR8c92TqvgXRQCHeUA7yF5d
         lQ+g==
X-Gm-Message-State: AGi0PuY/GcneDx0wAGo287nvGJh/bRjP5o/u//263wrt3lRovoANiQkd
        8yznj2iaGW5gRe2NYTQY/g==
X-Google-Smtp-Source: APiQypKGf4qEmv6HKFeAwKeNvcyY2qEuJmES4jhc+TZ+TkY+0koHDMAcOv8WvrCsD+XIzcg0qyyu9w==
X-Received: by 2002:aca:d9d7:: with SMTP id q206mr24081650oig.134.1589321447426;
        Tue, 12 May 2020 15:10:47 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h9sm1222216oor.21.2020.05.12.15.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:10:46 -0700 (PDT)
Received: (nullmailer pid 24273 invoked by uid 1000);
        Tue, 12 May 2020 22:10:46 -0000
Date:   Tue, 12 May 2020 17:10:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     mani@kernel.org
Cc:     mcoquelin.stm32@gmail.com, robh+dt@kernel.org,
        alexandre.torgue@st.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/6] dt-bindings: Add vendor prefix for Shiratech
 Solutions
Message-ID: <20200512221046.GA24216@bogus>
References: <20200503154215.23654-1-mani@kernel.org>
 <20200503154215.23654-2-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503154215.23654-2-mani@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 May 2020 21:12:10 +0530,  wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> This commit adds devicetree vendor prefix for Shiratech solutions,
> a SOM/embedded board manufacturing company.
> 
> https://www.shiratech-solutions.com/
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
