Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C8DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61848207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l6YV1FGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbgFOULl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbgFOULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:11:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E905C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:11:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so8062732pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yrq+7tIQLTLfowElVM/LAUx+j6R1G8S30nvCECShhQQ=;
        b=l6YV1FGo7TU7pAG9+qw2VIKRm2zpVhJYfNx5Q3J6oTPJYQgyGzOfcrhTa0eJoLKTfn
         6NfDhsnF08XkpsSWX1cIl04wPTRWtjc8sLkIwWt83YoJPjzvbq0i2dqsxkNArhbh3t0Y
         BD6QOc6aFvItzd5w5V1qKCCHaAGNorfpDSIn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yrq+7tIQLTLfowElVM/LAUx+j6R1G8S30nvCECShhQQ=;
        b=uWCjKqgclq8MmVmNpaRGQPi0uCqX/w5ggxBXrALWX9P4eKyssx0xkwDfuH5Kg9FCxd
         DwfcA79W5m0en37zXtseAer6T7qaS9WF6Eq0bk48j3UDd6X2Aqobotpw1nobhSBVP+UA
         VqFcgtHZ8RIMdaSPUFt1n0lb1iAmf9NwElBGcomisT4X4E+Vjdx6s8zJSHbAmDP0VUaq
         Z+e+ybT/xDPld+H2AbBIUOKXvugoyrEvUB8AqmkOTl0xrUTGOLwKx06W+FMMYO38Ow84
         tV47ru4gnPDmRNFKtebmWDnJLpAGnWgcjm1MqZwxuFygGKlfNy6V65EYfVQXYINlXhyr
         ptyg==
X-Gm-Message-State: AOAM531PvnlBvlavQYkXQfywjDmkjoOJq6u+yEfwvSk9UFpOwppDLYAU
        5rbVN8y9lL2RYCP3pR3S80vPTg==
X-Google-Smtp-Source: ABdhPJwhR93Vg5Nwqs2HYvPt9tQ/0LeMR6QDPhfir7kLCDe1EmntTkidhoi/vgyMd2V+CJ/mzmlt1g==
X-Received: by 2002:a63:925a:: with SMTP id s26mr14310236pgn.21.1592251900590;
        Mon, 15 Jun 2020 13:11:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n4sm15282175pfq.9.2020.06.15.13.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:11:39 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:11:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Eliminate usage of uninitialized_var() macro
Message-ID: <202006151311.138CD1D@keescook>
References: <20200615085132.166470-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615085132.166470-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:51:32PM +0800, Jason Yan wrote:
> This is an effort to eliminate the uninitialized_var() macro[1].
> 
> The use of this macro is the wrong solution because it forces off ANY
> analysis by the compiler for a given variable. It even masks "unused
> variable" warnings.
> 
> Quoted from Linus[2]:
> 
> "It's a horrible thing to use, in that it adds extra cruft to the
> source code, and then shuts up a compiler warning (even the _reliable_
> warnings from gcc)."
> 
> Fix it by remove this variable since it is not needed at all.
> 
> [1] https://github.com/KSPP/linux/issues/81
> [2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> 
> Cc: Kees Cook <keescook@chromium.org>
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  v2: Directly remove this variable.

Thanks! I've applied this to my uninitialized_var() macro removal
series.

-- 
Kees Cook
