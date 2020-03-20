Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C8AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791BF20722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Qb8zVeUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCTJzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:55:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40745 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgCTJzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:55:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id f3so6609723wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErKXfmzSgiNRkfee3fYZKinlr8hK0C8kq+czqF+B4Uk=;
        b=Qb8zVeUA6a5tsK9SLAzetx2Z8XGq55rcqU3BgxiAMA4hgj5cGM8uLs64RwPgnvUvFX
         WbZkOfci/8N91mpHMRg6KKt6LQYHof6+MjYBsb7IkgZSTUqB2Mjh9KylypFGvdXy7L4m
         DXwn7H62xWqT72f1bH4ZMrvJGpW/FfInMnId7BTEvdW3naNTlK/GZSg+gSc0/D5d4wgd
         Bdg4qdybUJnCZx8G19c+bRXgnVwp4BGpZrsroVq97M+R+/bMInz//k+8BVxQIfxUYriH
         2lk8UJkP2dGEBeZWJfRqt8qbDDHRLbTFH2cHKkgQNnWif0zfEoIma/xgvn15wJD2q0Pn
         aC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ErKXfmzSgiNRkfee3fYZKinlr8hK0C8kq+czqF+B4Uk=;
        b=Q2Scx/pnmHyiUFpRRR5fK3iHf3c3tR5BDYbetoq7hy7prsrcJW/1/5Cbd3J2cbquoH
         KgF4zXbcVVVBOfcHNsi0VOPCJvdX+Nq72ii9iCpIWyKHFF0jiXyTowkhnTUC/06ZR8Ij
         bib1/LXjNX/UKv8j5/qmSKs7bZwpuKZEP8ZOZ79Rk6UkIr/ZfFbnJdff+jFRFtysoSsO
         kNqNYgtfXVNeP00bWo5+1ypf4JnkICFO9lAx3r+/GiAW036JtOfQsESh9wAsrBwnUKwi
         Ja48AeEmEqceEWsPm01gDjWj15ll4FvCTr9wtphu/2TOEcp5Vzs12IFq5b2IvFvhCe/v
         0Y0A==
X-Gm-Message-State: ANhLgQ29vrTSNK5N6Ai1qsNW2VET57IpzBzl1bmyQoQczeDnA4l5zJBh
        SeBYqqIyfvu7yTTW/Xwq3q6Tkw==
X-Google-Smtp-Source: ADFU+vtDET9FB1w/A1ThK/1aB+wIdxZ7daLvtZe4Ij/KR07EPTRA/WVsYATCEe+qFHsJZjvtCixh3Q==
X-Received: by 2002:adf:ab5b:: with SMTP id r27mr10163208wrc.191.1584698109484;
        Fri, 20 Mar 2020 02:55:09 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id f14sm6365924wmb.3.2020.03.20.02.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 02:55:08 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:55:08 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: spectrum_cnt: Fix 64-bit division in
 mlxsw_sp_counter_resources_register
Message-ID: <20200320095508.GG11304@nanopsycho.orion>
References: <20200320021638.1916-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320021638.1916-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Mar 20, 2020 at 03:16:38AM CET, natechancellor@gmail.com wrote:
>When building arm32 allyesconfig:
>
>ld.lld: error: undefined symbol: __aeabi_uldivmod
>>>> referenced by spectrum_cnt.c
>>>>               net/ethernet/mellanox/mlxsw/spectrum_cnt.o:(mlxsw_sp_counter_resources_register) in archive drivers/built-in.a
>>>> did you mean: __aeabi_uidivmod
>>>> defined in: arch/arm/lib/lib.a(lib1funcs.o)
>
>pool_size and bank_size are u64; use div64_u64 so that 32-bit platforms
>do not error.
>
>Fixes: ab8c4cc60420 ("mlxsw: spectrum_cnt: Move config validation along with resource register")
>Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>

Thanks!
