Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D7C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D850C248A1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UBwbD9Fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgDFPzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:55:32 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36136 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbgDFPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:55:31 -0400
Received: by mail-pj1-f65.google.com with SMTP id nu11so21670pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSjkzhFEiFJjyufT8+HraUsb7czl0gNB79kUOtKiYko=;
        b=UBwbD9Fh2afx2lBbBBT4XMur9J9n4jUPu1rc4OUDGxMx+Ajc2wvGaAdQnMQlBkzsnr
         +8h6sXlemiz/8/52IJN8D40WBcKL/y010DcYxll1huL1G53cvuCJrvKJKdU1bhRZN5nY
         mW08EAE7q6lAjTkd4M3LAdvYDNmIr4f3nSivA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSjkzhFEiFJjyufT8+HraUsb7czl0gNB79kUOtKiYko=;
        b=gUMAXJa4jp5yFsqYGqablV7GjJJoMg4Zdo6p79iQjovcn3nTSIE/PwwFf5F+lokRwy
         ef/2mksmsOi6zckzTtaaVRaZVH8TlL5v0llNmLOjSHh1nPocd9kq0yeoFjNGsYK1H3D+
         ow/LV74eCZoQ1Ku1xHqceyEe+Bue0hhh5Nawki78K29NT/wBitppoPzRSxrNJkKWd/iR
         TkM3/E+AUrllFIQLHMpEKeT/ZTIbcmix6/1gQ2p2LwQu+6Cjw1nJdRx1dtCf8H17dgGz
         xLZp+YJBTi6E/jBJIBlyVRttRzvf+7RUQMY39PCOAcdNkXdfR1vDcCSUEMEQ+ORJJydB
         JRVg==
X-Gm-Message-State: AGi0PubYwArvsqshgjHcP6j4eKWTTN8Kd1zrF7XGfT/fT+zgibMCaYBr
        89jn3t/qUHFVVmN9F0p7AcmtoQ==
X-Google-Smtp-Source: APiQypJq6G4sfj4F480buN+2USewCEdxsSs+iaxAsio9clFT3schIx04v6ekH8nGfBzDTwyT28JlCQ==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr20706329plt.111.1586188529962;
        Mon, 06 Apr 2020 08:55:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm14581pjf.26.2020.04.06.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:55:29 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:55:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, penguin-kernel@I-love.SAKURA.ne.jp,
        vbabka@suse.cz, rdunlap@infradead.org, willy@infradead.org,
        kernel@gpiccoli.net, dvyukov@google.com
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
Message-ID: <202004060854.22F15BDBF1@keescook>
References: <20200327223646.20779-1-gpiccoli@canonical.com>
 <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:28:41AM -0300, Guilherme G. Piccoli wrote:
> Hi Andrew / Kees, sorry for the ping.
> Is there anything else missing in this patch? What are the necessary
> steps to get it merged?

I'm expecting Andrew to pick it up, but it's the middle of the merge
window right now, so there is likely to be a couple weeks delay before
this will appear in -mm.

-- 
Kees Cook
