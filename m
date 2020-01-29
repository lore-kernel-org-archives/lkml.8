Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5D3C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6994F2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R40RTKe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgA2T7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:59:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33722 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgA2T7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:59:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so1032693wrq.0;
        Wed, 29 Jan 2020 11:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=KQIYlN5HOzFLhj5jtZda0TleOgpJJL47WY9lbMV5qaE=;
        b=R40RTKe7WBKBnBEp0jxvh939RGtvGnrdQ6+w2eJ9G3ZTyQm04eL1t1l8zGvypgaWEP
         ny4vpG+D418EgNv5qlyB2KYXj/ENl/0NIktSuYURCuX7G+n6zOmsT6o68lAstP3J0Wim
         /V7+yDVa4tAn50n8OEqPX8jRaLwq8zodDV4XFmpqVty7vgD/shUTJX4wbm/9Q7gjOCY3
         VOEtrFELoH0qF1Thdg1nab6Rx0LLHDOqI1TEBG73rX8kDJRQh/5nJQ3WIGe6F80jOkp6
         cpkZD+Ml0stPGI3ul6akaAlXrSdrA6SThselx7k/90lWuy37rw0EgeFFmLS/AOtda3Ww
         AQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=KQIYlN5HOzFLhj5jtZda0TleOgpJJL47WY9lbMV5qaE=;
        b=ZeUcXvmN+8yJE4r8Wlq7RMaMIvuR0+ihkgt94BAneEt+EOFcV3LM1SJzyj/lzLC9WA
         s5NuOv+ULIUezn0N+yNRA0w0kblEXBqTaHNQF5AP4MDuBl8f9s1OHrVaVj1c/kGnqQEN
         4Py1nI3zod/iqdIgNdsEB5mJu57f6KDfJkmsaiUd3u4sbhgkI5Om8OpUJCv1fLAVF/Jl
         fV8EL2ZUeDqs7gMN2hrdEzIyAwmWiPQXpm64XgeYavLem0m0a5Ov2JSwLA3Vd6spEPsF
         eIFau3HtkK/3NU+gruUGRHikhNH6kiOu5CJBAUGOREKtkBg9txM8vRxcX+mN/2ZxnE9H
         v9nA==
X-Gm-Message-State: APjAAAU47et+qD2vdC+kJROIkYxqSeJ0WgQcdQivX3vJT5izvX4q8B8I
        dTO1XVNkdO6xwaGHKUsZHKg=
X-Google-Smtp-Source: APXvYqz0KHMdjB7MhvC0D8454io/mcZS6Qf9m8UNey648Oqs3gRg9sIQpSRw2pSRTKlNbq3z5VwmpA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr495290wrp.378.1580327986979;
        Wed, 29 Jan 2020 11:59:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:8f9:806b:30e8:a48e])
        by smtp.gmail.com with ESMTPSA id z19sm3303877wmi.35.2020.01.29.11.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 11:59:46 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     SeongJae Park <sj38.park@gmail.com>, sjpark@amazon.com,
        akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        acme@kernel.org, amit@kernel.org, brendan.d.gregg@gmail.com,
        corbet@lwn.net, dwmw@amazon.com, mgorman@suse.de,
        rostedt@goodmis.org, kirill@shutemov.name,
        brendanhiggins@google.com, colin.king@canonical.com,
        minchan@kernel.org, vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Re: Re: Re: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Date:   Wed, 29 Jan 2020 20:59:07 +0100
Message-Id: <20200129195907.4589-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129193616.GT14914@hirez.programming.kicks-ass.net> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 20:36:16 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jan 29, 2020 at 08:06:45PM +0100, SeongJae Park wrote:
> > > Perf can do address based sampling of memops, I suspect you can create
> > > something using that.
> > 
> > If you're saying implementing DAMON in 'perf mem', I think it would conflict
> > with abovely explained DAMON's goal.
> > 
> > Else, if you're saying it would be the right place to handle the DAMON
> > generated data, I agree, thank you for pointing me that.  Will keep it in mind
> > while shaping the interface of DAMON.
> 
> I'm saying it might be able to provide the data you need; without damon.
> 
> Might; because I'm not entirely sure what you're looking for, nor
> exactly what events we have that provide address information.

Thank you for further clarifying this :)  Will also address this concern in
next spin.


Thanks,
SeongJae Park
