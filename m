Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77465C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF0220767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584525321;
	bh=rX9o3cONFnXZZSdXRRIWv+YtTf3HJAiBs6aYKS25k5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DlTeUOPrAQC+Cu9jnNo4sYLjsjZx6Dv6+GfUl7GkkeHBKlkihOqGOWTS5IQwt5ZKN
	 7PKUxTe4VDfi53xl65pITy/RilQmQ8H4Qs7e/pjNC4wQWLGpOKM2/8adSFHtOzGJ6L
	 11KvvmG7IUD95GNuayw0yO1w3t6YHd6p7EqovvTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgCRJzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:55:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38216 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgCRJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:55:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so7706979wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h44VEghhnCpVrg8TDJ73z2V7JCZi3jSE0gcmzyWYyfw=;
        b=Ns3cwG/SZAEByHqX2YtSUREbNmvn2ixBh9egXpGZj+Zn7J3ZtJl0DqoQAl43h2Nu0W
         UwqiVZbdE04k3eM/1rDKyWTOasvQ3c1CcqtImqBHMwoWjY4c8SqlhauDv9xviWKZnK+c
         1rPJvQcj9MpJz0yMnvjKBYAKwoK54xCl96k0JQYjUmDuye7iTDghP1dUbcnQgZkUJawi
         LQ8lc0PkbVwjyfsY8Ecs20XMOoKsDDbvkyacLc5GWrPc4hrliavPa8O5ULLrnBf1mN9J
         +yF19gI1/lCiZkYUJyPyxhAouRyWKxF3+ldbnBIlRvlLYKpP3/gSmwZ4HSR0ikNUk+OZ
         19Nw==
X-Gm-Message-State: ANhLgQ3v/H/HPaW/jVRVRYqH1ijG1mBMvZ1NlV8taxFW1mERAxJYROyu
        7ysrJLPaJ+HMtPNiZM42BN+HKPBh
X-Google-Smtp-Source: ADFU+vstgSHo5VmReUDZrAdj+l5NrUgEQOqkv+kWYNzAN2bza84o98mKLheUgeRu/U+bb1powmFOPQ==
X-Received: by 2002:adf:df82:: with SMTP id z2mr4474873wrl.46.1584525317004;
        Wed, 18 Mar 2020 02:55:17 -0700 (PDT)
Received: from localhost (ip-37-188-180-89.eurotel.cz. [37.188.180.89])
        by smtp.gmail.com with ESMTPSA id 195sm1952050wmb.8.2020.03.18.02.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:55:16 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:55:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Robert Kolchmeyer <rkolchmeyer@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ami Fischman <fischman@google.com>
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
Message-ID: <20200318095514.GF21362@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
 <20200310221938.GF8447@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
 <CAJc0_fwDAKUTcYd_rga+jjDEE2BT7Tp=ViWdtiUeswVLUqC9CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJc0_fwDAKUTcYd_rga+jjDEE2BT7Tp=ViWdtiUeswVLUqC9CQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-03-20 11:25:52, Robert Kolchmeyer wrote:
> On Tue, Mar 10, 2020 at 3:54 PM David Rientjes <rientjes@google.com> wrote:
> >
> > Robert, could you elaborate on the user-visible effects of this issue that
> > caused it to initially get reported?
> >
> 
> Ami (now cc'ed) knows more, but here is my understanding. The use case
> involves a Docker container running multiple processes. The container
> has a memory limit set. The container contains two long-lived,
> important processes p1 and p2, and some arbitrary, dynamic number of
> usually ephemeral processes p3,...,pn. These processes are structured
> in a hierarchy that looks like p1->p2->[p3,...,pn]; p1 is a parent of
> p2, and p2 is the parent for all of the ephemeral processes p3,...,pn.
> 
> Since p1 and p2 are long-lived and important, the user does not want
> p1 and p2 to be oom-killed. However, p3,...,pn are expected to use a
> lot of memory, and it's ok for those processes to be oom-killed.
> 
> If the user sets oom_score_adj on p1 and p2 to make them very unlikely
> to be oom-killed, p3,...,pn will inherit the oom_score_adj value,
> which is bad. Additionally, setting oom_score_adj on p3,...,pn is
> tricky, since processes in the Docker container (specifically p1 and
> p2) don't have permissions to set oom_score_adj on p3,...,pn. The
> ephemeral nature of p3,...,pn also makes setting oom_score_adj on them
> tricky after they launch.

Thanks for the clarification.

> So, the user hopes that when one of p3,...,pn triggers an oom
> condition in the Docker container, the oom killer will almost always
> kill processes from p3,...,pn (and not kill p1 or p2, which are both
> important and unlikely to trigger an oom condition). The issue of more
> processes being killed than are strictly necessary is resulting in p1
> or p2 being killed much more frequently when one of p3,...,pn triggers
> an oom condition, and p1 or p2 being killed is very disruptive for the
> user (my understanding is that p1 or p2 going down with high frequency
> results in significant unhealthiness in the user's service).

Do you have any logs showing this condition? I am interested because
from your description it seems like p1/p2 shouldn't be usually those
which trigger the oom, right? That suggests that it should be mostly p3,
... pn to be in the kernel triggering the oom and therefore they
shouldn't vanish.
-- 
Michal Hocko
SUSE Labs
