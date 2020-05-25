Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB98C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C94B2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590391614;
	bh=r9OdalTMs700/aqIDgiJZ8RJ5okHeROR6URDpuZAV2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s9GL+FIJBNXBqDN8KpvG45i4l5LWsjFs0MWDq26jOsAU5hHMuf9VCXa7aYYMc0Q0j
	 9meN1UaJpTE36UOK2aUWShUjndl7Wt1/8ui72pllG8TEE026sy/W06k5Nz4TQ0PeyG
	 mrvVRg0HChPRUelr1DdFgGRmr4JUuHRLl8qzudJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbgEYH0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388948AbgEYH0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:26:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B21C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:26:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j16so3683391wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2c4UNQ+Kyk3q4svduIrEaGBN3fyWHwcY+p2JberCSg=;
        b=ksU7Hcn06eL+mrm2LSsDf9e+5GL1HbO/0LWxvCzJbKNLJ+BSpA1TwD2E9FUH5jof1z
         uzZ/dUCiMC+X/eZRyaFm3z0zzBxoGb/z8Y3ysgHvomuhD3zxQO4UKTIv68U6a0VORMe0
         ZXNU5aQUwCxtoZqTG2rWNduFxw7yfThFOJ9DDJ14+tlPThTItTzygzfBk+b9nyVu1e69
         Y+AfGj2DPi9JSUVe8NfnadNaf0IaHys9klDdCfLvVtXkCgOQ52hHGGDQwVb92t9XlB/1
         v+LAlRpIn0ud4Nopx7O3exgUYZ1afB3AAtS+k2g/Ui2HTmcZhyb5gpfh7eYskyFnl6+M
         0LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C2c4UNQ+Kyk3q4svduIrEaGBN3fyWHwcY+p2JberCSg=;
        b=o2CvytbzmIy1v5ghaRSWFOcEuw23IhcaG5TpdpFhbhn79CQZ0JiyeTPUc53WyEqyC9
         6ZgWxTNiapGD6sJbTAMv1FUMJoBSVWzBSr5GtNKIccDalVtoVcWEdp2R/3L+zzG6kGOb
         YXVTekXfMZEogyfXOGQuFGHEHRSMw4AmWTcM4sQpe6GUtnCT1ewxYs2Qj9eeMydU9s7K
         gyJTr2IsCIQc5KZVG/q3iD9xw7hkYhfFqSoeT05b8JYzBEcvDyz4jxARB6Rqj3zjOAqS
         38GpwunQaLBiN9Q/E8K9aFK90msx9S1t6qITkUL8Q5blFX+0f//icHSnytmD41eObuuy
         hi0A==
X-Gm-Message-State: AOAM530DYaZjWYKF/FCHsbUGndlHHHBy5cc/On5UHfo4ImraRKSSptHr
        H68Eo+yCzM7UVjF5I5E/sy0=
X-Google-Smtp-Source: ABdhPJya2PJCdP5Teww82CMyV/7VtiGyAgwh0BI6pZekrGciF7z50gTRint7ljLC4i8P4XrAqnPx3Q==
X-Received: by 2002:adf:a55c:: with SMTP id j28mr10340798wrb.369.1590391611360;
        Mon, 25 May 2020 00:26:51 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l13sm16998060wrm.55.2020.05.25.00.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 00:26:50 -0700 (PDT)
Date:   Mon, 25 May 2020 09:26:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 7/7] zram: Use local lock to protect per-CPU data
Message-ID: <20200525072648.GF329373@gmail.com>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524215739.551568-8-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> --- a/drivers/block/zram/zcomp.h
> +++ b/drivers/block/zram/zcomp.h
> @@ -5,11 +5,13 @@
>  
>  #ifndef _ZCOMP_H_
>  #define _ZCOMP_H_
> +#include <linux/locallock.h>
>  
>  struct zcomp_strm {
>  	/* compression/decompression buffer */
>  	void *buffer;
>  	struct crypto_comp *tfm;
> +	struct local_lock lock;
>  };

I believe the general pattern is to put the lock in front of the 
fields it protects.

I'd also add a comment documenting that both fields ->buffer and ->tfm 
are protected by the lock.

Thanks,

	Ingo
