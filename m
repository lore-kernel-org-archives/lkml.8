Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED50C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFC2206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584012460;
	bh=8LkXpjk/vT0XG4wsMPQXCP0zQWynqto8chp91dAaSOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zebNXm1RylPoyWv1om+O6nm9FfcPAIpp3p6lUamXvjK/DF29ZMgRXY/c96vclGddD
	 FnnW1qsYLfYc0Pz/cYtVqAUaWAgFNBCGdpdSmlCqWdIokj+i4Z+Nkq+rnHMS30xKao
	 PVDt+jbebIcty8mWlDImlQ1RjvM2MKDpl2YzitVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCLL1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:27:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43551 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLL1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:27:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id n20so1154629lfl.10;
        Thu, 12 Mar 2020 04:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OXQ9VWIqKeDLANditz4p9lg4cWOyyuLMtjlz1V83iJc=;
        b=LqKsEbQAsW1b/2HFFqfkbc2i8G6X16o2JiXJ+ssQ4CIGboVQd2m5HOW60QoxmWrXgZ
         y4sdOY/b991DVGx1k2/FgHZaoLpaL86u3EgtU7Aj/bcHIptEArcWToKHnC9YZQJJIB3N
         wos8xr8T1x0yG+F5wd295L9LCrOTMpZf5ZPUwzceTCF5VXoUPsGR6jEpRFI1yejWfCMB
         cwu882a8pgn17+HCyhgznuqzQLlWZHrkBfwCfigeeWFMAdN5Hqc1e18RG2uQ7x9LlDPD
         2hkgIi0560em92mVqNkSRGrGKCOysAdoX3peDsLk8XGwC06LdPcG4JnJnHbe8/KnEcd3
         Z0Mg==
X-Gm-Message-State: ANhLgQ3InMMWUDfZPnhalmdgSZFLwrC6aqEvnAk2+a+dXf7THUSeNhFM
        QxD9Ve13r8/0Y6KuCq8dQYY=
X-Google-Smtp-Source: ADFU+vuBA5rWFfsjCDLNiiHqN7ljiTPaMOhypM0lcTpHmgnHoj9/YqImMIKVQ8T7CFBjgm2cVGaIGg==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr5076975lfc.111.1584012456800;
        Thu, 12 Mar 2020 04:27:36 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id o26sm22828518ljg.33.2020.03.12.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 04:27:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jCLzo-0005qx-RH; Thu, 12 Mar 2020 12:27:24 +0100
Date:   Thu, 12 Mar 2020 12:27:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/3] ARM: dts: atlas7: fix spaces in compatible strings
Message-ID: <20200312112724.GP14211@localhost>
References: <20200212104348.19940-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212104348.19940-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:43:45AM +0100, Johan Hovold wrote:
> I stumbled over a new driver in 5.6 whose compatible strings did not
> match the corresponding binding due to spaces in the driver compatible
> strings:
> 
> 	https://lkml.kernel.org/r/20200212092426.24012-1-johan@kernel.org
> 
> A quick grep revealed that we a couple of devicetrees in mainline with
> similarly malformed compatible strings.
> 
> Note that there are no in-kernel drivers or bindings that use the
> strings question, so I think simply dropping the spaces would be
> acceptable. This is especially true for the flexnox nodes that also
> specify "simple-bus" so therefore I split the fixes in three patches.

No reply from the CSR people after a month.

Rob, could you pick these up directly?

Johan

> Johan Hovold (3):
>   ARM: dts: atlas7: fix space in flexnoc compatible strings
>   ARM: dts: atlas7: fix space in gmac compatible string
>   ARM: dts: atlas7: fix space in g2d compatible string
> 
>  arch/arm/boot/dts/atlas7.dtsi | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
