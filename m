Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9E3207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jiQOt+ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgGINkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgGINkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:40:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22980C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:40:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so1619522qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aArSsX+kcLK9H8PVf32S+hV/fWVcEOHS9Noqj2O8rKM=;
        b=jiQOt+nsmfzilkitKNSPpd5yXuFYmVlVIOz576TJcEy1B7M62GpAPcTuXs8vkt6v9m
         d+pMf2eTYAMo0al7k40A5COZd7ZfW8UXSXmP3UM6my5TfKBZKVWQdxdyb5NC+zD3O6/T
         39ipTCctzxbDF2K9uPSH+1ul9J9q6gJwwwoGowCfgHAN9K087wYwZaOWBbbyaj9MuNw1
         g/p8Q3PvrCdLST1PNbXi/aQQe1/CXwd51HXRVjCxc6Jo0nYdNQea1cbOy3Mn7lXw9/s9
         KlaHC5WRu65feGrDHE0jrXH/z93TIxNo+JfylWMpRyzAenyqdV30rqwV2R6qvUg1/gtf
         ZKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aArSsX+kcLK9H8PVf32S+hV/fWVcEOHS9Noqj2O8rKM=;
        b=ScdAZyrMzUvF5dt99OFfjb2Ir3VQU+Ddm8aAJJFYWR0F3iPSNmwa+gou7dC6qAdoSl
         JVwYfO8GCoyEz+vPPpzIXhlZAZOAyr7CvwgIsQ5KIGL9oji+RQGC6RKlpTPcaR4ybXer
         O+FhTZ+hTnKwAwRqXhVI3NxhV1USxnOFdjCfTzGmQFceKzIFA9RrIjmORP6K7SdGute1
         LIgv4kCvhw64KUhbtFN1ViRJTIrhRNeMps87aZpIsIl5Bw2vNc+uwjVZenLNfwBReNQo
         NjFjhJGwfdoUCWK4PggAIh6hwEFb4Fx8cD0TqiXvF93YcO8EnOF2DTBaQZ/R3iNaZ90g
         FUTQ==
X-Gm-Message-State: AOAM531/mRIevHNYSt7D0YAGhWxb1/jI1hZQ0Oobf5z/jMCzAcIAj7HD
        FwfYd9DhbIz3VZUid7j2PlCxLA==
X-Google-Smtp-Source: ABdhPJzFdcRqPgQkgNX9l5WhqF5BXcfGauhlP1aK2Z2MDXMzJDiY1XduUAcnhyd5x2bE3xSAxyrYpQ==
X-Received: by 2002:ac8:3985:: with SMTP id v5mr64771468qte.337.1594302048335;
        Thu, 09 Jul 2020 06:40:48 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d14sm3741806qti.41.2020.07.09.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:40:47 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:40:40 -0400
From:   Qian Cai <cai@lca.pw>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, tim.c.chen@intel.com,
        dave.hansen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200709134040.GA1110@lca.pw>
References: <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
 <20200706014313.GB66252@shbuild999.sh.intel.com>
 <20200706023614.GA1231@lca.pw>
 <20200706132443.GA34488@shbuild999.sh.intel.com>
 <20200706133434.GA3483883@tassilo.jf.intel.com>
 <20200707023829.GA85993@shbuild999.sh.intel.com>
 <87zh8c7z5i.fsf@yhuang-dev.intel.com>
 <20200707054120.GC21741@shbuild999.sh.intel.com>
 <20200709045554.GA56190@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709045554.GA56190@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 12:55:54PM +0800, Feng Tang wrote:
> On Tue, Jul 07, 2020 at 01:41:20PM +0800, Feng Tang wrote:
> > On Tue, Jul 07, 2020 at 12:00:09PM +0800, Huang, Ying wrote:
> > > Feng Tang <feng.tang@intel.com> writes:
> > > 
> > > > On Mon, Jul 06, 2020 at 06:34:34AM -0700, Andi Kleen wrote:
> > > >> >  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> > > >> > -	if (ret == 0 && write)
> > > >> > +	if (ret == 0 && write) {
> > > >> > +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> > > >> > +			schedule_on_each_cpu(sync_overcommit_as);
> > > >> 
> > > >> The schedule_on_each_cpu is not atomic, so the problem could still happen
> > > >> in that window.
> > > >> 
> > > >> I think it may be ok if it eventually resolves, but certainly needs
> > > >> a comment explaining it. Can you do some stress testing toggling the
> > > >> policy all the time on different CPUs and running the test on
> > > >> other CPUs and see if the test fails?
> > > >
> > > > For the raw test case reported by 0day, this patch passed in 200 times
> > > > run. And I will read the ltp code and try stress testing it as you
> > > > suggested.
> > > >
> > > >
> > > >> The other alternative would be to define some intermediate state
> > > >> for the sysctl variable and only switch to never once the schedule_on_each_cpu
> > > >> returned. But that's more complexity.
> > > >
> > > > One thought I had is to put this schedule_on_each_cpu() before
> > > > the proc_dointvec_minmax() to do the sync before sysctl_overcommit_memory
> > > > is really changed. But the window still exists, as the batch is
> > > > still the larger one. 
> > > 
> > > Can we change the batch firstly, then sync the global counter, finally
> > > change the overcommit policy?
> > 
> > These reorderings are really head scratching :)
> > 
> > I've thought about this before when Qian Cai first reported the warning
> > message, as kernel had a check: 
> > 
> > 	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> > 			-(s64)vm_committed_as_batch * num_online_cpus(),
> > 			"memory commitment underflow");
> > 
> > If the batch is decreased first, the warning will be easier/earlier to be
> > triggered, so I didn't brought this up when handling the warning message.
> > 
> > But it might work now, as the warning has been removed.
> 
> I tested the reorder way, and the test could pass in 100 times run. The
> new order when changing policy to OVERCOMMIT_NEVER:
>   1. re-compute the batch ( to the smaller one)
>   2. do the on_each_cpu sync
>   3. really change the policy to NEVER.
> 
> It solves one of previous concern, that after the sync is done on cpuX,
> but before the whole sync on all cpus are done, there is a window that
> the percpu-counter could be enlarged again.
> 
> IIRC Andi had concern about read side cost when doing the sync, my
> understanding is most of the readers (malloc/free/map/unmap) are using
> percpu_counter_read_positive, which is a fast path without involving lock.
> 
> As for the problem itself, I agree with Michal's point, that usually there
> is no normal case that will change the overcommit_policy too frequently.
> 
> The code logic is mainly in overcommit_policy_handler(), based on the
> previous sync fix. please help to review, thanks!
> 
> int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
> 		size_t *lenp, loff_t *ppos)
> {
> 	int ret;
> 
> 	if (write) {
> 		int new_policy;
> 		struct ctl_table t;
> 
> 		t = *table;
> 		t.data = &new_policy;
> 		ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
> 		if (ret)
> 			return ret;
> 
> 		mm_compute_batch(new_policy);
> 		if (new_policy == OVERCOMMIT_NEVER)
> 			schedule_on_each_cpu(sync_overcommit_as);
> 		sysctl_overcommit_memory = new_policy;
> 	} else {
> 		ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> 	}
> 
> 	return ret;
> }

Rather than having to indent those many lines, how about this?

t = *table;
t.data = &new_policy;
ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
if (ret || !write)
	return ret;

mm_compute_batch(new_policy);
if (new_policy == OVERCOMMIT_NEVER)
	schedule_on_each_cpu(sync_overcommit_as);

sysctl_overcommit_memory = new_policy;
return ret;
