Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90542C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE03206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hju9hXEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgIARwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgIARwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:52:01 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D63EC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:52:01 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id v20so701257ual.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LM/90lickBJaNMACbOvycyEGn6a9FzKJ0U/uO72EduU=;
        b=hju9hXEyZJ9W7EcArFXRkj//GhdBJx9t9WVyBsS5qVUMOPxI0SZi60FdZXd9DNc3/C
         S273aVy9mrHuTApmUBWlWClB5O1A52+eO4vMMVNKleLtw+3LtnOSi1YNNS56WBHf3VYe
         QDLb3WmoD2qGaP6w2RMuhDS75IjOokRPl9kWzfiKW2LoVixLj52+4FtQDVBupYZw3rp+
         tctiPNIlTvR1Y+MbRfmljBqzIEFH/K0tjpopvEbxUiWQq1Fyw0dCDOEwp5hKgYfW8aPy
         qUc22zx7ZSF3D4RlmvRYnFUgbqPz0l9KEmQoOSD7Ol59hMYh9qdzbEtk6EmTxiEnKoNa
         L4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LM/90lickBJaNMACbOvycyEGn6a9FzKJ0U/uO72EduU=;
        b=B74UXjvJNxb8tGQQO9mw1xYGojKkYFSbHFBIsrOYi1fwj0Dch4Xd9pN/h+crs47BkK
         Fjb+EzFOT5VJi0h9qNupV9dasZZmZkUmdkXOXFMD0S/v0mG0f5yCRSJMeBP/vSg+ZARL
         REJZs/tE71j23CjzrWo1HWvwVR3nvxAsbdW9duP/JCNbQHX6P2zhyr4A7k7jPv05/Y6O
         uYwI5GKzrIrTfSAJTvdeuepa16RSIf3jLnvRXU4eOPcjV5OQ6rDGw5GEzhPCbjyxVKYb
         hGKgYEa1AkyRi+KXwIGvqfoIc7vAmQGc3FpOqI1bQYSyiSmPOioBk8PK1aaXFwHPeQ88
         P2oQ==
X-Gm-Message-State: AOAM532vGag8wu1xfUrQ2b+gZ5GpJpC5v+fBF9fiC6Umh+2ncWVFmvws
        mLxsTeBCMsJDLs2Go5XHhgmZSw==
X-Google-Smtp-Source: ABdhPJwd4yAWigNFFp7I++YzQSE/wwvwyWSL4EWTSXtuXfgpD4jtXuOK2Hg4izfmGGMu0At/61qMYw==
X-Received: by 2002:ab0:754d:: with SMTP id k13mr2444657uaq.75.1598982720150;
        Tue, 01 Sep 2020 10:52:00 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 67sm242644vsl.13.2020.09.01.10.51.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2020 10:51:59 -0700 (PDT)
Date:   Tue, 1 Sep 2020 10:51:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Maoming (maoming, Cloud Infrastructure Service Product Dept.)" 
        <maoming.maoming@huawei.com>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        wangyunjian <wangyunjian@huawei.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH_V3=5D_vfio_dma=5Fmap=2Funmap=3A_optimized_for_hugetlbfs_pages?=
In-Reply-To: <8B561EC9A4D13649A62CF60D3A8E8CB28C2DC466@dggeml524-mbx.china.huawei.com>
Message-ID: <alpine.LSU.2.11.2009011040560.2984@eggly.anvils>
References: <20200828092649.853-1-maoming.maoming@huawei.com> <alpine.LSU.2.11.2008302332330.2382@eggly.anvils> <8B561EC9A4D13649A62CF60D3A8E8CB28C2DC466@dggeml524-mbx.china.huawei.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020, Maoming (maoming, Cloud Infrastructure Service Product Dept.) wrote:
> > 
> > > In the original process of dma_map/unmap pages for VFIO-devices, to
> > > make sure the pages are contiguous, we have to check them one by one.
> > > As a result, dma_map/unmap could spend a long time.
> > > Using the hugetlb pages, we can avoid this problem.
> > > All pages in hugetlb pages are contiguous.And the hugetlb page should
> > > not be split.So we can delete the for loops.
> > 
> > I know nothing about VFIO, but I'm surprised that you're paying such attention
> > to PageHuge hugetlbfs pages, rather than to PageCompound
> > pages: which would also include Transparent Huge Pages, of the traditional
> > anonymous kind, or the huge tmpfs kind, or the more general (not necessarily
> > pmd-sized) kind that Matthew Wilcox is currently working on.
> > 
> > It's true that hugetlbfs is peculiar enough that whatever you write for it may
> > need some tweaks to cover the THP case too, or vice versa; but wouldn't your
> > patch be a lot better for covering all cases?
> > 
> > You mention above that "the hugetlb page should not be split":
> > perhaps you have been worried that a THP could be split beneath you?
> > That used to be a possibility some years ago, but nowadays a THP cannot be
> > split while anyone is pinning it with an extra reference.
> > 
> > Hugh
> > 
> 
> 
> Thanks for your suggestions.
> You mention that a THP cannot be split while anyone is pinning it.
> Do you mean the check of can_split_huge_page()(in split_huge_page_to_list())?

Partly, yes: but that's just a racy check to avoid doing wasted work in
common cases; the more important check comes later in page_ref_freeze(),
which either fails, or prevents anyone else taking a new reference to
the THP (head or tails) while all the work on splitting is being done.

> When we want to pin pages, vfio_pin_pages_remote() always gets a normal page first.
> In this case, a THP cannot be split because of the increased reference.
> Is this right?

Yes.

> 
> Maybe I can optimize for hugetlb pages as a first step,
> and then cover all compound pages.

Okay.  That's definitely a good way to start out - but you may find
that the second step leads you to rewrite every line you wrote before!

Hugh
