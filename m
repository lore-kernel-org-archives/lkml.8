Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F21C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F480214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rFEynzgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395269AbgDPP2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442429AbgDPP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:28:33 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D692BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:28:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so21719481qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rMGtreOatVEYR4xQ6VveBD3ZVWSgS2maUcU8W3yRfLE=;
        b=rFEynzgFeDpdYxV542CPzFNIhibQUIccPl7/zDGoabrupO/hNa/co4cyDuvDCgMYac
         xXggmGZjBfmkynF5ZwWrrzoEplkuCpqDhpMztPGbgrBy2zlF8uCCrU2Z/tMxwWjnmrry
         u4ml82A3DWaW5w/4uXDWe0SVsnQroiVkEvYmgwckkkJ8u0esLgaymLIz0ZMbJMTXQ9Pv
         6yh8dDq8ttWGYnIwrsqCx/FlwRdSssWs5Sn9NIHvwsNRAR2VcYM1PczxmjzG2gkpf30Z
         XwrFytBiB7osgdp2UOlSVOFF0U/x7pdA94kwna1TwTMDg4Vh0dNKkbbkBVQs8JDBRT2V
         kUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rMGtreOatVEYR4xQ6VveBD3ZVWSgS2maUcU8W3yRfLE=;
        b=Pird4jiO4sPU3HUuIetth1O2bE7uoFMCrhLAtQGqBdSbaqX5HcsXGLjGfVED/sx2RF
         ymuFR0nUOn3T4/B7xcEJoO7gKS3IqCraXQpc801aYsPfAKnuUTjo00hY4CbZ8wHy40mq
         rTyNCCmlvXZc4Q+TMNenQLMrMUZ9ud3QmIoEMSNwr43zio/7urwEyCY/jUEqDrCgRtx+
         ylXSmwsPlqq4B7b8t9KPPaU4HI3QAxr4bA/I8snh1BwVcSIjejmBm73V2SHy8OQUWmeK
         Ktb4emU61HoOv3BZxVSC0p0moxdeuN1mTXuQxa38OuZyNviWsjJGW00SQGodb9Ab91az
         Sxcg==
X-Gm-Message-State: AGi0PubZkKDRbjDB3xWLvRMJNRycBkdj1wKViaHzMetfwIxFjOPMrShZ
        utuL0f4VV52bgRFP6zVmnvaOw0nlajU=
X-Google-Smtp-Source: APiQypJz4CZcsYAURwShmRlrfrBK99Z4C5EudPpGHD28P1A0CKliH58xqsqe116TmRINxbeHvAnpZw==
X-Received: by 2002:a37:e307:: with SMTP id y7mr22919119qki.420.1587050911999;
        Thu, 16 Apr 2020 08:28:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id z18sm16400475qtz.77.2020.04.16.08.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:28:31 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:28:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200416152830.GA195132@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
 <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
 <20200414163114.GA136578@cmpxchg.org>
 <54af0662-cbb4-88c7-7eae-f969684025dd@linux.alibaba.com>
 <0bed9f1a-400d-d9a9-aeb4-de1dd9ccbb45@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bed9f1a-400d-d9a9-aeb4-de1dd9ccbb45@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, Apr 16, 2020 at 04:01:20PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/4/15 下午9:42, Alex Shi 写道:
> > Hi Johannes,
> > 
> > Thanks a lot for point out!
> > 
> > Charging in __read_swap_cache_async would ask for 3 layers function arguments
> > pass, that would be a bit ugly. Compare to this, could we move out the
> > lru_cache add after commit_charge, like ksm copied pages?
> > 
> > That give a bit extra non lru list time, but the page just only be used only
> > after add_anon_rmap setting. Could it cause troubles?
> 
> Hi Johannes & Andrew,
> 
> Doing lru_cache_add_anon during swapin_readahead can give a very short timing 
> for possible page reclaiming for these few pages.
> 
> If we delay these few pages lru adding till after the vm_fault target page 
> get memcg charging(mem_cgroup_commit_charge) and activate, we could skip the 
> mem_cgroup_try_charge/commit_charge/cancel_charge process in __read_swap_cache_async().
> But the cost is maximum SWAP_RA_ORDER_CEILING number pages on each cpu miss
> page reclaiming in a short time. On the other hand, save the target vm_fault
> page from reclaiming before activate it during that time.

The readahead pages surrounding the faulting page might never get
accessed and pile up to large amounts. Users can also trigger
non-faulting readahead with MADV_WILLNEED.

So unfortunately, I don't see a way to keep these pages off the
LRU. They do need to be reclaimable, or they become a DoS vector.

I'm currently preparing a small patch series to make swap ownership
tracking an integral part of memcg and change the swapin charging
sequence, then you don't have to worry about it. This will also
unblock Joonsoo's "workingset protection/detection on the anonymous
LRU list" patch series, since he is blocked on the same problem - he
needs the correct LRU available at swapin time to process refaults
correctly. Both of your patch series are already pretty large, they
shouldn't need to also deal with that.
