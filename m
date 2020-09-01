Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CB0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113762083E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p683/8Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIAEQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAEQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:16:46 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C05DC0612FF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:08:22 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id h9so2014753ooo.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NaKIw5SZ2snUDIQdGMqi00rq2nlthzOV/iWfbjX5FMQ=;
        b=p683/8OhcapwMB7X8q7CDgEHBEZLk8MTO0hDyyoM9IeA9kE1jRIaauqXjx3fBJ+pC6
         bkI2qgc07N5yqXOBl2V6BHdGu20yzZnoZg+TwOa1qIGxyqJdwsYDs0hMfw3/KtjwkQGG
         vnsJfnchUVEzc4BNmmdaQMjVBRx5yG/F5JNq9shKPsS9o9qcIYg1yXTFUfSHzJfH6hMv
         4ghhrA1hsdXgGfMgZpx0cN6KtjCPhEImmwpOZ9Mppn739Hk2q9YlD9Kb/+t1IJ4r0u77
         3tcZL+iewBUiyY+hWvxeYuAtH55WI5k52AudlT0oISRlRNItf5ty88bkLWccj4dytFLr
         4AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NaKIw5SZ2snUDIQdGMqi00rq2nlthzOV/iWfbjX5FMQ=;
        b=S7O7L3ScOyrGOFtAk82usfoQMtdLjK32+jAF2KPMhs8BHxBSoeRkss6EeyFlG6PaAH
         x78fEqdqIVYl71Kyh+Qjmpwm2qir9M+S0cm751CM+Mf2TaMSoFA5+De3tdYiUCeJYB0T
         NhiuSgwBamuTofOuTLVj9AS69ohRa+Gzh1x3jW0tSXcL7vYOxkT+U/+OuMyl8uX/eq7M
         fushf+1VqnbQ4pWubfWUN32Hq516EKWf2leTzVipRmUL3ZTjWhZnUoTi7YJj/6FQxOhf
         NCO5ybpb/UQC+llsewEAwz53N7JUigY90iu7oqAOHfRfx4XWKik1UXA0+yEJ2oLoBaHD
         DLig==
X-Gm-Message-State: AOAM5336fnkvcvYnIN7r5I5dJsP4/E733eEnPIb4RmBhzmk0tbVyk1Hf
        UEIP29s9vigsQo4cSfHFZkDPkw==
X-Google-Smtp-Source: ABdhPJzkFt5m7gLJkldd0ofDPLe6KYcRsEykTxbgdct/rik9AN7M4HTPmS3L9AsIy9mB81WhPqPoyg==
X-Received: by 2002:a4a:dc03:: with SMTP id p3mr2986296oov.63.1598933301355;
        Mon, 31 Aug 2020 21:08:21 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i23sm2070866oii.53.2020.08.31.21.08.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2020 21:08:20 -0700 (PDT)
Date:   Mon, 31 Aug 2020 21:08:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] mm: fixes to past from future testing
In-Reply-To: <9fa34576-92ec-37db-0b9c-b29d28aa8775@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2008312059480.1019@eggly.anvils>
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils> <9fa34576-92ec-37db-0b9c-b29d28aa8775@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1105281253-1598933300=:1019"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1105281253-1598933300=:1019
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Sep 2020, Alex Shi wrote:
> =E5=9C=A8 2020/8/31 =E4=B8=8A=E5=8D=884:57, Hugh Dickins =E5=86=99=E9=81=
=93:
> > Here's a set of independent fixes against 5.9-rc2: prompted by
> > testing Alex Shi's "warning on !memcg" and lru_lock series, but
> > I think fit for 5.9 - though maybe only the first for stable.
> >=20
> > [PATCH 1/5] ksm: reinstate memcg charge on copied pages
> > [PATCH 2/5] mm: migration of hugetlbfs page skip memcg
> > [PATCH 3/5] shmem: shmem_writepage() split unlikely i915 THP
> > [PATCH 4/5] mm: fix check_move_unevictable_pages() on THP
> > [PATCH 5/5] mlock: fix unevictable_pgs event counts on THP
>=20
> Hi Hugh,
>=20
> Thanks a lot for reporting and fix! All fixed looks fine for me.

Thanks for checking.

>=20
> BTW,
> I assume you already rebased lru_lock patchset on this. So I don't=20
> need to redo rebase again, do I? :)

That's right, no need for another posting: the only ones of yours
which don't apply cleanly on top of mine are 20/32 and 21/32,
touching check_move_unevictable_pages(); and they're easy enough
to resolve.

With my 5 fixes in, I'll advance to commenting on yours (but not today).

Hugh
--0-1105281253-1598933300=:1019--
