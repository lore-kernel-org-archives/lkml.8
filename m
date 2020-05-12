Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3CBC2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DD320575
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589321141;
	bh=j1vAY40L3awDVf4d2kZXDZQndql+swIvtvfOxztyeV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0uPEimI/GgqrEJt5PuxucuMq57YFxfvzdNW7c64S7pxwTC+gxafR8rPM20Fj1jrFS
	 SIib1VzxJQr2bbXkQua1K7qtnJBsrrzedMDGncOB0ITJuJ+DVPAZs9nX5jFnhbxaBz
	 77xcrrTu1efQPQmXQ9eUe/YhtvUD/3j+GdvVXaDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgELWFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:05:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46975 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgELWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:05:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id z25so11812214otq.13;
        Tue, 12 May 2020 15:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1spzLK4cm4ekL4dQmE1+GWlhRjCGCTHWPWuSdcartNU=;
        b=E9kSd8ITWbesdZd2DQf/v3P49EXiZCJIOyJbxI8ay3VPzivr50F1HRm5jvR5zCo38H
         P+ErtMqTP3Aq/gvGPrtHxFPO6gH2bLMcTHIsFJaYYb1Cooh7TIhH1ut8ZA181cEN/N3r
         gx4QgJl0B/3brrAyYnwY6PySNM9cW9ZlhbdJzKJSajQyfYykQW3J/QSiBGNbH007XOvn
         XxxiXp+lhQ9MlEf2PiSfL9eXOSJQtobMhncj881XV9W5cArkvZoDmcLXiWdAcAq2zZXG
         oMVOKzdBN/FiwRQo9qq4Nsvl0IRFHzLYva05KXbcsagVAdpYoWz/ie8wij1HeV14XxAt
         YGOA==
X-Gm-Message-State: AGi0PuYS3FTVmPta8kuxYNIY3RN5GtNcLI0976XWtkvITlS7bPob/2dX
        Y0vA5SmnTcNIgTY57N3JpA==
X-Google-Smtp-Source: APiQypJZNwnsVvEn4yecESFGLnDDq4EBQLMVQoLrm7Afo3/qUJ8VPojy/Bqb85BUsmx+ciYyevsr9A==
X-Received: by 2002:a9d:7608:: with SMTP id k8mr4965628otl.233.1589321139244;
        Tue, 12 May 2020 15:05:39 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 95sm3802450otf.72.2020.05.12.15.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:05:38 -0700 (PDT)
Received: (nullmailer pid 16849 invoked by uid 1000);
        Tue, 12 May 2020 22:05:37 -0000
Date:   Tue, 12 May 2020 17:05:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        charles.stevens@logicpd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] clk: vc5: Enable addition output configurations
 of the Versaclock
Message-ID: <20200512220537.GA14318@bogus>
References: <20200502122126.188001-1-aford173@gmail.com>
 <20200502122126.188001-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200502122126.188001-2-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 07:21:25AM -0500, Adam Ford wrote:
> The existing driver is expecting the Versaclock to be pre-programmed,
> and only sets the output frequency.  Unfortunately, not all devices
> are pre-programmed, and the Versaclock chip has more options beyond
> just the frequency.
> 
> This patch enables the following additional features:
> 
>    - Programmable voltage: 1.8V, 2.5V, or 3.3V​
>    - Slew Percentage of normal: 85%, 90%, or 100%
>    - Output Type: LVPECL, CMOS, HCSL, or LVDS
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>


> diff --git a/include/dt-bindings/clk/versaclock.h b/include/dt-bindings/clk/versaclock.h
> new file mode 100644
> index 000000000000..c6a6a0946564
> --- /dev/null
> +++ b/include/dt-bindings/clk/versaclock.h

Belongs in binding patch.

> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/* This file defines field values used by the versaclock 6 family
> + * for defining output type
> + */
> +
> +#define VC5_LVPECL	0
> +#define VC5_CMOS	1
> +#define VC5_HCSL33	2
> +#define VC5_LVDS	3
> +#define VC5_CMOS2	4
> +#define VC5_CMOSD	5
> +#define VC5_HCSL25	6
> -- 
> 2.25.1
> 
