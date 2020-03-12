Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8E2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C98206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbsJWk4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCLSUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:20:36 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44316 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgCLSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:20:36 -0400
Received: by mail-pl1-f176.google.com with SMTP id d9so2968022plo.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sitKDgz0+LgOUGSpSSKOiwIOdws21DnB8cqKgpJ9nJM=;
        b=PbsJWk4cyqT0fCsrZEU4WqJL4RHHSQpca/DV1+0vlTsK4AeMwDGs4i3AdILikQOpB7
         0OKTw82se3eH+rxgIAdo4VLn3zynA4SxqPgmhAkWM3p+BJrcvGQxNzZ6OuJw0SXEmWAz
         aCVGrFuKkm2qtNNPs7PVXUSpWNXF/qhfQmOZ3L4vJ5lyNq7dSbO6PX1JA6Q4XZxuGUuf
         qkVI0aTv8TfqHZ5nQey6dupAMuDBbXytb7GeCoKv4BcQ445jFrpcndcitndxjkYIE0jQ
         63B3Y6M/dUWY3HlN7SBazVSznnaqH/ZrIYb9oca6+/ZDfIM042kSZ9GaEgd/kHM04o9Q
         5Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sitKDgz0+LgOUGSpSSKOiwIOdws21DnB8cqKgpJ9nJM=;
        b=MYM4+NmlPShd0PnAvy5huUfneSBbYdlJOM4Fw6PiTZXZBM+nNYN+UZBe3WQVVYwPXf
         eWDCh9dMFq+rUVhrg5+hvrD6dlHJqhkGMS3mg//4SEG5JcX6ozxXJ4J0TE+mZEFsa+7A
         Y1NU6x1HWBN3RFqkefj1y9AiXCddX2cBVuesf3pKwWWcttY1OdsiOZRLbzqcl+CdZX+p
         MXprSnXCzfCgzASLZTK1ij2tlCCaQEjPoS2nfiY4JcluWyWrY0K4mAqp9N47xd1hHsE3
         hGgFj7Cg9p54dLbEk3dXqeyh6aKFHiNdK5c4Yo1BMfHfcSxWE+6Yv8OHEu1Bs1M+t554
         4SNw==
X-Gm-Message-State: ANhLgQ3mpGSesvHK79MR4r3RgXlc4d6BBj2uCkXKANer58iZFW+uSA+B
        LgJLm3pSvcEFSlqiXXngSqZC/ugtQwY=
X-Google-Smtp-Source: ADFU+vtDzVDzQennu+P0iZ4plMN3zZILYTl7HKoNff1VX+/NCUykYYtYOBjMkO1u7Mr2wMvpjotZXw==
X-Received: by 2002:a17:90b:310c:: with SMTP id gc12mr4901073pjb.193.1584037234557;
        Thu, 12 Mar 2020 11:20:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e7sm1869108pfj.97.2020.03.12.11.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:20:33 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:20:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <20200312083241.GT23944@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2003121115480.158939@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com> <20200310221019.GE8447@dhcp22.suse.cz> <alpine.DEB.2.21.2003101556270.177273@chino.kir.corp.google.com> <20200311082736.GA23944@dhcp22.suse.cz> <alpine.DEB.2.21.2003111238570.171292@chino.kir.corp.google.com>
 <20200312083241.GT23944@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020, Michal Hocko wrote:

> > I think the changelog clearly states that we need to guarantee that a 
> > reclaimer will yield the processor back to allow a victim to exit.  This 
> > is where we make the guarantee.  If it helps for the specific reason it 
> > triggered in my testing, we could add:
> > 
> > "For example, mem_cgroup_protected() can prohibit reclaim and thus any 
> > yielding in page reclaim would not address the issue."
> 
> I would suggest something like the following:
> "
> The reclaim path (including the OOM) relies on explicit scheduling
> points to hand over execution to tasks which could help with the reclaim
> process.

Are there other examples where yielding in the reclaim path would "help 
with the reclaim process" other than oom victims?  This sentence seems 
vague.

> Currently it is mostly shrink_page_list which yields CPU for
> each reclaimed page. This might be insuficient though in some
> configurations. E.g. when a memcg OOM path is triggered in a hierarchy
> which doesn't have any reclaimable memory because of memory reclaim
> protection (MEMCG_PROT_MIN) then there is possible to trigger a soft
> lockup during an out of memory situation on non preemptible kernels
> <PUT YOUR SOFT LOCKUP SPLAT HERE>
> 
> Fix this by adding a cond_resched up in the reclaim path and make sure
> there is a yield point regardless of reclaimability of the target
> hierarchy.
> "
> 
