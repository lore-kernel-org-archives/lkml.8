Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CF4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232522074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWuDVdTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCMWsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:48:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36110 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMWst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:48:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id j14so11904188otq.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=gH+vH+oeiPGMFqi2IIAvq6zNNglZF+XoPGyI7E95+5I=;
        b=ZWuDVdTy2Lb7+FL+OE9ASOiOvFQb3Y/X2TYyIg0HfIPhi+QtrddD67fCjdlH6PjNPZ
         veEUtDwQTQ60onWES8RQZoC1KOPce9XGIZQmj3+3WNU7CJFHt9lnvk7IAe8WlaExkO8s
         XC4MDg8wAP5450Xln7JytB9C8pS17lN/9H9vtFq6NxGKVpog4JnnTQt7C/0f8RkeLjF2
         VzGMsGomsyvsZWB3rzYlcVPImDC8GsSYdfvOCvsj/zW6di8K1OvNsHCS7pCDyaJswMVp
         5aR5uAyovh5L7inqv2Tw7nElZ3SmpKJ+1AXNzEePBv31/cMmRcklJW0PPKPROJDBNMCY
         izmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=gH+vH+oeiPGMFqi2IIAvq6zNNglZF+XoPGyI7E95+5I=;
        b=eNWtMOXTD11EZe7xmXsVA8qcQifnrNoHll9dCFQ4RNduRE98aY3QlKH6D0JT3rMJch
         IAgOfZiY2D8de0Esh6KWMVJ7o1DYWquW67z899v20IgYDAUf34XYIZCh3jUurdQna4+z
         eyxAOQ3fcJhCSZtBbzmacEEyG0H+/ZMpqxjLaKP/cou+4JLm0XWEUACAnSggeo58vlYM
         qdnDnleTKLwwn4lHMicsQJUCkCX7mEA5HVFVt7T5x9T03NkI0M9lo0JdhR5izyHGHIXr
         uP+xBZziSKD5BRqskjOU6xhIFZnDxvHB58TibbpFRxDeNjv5oACQdKuMDLiWJPCyYwqr
         V0dw==
X-Gm-Message-State: ANhLgQ2hMQS3JWc3sR/hnsjZLrSLpZ5fr2gwFhkCpRHbpGV7tD6Sbq8x
        rKwysRnmsmUTA4WpgtbtB/YmEyWp5MPCrXyD4bRiag==
X-Received: by 2002:a9d:2028:: with SMTP id n37mt14133904ota.127.1584139727224;
 Fri, 13 Mar 2020 15:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200313223920.124230-1-almasrymina@google.com>
In-Reply-To: <20200313223920.124230-1-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 13 Mar 2020 15:48:36 -0700
Message-ID: <CAHS8izMcLx93DJtr0kyDz_qm_bNV-EOzKnPGrpQoopBHyJg9=g@mail.gmail.com>
Subject: Re: [PATCH -next] hugetlb_cgroup: fix illegal access to memory
Cc:     syzbot <syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 3:39 PM Mina Almasry <almasrymina@google.com> wrote:
>
> This appears to be a mistake in commit faced7e0806cf ("mm: hugetlb
> controller for cgroups v2"). Essentially that commit does
> a hugetlb_cgroup_from_counter assuming that page_counter_try_charge has
> initialized counter, but if page_counter_try_charge has failed then it
> seems it does not initialize counter, so
> hugetlb_cgroup_from_counter(counter) ends up pointing to random memory,
> causing kasan to complain.
>
> Solution, simply use h_cg, instead of
> hugetlb_cgroup_from_counter(counter), since that is a reference to the
> hugetlb_cgroup anyway. After this change kasan ceases to complain.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reported-by: syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com
> Fixes: commit faced7e0806cf ("mm: hugetlb controller for cgroups v2")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Giuseppe Scrivano <gscrivan@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: mike.kravetz@oracle.com
> Cc: rientjes@google.com
>
> ---
>  mm/hugetlb_cgroup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 7994eb8a2a0b4..aabf65d4d91ba 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -259,8 +259,7 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>                     __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
>                     nr_pages, &counter)) {
>                 ret = -ENOMEM;
> -               hugetlb_event(hugetlb_cgroup_from_counter(counter, idx), idx,
> -                             HUGETLB_MAX);
> +               hugetlb_event(h_cg, idx, HUGETLB_MAX);
>                 css_put(&h_cg->css);
>                 goto done;
>         }
> --
> 2.25.1.481.gfbce0eb801-goog

The patch this fixes is in linus's tree, but isn't in 5.5 stable yet.
