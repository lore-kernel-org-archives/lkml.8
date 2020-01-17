Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D70C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C3E2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TF9fXgaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAQJdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:33:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51889 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgAQJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:33:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id d15so2907770pjw.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=p0FYXrhY0dK2Yq0ADqbuALXVIqL3DOBXcQh5lESagqw=;
        b=TF9fXgaUP4k4EAUC/Dy/SrOzwDt7ThZAFl1RiO2a29ruRoatv9IVB/khL4saK8kRVr
         jmQulM0N9UWJo1tVbMtZSwfUOSeBO82sunl63tNxOn9BFdV+BcFNIApGC+7vEbF5JCs/
         sFX4nSxwdD66o0jnSZQb+cuxIhTNSgQPJw+NbD6Yp2tQePUHbGgagbNBt9loJ1etUD8y
         ju0tJkK2IpWUyY0tP+T6wcrO6lkabPJHh0jysu0L3AYYtHptfY8IDpWqeHAFxNNvJ2PP
         2UZyeAiwnjYi/RrtKRf8YgfE3/Mwr3ec4ZhjQSrEwi+CGDiEwax83iA9qESUsmFSl9lm
         BKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=p0FYXrhY0dK2Yq0ADqbuALXVIqL3DOBXcQh5lESagqw=;
        b=VKNI3GS0LmtFfnygaL/AowUjdiD4T1qmggnEOvJxFrnKOlIGtl5fL15MGuJeW8a6vt
         ifl9Dg4iC5RGe6PwKJLD+kv074yFMkSFisLM3h1L3gW3k8QLeiIGsc48BDVjg3k7Yl+T
         J1aqPi/CG2jSaoxI4QlVXKsw1gR+oNaqgzfOetJfpGiUjCHeP3wE0wO7NL+YnQPBfiE5
         LLRbV5zd/ZsH0Ef2L3HGwsuVL27s2/lcEUP1+XIKTB8/d1x9SwvLKUQ7KbVTxCrMYUl6
         De6nhXFeQSbwktXgB5JuH7jRloZidqUud24f9tXeUdi7nnpsOL0XQtckYPUqrg2h0va7
         ersQ==
X-Gm-Message-State: APjAAAVnpOo/IRV1f1uWH8+iJLNe1TVY4atjroZUfBCkB6Nf6g3MbJON
        7HfHuchJxBdmk6r5cWtqfpDnbw==
X-Google-Smtp-Source: APXvYqwrLEAFB5O9bxsGKIHjogYbkqKBu7pjTnCF9v/vgbb7R8TIhtoQCKwAw/QYjhF/m1x+onqgAg==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr43612993plj.146.1579253579655;
        Fri, 17 Jan 2020 01:32:59 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c22sm28137098pfo.50.2020.01.17.01.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:32:59 -0800 (PST)
Date:   Fri, 17 Jan 2020 01:32:58 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        stable@vger.kernel.org
Subject: Re: [Patch v3] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <b67fe2bb-e7a6-29fe-925e-dd1ae176cc4b@virtuozzo.com>
Message-ID: <alpine.DEB.2.21.2001170132090.20618@chino.kir.corp.google.com>
References: <20200116013100.7679-1-richardw.yang@linux.intel.com> <0bb34c4a-97c7-0b3c-cf43-8af6cf9c4396@virtuozzo.com> <alpine.DEB.2.21.2001161357240.109233@chino.kir.corp.google.com> <20200117091002.GM19428@dhcp22.suse.cz>
 <b67fe2bb-e7a6-29fe-925e-dd1ae176cc4b@virtuozzo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Kirill Tkhai wrote:

> >> I think that's a good point, especially considering that the current code 
> >> appears to unconditionally place any compound page on the deferred split 
> >> queue of the destination memcg.  The correct list that it should appear 
> >> on, I believe, depends on whether the pmd has been split for the process 
> >> being moved: note the MC_TARGET_PAGE caveat in 
> >> mem_cgroup_move_charge_pte_range() that does not move the charge for 
> >> compound pages with split pmds.  So when mem_cgroup_move_account() is 
> >> called with compound == true, we're moving the charge of the entire 
> >> compound page: why would it appear on that memcg's deferred split queue?
> > 
> > I believe Kirill asked how do we know that the page should be actually
> > added to the deferred list just from the list_empty check. In other
> > words what if the page hasn't been split at all?
> 
> Yes, I'm talking about this. Function mem_cgroup_move_account() adds every
> huge page to the deferred list, while we need to do that only for pages,
> which are queued for splitting...
> 

Yup, and that appears broken before Wei's patch.  Since we only migrate 
charges of entire compound pages (we have a mapping pmd, the underlying 
page cannot be split), it should not appear on the deferred split queue 
for any memcg, right?
