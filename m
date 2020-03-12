Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB5C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78657206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fzPYth0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCLNdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:33:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42347 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLNdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:33:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id g16so4290771qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdp99kBqJfGiQv6F9UTNp9A5C6kAffpbNzB4DpZx8tM=;
        b=fzPYth0xZm9OoYTE3PiBGE7On1NFZx1IBEPXPEmLQmvwXSpYkIBO+ZoVTnDJU5CJ/B
         xiHS1SVnGsF03Rof7Nc2jET2WgnrpPhvHwcouzYxDJqMsM9QceNnfPfvshG9KEmmrppn
         V5FnzxfRhX2qfhuepl8PyNsVttV6kEBPEGsmNVt2c+eHedzggAnwDyas0c6lRnqkwVZD
         YLiky49Z2jtXp5d+0B7HbeoBZxIokG11FsaR0SMrWu/MDDpwDR3zlbJupasDUf1xxwNl
         N7B/jT4rukl8RT0RXhWREdysvJTF4NGAl9TjZXQgN1irbTwWXkk0ZS/COqA/Ecxy0IV5
         8+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdp99kBqJfGiQv6F9UTNp9A5C6kAffpbNzB4DpZx8tM=;
        b=j61KJ3lwSqYkMyiCs04r0dlwiC+RpybedvSsAJ9pNe3INOX42q9rOQm7X3xk1hvpPP
         aIQUsnLw2mv8Cck3AnhrQ62CyESt6KWohF4qBl4a5eyOznyGxDOb6rfWL9cuP6b4vacd
         uAskKJ1JIbWRa04kw+GryI+1xTeNydtmvBFjPtkzstV7ZXR/dfrwoMK+J3oesdFtpJw4
         PVvD89PESvvYwL2YPOhfsqlrTpSUj8l9GJe4a82haRxDFBXfzoVGYrN9pvuque2ZoyDQ
         ZFUPr+vmxjjCRELiPmI1pnvxkAR2Gr2uZSvv9EnAcsQWw8PpcLHsxT6j79QJ2H3hbRot
         sbzg==
X-Gm-Message-State: ANhLgQ37f7UaxzaStGJ21OsoPOOXel6P7lS8zQFETzjDJKEhon5kls34
        95IowAzegUFL9y/PqXGvarRnqg==
X-Google-Smtp-Source: ADFU+vvDRZeSII7JjTWNMdHX9psSp1KBxs/GLiI1qtL2Ztqq8rO4QK5syjpynATSxvbPS875SqDTgg==
X-Received: by 2002:ac8:2bf8:: with SMTP id n53mr7309390qtn.1.1584020002510;
        Thu, 12 Mar 2020 06:33:22 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a27sm14228344qto.38.2020.03.12.06.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:33:21 -0700 (PDT)
Message-ID: <1584020000.7365.178.camel@lca.pw>
Subject: Re: [PATCH v3] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
From:   Qian Cai <cai@lca.pw>
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Thu, 12 Mar 2020 09:33:20 -0400
In-Reply-To: <20200311220920.2487528-1-guro@fb.com>
References: <20200311220920.2487528-1-guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 15:09 -0700, Roman Gushchin wrote:
> +#ifdef CONFIG_CMA
> +static unsigned long hugetlb_cma_size __initdata;
> +
> +static int __init cmdline_parse_hugetlb_cma(char *p)
> +{
> +	unsigned long long val;
> +	char *endptr;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	val = simple_strtoull(p, &endptr, 0);
> +	hugetlb_cma_size = memparse(p, &p);
> +	return 0;
> +}
> +

Here will generate a compilation warning,

mm/hugetlb.c: In function 'cmdline_parse_hugetlb_cma':
mm/hugetlb.c:5548:21: warning: variable 'val' set but not used [-Wunused-but-
set-variable]
  unsigned long long val;
                     ^~~
Also, the comments for simple_strtoull() in lib/vsprintf.c said,

"This function is obsolete. Please use kstrtoull instead."
