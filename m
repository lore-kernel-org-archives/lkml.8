Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5377C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F011206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589990883;
	bh=nPXnFffywA/1ltRGflWhejZcuskdPgGaSfTY+yTAPoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RllZkAiKclzBV5tWrTEBPAm1P6gPpLsXh91CH3WEXdOd+0XmmI6Abh4f7FQM1ScNq
	 FXNl5/dLPJr+Pr4UbkWvRnTzW+/ygiN7mkAHSRqKfvuto7zGel2KsAECGY3IIm/oca
	 31Rz0vxUKlESdxa6jDcgwQUBOAsGIMTfGHKG9ytc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgETQIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:08:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42199 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgETQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:08:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id k19so3628115edv.9;
        Wed, 20 May 2020 09:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgVaib5Fy+EUEQes9ZiIDDIjy7jSKVUxFMm2HzAvFj0=;
        b=eXg1/esxWxy1U1c/dajaoTGgexfkFMKIl6Fc27F6BPVrS1Jj9pd2rPxeBdOpHUkRJZ
         TPVPOZ2sL+UVzyZFHdGab7and6VjFMVom1n3eHt0O98jSA46Y6Xh6P3pGc40fECTt2K9
         U3zNgCLeCc2LMhcu3qCwwsXzqIXXTpBCz6m8CC60XI+AfkGnQs3Gh2dkyIfHgROM1558
         gw9kuT8GNqP/cr/9nY2iNtHDKdCkAAQYKk5gemuvzWHYOu+8WZLwDfQqvrdO5T1vy/zd
         Zk6BizFkANUWWMfAdmUN1oJBbAAyEz95jvpJQHe5f4ldnNpGSB667YJPF4o3USFlkM4e
         Rqqg==
X-Gm-Message-State: AOAM532I+3O39tuTqwtjpIb6SsaREvWRvs/73/yzSZruJgOdQKFCBRRc
        X4KVoFQN1A/8cWYSWFMAGeA=
X-Google-Smtp-Source: ABdhPJyQOPrPF3+kJAKOO9NVrKnMtjls62fkbDTEl2Pwkwd36rXGISXvYcPgJnDlKwm+JtcN9BWfjQ==
X-Received: by 2002:a05:6402:1c1e:: with SMTP id ck30mr3947546edb.154.1589990878278;
        Wed, 20 May 2020 09:07:58 -0700 (PDT)
Received: from localhost (ip-37-188-251-131.eurotel.cz. [37.188.251.131])
        by smtp.gmail.com with ESMTPSA id gl19sm2118874ejb.34.2020.05.20.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:07:57 -0700 (PDT)
Date:   Wed, 20 May 2020 18:07:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200520160756.GE6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520143712.GA749486@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-05-20 15:37:12, Chris Down wrote:
> In Facebook production, we've seen cases where cgroups have been put
> into allocator throttling even when they appear to have a lot of slack
> file caches which should be trivially reclaimable.
> 
> Looking more closely, the problem is that we only try a single cgroup
> reclaim walk for each return to usermode before calculating whether or
> not we should throttle. This single attempt doesn't produce enough
> pressure to shrink for cgroups with a rapidly growing amount of file
> caches prior to entering allocator throttling.
> 
> As an example, we see that threads in an affected cgroup are stuck in
> allocator throttling:
> 
>     # for i in $(cat cgroup.threads); do
>     >     grep over_high "/proc/$i/stack"
>     > done
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> 
> ...however, there is no I/O pressure reported by PSI, despite a lot of
> slack file pages:
> 
>     # cat memory.pressure
>     some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
>     full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
>     # cat io.pressure
>     some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
>     full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
>     # grep _file memory.stat
>     inactive_file 1370939392
>     active_file 661635072
> 
> This patch changes the behaviour to retry reclaim either until the
> current task goes below the 10ms grace period, or we are making no
> reclaim progress at all. In the latter case, we enter reclaim throttling
> as before.

Let me try to understand the actual problem. The high memory reclaim has
a target which is proportional to the amount of charged memory. For most
requests that would be SWAP_CLUSTER_MAX though (resp. N times that where
N is the number of memcgs in excess up the hierarchy). I can see to be
insufficient if the memcg is already in a large excess but if the
reclaim can make a forward progress this should just work fine because
each charging context should reclaim at least the contributed amount.

Do you have any insight on why this doesn't work in your situation?
Especially with such a large inactive file list I would be really
surprised if the reclaim was not able to make a forward progress.

Now to your patch. I do not like it much to be honest.
MEM_CGROUP_RECLAIM_RETRIES is quite arbitrary and I neither like it in
memory_high_write because the that is an interruptible context so there
shouldn't be a good reason to give up after $FOO number of failed
attempts. try_charge and memory_max_write are slightly different because
we are invoking OOM killer based on the number of failed attempts.

Also if the current high reclaim scaling is insufficient then we should
be handling that via memcg_nr_pages_over_high rather than effectivelly
unbound number of reclaim retries.

That being said, the changelog should be more specific about the
underlying problem and if the real problem is in the reclaim target then
it should be handled by an increased but still fixed size. If the
throttling is just too aggressive and puts task into sleep even when a
reclaim has been performed then the throttling should be fixed.
-- 
Michal Hocko
SUSE Labs
