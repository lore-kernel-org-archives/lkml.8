Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92699C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944B720781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596523594;
	bh=awvfd3eHrxyvJ4bymRiRBVgeB1uHuXhPbFH7qDVmFgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZXTU5zdffUM08u+1K1c9hYZWb/VoLzBGMyc9DARXYytDAvoUVTnwnWTBoTXeDIlEL
	 M9wA498UplUPuOj5t8HChnsurigj+XJAb3U2zl7c385SzwxwpFIaMfPQxLtTYdHjmS
	 faOuglvt4AVbn0AFMz0VkM0x4aB38URCbGrTCIsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgHDGqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:46:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43350 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgHDGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:46:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id o18so14595393eds.10;
        Mon, 03 Aug 2020 23:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/tXUse0K8rn7kKPagXhtuRhgALRu8y3NAavrcsnwyE=;
        b=PrLT5Z+JwGP2HBXzun6qo/tVkaIh/gjgtvItoYamBbS3aTh3qQ1TVGmXWAgeAxK0uF
         fTq7ezp8agFgD0iixLNqgs6lu2dMtxLUKXOlcF3TupT+JHfONLPUZwPDLxyWBn84yavm
         f22wL2MxWBG8RA4ZgHSOoTxzuvNorS9R6vxuOL8H2hod0AjuGCE/GQJaQgHx1Mw2lTMx
         YGCNR7jACsa5YdYzlpdUNXvcxUhmCeOUpiQco2+/V4ojhMx+Fw7HHxQ1aQM5B9WrgM/q
         n97kcm4pIu2W75wv4WRGWnXoF+1lX8djT2pHJICsLSU2GQzYCKBAKPm6vNLap+4n9js/
         52qQ==
X-Gm-Message-State: AOAM532T/HdtzPcU84qU84JQss0bg6KClVap1xqN25SEqY5oLh1vc7G6
        LOF7zXb76tpbRc3uNsc0tzI=
X-Google-Smtp-Source: ABdhPJxbMviXp7Ec9tGH19+u+gR70Y0Ham8OANYERZLnLjbLs59nJKkipXI0EndPxKdJzbj5ysMhkw==
X-Received: by 2002:aa7:ce0b:: with SMTP id d11mr18475007edv.357.1596523590498;
        Mon, 03 Aug 2020 23:46:30 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id y14sm16588349ejr.35.2020.08.03.23.46.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 23:46:29 -0700 (PDT)
Date:   Tue, 4 Aug 2020 08:46:27 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] memory: jz4780_nemc: Fix an error pointer vs NULL check
 in probe()
Message-ID: <20200804064627.GB10089@kozik-lap>
References: <20200803143607.GC346925@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803143607.GC346925@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 05:36:07PM +0300, Dan Carpenter wrote:
> The devm_ioremap() function returns NULL on error, it doesn't return
> error pointers.  This bug could lead to an Oops during probe.
> 
> Fixes: f046e4a3f0b9 ("memory: jz4780_nemc: Only request IO memory the driver will use")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/memory/jz4780-nemc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, good patch. The pull request with offending patch was merged
into arm-soc so I expect soon will be merged to Linus' tree. Therefore
I'll apply this after merge window to current fixes.

Best regards,
Krzysztof
