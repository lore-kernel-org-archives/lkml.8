Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EADBC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9572206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WASWlBRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgD2Oem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbgD2Oel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:34:41 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C41C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:34:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q7so2157661qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIL4ApehH49g+0+y5OYiHX2Oybm6lORCKM20y01yZyk=;
        b=WASWlBRBzQWJ+KWMiJ1PoJd/TTqH0NOoUHKPTsvnaAtF+2MilmX4x40jd3Vct8lD+W
         E7v8JzClLBPlmXzuseNhz13qBEqefDzk5uUUl2jPWi5KgfOUv60/E54MwZnJ/Hfx4k/x
         3yUq2KfboJDyd8e5KaEYqVbm/GaGk9Lk2d3PbGeMqXE4y3CBSHjklv/4ZgaaHkoiDyRf
         aXD+VqOfjwNyEWAUfM9KSjH0nt5k29BhFLgqFVXPoFgwcLssGZxMCSsYUDULayMxVAhh
         IvCbScPSOUygfeG6P6W9lOLsT5dLa/N3dZAUvNnj51SDhzkIIDO31biFt7/YDqW6boCi
         uarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIL4ApehH49g+0+y5OYiHX2Oybm6lORCKM20y01yZyk=;
        b=cL28Mbl3rf1HQvFu1RG8MLj69/jKehHNv+HxHQBwpfJCkrVYIu6rjXN44pfUjMMEDZ
         +bQ1+iWm5B0OZQoUBUPRx1vl3E3JsdNr6EGBiNfb6z+vIHrf2HkWdUF9w2gOYKqZnLXO
         EioXt3DyiCCdzK8zwkMsDI08Nx3Qg2k0cRxKx+mdYjWcpqz5TIJXTc+3hobP+8aJFkl8
         oIOgdsIClotOyrQenBaOWlwSWlBUpgblChZubWzbWHFSYTgnizXzrblXdZdujm/OuKcW
         O9wSe9r+85mdUfpPBTdvYFI1dTjZzHr5XVKiycDuK9xgZMcpu6Lbhp5Q8j5F7qxVlTZM
         YbFw==
X-Gm-Message-State: AGi0PuZ1aOuWrUGy3pCIw0Rz/csZMfe/M7Z8atseGQyk0ZIDv2nm212R
        6LbNhcktMMZn0O2srhnrurI=
X-Google-Smtp-Source: APiQypKTgN4JaR+rKiqwwTrTpzzd/tbjiq1vMLnLgfNxMnSp0opHhEjEiBUEzk8k3zM0OJ/RTGmLCA==
X-Received: by 2002:a37:7b01:: with SMTP id w1mr34172015qkc.167.1588170880678;
        Wed, 29 Apr 2020 07:34:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p80sm15706893qke.96.2020.04.29.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:34:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 930E4409A3; Wed, 29 Apr 2020 11:34:37 -0300 (-03)
Date:   Wed, 29 Apr 2020 11:34:37 -0300
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH RESEND] perf tools: Fix function name in comment
Message-ID: <20200429143437.GA29329@kernel.org>
References: <1588141992-48382-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588141992-48382-1-git-send-email-zhangshaokun@hisilicon.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 02:33:12PM +0800, Shaokun Zhang escreveu:
> get_cpuid_str() is used in tools/perf/arch/xxx/util/header.c,
> fix the name in comment.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> CC: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  tools/perf/pmu-events/pmu-events.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index 53e76d5d5b37..c8f306b572f4 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -26,7 +26,7 @@ struct pmu_event {
>   * Map a CPU to its table of PMU events. The CPU is identified by the
>   * cpuid field, which is an arch-specific identifier for the CPU.
>   * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
> - * must match the get_cpustr() in tools/perf/arch/xxx/util/header.c)
> + * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
>   *
>   * The  cpuid can contain any character other than the comma.
>   */

Thanks, applied.

- Arnaldo
