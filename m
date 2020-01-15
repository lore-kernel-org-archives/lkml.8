Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DBC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26725222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpGcNk0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgAOD05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:26:57 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55389 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgAOD04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:26:56 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so6777187pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Iae/mJgVCLpfLGSuYynupuWE+Z4MahohKNOA3VuWzvQ=;
        b=bpGcNk0KuEcv+Ht10XLkBn/HP68yrADkbQzthX19bcUJf/xKxwL4QilvYOrq63iLtP
         QXHGouASBxogJp3LM3yUP91HjYlur9dWJbk1ZdvMkGziZgmXfsEb4avARPSYrYz4rAi2
         OvLl6gWqyFfYMDOctvwF2bIE93PVsy8D7diUVOYObx1xhI1j8NNS0J3jP1ta1FEOYUhN
         fJkqV4C0RQGqlxMN8DMVvJKf7dAkzkAKKtQ1NBTJvxMf445Hmw2mTio4MwQ4BCYmKke0
         akfN3Qikj18K8eS4W8yDU5sAvOYFxPTnfoLGu4VRBE1cm/xaJ5NtSGJk5PobXwkuqimc
         oTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Iae/mJgVCLpfLGSuYynupuWE+Z4MahohKNOA3VuWzvQ=;
        b=tandvyes4i4sxS4Sgf/XLnXc5jnbERXX6ARUeTOx4ko/VSslHUXLzzevQ3UL1//gyc
         UzNuXPFf+B9TaRbqar/camqcT45RgKK8s9gic7LL2Xj+XBnX+HILiMwY99NW1fe2u91K
         Vr1eBfPm3kO8aGYj+Q7BL5y/N/46sN3FHR+1+jGIPKw4nWnDqiZJogUW66asW61O3kho
         O3wwjrYh43bdANm+evRPAqUpvfYvP1TbBHSt7nvG6a+vOuLMWE17a367MVNSZWMMcejE
         BByWDh4u1Me3SYyr8Pxgwu4wodX/4nxvvKO5c9j+NX+u6RdwuPH9bL+4iCyFTRMceYHS
         smMg==
X-Gm-Message-State: APjAAAWHhCI2F+MXNPXXi5phNbn4fhWEmZOXpBMprsg3Ux9UuoWHHuCS
        FOgGHFVnu8pNDqyR8cY6aKUI3g==
X-Google-Smtp-Source: APXvYqwymAKsgPxc8cksJon02QT8iWkblHOgN2DfaxP7yMktruZkpOMfqWcYVlLtqQMUC1ww0gHogA==
X-Received: by 2002:a17:902:7e49:: with SMTP id a9mr22409863pln.230.1579058815911;
        Tue, 14 Jan 2020 19:26:55 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a6sm18050644pgg.25.2020.01.14.19.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 19:26:54 -0800 (PST)
Date:   Tue, 14 Jan 2020 19:26:53 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, alexander.duyck@gmail.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200115010722.GA4916@richard>
Message-ID: <alpine.DEB.2.21.2001141924330.114086@chino.kir.corp.google.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com> <20200111000352.efy6krudecpshezh@box> <20200114093122.GH19428@dhcp22.suse.cz> <20200114103112.o6ozdbkfnzdsc2ke@box> <20200114105921.eo2vdwikrvtt3gkb@box> <20200115010722.GA4916@richard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020, Wei Yang wrote:

> >split_huge_page_to_list() has page lock taken.
> >
> >free_transhuge_page() is in the free path and doesn't susceptible to the
> >race.
> >
> >deferred_split_scan() is trickier. list_move() should be safe against
> >list_empty() as it will not produce false-positive list_empty().
> >list_del_init() *should* (correct me if I'm wrong) be safe because the page
> >is freeing and memcg will not touch the page anymore.
> >
> >deferred_split_huge_page() is a problematic one. It called from
> >page_remove_rmap() path witch does require page lock. I don't see any
> >obvious way to exclude race with mem_cgroup_move_account() here.
> >Anybody else?
> 
> If my understanding is correct, the reason is deferred_split_huge_page()
> doesn't has page lock taken, right?
> 

I think the fix that you have proposed has inspired some deeper looks at 
the locking around the deferred split queue and the hope was that perhaps 
this could be protected by the page lock but it was found that at least in 
one path that isn't taken.  So I believe your fix is still needed and any 
possible optimizations in this area can be proposed on top.
