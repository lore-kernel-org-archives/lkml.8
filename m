Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0540CC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75DD206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588705079;
	bh=ZdPYSSxuhpm7JFLqK5Xb5/6dr0YeVxbl/wtkI3aJW3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SMOW8dS/Uk5hDxCyz7KiB4uThTu5zou9vAQj0SnIHtP36K+0V14T4VfxbzGvglmDv
	 JEVbpHTPd80pmuYuMU67fSt5hby9O/YguY6J0LsTuN6o4k5+92hh7kV9B4pChH5x16
	 mj6fJmtGXsy8xVwWIhdmdm1E/z2bl56oUt8atipc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgEES5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:57:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39905 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgEES5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:57:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id b18so654554oic.6;
        Tue, 05 May 2020 11:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2U/Wnz435VmQlMfL1zswAwLryUaf+4CgRxZXzmrLZM=;
        b=Vu2iVxEVHsdPyRBq7WkZi2s5CKUnV7JYc5ZWRyWSj+DSYeqP7MZmLCOkuLqV0h+37H
         I/iKn860aMYioc+fDoctdGWLmbcMuuvaTDeF/oWGUQyOpdEtp2MOqxLvSDcYfz6IRstg
         OfTyBcGwVjX/paw6cq4ZO//jCqXNkLFVRsyByKeJ1NlsGmaddWINhIDLhIVvp4O+AFPJ
         zuS2J24iyupr4m1reYZ6UBgJ1T0CBehgb2rLysePUlaYdaZJnaLvFBqNGKca4hW2ZL+H
         t5+KXx5r8fYsTf3sby1yNNhhLWuK9XRew2FH4d3M9eSOlTkBHMjV/hZrOFE92a2ZxINi
         ycNA==
X-Gm-Message-State: AGi0PuaECSK9jI9aKAb7QyBBIM+v2+dWz3Q2UxXU2YaHTlsfVTTbbv83
        HisDL/Ai0/yRK7kpSK7t0A==
X-Google-Smtp-Source: APiQypLPm8uYmEX5Xze9/O3MkGTUnGnKYJIuN7v2j7E5LAz/Lp0itb1zrhn/fgkTS0n8XclGImOhyg==
X-Received: by 2002:aca:3a55:: with SMTP id h82mr24462oia.135.1588705068907;
        Tue, 05 May 2020 11:57:48 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l21sm787544ooe.29.2020.05.05.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 11:57:48 -0700 (PDT)
Received: (nullmailer pid 2217 invoked by uid 1000);
        Tue, 05 May 2020 18:57:47 -0000
Date:   Tue, 5 May 2020 13:57:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Pedro =?iso-8859-1?Q?=C2ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Message-ID: <20200505185747.GA2122@bogus>
References: <20200505022517.30523-1-digetx@gmail.com>
 <20200505022517.30523-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505022517.30523-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 May 2020 05:25:14 +0300, Dmitry Osipenko wrote:
> Acer is a hardware and electronics corporation, specializing in advanced
> electronics technology. Acer's products include desktop PCs, laptop PCs,
> tablets, servers, displays, storage devices, virtual reality devices,
> smartphones and peripherals. Their web site is http://www.acer.com/.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
