Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62507C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384B32068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ilan3iZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGMC0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGMC0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:26:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D43C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:26:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so5368091pgg.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7MYaIX+wT71EJvLWgWA8JA0RGTIZ3wbXsQ2GKe7NSw=;
        b=Ilan3iZoZmROtJNhs74jfnx1uUwFqbZ9FIHrlgLhPBuhNvJADRLACQ425GmwK9LEcY
         DcWI5SKoLXnQOD4CjGCI6hAKadCYNKS510LmQrbkCSXfEXtyroqyLHBiMKi/sxCNTCaB
         bpKBPKqdu2lLKm5eksty5ILO++cGoBgBFMh/hQqvwUHFj6H2+w+uAP/CEUAm0bahI50Q
         BJCGYPWWjEV5upJ2XSKwxEElZRX+AHjCeM5kFqWUz09YuKDFN66OErOt+ofqsgkbBz5D
         /yG4MjdBBIhFIz01ksGbhx9/co1uEcSMS6zfHP/lMyFBwCZWgIYB0dfWTjthWH3ei7k7
         dW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K7MYaIX+wT71EJvLWgWA8JA0RGTIZ3wbXsQ2GKe7NSw=;
        b=EuKOK/burWhGwhfILLTZoPNxAjgdKtDrH+SSldZl4Hzvgf5ieC6zNjOGY5ZtIEeVFS
         QvRu+O8+jr5BtdCjL5uQJczwdG9eQq0j1954IZG78U/DOyIme4iQKtbgB/wJtQAWH4K+
         r71+rOcOhUcGQBiDn1OWkNWGJ25opnR+k19otDsUualPmcTX3VEdBg+xH4wykq6urQc4
         Zk/r6aHuHyV8a8rxMCbdqdw4vj4YeuvOwuMYcngg8gUiB/Lwh5r3CLEzWizzw1CsLwzQ
         TOmi2mgv8S9w3OXQvpmPuzuxnfohuZacNeHgI+jVpLavqMJTSPqIGaXLm0uLv/oMRkzq
         4BSg==
X-Gm-Message-State: AOAM532VsKGBkSyfVNobJ+evwiY9FQFaAwnJM8A+sYVKjGGGSQZflxzs
        t+P6jViM5lNXvJfYK4Fud8c=
X-Google-Smtp-Source: ABdhPJz5WPfbo1qjfg+warbSMJgxBFnFz+PRzO15Kx7y7n3fX3y1SHO2kCDjq3imq/qFoNq0XMAbWg==
X-Received: by 2002:a63:571b:: with SMTP id l27mr68389176pgb.417.1594607162752;
        Sun, 12 Jul 2020 19:26:02 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id w1sm12007792pfq.53.2020.07.12.19.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 19:26:02 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 13 Jul 2020 11:25:58 +0900
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, torvalds@linux-foundation.org,
        Jason@zx2c4.com
Subject: Re: [PATCH v2] doc:kmsg: explictly state the return value in case of
 SEEK_CUR
Message-ID: <20200713022558.GC491026@jagdpanzerIV.localdomain>
References: <20200710174423.10480-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710174423.10480-1-bmeneg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/10 14:44), Bruno Meneguele wrote:
> The commit 625d3449788f ("Revert "kernel/printk: add kmsg SEEK_CUR
> handling"") reverted a change done to the return value in case a SEEK_CUR
> operation was performed for kmsg buffer based on the fact that different
> userspace apps were handling the new return value (-ESPIPE) in different
> ways, breaking them.
> 
> At the same time -ESPIPE was the wrong decision because kmsg /does support/
> seek() but doesn't follow the "normal" behavior userspace is used to.
> Because of that and also considering the time -EINVAL has been used, it was
> decided to keep this way to avoid more userspace breakage.
> 
> This patch adds an official statement to the kmsg documentation pointing to
> the current return value for SEEK_CUR, -EINVAL, thus userspace libraries
> and apps can refer to it for a definitive guide on what to expect.
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

Looks good to me,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
