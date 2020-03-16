Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3ACC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44AE205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I2HQYc3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbgCPSVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:21:24 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45773 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732236AbgCPSVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:21:24 -0400
Received: by mail-qv1-f66.google.com with SMTP id h20so5477056qvr.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6kGpNmJOznrZ9oqsorGnOjVKptS/zORV95BRyc657r4=;
        b=I2HQYc3rx475UZv7CWGq5B6xmSNOiYbtz7Aas+ALd2V1dikTaBwhmAtDW7+6DeMTZt
         LpOTjmORhXvBXCvE+kQs0+WzrK/SK0XIuy63vJ52riYpx97lsRox6fQ6gW9kH1wvBR8n
         gb4qjTjkP6Shg1koYnHCggYh/17JeSQ4/EgKSimtMEFglAXZH/uD20vLqWKkxSI7Dq2r
         7eV0wbTrcThiDTn7ugs0bmkHXfWQZTKPa/Yx8JNG4vOrUj/lvmlOrQti1pddExrw0tUr
         JWfUvrxEig6JEFGbRl+eZPT/M/JE17bS9ewBZf0nmoM9n3iI1cEAn1nBx6UmWM0RMum0
         C2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6kGpNmJOznrZ9oqsorGnOjVKptS/zORV95BRyc657r4=;
        b=MUYKpbi/rY/JSs31zcgjBicgQrLQayuib9nUmlwb1EOuvqEB1ghc38sittCKi/rYyT
         9BVJGg23NAMXKdz4i5lvbGXOd1+2Z7JwSiueGUizaLnBWDEUw5TMSsRVyt37aHO7GUge
         bPaq6orhBqXwA1102MujwQVCWCbP8vja718dYsU589YE0Xdudgrf/Ss1AdyVlfs+LNRP
         iRfqX1okhysSTk2y2GubULYQPAJuEneAzbY4hUA30elcSJxUi7kMh71F7OwwsZ9RQh9Z
         vDFd31VNV5bNX9ZemGz78tv+LCyCRTDBk3emI/BalTIHpFS1sC5V3Sqn2fCUmP6HbXue
         hFvA==
X-Gm-Message-State: ANhLgQ210gTmExMfCGHh9LghbFZUlDSNHH+3vClsslgZyZh6GIDVtvSb
        lnP3P1zegLZh/tppkXGPLn2FUg==
X-Google-Smtp-Source: ADFU+vv6TGlS9YyyJR5dZgspw4yqTC2oyUFtXWcfLf+w33a3EJ9aGw849dwyQjnTT/8v4Xtv5hdK/g==
X-Received: by 2002:a0c:f601:: with SMTP id r1mr1081805qvm.91.1584382882827;
        Mon, 16 Mar 2020 11:21:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w21sm267246qkf.60.2020.03.16.11.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 11:21:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jDuMb-0005WE-Uk; Mon, 16 Mar 2020 15:21:21 -0300
Date:   Mon, 16 Mar 2020 15:21:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RESEND] memremap: Remove stale comments
Message-ID: <20200316182121.GL20941@ziepe.ca>
References: <20200316173414.143627-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316173414.143627-1-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 10:34:14AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Fixes: 80a72d0af05a ("memremap: remove the data field in struct dev_pagemap")
> Fixes: fdc029b19dfd ("memremap: remove the dev field in struct dev_pagemap")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Resending as I don't see this picked up in the rdma tree.
> 
> Jason I sent this to you as you pulled the patches which dropped the
> parameters.  Can you take it?  Or do you want me to send through Andrew?

To Andrew please, hmm tree should only step outside to manage
conflicts connected to hmm related patches.

Thanks,
Jason
