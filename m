Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C071220734
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589510551;
	bh=OfQLHjO9LOV02Uz+SEV+a9/4ng7mJONtaETGbnltb7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Iz7MF0DTUi9A77PIdTV/euskoYGJRs9n/i2pkBHeNWKlzcdw84tfQJxQqMI2WJP17
	 hr1dBfZAc43XGY4OWthtBAHEpDmPAUPmG521fkN0BKWlUHIZjIknewGdBU0GF5GvHY
	 rGGUjFKC5D8OlGN92FxtVQfLgHXOHrqvBHPirgjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEOCmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:42:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37591 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEOCma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:42:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id z17so786974oto.4;
        Thu, 14 May 2020 19:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qhA31OEEIMS3cmtOlMX5LEdCP8LUU9nCDYnHhjMZQ94=;
        b=lxUSCbFGzl5NHYZyO1KYPqKByJwhAkoVrzjEwN5DxHeyrwI6qbLPZcXcEsf1kW2Jrd
         zQtXJ+nqE9yxYj9LLVCazvOTu/TsjngS+fzAts9/ts+XoTI5UCCCkzX0prHcblKoQL6q
         48zJXKfa2T3RDQ3ixNh9PjQFTKlQ3i08Jzy9FJTpG1tAaICROxokvZNJLjLGnybrGzcr
         8N12bNqnbowSXcgBW/Ct2ms73mrLdGB1yCG9WPYdPhg7G8Y+sDq3RlWwOI1hZAIc5t0p
         sDdX/bj0zWpuXCsFdoVuTc7MHYJuvzllf/3RJVNkKIzB8vJjbWknBSSRiyhqmso/GPCs
         FTHA==
X-Gm-Message-State: AOAM530ivU2ELzPPZNX1IwDCuor8vjfGfWB3GCuVcH6c+NOdX1NgdxqU
        H6VebtXzRVvCqi73aMj8tg==
X-Google-Smtp-Source: ABdhPJwJ6r+UQNDYSl9WyyXMu1dSVzcRRbNO85ZUFZ8EbBTT4VE/4hWMneEb6iOQf9L6xLmuZ98yoA==
X-Received: by 2002:a9d:730b:: with SMTP id e11mr763055otk.9.1589510550174;
        Thu, 14 May 2020 19:42:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l192sm256071ooc.3.2020.05.14.19.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 19:42:29 -0700 (PDT)
Received: (nullmailer pid 18636 invoked by uid 1000);
        Fri, 15 May 2020 02:42:28 -0000
Date:   Thu, 14 May 2020 21:42:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH] clk: clk-si5341: Add support for the Si5345 series
Message-ID: <20200515024228.GA18577@bogus>
References: <20200507061544.11388-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507061544.11388-1-mike.looijmans@topic.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 May 2020 08:15:44 +0200, Mike Looijmans wrote:
> Add support for the Si5342, Si5344 and Si5345 chips. These are equivalent
> to the Si5341 family, but with more clock input options (which are not
> supported yet by this driver).
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../bindings/clock/silabs,si5341.txt          | 11 ++-
>  drivers/clk/clk-si5341.c                      | 69 +++++++++++++++++--
>  2 files changed, 74 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
