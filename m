Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F957C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CC620733
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guum6PPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgBKDFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:05:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45863 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgBKDFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:05:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id f25so9808715ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rn1p5/lbII7V0l1DMSGRcwSDsU+MJEO/butD3aVJNuA=;
        b=guum6PPtD1iOwa4ooNUwqPjTFmwIQ/xQ0faz2TiBp0KPQrQF3UVcefGkxRbeVYiINs
         +YVKuygMkTJOncncS3155kQZ5zBIubwY+m25rmuIoWWFTvQzsqEo9JpMRJgI0cQB4pmu
         BI2urrkfveF0K4daq5C/lEvwag4nCZ1ESATAZt4hOHNdhEOE1uXAMworr0DpI8ddVw8+
         RFBTaIN2ArCVMxfcKaCD64VVOd/GcUX8teHiAseOHT4rqMBoKlFW30VLyOZTn7gygkv/
         Fy6ix+B8Ar7lFjrIv5Fbr561bSKf6fsPjJ0lH/2lM/lJu8UdqPqA0jAuIBOqFTJniVvK
         gMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rn1p5/lbII7V0l1DMSGRcwSDsU+MJEO/butD3aVJNuA=;
        b=hvsbOF/Ntuxo2OSkJJRC8e1gxaNAY9naAk+CwHyez76RD/7RGsH2kALiZfo2quRf57
         MpILsGcnQpJi/ApN7ds7gD0+7WPvjGJvu3ZVdiBzk9e83mDxTlKZLAxQMFSCQ52S+VJi
         FSzyXdtDdOI9hSPHEdjvRCUNy1SgmkxpmGpUEsGSOe6mFfoUQ4ZRS5Yiu8TWaCrKv7Aj
         LoK24kQZpD4vCKDkxn7rX+UymgCwqclBDEEjaNfedz4q9vTEmeORh3/G2pOHVsehohJd
         ZoMiW9cTZrrNFxkFaXEwergN/FNCBGN8gYuILU+HJv6BURMgLpd3mezZlS2sg7SWZDiK
         ekBQ==
X-Gm-Message-State: APjAAAUySg0+HcDUy9oWU1qewg6Ejle4N4u73nb3z7JRCYdD7rcBQv+d
        lApn2PshoH8E/KzBW312nLH7ti42xgFLKrkw+wL/
X-Google-Smtp-Source: APXvYqxTuBC6NMIfx2oMrv2OzCdieAow+fuZIbybDXCjPhR4HXXqs+o9SBh5c2NOTYtoMOJPhlwP2Hd3dmzMo8D4zTk=
X-Received: by 2002:a2e:9157:: with SMTP id q23mr2788619ljg.196.1581390346310;
 Mon, 10 Feb 2020 19:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20200211011631.7619-1-zzyiwei@google.com> <20200210211951.1633c7d0@rorschach.local.home>
In-Reply-To: <20200210211951.1633c7d0@rorschach.local.home>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Mon, 10 Feb 2020 19:05:35 -0800
Message-ID: <CAKT=dDm+UKqa7j744iTsvYs+jqrdOHpTqdksRUjDe-6vqkigew@mail.gmail.com>
Subject: Re: [PATCH] Add gpu memory tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the prompt reply!

The tracepoint proposed here is for tracking global gpu memory usage
total counter and per-process gpu memory usage total counter. The
tracepoint is for gfx drivers who have implemented gpu memory tracking
system. The tracepoint expects the de-duplication of the shared memory
is done inside the tracking system.

On Android, the graphics driver has implemented gpu memory tracking.
First, we'd like to profiler GPU memory with this tracepoint. Second,
we implement eBPF programs and attach to this tracepoint for tracking
GPU memory at runtime on production devices. However, the tracepoint +
eBPF approach requires the tracepoint to be upstreamed so that it's
considered a stable interface which Android common kernel can carry it
forever.

Best,
Yiwei



On Mon, Feb 10, 2020 at 6:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 10 Feb 2020 17:16:31 -0800
> zzyiwei@google.com wrote:
>
> > From: Yiwei Zhang <zzyiwei@google.com>
> >
> > This change adds the below gpu memory tracepoint:
> > gpu_mem/gpu_mem_total: track global or process gpu memory total counters
> >
> > Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
> > ---
> >  include/trace/events/gpu_mem.h | 64 ++++++++++++++++++++++++++++++++++
> >  kernel/trace/Kconfig           |  3 ++
> >  kernel/trace/Makefile          |  1 +
> >  kernel/trace/trace_gpu_mem.c   | 13 +++++++
> >  4 files changed, 81 insertions(+)
> >  create mode 100644 include/trace/events/gpu_mem.h
> >  create mode 100644 kernel/trace/trace_gpu_mem.c
>
> What exactly is this, and why is it being put in the tracing
> infrastructure code?
>
> -- Steve
