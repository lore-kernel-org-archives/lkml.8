Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA72CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA0120702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bpivmHxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgF2T2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbgF2T1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4CC02E2FF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:41:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so8123186pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XjoUiklDUvReiT2FIC36A2hl5VE/H3fiq2YzGlb2P2Y=;
        b=bpivmHxjHOQemBKCF8WRC13meg8lMT7C+NNOuOy6BrGSoam/fNHBKzQxojfV+qVaNJ
         /mNFtrkij3lL7ItNwU3KXiX4SlBGRuKr93SpibdVw4a6rIN0ic6E0t/IBuU/7Zszu01I
         Wk45hxoJW7EWFmOy5+QOjF5j4wv/hxrUZMGoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XjoUiklDUvReiT2FIC36A2hl5VE/H3fiq2YzGlb2P2Y=;
        b=oIIj8lom9Y4T2KK9W5hcpgQBS9wATcmXJb6tCwCm9Zn0yZl0ht8qEgFnZjq500t48c
         XHjxNT87Kk2GJnYm6qmIIC7dhjoSZPhehpT5GkT2gu/FfFl1POxb9/3k50u8EaJ9nofT
         QshYdCTFW52TU7Y9cuX56eFStbMhOEFfPtqOU7qz3hlhRPgCdZHzz1xKMTLVZ38gFlv3
         GeJLCIN6UKU36+M0HNuMqj/dIyHE05usRAUE7K/Q+oiLRFkpDCYZ/mqzK0CDObw9TwwC
         oeeJU0Owob13yBRpKBN7/Jfo8TG+i8JMra2bJxBfD20KWoTov4ymtoD9doDdYHbwQUBj
         kydQ==
X-Gm-Message-State: AOAM531DAIj/ksYZoiJ8eQd6csEAdKzU49C7aPpqzkLi9J9pIVwmr7kF
        Tsq2jiUu4tJS5gswCW8o9PLB2A==
X-Google-Smtp-Source: ABdhPJy2v/Y3BhRwD+a0JnxcRZ/j8ybCygjQ+nNavL0Mzut8fwTYDWSvCr3VP7glN3bkr6JqDzthNg==
X-Received: by 2002:a17:902:507:: with SMTP id 7mr13452603plf.186.1593441718881;
        Mon, 29 Jun 2020 07:41:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9sm29483pfh.160.2020.06.29.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:41:58 -0700 (PDT)
Date:   Mon, 29 Jun 2020 07:41:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [REGRESSION] 5.8-rc3: seccomp crash with Chromium, QtWebEngine
 and related browsers: seccomp-bpf failure in syscall 0072
Message-ID: <202006290739.8AB49B15@keescook>
References: <2293324.KF7j4Pszzj@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2293324.KF7j4Pszzj@merkaba>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:08:10AM +0200, Martin Steigerwald wrote:
> Dear Andy, Kees, Will, dear kernel community,
> 
> With 5.8-rc3 there is a seccomp related crash which prevents Chromium and
> QtWebEngine from starting:
> 
> Bug 208369 - seccomp crash with Chromium, QtWebEngine and related browsers: seccomp-bpf failure in syscall 0072
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208369
> 
> Reverting to 5.8-rc2 fixes the issue.

Hi,

It looks like this is from e9c15badbb7b ("fs: Do not check if there is a
fsnotify watcher on pseudo inodes")

Currently being discussed here:
https://lore.kernel.org/lkml/7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com/#r

-- 
Kees Cook
