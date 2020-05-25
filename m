Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DB5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE24E2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="OYhfUff4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390926AbgEYOgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:36:47 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:36:47 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w4so16201894oia.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kw2fKaRKvOIIxpRTa8x3Y4jbYK2CA9gBfngQDWLTWO4=;
        b=OYhfUff4HeNuD4TiomdTQEIqVMS9FcFID+h/dgJYNqRV6WTC/nWx4s8+U8ymAQL+xu
         8Q+dzHfrBzHP+xqHi8Q+w7on7g0RSTjbgkGy87O2//lasA5VabsUVDD49fqer+2bxKCK
         jPDgpQtAcS8Vr3J/XFObPZb2gbjqnvWBp+bzkMyeIgLBsXK4DGk43toSoI0tv1vmo+++
         et+Vb4YX1kY3pzLKukpZaOayruopaNrQyk1zgVTPOn8MMMbf1iA61ort89lLRKT9zloK
         WwMUPJ+jXED2hXh56Wc0DCkqYS4UE5QdNJrmx7CUJdh/J+jlFZCGuNeAH85wDJcLxd+P
         WAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kw2fKaRKvOIIxpRTa8x3Y4jbYK2CA9gBfngQDWLTWO4=;
        b=Tgdu2NTchjXc+WFz0qoMuq2hTMzUuydwVaXOOLCa4rcbRuBeqCtv9gujKiRLilGoZC
         z3EU5DM6GX1BrkURnUwX0jDkrn+Zc2wTkwKfDoxirEW6dZaXRJXBoRJGyaP24mFEZ17Y
         b6Qgy6IbJd9jRpHxSDi/wQJHCh28JKuHg3OZ3qiOZZhPuBtl1E1Kg4NnP7MjMq7+f5+X
         MCjolME5xowoxvwibg+QjjHihA53CJq3BVpcdrw54j6MKweVoaUCAPY2/pHMdMQEUIs3
         q14e5sD8H0hYLV9UbOOFZVTCGf32bjX/fBhMOU5XI8n5lt25JjQq3Fkdh5f+PkIvdhLc
         G2tA==
X-Gm-Message-State: AOAM532SnuAaruI8akkQyNu8w1RjAqBArvR6Q43Y8R2e/3v8ZSpqc9n0
        RoeB+fY36Os+4vxIzJ3QTQiMOg==
X-Google-Smtp-Source: ABdhPJxtiNlpD3jfbjf1oM2QC80aG/lFgqA1MfUGS6Q6/6T77Pk3NAH+SW2BlbBbd5ISrz98mRGRCw==
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr11190788oic.73.1590417406651;
        Mon, 25 May 2020 07:36:46 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:e9d7:5ec6:88ea:b4a1])
        by smtp.gmail.com with ESMTPSA id e91sm5108353otb.40.2020.05.25.07.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 07:36:46 -0700 (PDT)
Date:   Mon, 25 May 2020 08:36:48 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     guoren@kernel.org
Cc:     keescook@chromium.org, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: Remove unnecessary path for syscall_trace
Message-ID: <20200525143648.GM2605652@cisco>
References: <1590416306-66453-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590416306-66453-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 02:18:26PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Obviously, there is no need to recover a0-a7 in reject path.
> 
> Previous modification is from commit af33d243 by Tycho, to
> fixup seccomp reject syscall code path.

Doesn't this suffer from the same problem, though? a7 is clobbered, so
the -ERESTARTSYS behavior won't work?

I haven't run the test case that was failing before.

Tycho
