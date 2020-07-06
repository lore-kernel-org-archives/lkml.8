Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A203EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C4820720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594078943;
	bh=t/nO/7PyzLhpBEiwo9upsXorfRn3O1Jz/2RyIvBEB5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ExIrJrB6dUv2XgX2Epcw5iqHiN0Mmvr4AaqqUbMCHjGI7LQzr+mx5aelBNrMfkw+J
	 +iPI0imBqh4qAYpcBSJ5wIp4ske5Z/u9ayKaFy7WotRwbwxidv4qkCHrbzO1H3+1FJ
	 lwDj9sWK9VgF6rnX1UfNbtj0AduIcnYZ6s0FwzRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgGFXmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgGFXmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:42:21 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FD2206E9;
        Mon,  6 Jul 2020 23:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594078941;
        bh=t/nO/7PyzLhpBEiwo9upsXorfRn3O1Jz/2RyIvBEB5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gf08immkIY0zN6dKfIodzmcYTFcyBsLPgNlF2Zxveg00m2kfu570Aa8vSheBrB4qA
         9sJr1So6ZaP888dMXSbmFZZBkTvpsdR/c4hRv1ONC3MVK9hG57f452K2n3Nr1i0YBs
         atWUXl54/p//1sVSBkLN7G/yaHRCgNxao2HHpZ5I=
Date:   Mon, 6 Jul 2020 16:42:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andi Kleen <andi.kleen@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>, Qian Cai <cai@lca.pw>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, tim.c.chen@intel.com,
        dave.hansen@intel.com, ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-Id: <20200706164220.cc73e53c7f1b285910c82807@linux-foundation.org>
In-Reply-To: <20200706133434.GA3483883@tassilo.jf.intel.com>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
        <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
        <20200705125854.GA66252@shbuild999.sh.intel.com>
        <20200705155232.GA608@lca.pw>
        <20200706014313.GB66252@shbuild999.sh.intel.com>
        <20200706023614.GA1231@lca.pw>
        <20200706132443.GA34488@shbuild999.sh.intel.com>
        <20200706133434.GA3483883@tassilo.jf.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 06:34:34 -0700 Andi Kleen <andi.kleen@intel.com> wrote:

> >  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> > -	if (ret == 0 && write)
> > +	if (ret == 0 && write) {
> > +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> > +			schedule_on_each_cpu(sync_overcommit_as);
> 
> The schedule_on_each_cpu is not atomic, so the problem could still happen
> in that window.
> 
> I think it may be ok if it eventually resolves, but certainly needs
> a comment explaining it.

It sure does.

The new exported-to-everything percpu_counter_sync() should have full
formal documentation as well, please.

> Can you do some stress testing toggling the
> policy all the time on different CPUs and running the test on
> other CPUs and see if the test fails?
> 
> The other alternative would be to define some intermediate state
> for the sysctl variable and only switch to never once the schedule_on_each_cpu
> returned. But that's more complexity.
> 
> 
> -Andi
