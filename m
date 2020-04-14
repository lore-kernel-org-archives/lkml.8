Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C55EC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2496F2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586887990;
	bh=u0NkTleULn+zSjT9L9M78XEYUbfi1MBjevJUUG9qtdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QA4hLprXxe+Hetc8Lf65hMkr667FMNsjS1YN2GSLb65zibgFxwi8TV+b/W4ZG5JEj
	 VDbyTo/TcSynhUqjwt0VhRTZPXyOB8P6irAVE+rBGuS+w9taOHSSSa4ipV+JfkLMd4
	 /89hejmUkZLvpNbxsYYRrgZvsGU0zb01xma5y0QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503586AbgDNSNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:13:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42975 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503533AbgDNSMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:12:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id d7so6200135oif.9;
        Tue, 14 Apr 2020 11:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JbkL8cT84GMwOThia0hI7fpyipnzfE/v8BeyXwmlGqk=;
        b=MyJaNNiz9gZWXX+6lVeOO9rD0Pbsl+hG4HqbIH3umZ0m9JOMKSxlNntwOuU69tlv26
         1ctIFQM9U4qawpnry95H42kt/jrQ/NTw9wJQjHP5ok1FRwXhCCK5Z0ke9gYFvKVjjjhc
         haS7HCODsHtJ+vy5zIeOXiAtPQXkhvBKtm+/S+2/fB/atSD9QhuwjOx0HgWLbEcEtzo6
         kh1MEmt5FTHImJB1SGqtIttI6DJ4QN7LyEcwJ6BjsH4vYatGxerzNkZKOYRb/fRhwtO0
         h/CBVv7pCR4ANYeedLH4sFncb1hQhiai2ffKk4w2WSZQc9+oy4p6vfEBQYEZRLKe0yv8
         m1vQ==
X-Gm-Message-State: AGi0PubTzz3SDWU2EC9JSo2IQHjz5+ATH3bBkvJRbaTe/btXTZYujlc0
        Cqe4m/20wKLT9Gq0He7E9A==
X-Google-Smtp-Source: APiQypJ9Zq8kiIMVEyTPzpiU4EKX0rS7dKCNaqzL+3I+Jc5UO3riOzaMYx1BmPbxlhKgaXJ22Hq3BA==
X-Received: by 2002:aca:1107:: with SMTP id 7mr7932181oir.133.1586887938535;
        Tue, 14 Apr 2020 11:12:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z15sm5675058otp.10.2020.04.14.11.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:12:17 -0700 (PDT)
Received: (nullmailer pid 10763 invoked by uid 1000);
        Tue, 14 Apr 2020 18:12:16 -0000
Date:   Tue, 14 Apr 2020 13:12:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, frankc@nvidia.com, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, helen.koike@collabora.com, digetx@gmail.com,
        sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/9] dt-bindings: clock: tegra: Add clk id for CSI
 TPG clock
Message-ID: <20200414181216.GA10665@bogus>
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585963507-12610-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 18:25:01 -0700, Sowjanya Komatineni wrote:
> Tegra210 uses PLLD out internally for CSI TPG.
> 
> This patch adds clk id for this CSI TPG clock from PLLD.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra210-car.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
