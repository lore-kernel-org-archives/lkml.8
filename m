Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40048C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86F521D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="h36kM+lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgIIEUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIIEUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:20:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3775C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 21:20:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o68so1144619pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LP46ySnI2xDx74RsYVuIFFKElqOmtzPA4koaAcc6C4=;
        b=h36kM+lTNfnMAxtTC11+wijbU0dUb+RRyuImhwpazjMoH1jWjPQ/XbJxXgHZNPvtkd
         DAYepA2TpuaKw2py7MeoNBYmmwnedkTOkuDuDnfDJnP6SE2kREkEcJ5rg6hMK2rZo4xQ
         zVTzUmzEF2PtGGnWRu0iY+M2fwAfnZkG++zMhxnCCcGpBdoaHJOp88bDrexVNC7/RmH7
         hj4IFkjATHqS/lb5UFxCVUzH9Od9LbxEYnsqQ/zvVA3uVCrppJH1pJIXB8ogGfWEBzdx
         zFFnHQ24kzoqh5ZWb15QoeGYfb26SfoN8dfiXdpDpx471/KBUMqibASQnCziNBmP4R3u
         Q5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LP46ySnI2xDx74RsYVuIFFKElqOmtzPA4koaAcc6C4=;
        b=A5jigt0F8UCy2MsB01Ix5nW8v+5HCC9WnZaroLBLLlHQ188xeSAKGneQ9d7m+E414n
         zcsd+iiWTOxd6N5KnzY8lSCkzswRU213WrhmTshAxbmpVu5RTE56ymqgzTR0N6mM5469
         b94Rb5/kAID4bCOQVHckaNeHtf9hjQdWJCnLREq5XpzoZxnjuX7KdQQcVK5wPq6hZuQi
         EWUKQRfjQXhvRu0klAigwYM+muTTbr4xAK4kjSU25BMCcLfjw3Tzt3FHhHvAm/YJdmjR
         x0r28JKQFI+rjqmqkH2N+NYGP694Kj8XiRF/HdduxybLC0MtzcvIO7uBlUzmzvJvg0NF
         c/YA==
X-Gm-Message-State: AOAM530cPcCYB/ZZODWMuqshY9DrVgc0i9gR/wbLaNE7rtrAgO00Ff8E
        1zXz7CMHmRG0XaifJDr1Z+faNfe7wDaZOKLcpkEoXh7yM/RJobA0SKU=
X-Google-Smtp-Source: ABdhPJwnPsQQ3cOrC/3M4+xwMi+fo+XFlMR2+vKr4m+7nvqnLXLlLZlg9eSyE5S6Sh3SR6umL/g3O6AswKoMhElSljw=
X-Received: by 2002:a63:9041:: with SMTP id a62mr1509992pge.273.1599625204761;
 Tue, 08 Sep 2020 21:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200908142456.89626-1-zangchunxin@bytedance.com> <20200908150945.GA1301981@chrisdown.name>
In-Reply-To: <20200908150945.GA1301981@chrisdown.name>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Sep 2020 12:19:28 +0800
Message-ID: <CAMZfGtXDXzv8FEZa7cw6v+jV4ODnVuA3_UGEGWm7eTtZWCU+Bw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/vmscan: fix infinite loop in drop_slab_node
To:     Chris Down <chris@chrisdown.name>, zangchunxin@bytedance.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, Sep 8, 2020 at 11:09 PM Chris Down <chris@chrisdown.name> wrote:
>
> drop_caches by its very nature can be extremely performance intensive -- if
> someone wants to abort after trying too long, they can just send a
> TASK_KILLABLE signal, no? If exiting the loop and returning to usermode doesn't
> reliably work when doing that, then _that's_ something to improve, but this
> looks premature to me until that's demonstrated not to work.

Sending a TASK_KILLABLE signal? It didn't work now. Because the the
current task has no chance to handle the signal. So I think we may
need to do any of the following things to avoid this case happening.

1. Double the threshold currently hard coded as "10" with each iteration
    suggested by Vlastimil. It is also a good idea.

2. In the while loop, we can check whether the TASK_KILLABLE
    signal is set, if so, we should break the loop. like the following code
    snippe. Thanks.

@@ -704,6 +704,9 @@ void drop_slab_node(int nid)
  do {
  struct mem_cgroup *memcg = NULL;

+ if (fatal_signal_pending(current))
+ return;
+
  freed = 0;
  memcg = mem_cgroup_iter(NULL, NULL, NULL);
  do {

>
> zangchunxin@bytedance.com writes:
> >In one drop caches action, only traverse memcg once maybe is better.
> >If user need more memory, they can do drop caches again.
>
> Can you please provide some measurements of the difference in reclamation in
> practice?



--
Yours,
Muchun
