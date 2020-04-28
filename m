Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E45C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BF7206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Y04B/ety"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgD1VUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgD1VUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:20:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52033C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:20:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s63so23372902qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DYMJh06e9iMMWdrsr02cndKE1zO1nSUZw6qGhVvzfJk=;
        b=Y04B/etyyvTEoyxiFp/Ge/tIuXV13XVK0tWT0wMgXagiNpdXZHu671Z6uz1oRQxTB/
         luDeG+Ku00p2UIdq6iTHAj9wPCunMVfBBb7rEmmQQoPJMnvNJbx9jNYKKvrwAxUM2POw
         NsPtGsFu+ENVdOtc0jqhTayn09DQb7BFMworUt92vQxYGwMip2kjIPcUtpO8P2SSG4Sb
         ipW+OfYq3uk7IwQhZ4zZTN20uXB8GtEQZsq8l1ttW9kaZJd9zkSybkcacHxlcVU7vCFm
         dGy41fvebrFw1PFFAc8HjEB30V0SWwU7SSLDh0nH1vGdWM2eUPfMopufnc0w0Wl3xMiG
         mujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DYMJh06e9iMMWdrsr02cndKE1zO1nSUZw6qGhVvzfJk=;
        b=K7NzQA6EiqRL6ZKvmwyx24Y6TJGgl3AP2vxjxDuR0Bv/1NzlimTiJLLoe9K+YXqteM
         aRxT+WZZaZ9jKBTEESI/bCus3rJ74rb89+DM1sJdpZmDRT/eOTMLvHUe/iil6EhASOVS
         mzVwBPi4L0UPbsOFpxeW5sNzllULGfXo6RbcjU1cUhnFcYYZS87bEg57FnNZ2suweppi
         1d+vG20XyR5UaNKFuEIarWjcamuDKbdUS8Yv9t255FPl01D49pK4EYUbB70NlHAPhSYG
         UJGN5p4+oneoLgWYVPq+Rv+U6+nXaO1+xyF1Mm6lcrOrbLau79ChVi3tyKILsf83btNE
         qS7Q==
X-Gm-Message-State: AGi0Pua1V5igGZ8/C8DbfxUosvVn8ZNaEoqCrmplTy3uvs3hR8uUT6ya
        kjQziPQ79+a94d6/UWW6sydAKQ==
X-Google-Smtp-Source: APiQypKw92B0PsLW4fngghJDAt/o149NdgzbjL2f02LwkiP7VoBOSPh0EhAm3W1iLGRbyDc//W1uRQ==
X-Received: by 2002:a37:981:: with SMTP id 123mr29310832qkj.453.1588108803619;
        Tue, 28 Apr 2020 14:20:03 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 60sm14455678qtb.95.2020.04.28.14.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:20:03 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:19:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm, memcg: Decouple e{low,min} state mutations from
 protection checks
Message-ID: <20200428211953.GB400178@cmpxchg.org>
References: <cover.1588092152.git.chris@chrisdown.name>
 <51ffacb736bb02ecc09c828ebe8f4ec7fda68c48.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ffacb736bb02ecc09c828ebe8f4ec7fda68c48.1588092152.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 07:27:00PM +0100, Chris Down wrote:
> mem_cgroup_protected currently is both used to set effective low and min
> and return a mem_cgroup_protection based on the result. As a user, this
> can be a little unexpected: it appears to be a simple predicate
> function, if not for the big warning in the comment above about the
> order in which it must be executed.
> 
> This change makes it so that we separate the state mutations from the
> actual protection checks, which makes it more obvious where we need to
> be careful mutating internal state, and where we are simply checking and
> don't need to worry about that.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
