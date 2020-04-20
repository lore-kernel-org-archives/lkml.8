Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34AC54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB900206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="MtTtVazM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgDTW0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgDTW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:26:46 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38327C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:26:46 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z25so6145771otq.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnN6t9hfQo+VsrAYXTcci6beWWsRl0rIw4dpYadHnVE=;
        b=MtTtVazMtrYKkRDqDEkd4dL/KC4Gj9jH/4FFdLlgRHwjPj0549U5suwucimHv5H3iL
         Ozqztn+t5yOQ4ubc7+EHAghRlsT3JUSS8LiKeHbsCoKUELFW1L2WSpmzFL7ypEtkqrus
         RoxKiTy0S7Y5CPwP7Y7wXtHbwfd8AP6OMXcg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnN6t9hfQo+VsrAYXTcci6beWWsRl0rIw4dpYadHnVE=;
        b=E4Yo2lu3naamNbnDd/LGiD1itZCYBawWZ2JjuxAE8xlxz4TGYyDPbtIfHjMd3OaNvG
         H9Vgo+DRVRZECoTIs1Jn8nhE3csDoHx/fKDYSbeYyJwK2YZt+vPBhpZ/H7hoax2xV9PV
         FhcLczWUMQtehRcos4xJnLCHlQ70m5SH/MvCZ5qW+Pr3E9NFRZPqbFbTqiWwUlVMIfiT
         3dkiM3TVZfRwVSvG4S2/nFv70GwN/QzReuWaxvBmNE/Eph2lcFnaEsIWBkZM/9JEnOLD
         3wDMUhaORAogCk2JGlq4WB+oLma5KlGEhvvCzxWseNl59ezN4GtciQjujXnp/g6Ncgvg
         srUg==
X-Gm-Message-State: AGi0PuY9z0ePIROanth4N7NQWYF7uKDwGOhqJxhAsieVRVXr6hjr9LMg
        CCkyLbMUBVADWxoRoy1A9X82iAHV6MfSt8cOm+1GeQ==
X-Google-Smtp-Source: APiQypJNwcRYG+FszSl8XzFOKZQek2T3+gBQST3o0l/P+JoAVb2HthS7dQknFIOl306wE5IwI16eu9BfyDC0N/bmwLc=
X-Received: by 2002:a9d:7dd8:: with SMTP id k24mr6196388otn.33.1587421605462;
 Mon, 20 Apr 2020 15:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net> <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain> <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain> <20200420080759.GA224731@ziqianlu-desktop.localdomain>
In-Reply-To: <20200420080759.GA224731@ziqianlu-desktop.localdomain>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Mon, 20 Apr 2020 18:26:34 -0400
Message-ID: <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
Subject: Re: [PATCH updated] sched/fair: core wide cfs task priority comparison
To:     Aaron Lu <aaron.lwe@gmail.com>
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
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 4:08 AM Aaron Lu <aaron.lwe@gmail.com> wrote:
>
> On Fri, Apr 17, 2020 at 05:40:45PM +0800, Aaron Lu wrote:

> The adjust is only needed when core scheduling is enabled while I
> mistakenly called it on both enable and disable. And I come to think
> normalize is a better name than adjust.
>
I guess we would also need to update the min_vruntime of the sibling
to match the rq->core->min_vruntime on coresched disable. Otherwise
a new enqueue on root cfs of the sibling would inherit the very old
min_vruntime before coresched enable and thus would starve all the
already queued tasks until the newly enqueued se's vruntime catches up.

Other than that, I think the patch looks good. We haven't tested it
yet. Will do a round of testing and let you know soon.

Thanks,
Vineeth
