Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44932088E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sN/5GAbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgETWaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgETWaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:30:52 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF4C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:30:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o13so3897200otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4meyUv3apA8iPicPJAJdGUiEC8vQmDAeMhqbnd2+eRA=;
        b=sN/5GAbLyv5S/YTIO3jPXHKk/tSB1ZTxqYGNbtJc7wDZ2bZeQo5Q1J0aVDMkn89qOC
         QYoeACQBxyB9swUKayNAX5GG3boQb7wfGXiZTggIkZtQK4tBUrgUtXBQ9iUdMHx5Zw+Y
         6nF8/RGFZKwheRzR3Z+FPeIJEIBPXXbA/Tnhlv8fw38SnqdRUab44lVo1qdNhCQuja7j
         /kVO7KGlAxNZdcZwuVI23DEXW7/3ShQRML4/PiBQ2o6czcKnFBrj80M4JiyQn5+vx9sg
         uS1X94Pq1SX8DV1tFZPidkXnNieyCeKxMlUnHITPfz4ahGkYrVn80hopyvA/OcnITsp2
         2afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4meyUv3apA8iPicPJAJdGUiEC8vQmDAeMhqbnd2+eRA=;
        b=Tjv/p+x2ttKJLRK11cKSYE9FRrX9zi4JvKe0/OTDgjFHP01ExcQdj437bZsyafHUvD
         7GxlYXDYtFJrmG+tnhu0np00XoVNPlkHzx0FXUU8KyH1ex/AQeg1KsvYk62GeVH67iDa
         s6LBYJczpDl+VzWn/NO4ZoPGBps92jpSdKmm9jHdq/Cq8opqpiUzYxBh/PLGe1R5eg1O
         kfOx8lmDlbhsGatGzXaNNqTAdIXiIxwcnwBdTwVHG9gi4BexXYVuMG/31/V7zi2kvFw7
         I6L/4i7wtIxAfeCyq/2clHZdKvgLtfClOHqnc1SDNXpapHqjjGPbIzi0BTKjDg26PHhD
         hS9Q==
X-Gm-Message-State: AOAM532PmDfO/MEpdh7sCdGc+XJ/l78a+YNjP6+Z0QBTiVRxwgII8Jfp
        5J+Yoeo8XnJqxNXe3yVXFPvijLkp7kBVHflXdoM5nQ==
X-Google-Smtp-Source: ABdhPJy4Jgra/VNng6E/OpyCiywEvyOQ+aFnAf0/rGeNsLRikA2hO5jssErrlOqsxruEzeJyspzmmfi2HrGN5TXfzyA=
X-Received: by 2002:a9d:27a3:: with SMTP id c32mr5249187otb.233.1590013850956;
 Wed, 20 May 2020 15:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-18-will@kernel.org> <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
 <20200520221712.GA21166@zn.tnic>
In-Reply-To: <20200520221712.GA21166@zn.tnic>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 00:30:39 +0200
Message-ID: <CANpmjNPsEMF8qq4qHoJEDb8mi211QzXODvnakh2fj3BOw+56MQ@mail.gmail.com>
Subject: Re: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN instrumentation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 at 00:17, Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> On Tue, May 12, 2020 at 02:36:53PM -0000, tip-bot2 for Will Deacon wrote:
> > The following commit has been merged into the locking/kcsan branch of tip:
> >
> > Commit-ID:     cdd28ad2d8110099e43527e96d059c5639809680
> > Gitweb:        https://git.kernel.org/tip/cdd28ad2d8110099e43527e96d059c5639809680
> > Author:        Will Deacon <will@kernel.org>
> > AuthorDate:    Mon, 11 May 2020 21:41:49 +01:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Tue, 12 May 2020 11:04:17 +02:00
> >
> > READ_ONCE: Use data_race() to avoid KCSAN instrumentation
> >
> > Rather then open-code the disabling/enabling of KCSAN across the guts of
> > {READ,WRITE}_ONCE(), defer to the data_race() macro instead.
> >
> > Signed-off-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Marco Elver <elver@google.com>
> > Link: https://lkml.kernel.org/r/20200511204150.27858-18-will@kernel.org
>
> so this commit causes a kernel build slowdown depending on the .config
> of between 50% and over 100%. I just bisected locking/kcsan and got
>
> NOT_OK: cdd28ad2d811 READ_ONCE: Use data_race() to avoid KCSAN instrumentation
> OK:     88f1be32068d kcsan: Rework data_race() so that it can be used by READ_ONCE()
>
> with a simple:
>
> $ git clean -dqfx && mk defconfig
> $ time make -j<NUM_CORES+1>
>
> I'm not even booting the kernels - simply checking out the above commits
> and building the target kernels. I.e., something in that commit is
> making gcc go nuts in the compilation phases.

This should be fixed when the series that includes this commit is applied:
https://lore.kernel.org/lkml/20200515150338.190344-9-elver@google.com/

Thanks,
-- Marco
