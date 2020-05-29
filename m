Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CECC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C62207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590737125;
	bh=SEGf7HPanKZuuMLH9HEIWpQrN2M5+ZEQMhjjVYgR1GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IaldXYtOf9SV89N82Rmsi10j3gVD/F+xXXVej173cz+cVgktEMO8BGm5vx7sT8ctu
	 hfOfkoFZ1IsL2aI9liwOH183A5Q/6QgFNEeskCnSWu+BRExkV5qthKOV+8Mtgf4oDS
	 RBW7AQzGEe5Wrl+QRU4SVJgjW3BvPdOKXiaPxo1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2HZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:25:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37756 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2HZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:25:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id x13so2247575wrv.4;
        Fri, 29 May 2020 00:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cu9vzNZYc7Xw8z9bCnT/mNbRyFHSEb5aY4LsyXQDvtk=;
        b=YrPWLBXp6/zcPwAl433ddMJ7NYhVyXgL7hx7q2+PkQyJcEjIwykx0J5O0wKQiMsWzz
         Z9OBa2x8MopgAzXShlHXiGvdDJ9iIOU5tsWPvO/GtTmO7FW0fwVaFbLekwZdNjLWhuv7
         vxRCrKfCYxDt4VS8OsTrVfUCYGYXRxlT7WtxtMn10gldf9mY6tuwNrFlgTNXhJwIOmut
         Q0C8e0oEWmiJAPANZyr078oBooM9JjILHph2j2xTh6wu9qoTgkwInzgbtyIMd+Q5w6N4
         Gn7ddi4jB+F97uHtSVlEVe0AYDfLY9eTKToAQPXkSMguUrDUEpTdAqP+PWujnvFbm2I2
         essw==
X-Gm-Message-State: AOAM531cY6wp2Cty1FqNSLPSGrR0fO9jb+tWB2qcAAkmm/71qtnYZoo2
        X8iKfD6Rh0Z5ar3GrC1/7tw=
X-Google-Smtp-Source: ABdhPJwf7DObSBiktuX8OHOA8HzkfiD7CcXiSTDiz9IrSF4MaH1zYmpZrK7vPF6TDC0tV1NJi4Yh7w==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr7133757wrq.325.1590737122925;
        Fri, 29 May 2020 00:25:22 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id b9sm8810619wrt.39.2020.05.29.00.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:25:21 -0700 (PDT)
Date:   Fri, 29 May 2020 09:25:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200529072445.GD4406@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
 <20200528194831.GA2017@chrisdown.name>
 <20200528202944.GA76514@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528202944.GA76514@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-05-20 16:29:44, Johannes Weiner wrote:
[...]
> How about this:
> 
> Reclaim memcg_nr_pages_over_high in the first iteration, then switch
> to SWAP_CLUSTER_MAX in the retries.

Yes, that makes much more sense to me.

-- 
Michal Hocko
SUSE Labs
