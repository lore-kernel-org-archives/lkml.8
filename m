Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC62C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9886821835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZJFiO4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAVXjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:39:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41068 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgAVXjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:39:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so350717pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 15:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YNvajkPj2BUn62eVSIlq+7puNDrKQpZK5MXXRGczBsE=;
        b=WZJFiO4NDHzrXRTXfEk15plzqfBCf/XF0WnvEGStfqkfZ8Fj/EQr8PPvQ1mLAYqSCP
         v+tE914RPXI/94X6Y2Ek89gj39gHYxA1NTi3sKa6IgtxsqR7fEYjau6jIW00dazgJtqm
         NZx1MnFTfqkmUSUZZeskkvhavOEJCNt5fV+mYrZt5vPpBAD/vBNFA/RgfJYLX8D9PJaA
         G3KnjIHOycLCS+ldcv/ah1Uk5FmX3GkTjliBdERDyczvEhEsSyWkRdr9Dv0Y86tQcqZ1
         /LhnvAT2PoZqjNrkdXKx4QNEIv+ukhBvwK0989ik3JobGkgCQ3qE+FM9Wjg3YeOp+dJQ
         Gk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YNvajkPj2BUn62eVSIlq+7puNDrKQpZK5MXXRGczBsE=;
        b=IyZONn7KgWAN9DQ770k3uIkOqNp3awNux38tz8BPUIXaGD7mW6v9p4ss60RdytEnaZ
         LvCOK+Ph7Ezgc6PeM/menn1C5hLnZuEXsPAeow4dkFPr6TpTU2ca/+mYV5zYzp7c3qA3
         KjBxDerqrEPrYDThAS59OkaBRLM4FcT56f2HTU4q0uiyobA/Oo7w5Tw2yBT9nbM5eC/3
         BqT8vAebKoze8rCpI8hgSKcaBkTOpws1VGKsp6Bf4Z3FI8nE1WLUrnv9xJl1B4f+mOTp
         Rd8y+aEDgQyaI73MywtvQOs9VTWzVodiV4zeIEmkYrtDI7LqtOGB9oXCpA1uH/ZuY7jV
         G+Vw==
X-Gm-Message-State: APjAAAXRtp3633xTehoTIGGlx7U6X9Wg0ok+Xc3EJ71oEfAKwlvM6j2K
        GRVxM4zg9VBcyIxeQpNvT20DEA==
X-Google-Smtp-Source: APXvYqzYKfqD7EIYVVlkhEXDYVigv+4+OFhdSez6pqm4NRA/CZmbpyFtyH7DKP240xSGf/Xi6bieBA==
X-Received: by 2002:a62:e80a:: with SMTP id c10mr4833932pfi.91.1579736358110;
        Wed, 22 Jan 2020 15:39:18 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m101sm98110pje.13.2020.01.22.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 15:39:17 -0800 (PST)
Date:   Wed, 22 Jan 2020 15:39:16 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, ktkhai@virtuozzo.com,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        stable@vger.kernel.org
Subject: Re: [Patch v4] mm: thp: remove the defer list related code since
 this will not happen
In-Reply-To: <20200122081406.GO29276@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2001221534510.159514@chino.kir.corp.google.com>
References: <20200117233836.3434-1-richardw.yang@linux.intel.com> <20200118145421.0ab96d5d9bea21a3339d52fe@linux-foundation.org> <alpine.DEB.2.21.2001181525250.27051@chino.kir.corp.google.com> <20200120072237.GA18451@dhcp22.suse.cz>
 <alpine.DEB.2.21.2001201307520.259466@chino.kir.corp.google.com> <20200120212726.GB29276@dhcp22.suse.cz> <alpine.DEB.2.21.2001211500250.157547@chino.kir.corp.google.com> <20200122081406.GO29276@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020, Michal Hocko wrote:

> > The current code in 5.4 from commit 87eaceb3faa59 places any migrated 
> > compound page onto the deferred split queue of the destination memcg 
> > regardless of whether it has a mapping pmd 
> > (list_empty(page_deferred_list()) was already false) or it does not have a 
> > mapping pmd (but is now on the wrong queue).  For the latter, 
> > can_split_huge_page() can help for the actual split but not for the 
> > removal of the page that is now erroneously on the queue.
> 
> Does that mean that those fully mapped THPs are not going to be split?
> 

It believe it should but deferred_split_scan() also won't take it off the 
wrong split queue so it will remain there and any other checks for 
page_deferred_list(page) will succeed.

> > For the former, 
> > memcg reclaim would not see the pages that it should split under memcg 
> > pressure so we'll see the same memcg oom conditions we saw before the 
> > deferred split shrinker became SHRINKER_MEMCG_AWARE: unnecessary ooms.
> 
> OK, this is yet another user visibile effect and it would be better to
> mention it explicitly in the changelog. 
> 

Ok, feel free to add to the last paragraph:

Memcg reclaim would not see the compound pages that it should split under 
memcg pressure so we'll otherwise see the same memcg oom conditions we saw 
before the deferred split shrinker became SHRINKER_MEMCG_AWARE: 
unnecessary ooms.
