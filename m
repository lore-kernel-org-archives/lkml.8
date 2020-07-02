Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E4FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2126C206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i2/zLzcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgGBPSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGBPSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:18:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FA4C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:18:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so13615849pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZoZRqj79509W+zskyZYR+5ZRtTQjElio5nf3SxUK6Lg=;
        b=i2/zLzcCZwqyCEyCmbGH0DgqG1xZii1BrbGzixiC6SqNv9zW9vtxMyduhe7cJVlM/S
         avL9+fyIy0AxlMy4jH+e6u2XYkc+K44JhOC5s3s0iGjNLnR7Y03lH+yYQ3rd0JARDNhw
         deuZfSDE7JrYDO0TOVYntZ/jxqBq4V2zFVjEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZoZRqj79509W+zskyZYR+5ZRtTQjElio5nf3SxUK6Lg=;
        b=CN4Lrl4FGFCxP1AU+w3IiLPRX4BjWVDIi5EGdkSMFi8q1bO1C0zJJpjY5FqkRRvBOh
         SqS/PkJyIbAxXkpTaa4FdWd+ycHDSFQba32eAYcWZiaqDe0+h9SlJzGVfVEG0pK8dbd8
         zkK8HljykAke4EgsZceLxs9MJI2euOeJBUx+tjpupNtnc8kLRvt+sYjakk0yBhPs4zoY
         OzizdIGkuYKZ9ZzfNR2q4FrgVPDBD3hUqM0aTXjnPG7Ax4LOn/IAXo3Ak+Rv07No8neW
         ZD2Fjr7mo63JU18oooCfClueon7vPsg8VN+t5dLsPnxJLPUdqickIPu6hW69sx6dAK+N
         scLw==
X-Gm-Message-State: AOAM533e5fOeA41pwE6yZS2pnXWdqyOTmmogX63STyTGXehlRwFKUmDC
        gCPBvga9nMwXVpLplUemuPE8wA==
X-Google-Smtp-Source: ABdhPJyDT39ApMmhu3R+RsMDMocrgz+h34f1a0sxmX8XLpY/OiD4ypQApRdsmsl674UurYNSKifffA==
X-Received: by 2002:a63:20d:: with SMTP id 13mr25094225pgc.166.1593703127475;
        Thu, 02 Jul 2020 08:18:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1sm2384911pfc.55.2020.07.02.08.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:18:46 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:18:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>,
        Norbert Lange <nolange79@gmail.com>, Chris Mason <clm@fb.com>,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        gregkh@linuxfoundation.org, Petr Malat <oss@malat.biz>,
        Kernel Team <Kernel-team@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: Kernel compression benchmarks
Message-ID: <202007020818.87EA89106@keescook>
References: <1588791882.08g1378g67.none.ref@localhost>
 <1588791882.08g1378g67.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588791882.08g1378g67.none@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:35:48AM -0400, Alex Xu (Hello71) wrote:
> ZSTD compression patches have been sent in a number of times over the 
> past few years. Every time, someone asks for benchmarks. Every time, 
> someone is concerned about compression time. Sometimes, someone provides 
> benchmarks.

Where's the latest series for this, btw? I thought it had landed. :P It
seemed like it was done.

-- 
Kees Cook
