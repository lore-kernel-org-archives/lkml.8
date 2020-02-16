Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C40C76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 01:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3F42084E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 01:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFq89J3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBPBaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 20:30:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36932 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgBPBaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 20:30:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so5676122pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H1J2XGmudHXtmp+DJfVLIIqWxd4GHWG0D55ayu8ofeI=;
        b=gFq89J3C6y2E3dC6eJosGCejVHswqtg68Tow44UbrH2gVrpogK7qFB1KHIIqqUr7bn
         tF6i1gknCrbwVMRuZQ5ME8rn/UmTXJDDfhHRV6pW2PIY5pqan+jFUw+/kb92UAgwLVbj
         T/G17QADHWbAVrR3b1QVTsvF3ed/aWsXDnw5zV2uSZHZk/45sRr34UPnEUrZgMEdy6J6
         YqeWVAyXZWILuihYlGoDPXdNP++ifAKU+tFKpgmi8EBlQR2AX2NbhCSBXI96xRW5tjuA
         ImAmKQCewP/SSbyC0hOD2KKx7/xtU+uyWnFN+4DYSnSZDjveEXzbpjxCsl1eW+3zXMKv
         iahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H1J2XGmudHXtmp+DJfVLIIqWxd4GHWG0D55ayu8ofeI=;
        b=NRN/VP7nflmsgB/fTCYndtKWdezwe4Sfg8d5elsnLV0ebWXbjdhq+hrtHOm2+DjAv1
         xYlNsD5cjT7zf0CY94La6IjIDibWQKu0KQwPi70IBycZoKqrGtLtbDuNatjzG2cyV/lJ
         sUqBBs9tMF5v9D7WxqgYVqx4DlluSbJloqv1MbSXqtx92NCI3E+rQ6ifDVtzJludB3LM
         UOGBMt+xFB8/n7E5pih/cfN/ni5WBukc84ZFlzpVsKoO/wMLdOkE+mOH99TaK8qeUSRk
         zXvac7hT8oaPOfO/PQybKdj4iiFVgqL6HERW5r/3NFzoBEmWX7eIqaT7OtAQndl9xNcE
         Uiwg==
X-Gm-Message-State: APjAAAXRvzoSUflZzne2IvQSJqhYkU/jtkHZ8lLbgWEqFWAz3vIpXHq3
        bya39GmuoPmazE+E5+ZUNMl1/A==
X-Google-Smtp-Source: APXvYqyGFRjjGux2Y1Zo0z/8WLWOp+BzYnoiWnfZ6OCKzLnyPcaJCc5ufv5eAEVQKL1cq60yEjgu4Q==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr9683676ple.226.1581816600814;
        Sat, 15 Feb 2020 17:30:00 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f3sm12207242pga.38.2020.02.15.17.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 17:30:00 -0800 (PST)
Date:   Sat, 15 Feb 2020 17:29:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shuah@kernel.org, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v12 7/9] hugetlb: support file_region coalescing again
In-Reply-To: <20200211213128.73302-7-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2002151729470.244463@chino.kir.corp.google.com>
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-7-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020, Mina Almasry wrote:

> An earlier patch in this series disabled file_region coalescing in order
> to hang the hugetlb_cgroup uncharge info on the file_region entries.
> 
> This patch re-adds support for coalescing of file_region entries.
> Essentially everytime we add an entry, we call a recursive function that
> tries to coalesce the added region with the regions next to it. The
> worst case call depth for this function is 3: one to coalesce with the
> region next to it, one to coalesce to the region prev, and one to reach
> the base case.
> 
> This is an important performance optimization as private mappings add
> their entries page by page, and we could incur big performance costs for
> large mappings with lots of file_region entries in their resv_map.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: David Rientjes <rientjes@google.com>
