Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5D9C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E49920702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/D+X34D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgA2VVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:21:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38974 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgA2VVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:21:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so450384plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 13:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fSu1mCirRVJUEaT+xu3QH4J7cMfTuyOkl0e/HLlkDbU=;
        b=P/D+X34DyFIVyb02XfVKy0ez7sqi3JEfNxP0fAGOgGmxc1cVKQ9rGo+vjzEILUFZYY
         Th6TqFfL/TeL6mjRI1wEB1tf6SKODMXuKHiHGuUkNzirxDxr1isbiii+zASEv0IgrlMt
         XOk+l8dhoulN6hdPOkhiOypf3L8b2P+1jI+lfCTBd+RxcX5LtJoQGNa45TGmQl0gCAMy
         6+MTywXj7bOpvfE6pqDPCEil8nOdV7/3VBcmgVrxE4eNto2UBQkxzApfPQ97iURPOylx
         wJjgAC3U/gPQTvu2jiC/Q3wVMMMRHWtsnUvhcNxk9ON65oZcbx7eDZiCGIDSuRA7UJJt
         fx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fSu1mCirRVJUEaT+xu3QH4J7cMfTuyOkl0e/HLlkDbU=;
        b=EmAs4PIBHBUCVvKuiSs/QSUbo7uo75yf6tAWjlv/K4ZeCl+wBBcIgX6iXqnBfRT2vc
         S1/3/+bPUbiZDi9X0J4pGPiATbmdJ+w/gDghJREg2xXc2cilsxm1ckdHCs4SaqYbjULh
         XdEf00oZFP/Ht09MXwXfJEp/XEXiVY39CAF5l3v0Q8xMMrijF5dBQvanLVrY979+oZU4
         hLCmWz92N2O+PRIORHaYkdgPqKOEjBhey6lr/MimCYopq6rOE0wuZtmIwvXPbmJl0Kme
         jV2Nx9tZ3FFad2tilUBYML61tTQrnuS2UJxbDH+4hTDml/N1gCt/TDo9gkYR6fj1QWU8
         PvZw==
X-Gm-Message-State: APjAAAWSO5eaaLXxRkLO6XWzrC8+umNfF3pDujbO8LYzo6+oGh9Ne5uy
        4ycehDGUjKsHEAnC5RbxzF5IDQ==
X-Google-Smtp-Source: APXvYqzGWo58ejovUm6nF7NJLFty3hOvszT3cTmNTbY14PSI28WNkitrX9z+LDyHBkwotFjy817GTg==
X-Received: by 2002:a17:90a:1f8c:: with SMTP id x12mr1900049pja.27.1580332913389;
        Wed, 29 Jan 2020 13:21:53 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u128sm3635727pfu.60.2020.01.29.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 13:21:52 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:21:52 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shakeelb@google.com, shuah@kernel.org,
        gthelen@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v10 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
In-Reply-To: <20200115012651.228058-2-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2001291312490.175731@chino.kir.corp.google.com>
References: <20200115012651.228058-1-almasrymina@google.com> <20200115012651.228058-2-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Mina Almasry wrote:

> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index 063962f6dfc6a..eab8a70d5bcb5 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -20,29 +20,37 @@
>  struct hugetlb_cgroup;
>  /*
>   * Minimum page order trackable by hugetlb cgroup.
> - * At least 3 pages are necessary for all the tracking information.
> + * At least 4 pages are necessary for all the tracking information.
>   */
>  #define HUGETLB_CGROUP_MIN_ORDER	2

I always struggle with a way to document and protect these types of 
usages.  In this case, we are using the private filed of tail pages; in 
thp code, we enumerate these usages separately in struct page: see "Tail 
pages of compound page" comment in the union.  Using the private field is 
fine to store a pointer to the hugetlb_cgroup, but I'm wondering if we can 
document or protect against future patches not understanding this usage.  
Otherwise it's implicit beyond this comment.

Maybe an expanded comment here is the only thing that is needed because 
it's unique to struct hugetlb_cgroup that describes what struct page 
represents for the second, third, and (now) fourth tail page.

Or, we could go even more explicit and define an enum that defines the 
third tail page is for hugetlb_cgroup limits and fourth is for 
hugetlb_cgroup reservation limits.

enum {
...
	H_CG_LIMIT,
	H_CG_RESV,
	MAX_H_CG_PRIVATE,
};

and then do a

BUILD_BUG_ON(MAX_H_CG_PRIVATE > (1 << HUGETLB_CGROUP_MIN_ORDER));

somewhere?  And then use H_CG_RESV (or a better name) as the offset from 
the head page in the code?

> 
>  #ifdef CONFIG_CGROUP_HUGETLB
> 
> -static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
> +static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
> +							      bool reserved)

When implementing specs, I immediately see "bool reserved" or 
"int reserved:1" as reserved for future use :)  Maybe simple enough to 
just name these formals as resv?

Otherwise looks like a simple conversion of existing functionality and 
extension to the new limits.

Acked-by: David Rientjes <rientjes@google.com>
