Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DDCC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8ADE2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255820;
	bh=lCkkjbTRKnupktbhhwm1QNoArUgsPT25OPIGy+WhnWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s5HSM902lFM8bsfWgoEM0IPEhmnFqvxiCjhjOREBaaXIKfqrW9s5Pti6AHDhVEtzk
	 24zm3SvmQCjiNMprd+PakAu/5UjuJBFROauSu+hpD2LC5JUJJpSyO4SJMMPMFLAJgj
	 1Msu2/h9RgvEImpJ3sc/EYtHUHGI19O7n///xvhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgD3OKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:10:16 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:45620 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgD3OKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:10:13 -0400
Received: by mail-oo1-f67.google.com with SMTP id 190so1297688ooa.12;
        Thu, 30 Apr 2020 07:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6aiOkcIgJAWhCqfCs33Rhe1wkSnQyKwXVAe/pUh2Rrw=;
        b=tEabOy9KM9d7LRpLuowDfHa3grtUQXFhRb2NhOXb1jC+n25OcJI/CPHVJ2hoGBL0AV
         bQZW/AEkMCJJJCJmbkLjqJSybjjF39nfoDb+1zec5tQY2YDd/+HUyVb1PL/mb8Vy6g1j
         k3EFVdk01IO5HzTctxpG1qfP8Pm7Dc2uipe9q82d6X9Y4QKiPcXp77XC5ODDIE4KEAXT
         byEjM2RxzePIllwIxe4Bk5jUIcELo27BI1dF9gwuR8D7SY0pK/5nqvf/kLmEKBInWM82
         0X5jY3D2PEsJODv7obzXkopLojx4QLHNArVJVGf2lGAz9wzugmwebeYGTKC7bFTBlPfk
         ZhcQ==
X-Gm-Message-State: AGi0PubzrAtthmqGA7SayY2TyG7N3vGebiIiJPT3tEW3YuyDOG3CVyfw
        zo/nZN/nKzfzwvMzoL0ez6hLSPE=
X-Google-Smtp-Source: APiQypIlZrdNDKXt4h5JYSoYrTTeKI8v+e+CVvcep7L1dYna5MbvAQ/q4ekiXc5lL7JJyjUKWiE5Xg==
X-Received: by 2002:a4a:390b:: with SMTP id m11mr2952624ooa.2.1588255811640;
        Thu, 30 Apr 2020 07:10:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m16sm1304134oou.44.2020.04.30.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:10:10 -0700 (PDT)
Received: (nullmailer pid 4677 invoked by uid 1000);
        Thu, 30 Apr 2020 14:10:10 -0000
Date:   Thu, 30 Apr 2020 09:10:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] of_graph: add of_graph_get_local_port()
Message-ID: <20200430141010.GA4602@bogus>
References: <20200418170703.1583-1-digetx@gmail.com>
 <20200418170703.1583-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418170703.1583-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 20:06:58 +0300, Dmitry Osipenko wrote:
> In some case, like a DRM display code for example, it's useful to silently
> check whether port node exists at all in a device-tree before proceeding
> with parsing the graph.
> 
> This patch adds of_graph_get_local_port() which returns pointer to a local
> port node, or NULL if graph isn't specified in a device-tree for a given
> device node.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/of/property.c    | 32 +++++++++++++++++++++++---------
>  include/linux/of_graph.h |  7 +++++++
>  2 files changed, 30 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
