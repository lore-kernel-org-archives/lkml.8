Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6490220768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhBYvvKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391405AbgFXUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391221AbgFXUAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:00:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423BC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:00:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q17so1676841pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IeM1pbX3Y/QRt8rMyrroNyrQ/gTGnkJwEnogm0dQ3GE=;
        b=uhBYvvKCWelTf4JenS6hYiSwgyGKBjl7XAHO+DuYLiRrdYNH1hh8a647W7MkpRc4W3
         grtXLTOUfUT9eg5QiRa1Fb/bpa4JxRgaR1568VZ3Rp4Tzrkb68F99ewBKwLJE2svnato
         wIDa9TNmSIMZXHndufHSFI3KeZwRR31Pat1P9Ww2YAe/Blsh7+N+pV1a1TQjce7oLPl+
         L9IhY2vdG5I9KUW4iS96MKRWm8TQzhkjib3ioZR2aREcTFKbAucF0gsWUdHcOivUMgTR
         hZV33HumrWYCIH4FW+6RBsVHhBxSKuITT9/LtRDQYcJXRJ3TafqePblA72wzwovefbeN
         YUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IeM1pbX3Y/QRt8rMyrroNyrQ/gTGnkJwEnogm0dQ3GE=;
        b=msXBUmx21kWY8CbQAxXovxGuzg/IjLN0ka0mnGBkrO64roADLC4/DzrOyVoeS8RHEj
         jLpgCAg+QCHWSQ9NC4cOsAFXuaVpy/pzwv2NrRBG1vFp5XU9rA+0k6Vtm5o0pp/6sFmX
         WulwVC1+AAe5nkjluncBZLpMyOT+qc2NucPl3k9XaduUpun1Kz7K2hcg3Xi0V88UdW8n
         s9QxEuvJeToxVrMN0pBhnuzulF8vxNptZxow519VL+MmQBWrqBs5FHSXKD3gOqii+TRu
         ZEU2qpXUpqcj/gM1DP0e3kDMk1fAEGhd/LY2s46C6TzMYd3/eRLPwlqOvH/qinlpSBi0
         qR+g==
X-Gm-Message-State: AOAM533XqbqkSmSqLx4k715G41Z/BgcGxE8WeJt4nB722120GIbV/tKa
        n91BuqVxhhW2aQcF8tol2piq1w==
X-Google-Smtp-Source: ABdhPJwi+ep/yhnadV35mqvrBbBtsDSgiibwsNhPmy0Eh7KnXNpc3Qxvv8zxkmDoRNCdHSdO5Af54A==
X-Received: by 2002:aa7:924c:: with SMTP id 12mr30224767pfp.225.1593028805959;
        Wed, 24 Jun 2020 13:00:05 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h30sm3090949pfr.89.2020.06.24.13.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:00:05 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:00:04 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Minchan Kim <minchan@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v8 4/4] mm/madvise: check fatal signal pending of target
 process
In-Reply-To: <20200622192900.22757-5-minchan@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2006241259530.35388@chino.kir.corp.google.com>
References: <20200622192900.22757-1-minchan@kernel.org> <20200622192900.22757-5-minchan@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020, Minchan Kim wrote:

> Bail out to prevent unnecessary CPU overhead if target process has pending
> fatal signal during (MADV_COLD|MADV_PAGEOUT) operation.
> 
> Link: http://lkml.kernel.org/r/20200302193630.68771-4-minchan@kernel.org
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Daniel Colascione <dancol@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: John Dias <joaodias@google.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oleksandr Natalenko <oleksandr@redhat.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: SeongJae Park <sj38.park@gmail.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Sonny Rao <sonnyrao@google.com>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: <linux-man@vger.kernel.org>

Acked-by: David Rientjes <rientjes@google.com>
