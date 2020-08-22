Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15DDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC67720738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598112371;
	bh=wwRY/NHzLLJH7Pz6XeoDUl6RhGYuBFHXf7ymbvyB7Fw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jB3FzeoTvMYkDj28S3PnBHgKL47lIQ5V2lrj9LmNB9Bg1ceymykmorq89viQtoPK4
	 nTPpYiurZ1GF93uphpCFCeA01ItsudC0pWhDO0RDD3DYqNnIuf5cIGRuWxqcmVmu+1
	 jwrOmEioI4p+rSgzGXzYWI+/05j8UqkAzRpc2WKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgHVQGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgHVQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:05:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:05:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so5081327ljn.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCOteyGRyHLlleJ2kVYBfkztXYhY3DPXBVegbukXECs=;
        b=XgLZo1E3UlNm7AbkzgPPqXS4AkCdSZRGFs3Tgq0bXjoZdTMa2MO3QW3EmND8SAWUIH
         5Odo+4Pfl+8aylwqwbGkF+AenDA2NrCtmrCAeKGUhE3JdiuQrDKS7Lz00QSpvrFSCJRC
         nHvVCVnIjn1UrZTJPtou0UEuYag9SNOF1sI3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCOteyGRyHLlleJ2kVYBfkztXYhY3DPXBVegbukXECs=;
        b=BIxrVp/orwDZnFIaV41mZq0sc/o3gAQSwF2Jk/7QY7b3Wbc62IxI15NfxIeQdPCvAv
         NQQhop/QWvYGX6CSyPCo/+iyu49/j4CCfKCCroMwnmfYBwxjewBR5VQDCHyu3uJM0a0Y
         FsEdEj8kgh3HIGhjAQpesmyCo4S+/QfKQY17XTGoEERM9Tmdc/IMMg9Q57pAZYYAOZ6z
         8Y76cWush83B6Y4dl5KEZk9ij3ORQ0Qi6yDLHGIujVHc/lFkJWhPKW4sKM5u037ISbo7
         3Vh0FM0sn2CdK+bK6xs8ch/5MilOd7M2wB/5AgFhyghPAoITahNLBiz+Wz6ydZY/Sd2h
         rqtQ==
X-Gm-Message-State: AOAM533k1fQ5cZGE3+Qvfta58m6qTc0tA5m7W2X0oQPJtEQUKOMcKNEF
        iKdfkcYRDD1RJX68MRl7SnvriBucO7CoVw==
X-Google-Smtp-Source: ABdhPJyTK+omIP+Xb9maXiB3Rk/m1a8hHkhCMaqfSzDfH1dl+WXsBctNKQAHrVOgYPwcxH2K3nbVOw==
X-Received: by 2002:a2e:a370:: with SMTP id i16mr4135560ljn.22.1598112354688;
        Sat, 22 Aug 2020 09:05:54 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id c17sm1084290lfr.23.2020.08.22.09.05.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 09:05:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g6so5046597ljn.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:05:53 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr4223772ljp.312.1598112353202;
 Sat, 22 Aug 2020 09:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200821234958.7896-1-peterx@redhat.com>
In-Reply-To: <20200821234958.7896-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Aug 2020 09:05:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ_bqiEXrwnAratT+2N+VGdhEsK7xShaj04Dgo2JNwtA@mail.gmail.com>
Message-ID: <CAHk-=wgQ_bqiEXrwnAratT+2N+VGdhEsK7xShaj04Dgo2JNwtA@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: Simplfy cow handling
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 4:50 PM Peter Xu <peterx@redhat.com> wrote:
>
>   - Run a busy loop dirty program [1] that uses 6G of memory, restrict to 1G
>     RAM + 5G swap (cgroup).  A few hours later, all things still look good.
>     Make sure to observe (still massive) correct page reuses using the new
>     counter using the last patch, probably when swapping in.
>
>   - Run umapsort [2] to make sure uffd-wp will work again after applying this
>     series upon master 5.9-rc1 (5.9-rc1 is broken).

I obviously like the diffstat, am wondering if you saw any throughput
changes or similar for the busy-loop dirtying thing?

              Linus
