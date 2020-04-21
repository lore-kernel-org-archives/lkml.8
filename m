Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46268C38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2131F20782
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8DLC6Uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgDUCvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbgDUCvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:51:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C29AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:51:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id ay1so4723589plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IOYiW0cFU06Y60gljkCOtUC5CPSaXPSr8wG1AO8tdlg=;
        b=U8DLC6UvGzn3yX4U5EL788c3XjR5qwjwp+otHn8goLviyguy500btfkwryCJF70/UK
         Yn4Ya1Oe57h489iWtFrjX6zVkOVWmGR9vzXItfTzVadrPXeyjS8zy5Ok/Oj3DmUygG0l
         K3ll1O6E6smgQ+fmrWapftB5MjBa3wFstmKhtMUtH3uqG1yNMMP0bHVhO3n8m9YAQfXu
         EMfvemgVZ2mp7jrLelChT0u6M0IXtl0MUzqnbxV5qeonA+U3WVg/YciJ4tKyrIOkmXSk
         uMID9uDLS1/2eTIM/nehg3bNPEpcpswvjHurq7qg2DQXDQDfYpDDByrOuT/dWF3WzxvO
         IlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IOYiW0cFU06Y60gljkCOtUC5CPSaXPSr8wG1AO8tdlg=;
        b=Y+DqPtEgTQPZHZ0bArSw+FKAgckjaL/z06oOE4hgmtXKEHu091dtP/KFJSczs5VTrr
         t9B7Lv6ufnkyBHfmPuMKBHsLjxWHKkFliTVD5V6ZbvYjOeJ7zBuQv2Oey7VoG6ecxZp3
         nkGNVRL6VYVv4/fPExdySc6iexrr5TnnSYbFaIh3qA+JKEF4nTNVjyt1p69H3FKLd0+D
         4OI1JiQ5d/MQlXvTehmLyLOXLaxL5rEy02ynLx8wxyA8INZ5nDREtVFLqXiljDX3MKXV
         ZKxPuKTD/maffscVwSbBzBv/PN9j0X6Nwp8HigcHVygBiQmHEQbdPAJ59kAqaLWUHbCw
         m4vA==
X-Gm-Message-State: AGi0Pub98WwTchEC9uwtjFL12sV7ogjCd544E1P+OhX9zD6nVp8lE4m1
        1jqlRir52hmUdtlqTxX0Pew=
X-Google-Smtp-Source: APiQypK0lDPPRyayFdvoNBnao08LfLtIg3qdqgMn31qx+vvzUXPFtVSkDAqqm9Qwbb3Hgs9jEeMuaQ==
X-Received: by 2002:a17:90b:19c1:: with SMTP id nm1mr2907310pjb.73.1587437500997;
        Mon, 20 Apr 2020 19:51:40 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id p189sm896122pfp.135.2020.04.20.19.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 19:51:40 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:51:31 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH updated] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200421025131.GA227300@aaronlu-desktop>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net>
 <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain>
 <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:26:34PM -0400, Vineeth Remanan Pillai wrote:
> On Mon, Apr 20, 2020 at 4:08 AM Aaron Lu <aaron.lwe@gmail.com> wrote:
> >
> > On Fri, Apr 17, 2020 at 05:40:45PM +0800, Aaron Lu wrote:
> 
> > The adjust is only needed when core scheduling is enabled while I
> > mistakenly called it on both enable and disable. And I come to think
> > normalize is a better name than adjust.
> >
> I guess we would also need to update the min_vruntime of the sibling
> to match the rq->core->min_vruntime on coresched disable. Otherwise
> a new enqueue on root cfs of the sibling would inherit the very old
> min_vruntime before coresched enable and thus would starve all the
> already queued tasks until the newly enqueued se's vruntime catches up.

Yes this is a concern but AFAICS, there is no problem. Consider:
- when there is no queued task across the disable boundary, the stale
  min_vruntime doesn't matter as you said;
- when there are queued tasks across the disable boundary, the newly
  queued task will normalize its vruntime against the sibling_cfs_rq's
  min_vruntime, if the min_vruntime is stale and problem would occur.
  But my reading of the code made me think this min_vruntime should
  have already been updated by update_curr() in enqueue_entity() before
  being used by this newly enqueued task and update_curr() would bring
  the stale min_vruntime to the smallest vruntime of the queued ones so
  again, no problem should occur.

I have done a simple test locally before sending the patch out and didn't
find any problem but maybe I failed to hit the race window. Let me know
if I misunderstood something.
 
> Other than that, I think the patch looks good. We haven't tested it
> yet. Will do a round of testing and let you know soon.

Thanks.
