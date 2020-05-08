Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DABC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C607D24964
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z07+lJBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgEHNPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730437AbgEHNPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:15:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F811C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:15:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so1789311wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EzHI5Xuq83xJbZHgwiOOt3hcMqs9I4sZnbPBM/oFcog=;
        b=Z07+lJBTwEM4bGY+C2ZRpCkZ3QKIXTnBan62CpCJWSEOHTqvZzUUAt//mNP9uZPftp
         sQeXNAaPYEa6cZEAlZGZc5DqdAnJ/z+l6NM0pdSs1N9LGxjy2xMfXlCoRi63lJ0EHv9V
         pE1Pfd2pMSp4yr5gs5x6HArujjnLW8svw4Dd9z1F0owqqg1VBdc4sDITw1ARI8r8rEzk
         0XFzY/t+NB9SFaln00id3Bsa1hskpTKKnI+0INn0hWTKqgITQkfNDoxZGXG3F4sh5b4k
         +brqbhpCGl0e2MjLTLVVontyQ4ZdJK5SDTLZhVPvlQ9ZlgEc0Tm254JpPB3NnV0+nyk5
         KKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EzHI5Xuq83xJbZHgwiOOt3hcMqs9I4sZnbPBM/oFcog=;
        b=Aj9N3FMkHZ625iMnvh5P2gfJ7urzBAoPSyD2TSiB0L6r4e3hrQDfQpzExIeX9EQFf8
         Mqguz/KM7In2ydh14hWkOy0rwf/GiKhYUUMI3+tpkeRc0P3v5QwPiAYD5bX7A4jBW9Wg
         GjdhJbKnuTv39MMx2TEoRmLAzBaOHtgDkbvkuEJpU8bEjaTiD9ChofBqHb9V5jnlwem7
         BN8e1oqXccZSB7xVEGvOXcM023KwiMffGaB3diI7DeGFPk9VTbPW34KvmlU6bTpNyGbp
         i0scefvd19dj1qeovPaPQPi3dUT61/5mISoOtDNJuBWFhLXynhBhgRI3Xc1+OzSIujlC
         lQAA==
X-Gm-Message-State: AGi0PuYl5zSGNXiBKGLndZMxPXlvQrT3biE0jbu5+SqBxlz+dXAZI9fd
        2XpnNL0dnJa3OKrG+8BATIz3Bg==
X-Google-Smtp-Source: APiQypI9F7N2h90hD9nJL9PvGxhA6vVv5J1pErloGxpY7jK8feMGi5s195iTAy1p44wUJq0ITF+Pug==
X-Received: by 2002:a05:6000:1ca:: with SMTP id t10mr2937315wrx.230.1588943712773;
        Fri, 08 May 2020 06:15:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id w10sm2921808wrg.52.2020.05.08.06.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:15:12 -0700 (PDT)
Date:   Fri, 8 May 2020 14:15:08 +0100
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508131508.GB10541@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <jhjftcbtoo6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjftcbtoo6.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Valentin,

On Thursday 07 May 2020 at 22:34:17 (+0100), Valentin Schneider wrote:
> I'm curious; why would some Android device not want to roll with schedutil?
> 
> When it comes to dynamic policies (i.e. forget performance / powersave, and
> put userspace in a corner), I'd be willing to take a stand and say you
> should only really be using schedutil nowadays - alignment with the
> scheduler, uclamp, yadda yadda.
> 
> AFAIA the only schedutil-related quirk we oughta fix for arm/arm64 is that
> arch_scale_freq_invariant() thingie, and FWIW I'm hoping to get something
> regarding this out sometime soonish. After that, I'd actually want to make
> schedutil the default governor for arm/arm64.

As in setting CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y in the arm64
defconfig? If so, you have my Acked-by already :)

> I'm not opiniated on the modularization, but if you can, could you please
> share some more details as to why schedutil cannot fulfill its role of holy
> messiah of governors for GKI?

I guess I answered some of that in the other thread with Peter, but all
in all I'm definitely not trying to make an argument that schedutil
isn't good enough here. I'm trying to say that mandating it in *GKI* is
just likely to cause unnecessary friction, and trust me there is already
enough of that with other topics. Giving the option of having sugov as a
module doesn't prevent us from making it a default for a few arches, so
I think there is ground for an agreement!

Cheers,
Quentin
