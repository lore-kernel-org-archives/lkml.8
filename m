Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67626C55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A95720575
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587415672;
	bh=WqjuUPcshkg1Fl5UeaP99Bk/vgsChhwPDzeZB2nrP0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Li85pmZHHz6UpxqymC1YdO5tvMJ2Plhr9+U8kclvo31paKINiEmH5FvCiYmsZNw+q
	 7QtQnGiR5R/Zunt5gxHMx3X3vfWMhvsWZVp0lDRD/DSEBOEbAvZ3+spZa0n/WdO2Cs
	 K0dzGduIugEYtufYVQTMhqaJJTJLqWtSkHJRL8hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgDTUrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:47:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44163 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:47:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id j4so9364255otr.11;
        Mon, 20 Apr 2020 13:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=03daUD91BmLRPkQX2g3OkI4KkmbbVSqJ0/5HyTXhZcc=;
        b=qqYtHF7D7hJOvUHjPrpQpuGiq04khtT2zl5OzGwrBqLOCUWbYs4hOCHiLf00pEXk9G
         6TqOmBlVzn6JfJPn071k5pmsBImb1jDrVxT226Ab2ou6KHCcuWJO2oEevzslHX/LI6wD
         VKoHRlH+GBrFQJPb+RAXaU/t4cqD8P4WYhVkg6Ozn5JLFH9coROdY6QXdIAEeRDVdnuB
         ONEyEa1QtC2GZq6nZoTH1R85yXdyr6bqWgMuRlStKpKwPcxcVXcIgTmtkXQxv87ZsIy5
         RPOctmCGKCEJSMSO4wMcnjW/4lr5xe/AEeqMA6Fe7xtwfVMYDkb+DATdb9OEKprPZFVX
         Ph3Q==
X-Gm-Message-State: AGi0PuZuJGFrIsP8z0tlFt/DuMuqY3R3DbO0Gscw6bC5YeN35td70OEC
        pxw9kimhDP5UJ9CpmKflHB8rT4o=
X-Google-Smtp-Source: APiQypIc3Svb/uK4rCWU7hsCX+MGdL5CagM45jjt3R28s7oM272csJN2xAQ8XONrOXLQhKLdKOBmZg==
X-Received: by 2002:a05:6830:3110:: with SMTP id b16mr4600911ots.68.1587415670216;
        Mon, 20 Apr 2020 13:47:50 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p13sm130461oom.34.2020.04.20.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:47:48 -0700 (PDT)
Received: (nullmailer pid 2136 invoked by uid 1000);
        Mon, 20 Apr 2020 20:47:47 -0000
Date:   Mon, 20 Apr 2020 15:47:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>, od@zcrc.me,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/13] dt-bindings: timer: Convert ingenic,tcu.txt to YAML
Message-ID: <20200420204747.GA2076@bogus>
References: <20200413152633.198301-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413152633.198301-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 17:26:21 +0200, Paul Cercueil wrote:
> Convert the ingenic,tcu.txt file to YAML.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     This one patch was sent as standalone before, so it's technically
>     a V2. Support for 'assigned-clocks', 'assigned-clock-parents',
>     'assigned-clock-rates' was added.
> 
>  .../devicetree/bindings/timer/ingenic,tcu.txt | 138 ---------
>  .../bindings/timer/ingenic,tcu.yaml           | 281 ++++++++++++++++++
>  2 files changed, 281 insertions(+), 138 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> 

Applied, thanks.

Rob
