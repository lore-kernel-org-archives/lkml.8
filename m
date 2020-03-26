Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ABCC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB5E20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585203897;
	bh=joBp77EHpMUHnt+HbDfYzk8qQbUSXrG9iYLpGpedBv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t0F++I2wOTuIrr3n4qhAFx7KsqBwk8A6N6TiVlljl0vQgKdI6rL+JmEKyJ1UIWug8
	 1g4rw84PUVro25ytDCFzYDpoliiUOMRe0k60Pf/RNBjJqeCy0g6YXkdefJtiqdK1qd
	 NYzjpQr8SjMvRx+ztYjTo95XgiF6FtklTXqMlzPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCZGY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:24:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38204 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgCZGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:24:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id x7so2375004pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QC+ohq6WZjxovn5VwJ2HdsYXNpZbNsFxrRkCdKEZ/vc=;
        b=hzgp/dtrXiN58qp7hN54DADkqUTDifOTZrpMM5WZnEoe7wYEyAIUiWmPWxtElkm8x+
         +omaV76rfNc6/GVqAs/T6aBarOMzcQWia9R0yTlf8RDUFNNLGDS5jd+UkZhVbH+PnCsu
         F10WDVNpk3ZlefXQIry+nKbIz7xn9R7vdqGeElOMVdRTpWDbq7X7HW4sjazpO9poh18s
         g8HzcI/RtPl+6Kt67Bpxp+KhJkdExIC5Q+s4iYfguWGh4prIdn+zlR9vrCgXPAuvLCm+
         jCYb569qCuuTKCOmK5YO+vOlTvvjh9vxfxkoqcW8NibNpCUQ6eS6SSfe0n4fK+gcGi2L
         ynKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QC+ohq6WZjxovn5VwJ2HdsYXNpZbNsFxrRkCdKEZ/vc=;
        b=Y9ocqWLd40Si4LuO4hXmdXxuWscUOU75nXzh/dcfVFqQ0cvSvTqmaKtsnlH7YkQKkr
         +kU1JyinhxRSm6/Ae7AoBnB4ftbso4R2ekpB8zjewOdQB6hxnR6wejuwe+WKF6cwdrN3
         1EuX3/kqdHbB0q6deBT66cxoD7oo+tN3nUdWBY0cdE/UNjOxFjKztGF2GVGTeFznfpqB
         BIy7e+YQr4XZ8qYSQtLN1uQJJa02GFU6nXCM470FQkhQJp5A/PYLaCdtjuDFEioo3o/g
         zz0RZrx3lQwxbGI34+iV7/muE3QCZQssjCF3kCs77YWJgIfV0EeiAWgZLWjqDawz0T31
         fa1g==
X-Gm-Message-State: ANhLgQ1LoJq8IVVe803Cq1zEhxRlD8tvlubY75FwBnWKXeaI0Vc5m2Wr
        RbYQ7fJhl0aLfMzC8mySEDQ=
X-Google-Smtp-Source: ADFU+vvSmEkn14N0smjb5VMv00Mj+6EELqW7JUDOxklCkXBTpfTN5vh4A0EFg0BmcUEjAhAE7lcR7Q==
X-Received: by 2002:a62:2ad0:: with SMTP id q199mr7714552pfq.48.1585203894994;
        Wed, 25 Mar 2020 23:24:54 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id b9sm793958pgi.75.2020.03.25.23.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 23:24:53 -0700 (PDT)
Date:   Wed, 25 Mar 2020 23:24:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jannh@google.com,
        vbabka@suse.cz, dancol@google.com, joel@joelfernandes.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/2] mm/madvise: help MADV_PAGEOUT to find swap cache
 pages
Message-ID: <20200326062451.GA110624@google.com>
References: <20200323234147.558EBA81@viggo.jf.intel.com>
 <20200323234149.9FE95081@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323234149.9FE95081@viggo.jf.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:41:49PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> tl;dr: MADV_PAGEOUT ignores unmapped swap cache pages.  Enable
> MADV_PAGEOUT to find and reclaim swap cache.
> 
> The long story:
> 
> Looking for another issue, I wrote a simple test which had two
> processes: a parent and a fork()'d child.  The parent reads a
> memory buffer shared by the fork() and the child calls
> madvise(MADV_PAGEOUT) on the same buffer.
> 
> The first call to MADV_PAGEOUT does what is expected: it pages
> the memory out and causes faults in the parent.  However, after
> that, it does not cause any faults in the parent.  MADV_PAGEOUT
> only works once!  This was a surprise.
> 
> The PTEs in the shared buffer start out pte_present()==1 in
> both parent and child.  The first MADV_PAGEOUT operation replaces
> those with pte_present()==0 swap PTEs.  The parent process
> quickly faults and recreates pte_present()==1.  However, the
> child process (the one calling MADV_PAGEOUT) never touches the
> memory and has retained the non-present swap PTEs.
> 
> This situation could also happen in the case where a single
> process had some of its data placed in the swap cache but where
> the memory has not yet been reclaimed.
> 
> The MADV_PAGEOUT code has a pte_present()==0 check.  It will
> essentially ignore any pte_present()==0 pages.  This essentially
> makes unmapped swap cache immune from MADV_PAGEOUT, which is not
> very friendly behavior.
> 
> Enable MADV_PAGEOUT to find and reclaim swap cache.  Because
> swap cache is not pinned by holding the PTE lock, a reference
> must be held until the page is isolated, where a second
> reference is obtained.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Minchan Kim <minchan@kernel.org>
