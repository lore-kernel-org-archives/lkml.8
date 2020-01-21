Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704AE24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579596169;
	bh=9WlwXjK2f5D6K9uoRAyGn7F2mD61kmlMjiCAakrnZLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hxRnZNmHRejiFrWd5gcjiEcF+3JlGn8f9Tc1VVgq8gbmFsyCn9QefzP9Vc/iJzgId
	 wbV5hmA9DC35nghnEtqIlvjSwLdPwltR6TqhWeiE7H+ToTV1cRf/TlS74BgyEhVikK
	 gFeJ84Yadk+qA8N6fIYqB90MUH/fi8nqXzLiss98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAUIms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:42:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40079 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgAUImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:42:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so2004629wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tL2ilmdXW53jOUQKDAEIqhCCGh8ZV7CKZBsB46zgNx8=;
        b=O393f64mQQCXHZtcTWfGZBk0M4/671SV9rkq+KDY0emjh7UhukOSsfrHDo8T1lD07k
         bUXDmbBC8jzXcpChhPOI/Ine01OGMIWODqQRtlG4yyHGjT5kVJtN6/m+aAyLz+vQw3gR
         y4uxa1NhEXjZdpkdKpdSHpjXoGPBevUJC4IGp5s3Ni1qDRjbHCkxlC1X8G/h3tqYJEz0
         PAYFExsEkSjMzkab0SeckRewk4pJos7e1JMmR5mIxiL1UjQ7xLmU7tw9PISpMFa7Hiti
         75KuHqZuelm3agd7dz5T+VqdOA5GVlcrSfmsiYU4jasnO/6h5sF5jBjmgfvNeqPoCjU7
         lEtg==
X-Gm-Message-State: APjAAAUVnzjAsJ37TjXCkl9R0Qggf8WNhmhdjDaO1sZg32mL+WFwaFpa
        XUHxIr7R+tmbKOtHBdkIV10=
X-Google-Smtp-Source: APXvYqwkW0vXjcx+70B/f17uAuyCsICIZSZL6Zn8v/NiWr8mGh8V0cKPoA4J7qp7efeu2Pi8ZAahlQ==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr3056679wme.109.1579596157045;
        Tue, 21 Jan 2020 00:42:37 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c2sm51332826wrp.46.2020.01.21.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 00:42:06 -0800 (PST)
Date:   Tue, 21 Jan 2020 09:42:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 1/8] mm/migrate.c: skip node check if done in last round
Message-ID: <20200121084205.GD29276@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-2-richardw.yang@linux.intel.com>
 <20200120093646.GL18451@dhcp22.suse.cz>
 <20200120222540.GA32314@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120222540.GA32314@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-01-20 06:25:40, Wei Yang wrote:
> On Mon, Jan 20, 2020 at 10:36:46AM +0100, Michal Hocko wrote:
> >On Sun 19-01-20 11:06:29, Wei Yang wrote:
> >> Before move page to target node, we would check if the node id is valid.
> >> In case we would try to move pages to the same target node, it is not
> >> necessary to do the check each time.
> >> 
> >> This patch tries to skip the check if the node has been checked.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  mm/migrate.c | 19 +++++++++++--------
> >>  1 file changed, 11 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 430fdccc733e..ba7cf4fa43a0 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1612,15 +1612,18 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
> >>  			goto out_flush;
> >>  		addr = (unsigned long)untagged_addr(p);
> >>  
> >> -		err = -ENODEV;
> >> -		if (node < 0 || node >= MAX_NUMNODES)
> >> -			goto out_flush;
> >> -		if (!node_state(node, N_MEMORY))
> >> -			goto out_flush;
> >> +		/* Check node if it is not checked. */
> >> +		if (current_node == NUMA_NO_NODE || node != current_node) {
> >> +			err = -ENODEV;
> >> +			if (node < 0 || node >= MAX_NUMNODES)
> >> +				goto out_flush;
> >> +			if (!node_state(node, N_MEMORY))
> >> +				goto out_flush;
> >
> >This makes the code harder to read IMHO. The original code checks the
> >valid node first and it doesn't conflate that with the node caching
> >logic which your change does.
> >
> 
> I am sorry, would you mind showing me an example about the conflate in my
> change? I don't get it.

NUMA_NO_NODE is the iteration logic, right? It resets the batching node.
Node check read from the userspace is an input sanitization. Do not put
those two into the same checks. More clear now?
-- 
Michal Hocko
SUSE Labs
