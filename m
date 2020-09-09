Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C12FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB3421556
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="CrxiqY4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgIIO7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgIIMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:22:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517EC061796
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:11:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so1238251pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CSI24S8plBTXtRgEcDOdjCLZsD8Xjzm/x3QvW5GzzA=;
        b=CrxiqY4eqzLovv8Iwz2sAdv/R4dvPyNaEFS0bl0Q+eQt7YSX9DLk69dRuVBaBnrwPC
         dwVAaK9uxYzBLmAen/KHnYGaWDrzgLDsfx6T4RyahPeFdLRkP2buCCet/pe1TM5R5u2+
         qQh+wQMV7HSCveHSET/gSe12NjhmDGKAwhuooc8xiJ/6oCr/2bvkwQ7TIpSpu1fQ9gT3
         uBOLib7VicZvdfGzBIFiOEpzy3rFbuaG+lLUIlSPI3Yx0IjLBBXZhziDHGXZgWC/isaM
         o1HzfXUgWdjlOMoTc6KbAWnC1rcRnvfBQIAgDTG0LxaH/ur8p/t6j4YdTsfDhV8NUT5O
         gr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CSI24S8plBTXtRgEcDOdjCLZsD8Xjzm/x3QvW5GzzA=;
        b=AQn71Di0OFpqTZG2BqO5Kkw3l2sfRv8IOhe7LlhxULuOFQmKZIUSgTTecf6ciKrQvY
         5SCEtR+WkRuK1eFCcdOUZfidbX+k3EVBqI2edz7KHdkB1C6L091nStP+TTS3lzWHy0UI
         fxc0TgGVZGA2Z81h8W7pUXSQiMCozUc43E5ps61nEmzc4tZmWaghOmLLispIymQJ/S0m
         GCmR+WJW8Mo41h5m/BzWD4qq1mZNan9GVdnPOxYPmC29zWdwkmeWGAltOnOWihj7LTsJ
         ByEN1v7dZL87jqLC6O69QfXKKrWKcGnzN84a0ituTvFBjcajGDWW4Dl/QcY6vEWu8eWz
         qlvA==
X-Gm-Message-State: AOAM532wbjBMGZjJFZbGOryGoZTM5XB3AngEcYC+AMLmRo7zVdSQSMKy
        v+t+qlrk8CeeBrnbW0ZwJmpugQFKlnxQ8Cjlvata+g==
X-Google-Smtp-Source: ABdhPJzSzC6P2DfhIWtu+y/IAzCXD0HNAlLfeRfx9UE1/C1qO6I+SsnJZKvhdRFgxyCmlNAKHQM8UXJ8SnF5aucb8yU=
X-Received: by 2002:a17:90a:bd0e:: with SMTP id y14mr577786pjr.13.1599653475051;
 Wed, 09 Sep 2020 05:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200908142456.89626-1-zangchunxin@bytedance.com>
 <20200908150945.GA1301981@chrisdown.name> <CAMZfGtXDXzv8FEZa7cw6v+jV4ODnVuA3_UGEGWm7eTtZWCU+Bw@mail.gmail.com>
 <20200909095915.GA1412646@chrisdown.name>
In-Reply-To: <20200909095915.GA1412646@chrisdown.name>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Sep 2020 20:10:38 +0800
Message-ID: <CAMZfGtXe_5AqdDA5hRfT+CkKVYO0mdvN4k4_D1jXoZneP+jTdw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/vmscan: fix infinite loop in drop_slab_node
To:     Chris Down <chris@chrisdown.name>
Cc:     zangchunxin@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 5:59 PM Chris Down <chris@chrisdown.name> wrote:
>
> Muchun Song writes:
> >1. Double the threshold currently hard coded as "10" with each iteration
> >    suggested by Vlastimil. It is also a good idea.
>
> I think this sounds reasonable, although I'd like to see what the difference in
> reclaim looks like in practice.
>
> >2. In the while loop, we can check whether the TASK_KILLABLE
> >    signal is set, if so, we should break the loop. like the following code
> >    snippe. Thanks.
> >
> >@@ -704,6 +704,9 @@ void drop_slab_node(int nid)
> >  do {
> >  struct mem_cgroup *memcg = NULL;
> >
> >+ if (fatal_signal_pending(current))
> >+ return;
> >+
> >  freed = 0;
> >  memcg = mem_cgroup_iter(NULL, NULL, NULL);
> >  do {
>
> Regardless of anything, I think this is probably a good idea. Could you send it
> as a patch? :-)

OK, Will do that thanks.

>
> Thanks,
>
> Chris



-- 
Yours,
Muchun
