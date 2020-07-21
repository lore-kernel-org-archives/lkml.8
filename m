Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E4DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB402063A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595343630;
	bh=iznnPoVqYimi5/Rsz8o0VYvjp1CJFTJYU+fl1c+IbIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VsCzSUaI7FqB9RB2Ov9LSXKEKBzSXwnrgmfadCq+VBiEhxODAR6gErSX1Ja5Jzl7M
	 LPQEx5YiC8q7FOoVwZoxwKT8z7g8YqQmJ9m6lx6mmA9M7l6pMJkhi6r/EW8GSGkviq
	 eSiBFF1OvCjGUq/hq41SzAt++xCQYLmF/upWvBkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgGUPA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:00:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35850 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUPA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:00:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id 88so11244995wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PdRzWzU32y088w1nnN7LL05iSLcy8TzWf9MSc3wvOO0=;
        b=cqP9gcQGouKXuAA2A99gq39dqlcXkMUImJ/cd8JWwFGeFk+F8KJMktN8a93Bi+043h
         yXy7+UgZeB9DOO3mm9GOmemKBBVHWLtdlFG9bsnSP2qbF3zYRcUDXDtFWNNREqGU7oQE
         CQUufjwfNC0Awfl+fb39XStrI9a0EhW9VLN7m5lk2LqJkbygXe3obMooHhhTdQcQgpe+
         0VrMXl4Ss0eXkV8utPxDlmZfwrkmeHtDsAv8R8x3bHTzulBoRniXN6Ax/AzxXY+RRCDw
         alSdb3L1eHjnoRSzkeQ5WrHRaNr7GVnGdNQANpeil/LD1/u7cSiGQEZYFw3OGAIk/t19
         HoYw==
X-Gm-Message-State: AOAM530HJ0eIkBLRrDZajPnHHc2i6mOm0mQGX8HybJLxQ5Z9c7NEQ8rs
        5ERKUWkZZgV7xTLmc5mOe0O4ETw9
X-Google-Smtp-Source: ABdhPJxco7vYnqIFP97qOvGVNKuHycTz/zqbqi5v7NCur7WZ6wi/ZNqRv2m84qNgnC2PyV+EndhDqw==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr12839448wrr.323.1595343626779;
        Tue, 21 Jul 2020 08:00:26 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id b139sm4002776wmd.19.2020.07.21.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:00:25 -0700 (PDT)
Date:   Tue, 21 Jul 2020 17:00:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200721150024.GM4061@dhcp22.suse.cz>
References: <20200721063258.17140-1-mhocko@kernel.org>
 <20200721141749.GA742741@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721141749.GA742741@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-07-20 15:17:49, Chris Down wrote:
> I understand the pragmatic considerations here, but I'm quite concerned
> about the maintainability and long-term ability to reason about a patch like
> this.  For example, how do we know when this patch is safe to remove? Also,
> what other precedent does this set for us covering for poor userspace
> behaviour?
> 
> Speaking as a systemd maintainer, if udev could be doing something better on
> these machines, we'd be more than receptive to help fix it. In general I am
> against explicit watchdog tweaking here because a.) there's potential to
> mask other problems, and b.) it seems like the kind of one-off trivia nobody
> is going to remember exists when doing complex debugging in future.
> 
> Is there anything preventing this being remedied in udev, instead of the
> kernel?

Yes, I believe that there is a configuration to cap the maximum number
of workers. This is not my area but my understanding is that the maximum
is tuned based on available memory and/or cpus. We have been hit byt
this quite heavily on SLES. Maybe newer version of systemd have a better
tuning.

But, it seems that udev is just a messenger here. There is nothing
really fundamentally udev specific in the underlying problem unless I
miss something. It is quite possible that this could be triggered by
other userspace which happens to fire many workers at the same time and
condending on a shared page.

Not that I like this workaround in the first place but it seems that the
existing code allows very long wait chains and !PREEMPT kernels simply
do not have any scheduling point for a long time potentially. I believe
we should focus on that even if the systemd as the current trigger can
be tuned better. I do not insist on this patch, hence RFC, but I am
simply not seeing a much better, yet not convoluted, solution.

-- 
Michal Hocko
SUSE Labs
