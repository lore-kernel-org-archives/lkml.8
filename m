Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6148C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89209207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="K21CmpkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHEEyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHEEyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 00:54:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63224C06179E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 21:54:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t6so3639686pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 21:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYCQlIkzg67iN4PflE8iywKTCPG8vSpboFXW+JvF3bs=;
        b=K21CmpkUagMRtBPpA73E3ebTNyhpUWKOwUpsv9WNMiieMdLiZnYar8K8jPuHZGK3E8
         8w12hgheCn8CkvUzAYJ/oq6UxtzFu13cxOKErlWlcS89ClpLAX2u79Jh3oI/8s65/hdS
         3/nv3rPIYrWZJTyEgozv6gtpVlc1a09/F6MyXwIHz8Uom5BBQNck015vr2Fb1Fb84dfj
         Dsr7SErCuqP0srGRZfGacBuwiUgI83LukV4XQVlrgZTPb8LClnzA3de/e6/NTCuxdwUd
         54k9tjlcTwTYshXkRJRq7+E2UVtS+/VY0nBOG9+/B+WlBIZ430qBSHjkDKr1dc960fqI
         cQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYCQlIkzg67iN4PflE8iywKTCPG8vSpboFXW+JvF3bs=;
        b=m05OXa6ITI+73B8vFEnHkCs6pJpK6+E7tK2A+EGRITQ8clINrzij6EICDYvSGC/3Wt
         IEagMCaAcFImPnUtM/vb7fPB04hntGmbHN5ocxZdKWQnPin/jUfJFIDNhQlelFHs4ZOO
         tWDkxOaiE/fSopWuSEFyDDxJjks5H1ibzhOUER64yVqgjtOmsyKYdMtY1J2iFrP/h4Ue
         br+lva+fl//hsRZgQaL0u7MPPaztAePMSoZFWB1lrN2Fo7JHr/aXrX6wc5IAoe4SfJi8
         0xWVy/V79bALFmCv6plIcpBSiT5E8xGye1BgEUraqgvPjW/wWQC5Y3ve/glUlaKBtyuW
         adow==
X-Gm-Message-State: AOAM532Iw0o7haSdDGeKmqicw//nloH/mxCvh6xXN+JHeLnvYamfnAmf
        ymBybgbVpLntTu8/+pTEeu28wGBDpFUeeW/oKlgj0ENQI/u5J7tw
X-Google-Smtp-Source: ABdhPJx8lhzU3SLTCTXaRcNfhn+oTEgFF0sx2/gEfFSroWOlyhiIDRSP/joPoUWfQREEyMuzsDvHnU6iUzBHH/dPC78=
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr1515639pjb.229.1596603255913;
 Tue, 04 Aug 2020 21:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200805142136.0331f7ea@canb.auug.org.au>
In-Reply-To: <20200805142136.0331f7ea@canb.auug.org.au>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 5 Aug 2020 12:53:39 +0800
Message-ID: <CAMZfGtX0a3tui_KQfCXLcARVcev9V-HV6HMkXgVXObq8w-4EQg@mail.gmail.com>
Subject: Re: [External] linux-next: build warning after merge of the ftrace tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 12:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the ftrace tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>
> kernel/kprobes.c: In function 'kill_kprobe':
> kernel/kprobes.c:1116:33: warning: statement with no effect [-Wunused-value]
>  1116 | #define disarm_kprobe_ftrace(p) (-ENODEV)
>       |                                 ^
> kernel/kprobes.c:2154:3: note: in expansion of macro 'disarm_kprobe_ftrace'
>  2154 |   disarm_kprobe_ftrace(p);
>       |   ^~~~~~~~~~~~~~~~~~~~
>

Sorry, maybe we should rework the macro of disarm_kprobe_ftrace to an
inline function like below.

-#define disarm_kprobe_ftrace(p)        (-ENODEV)
+static inline int disarm_kprobe_ftrace(struct kprobe *p)
+{
+       return -ENODEV
+}
 #endif

> Introduced by commit
>
>   0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")
>
> --
> Cheers,
> Stephen Rothwell



-- 
Yours,
Muchun
