Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62DBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751A620874
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioJAkhMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbgFWW5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgFWW5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:57:32 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A6CC061573;
        Tue, 23 Jun 2020 15:57:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b15so29506edy.7;
        Tue, 23 Jun 2020 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JyaST442g4jgVoNwB5FBRI2rFKCQGveZheORu1G0/FU=;
        b=ioJAkhMsktmUa11lXkCStq+y/AVVW4lFT1gfC83aLREGmYEwEs0S9oQQTQKPu9xUhV
         LzuIE7WbfFvF3CX03YcnxECAluMmM3DaK6Jim0sWVZFz2vADTyTo5EI0dnr8FyPu9TH8
         cP7rx9Lt+Ki+600SUS/ttReMLQzLTWCRa/Nuz4PkXfKm00LkTEqVao+Asf3pj03HIN/R
         wqzaXS+ZzXy0Bmrk7gDa68TlBRhXesxPbmj5GCpfPa1exk1PzYivaic2H2XjqKDJ1kxN
         OTEZGC/EB2v7YwsWVYKX4e+I+1Q6CS/+cT3XJP9t3sAPq51BLK0+oR/SVfshzXDOdmMq
         SEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JyaST442g4jgVoNwB5FBRI2rFKCQGveZheORu1G0/FU=;
        b=WT29vQ1Cq3Ftr5iTBgMNCos9K4ozOsD4afbpxIAfL/pbLgpjhYlo7rOf2+P8dSmz9L
         R8eXAVAmTBpt3rm9ePAUdDrs247VURZmVuw2OC/bTQIO2Ow1DtS/X1i/Xrt3cHxbGBy6
         9BDH32yb1U1mlF4UpuK54HK9h+EKp42T4RkJC0ih71VNY6iv9QBP3uJmDZcd/IVtGtEr
         jR9h6Gta68z08ZOzNbdc7aEBZlCsJxcUbBbM8pCdW8urOjzUYJLHd2QTEpSv8XSxJSQi
         25Lp6tXXzr9A4dJuNxGpWDq5SEeSugxLRty0awm+Z5dUA6MP0RF1f8DJS6hRmhkbfvyl
         8UkQ==
X-Gm-Message-State: AOAM533CnvpnSdEVzOlVP+jA6362rUJ4v2+jTMNsMsNmOWJSDll2mexU
        Rh+WRgLy3ezvmnIu9MvWuu8=
X-Google-Smtp-Source: ABdhPJxkEM2iIPabqqWzv0T6tp8OrSBJeVTMWnNbvC03qu3DhO/Rb7O5MGRyUuAyKcxbCuNkXa77pw==
X-Received: by 2002:a05:6402:a42:: with SMTP id bt2mr23544981edb.42.1592953050426;
        Tue, 23 Jun 2020 15:57:30 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id js3sm14230604ejb.65.2020.06.23.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:57:29 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:57:23 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Subject: Re: [PATCH 1/2] tools/memory-model/README: Mention herdtools7 7.56
 in compatibility table
Message-ID: <20200623225723.GA418699@andrea>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
 <20200623005231.27712-13-paulmck@kernel.org>
 <e3693dec-213a-3f65-eb1c-284bf8ca6e13@gmail.com>
 <20200623155419.GI9247@paulmck-ThinkPad-P72>
 <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:06:02AM +0900, Akira Yokosawa wrote:
> From 89f96cba0db5643b1d22a0fe740f4c5cac788b29 Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Wed, 24 Jun 2020 06:56:43 +0900
> Subject: [PATCH 1/2] tools/memory-model/README: Mention herdtools7 7.56 in compatibility table
> 
> herdtools7 7.56 is going to be released in the week of 22 Jun 2020.
> Mention the exact version in the compatibility table.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
>  tools/memory-model/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index 90af203c3cf1..ecb7385376bf 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -54,7 +54,7 @@ klitmus7 Compatibility Table
>  	     -- 4.18  7.48 --
>  	4.15 -- 4.19  7.49 --
>  	4.20 -- 5.5   7.54 --
> -	5.6  --       HEAD
> +	5.6  --       7.56 --
>  	============  ==========
>  
>  
> -- 
> 2.17.1
> 
> 
