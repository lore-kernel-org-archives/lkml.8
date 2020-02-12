Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2890C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8211E206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="O6bqdQqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgBLRI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:08:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38168 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:08:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id z19so2755000qkj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HsBl5rMluvvE/pco2RfgwIL5+jpMuMRec38m/p38OMc=;
        b=O6bqdQqB754/215opJE3M7EUYVTUIhhbCE2lNZaklstLauxL4cB6U5Lkm8nLa6ai+V
         M6T/WjrYmfRSVrpnvIulIoWhLs9eS8Y55Aariv3m4POcoSqfrPc52/AL5HHw49GU3aro
         q9emBN3umt3HPcAAZjNvc7ea18lJ/hn8Q3S4jrizD022B9CE+zN+WAsr6FS6zAPsSER0
         lkBBVZbw1FZR9AD9LiyKVVyyqDxsGlA8Ky4TnhMZQhNdW8OGVXr8cXXeIQ1SLHE1IhDD
         yb2N6V11ijw8SEjuvEiC7qqWBmpm6xRnSyJIfQPhV6KRUx6DOyATDYdS8rZ1mEZvPFQy
         lORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HsBl5rMluvvE/pco2RfgwIL5+jpMuMRec38m/p38OMc=;
        b=dFM3IytRLiKX4t020x3MCnk5jmuqUozOUNKk2/tD98J7mJgDooRviMEDtach+hRXIt
         WG79PTy4qGaVwRUk1NuCXXBBnfFB5uGO7wEPF4nznuoyaQInZQ6bDYdb4/jHLHMPCWFp
         3UJjYxaqrQNt9XXuFaK8aOymjypPSVLVnaaroCuwRod7+ku/SenPFMDlaMjh2pHqz+W8
         n8NwKgf8pcLrAlnE+nqzmU70mgxx41Hoj7RQ8E5AdGGmy0VaIiZBC/7ATDaz05R4m39t
         x4wguMOwIFwB9mEa1RNl3xGFzwgHLrjim5qIbA22rn6bg8c0Kv5sJY/hK5BJJ9poLBd3
         Xwfw==
X-Gm-Message-State: APjAAAW0ImLQ3f35XFWpM4zqz9vw+ikjxN0YBTR9RxKV7QeP94rzw+D2
        7n/2BdRouwDEkM3ohlbSbK8x6w==
X-Google-Smtp-Source: APXvYqzFArg0u7ixTyn9XIaPgPpptQEFElmY295g4IC8sWja/fFRjB35UdOOImoT6soG8zmA6a9W0w==
X-Received: by 2002:a37:e409:: with SMTP id y9mr12047308qkf.352.1581527307550;
        Wed, 12 Feb 2020 09:08:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:26be])
        by smtp.gmail.com with ESMTPSA id o6sm495462qkk.53.2020.02.12.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 09:08:26 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:08:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200212170826.GC180867@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211164753.GQ10636@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:47:53PM +0100, Michal Hocko wrote:
> Unless I am missing something then I am afraid it doesn't. Say you have a
> default systemd cgroup deployment (aka deeper cgroup hierarchy with
> slices and scopes) and now you want to grant a reclaim protection on a
> leaf cgroup (or even a whole slice that is not really important). All the
> hierarchy up the tree has the protection set to 0 by default, right? You
> simply cannot get that protection. You would need to configure the
> protection up the hierarchy and that is really cumbersome.

Okay, I think I know what you mean. Let's say you have a tree like
this:

                          A
                         / \
                        B1  B2
                       / \   \
                      C1 C2   C3

and there is no actual delegation point - everything belongs to the
same user / trust domain. C1 sets memory.low to 10G, but its parents
set nothing. You're saying we should honor the 10G protection during
global and limit reclaims anywhere in the tree?

Now let's consider there is a delegation point at B1: we set up and
trust B1, but not its children. What effect would the C1 protection
have then? Would we ignore it during global and A reclaim, but honor
it when there is B1 limit reclaim?

Doing an explicit downward propagation from the root to C1 *could* be
tedious, but I can't think of a scenario where it's completely
impossible. Especially because we allow proportional distribution when
the limit is overcommitted and you don't have to be 100% accurate.

And the clarity that comes with being explicit is an asset too,
IMO. Since it has an effect at the reclaim level, it's not a bad thing
to have that effect *visible* in the settings at that level as well:
the protected memory doesn't come out of thin air, it's delegated down
from the top where memory pressure originates.

My patch is different. It allows a configuration that simply isn't
possible today: protecting C1 and C2 from C3, without having to
protect C1 and C2 from each other.

So I don't think requiring an uninterrupted, authorized chain of
protection from the top is necessarily wrong. In fact, I think it has
benefits. But requiring the protection chain to go all the way to the
leaves for it to have any effect, that is a real problem, and it can't
be worked around.
