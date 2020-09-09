Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B149206F4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bED0Svmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIIM7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbgIIMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:54:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0483C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:54:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gr14so3424868ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MkTFG6PvXpNoyym24U4EGiq+J1JzE76f2uYpJH8tx0=;
        b=bED0SvmpnihLTx7w6yxuLyY0+FkyiLEaFYFx7SaCxzu3V6SeQV3HJiLHEvYsLeIQ4W
         RZTidtAZkZaoTYoqd/bfS2EHxx+na8JVzUVMZ8vdzCmAP7nC0WriAT8xggzKwb0DeuMq
         XldnkdVTUniwcLFwOa3d3lNG7f04GYaEGFRRC/+eejocYP+JW7AC63ZKdTVqR8G9DCJo
         KmBpVriFFC+qo/VQXgwxbDTFvI4lI1qxj77yGPZ/S0xbmKx4OGAj34OIuqMqH9wC9OKQ
         3MfO013qxHWBtVEdBuGPwxu7UnNb0vWY87FMWyywTA0PlqpSehJuJEeTLWWegYj9Hvrl
         0JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MkTFG6PvXpNoyym24U4EGiq+J1JzE76f2uYpJH8tx0=;
        b=s67hmjCltTQkzKyizIKPPthZPaGup8CYFrnnUr1IgWNwNVnRQsBMuWBGZwze+VNM8O
         FUsKt+hMvDkcVFpN/+EQ2MDCCCUk5L+xNw6REwsgwu3+nK2pKzPjt9YR5LotO+M6sWRX
         MbkkVu47I42psJEgjb74dAXDvY2WzND6Yo9PsOkM27X6lNelfk+w/N7IablWPA+QnVnu
         s18n+GHTwgFPccKwDSjjYiA3FYILM6W6S3TmmqDccOa9CyEioXBf5J755FHVp4dppY9n
         81m/1POnEFP+tSecjM/N4yErCv1mI1U7Oq6uFdFUhAwc/YPcz9o695HFA1kPg/UI13lC
         /x3A==
X-Gm-Message-State: AOAM530bZSZ5FUO3qDZhY2YIPtvTI4+4SFUZCKwxDy2W67UuSiYW5Ql4
        y0H7H769PSii3JiRD38OGMC6XMPwDpNXde6fTWb7WQ==
X-Google-Smtp-Source: ABdhPJxiW6o5CF789NcjwGT/tFM0KuNKzfoTCu8t7Mkh4H09/JIsdp6BPkaNcid/X6E3sEHrrrajh3SKhiOS/UZctcw=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr3608780ejb.426.1599656051243;
 Wed, 09 Sep 2020 05:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200907163628.26495-1-vbabka@suse.cz> <20200907163628.26495-6-vbabka@suse.cz>
 <d5d5ef64-b239-0640-5640-75c7a3c78584@suse.cz> <20200909113647.GG7348@dhcp22.suse.cz>
In-Reply-To: <20200909113647.GG7348@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 9 Sep 2020 08:53:35 -0400
Message-ID: <CA+CK2bAai5CMWVVeTxbAjaeLBJ8sjT7H6OuAEJYjUXcas8EBcQ@mail.gmail.com>
Subject: Re: [RFC 5/5] mm, page_alloc: disable pcplists during page isolation
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> because we do not want to call out pcp free lists). I strongly suspect
> that only the memory hotplug really cares for this hard guanrantee.
> alloc_contig_range simply goes with EBUSY.
>

You are right, the strong requirement is for hotplug case only, but if
PCP disable/enable functionality is properly implemented, and we are
still draining the lists in alloc_contig_range case, I do not see a
reason not to disable/enable PCP during CMA as well just to reduce
number of spurious errors.

Thanks,
Pasha
