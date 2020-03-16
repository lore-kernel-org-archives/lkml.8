Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB0C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DF42051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Z6fboPME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgCPQNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:13:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37724 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731991AbgCPQNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:13:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id z25so22263842qkj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MfbIGBc63hzvaI2AjhmQGq4X01IizPj1vckVgt6cE14=;
        b=Z6fboPME5eE2zk22FztnS6AC+ygfbWbrvd0GV/aPzJXFF7BOitZfSfphe7G5SGLDKO
         EaG13j4Bu+sJvDyzzAZGhqzRILxSdKeBbIgrtGJ5hbYof9Xnm3eQjrSz7AN9XyfliGIX
         nz+tC7bc3qNSw/onBelQEtbGkk8b0uBunLiBzLjap56J0SIOMqgmWNc32ltwDcboaqMK
         BWrsk52YTeZLvsCTA+d7oEjQ9ZF3ZLiQeOZNTu9qNkp+Eq1gUxWTmzFlt/6YIQ9ilaz7
         JOIwZSc5Vr4WakJZygmy8z5zwqyp6idd4ANSthrp/LpIGaE2ZF7J8QGS7YXpKAEKWV5T
         GXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MfbIGBc63hzvaI2AjhmQGq4X01IizPj1vckVgt6cE14=;
        b=USvpV/aPHswIPuFKMQzgJlSivX6wchQd25jKCe4DHUvZidfB63Abz1zA2GjUVMOn10
         pZ3u7PSWfpyZpkbP5yrI5Tha3Kotb8TT/wN+DcLAVYIH8bGsl8lWJwNV8vHALrx3Iqo+
         zdr+r0q6BQfhQNhWxDOUJOL4L0yRIFKDRpONORxVbon6u6U/SSdD/kniztZyBZLrR7j1
         S+D9k6Qn+WLZC2h/f16GNAbcd7kRCobPqkjHZjg2zsPDIxKKDD2MAkgDQ6bF0UzEZzti
         JKNXWBrhroHsn+xjSS9wUA7No/RQa+OYBZHeVgabyagpp/YxfvRHeu1C4ZA5JT/T6JTU
         Sdcg==
X-Gm-Message-State: ANhLgQ03T53ncFOGodVi5KPlmQQpsp/pcgcVUp61TuZejlFJhU3gF/t1
        5ez3OoFBMJsNKQd+FifNqXwS8Q==
X-Google-Smtp-Source: ADFU+vsVGfndOoHO//HLE/DL7hovHJD5skuz/7ebMx9g/pExAzenBq3qv99ouVtyhB8siwK0Ny7Jlw==
X-Received: by 2002:a37:e40d:: with SMTP id y13mr428529qkf.39.1584375209267;
        Mon, 16 Mar 2020 09:13:29 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id r29sm88711qtj.76.2020.03.16.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:13:28 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:13:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] psi: move PF_MEMSTALL out of task->flags
Message-ID: <20200316161327.GC67986@cmpxchg.org>
References: <1584355585-10210-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584355585-10210-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:46:25AM -0400, Yafang Shao wrote:
> The task->flags is a 32-bits flag, in which 31 bits have already been
> consumed. So it is hardly to introduce other new per process flag.
> Currently there're still enough spaces in the bit-field section of
> task_struct, so we can define the memstall state as a single bit in
> task_struct instead.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Thanks for reworking it. This looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
