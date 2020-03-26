Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77421C2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493BD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585239743;
	bh=q3P/MM00/TjaoN0bD6LqkI388ZCVFcS+n4LUIF5KCYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r9G8DbPQIZ2OBegIcOixprQh2HxepWWEdBGTY+ZbBhz+KYT5CyjO/d8B+m6Kzlwle
	 8U/CGtF5V3kbzVxtwFTxg8eVIahbdc5rKL0pvtPKIhmM8cSx40G0ur83tkLEDRjvxg
	 3hmtwI6iE7QUVAzeGzTy7Q3xd9eMrUpdjHXzidsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgCZQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbgCZQWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:22:22 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C13802083E;
        Thu, 26 Mar 2020 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585239741;
        bh=q3P/MM00/TjaoN0bD6LqkI388ZCVFcS+n4LUIF5KCYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9jVZT+iWYixmSOf/Eov6Hd3J/SsuXrwRW1PnRUx6kuaicKfI92SDj17OUPBT5hgn
         1PQ6ZbsG9pyJ36A8SfrsR+Mf8L7/esSoh+79l7nCucVCXPeBXlWiuCCDlboUzdNJJ7
         JROAd9PVFH/3vwCAIvaNF/w39lnpzfcNfxWjsLYU=
Date:   Thu, 26 Mar 2020 17:22:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Marcelo Tosatti' <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Friesen <chris.friesen@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200326162218.GB3946@lenoir>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
 <20200324152016.GA25422@fuller.cnet>
 <b88327780661496fbee6d8ebe2e0d965@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88327780661496fbee6d8ebe2e0d965@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 06:05:27PM +0000, David Laight wrote:
> From: Marcelo Tosatti
> > Sent: 24 March 2020 15:20
> > 
> > This is a kernel enhancement to configure the cpu affinity of kernel
> > threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> > 
> > When this option is specified, the cpumask is immediately applied upon
> > thread launch. This does not affect kernel threads that specify cpu
> > and node.
> > 
> > This allows CPU isolation (that is not allowing certain threads
> > to execute on certain CPUs) without using the isolcpus=domain parameter,
> > making it possible to enable load balancing on such CPUs
> > during runtime
> ...
> 
> How about making it possible to change the default affinity
> for new kthreads at run time?
> Is it possible to change the affinity of existing threads?
> Or maybe only those that didn't specify an explicit one??

That's already possible yes, most unbound kthreads are accessible
through /proc including kthreadd from which new kthread will inherit
their CPU affinity.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
