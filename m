Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B320674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJriiaT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgERQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgERQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:08:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D4C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:08:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so36102pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UvPpDrJRTISjRmaitgDIto8RJyndLCc2sSj57LCcK5s=;
        b=kJriiaT8bwsbMU+17BfUzGJkZ5x7ACjzaUbUglQ0rEiAY4dvdhLlmrkZ7+euuzmk+j
         4qsmp7fzIrkvDRISd7JmCZvLc9Gyv51lm8tg3i2ltRzdUwDpEN/LXoB8wd02AqeRBr/B
         lzfu/wW2z8yfRnFdZmtyJ/Yx5/0hqU2LYRXLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvPpDrJRTISjRmaitgDIto8RJyndLCc2sSj57LCcK5s=;
        b=RWrWgu9WHoX9a1PKqk1cBOmSXDadeC+mRkKvhaPl5/CfBFxgrHFUKDsFd+pUlcO9oE
         qJBn5/oHC0hYhBdpvarkprc/w1KCgnWvQa0ICj/QBRTKo1McaNxx1fp6OpzvWYXdNIIA
         LO1VebjSw0ROCyV3iMtx2YKUafGZ5sCnuZWCCDfcI89MSZ8cMVlAsmqSMPRZYqcK8pQF
         bqX2y6E75c27kbGJRdgAiJrshYjTJ8Se21ZK4dP3dQM3iPCHT0MWp9eI5fFNl1ZKzvaR
         qLvQPSnyS4WQOhOUPG6MUqzFStyHNnAAiZLIo+dKOnqrCqIOxdThDhuK8WRSu4nW/R4G
         WKTw==
X-Gm-Message-State: AOAM532nwyhFG+4ui8wzM+3W8EA7JxC8LSE5U0JXHwh68wLavZBAIICK
        8EzVhWOZZNbdCsDl5olHstfGEQ==
X-Google-Smtp-Source: ABdhPJx943rWOZXiT1nWV3r0+zppQzp7AjAdvm8rHRNKXd1IRHY+obmDA08JLGYcXz6Qui/u3thMaQ==
X-Received: by 2002:a17:902:8c8f:: with SMTP id t15mr16690559plo.183.1589818104936;
        Mon, 18 May 2020 09:08:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm8225907pfo.3.2020.05.18.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:08:24 -0700 (PDT)
Date:   Mon, 18 May 2020 09:08:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: const-ify ngroups_max
Message-ID: <202005180908.C016C44D2@keescook>
References: <20200518155727.10514-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518155727.10514-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 05:57:27PM +0200, Stephen Kitt wrote:
> ngroups_max is a read-only sysctl entry, reflecting NGROUPS_MAX. Make
> it const, in the same way as cap_last_cap.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
