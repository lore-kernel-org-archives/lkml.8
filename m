Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21333C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24B820716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UvymxQap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgFVM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFVM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:27:34 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YfMOzPuDOeX4F8QITGOgeYF7rNWEDYNWfPQiK8lEsik=; b=UvymxQapcE7G9G3BNTsfVoWsAb
        fZmDam+SDYF0RgZ4jiOp+7/7gPZWzGAG/TUtctH4Eqic5aqhN7oVwjo+ioPIRs5ZeVBl8dnwywvF5
        EA7lMmLB3RyR2Q74YVlBrN+h7Zk+/ZmIwiYGz81OJzz2UblNm8ADO/TlMuucDyIphFy5UQImZGUy/
        WRtKPGf+RamqB45FMAPFdYZA+dtQ41ouB7b1BhTVmK3T5kEAS8WmHux8Fy0NNTmcnyQrIrYiucmml
        JBaZXZs6UiGyTqEelgstXdPFaORQ64QdAlB61NIx5TRPECKpr6pdRKPjJ3CdKfeYaWqmald2Tsy9m
        eKouWOCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnLXa-0004J3-P2; Mon, 22 Jun 2020 12:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4847A301631;
        Mon, 22 Jun 2020 14:27:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAED4236D2014; Mon, 22 Jun 2020 14:27:08 +0200 (CEST)
Date:   Mon, 22 Jun 2020 14:27:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [rcu:dev.2020.06.17a 35/38] kernel/sched/core.c:2650
 try_to_wake_up() error: uninitialized symbol 'cpu'.
Message-ID: <20200622122708.GB576871@hirez.programming.kicks-ass.net>
References: <20200622121116.GD4151@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622121116.GD4151@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:11:17PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.06.17a
> head:   d3779e78b9848a707448dbb4a0cb6c4bb651fe9c
> commit: 59a5d883f2ccdce1700862b5983cfd3473630aea [35/38] EXP sched: Alleged fix for v5.8 merge-window scheduler issue
> config: x86_64-randconfig-m001-20200621 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> kernel/sched/core.c:2650 try_to_wake_up() error: uninitialized symbol 'cpu'.
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=59a5d883f2ccdce1700862b5983cfd3473630aea
> git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> git remote update rcu
> git checkout 59a5d883f2ccdce1700862b5983cfd3473630aea
> vim +/cpu +2650 kernel/sched/core.c
> 
> ^1da177e4c3f41 kernel/sched.c      Linus Torvalds 2005-04-16  2644  
> b5179ac70de85e kernel/sched/core.c Peter Zijlstra 2016-05-11  2645  	ttwu_queue(p, cpu, wake_flags);
> aacedf26fb7601 kernel/sched/core.c Peter Zijlstra 2019-06-07  2646  unlock:
> 013fdb8086acaa kernel/sched.c      Peter Zijlstra 2011-04-05  2647  	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> aacedf26fb7601 kernel/sched/core.c Peter Zijlstra 2019-06-07  2648  out:
> aacedf26fb7601 kernel/sched/core.c Peter Zijlstra 2019-06-07  2649  	if (success)
> aacedf26fb7601 kernel/sched/core.c Peter Zijlstra 2019-06-07 @2650  		ttwu_stat(p, cpu, wake_flags);
>                                                                                              ^^^
> This can be uninitialized on a couple "goto unlock;" paths.  Lines
> 2581 and 2622.  The KASan tool will warn about this at run time as well.
> I'm not sure why the build bot doesn't include the whole function for
> this bug report...

Indeed, lemme go fix.
