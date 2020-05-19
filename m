Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281F8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23F82081A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgESQtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:49:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:47509 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgESQtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:49:00 -0400
IronPort-SDR: o8oUNMS51PzIQjx/DF9zaln9bBJTEx+tFHKZa48rz9b+DViqe7BuqGNkHxBkD1ruLEw8S9LqU0
 FQx31fp5/RAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 09:49:00 -0700
IronPort-SDR: VD1Q/i7H/L939aTI3k5AVEAZyVzWXPKt2JP73oj/6rjxwssovUBLbyzuVEKToxm00qeOiJ9tPY
 DwjQUfoVzFew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="282380436"
Received: from joelin3-mobl.gar.corp.intel.com (HELO localhost) ([10.249.42.57])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2020 09:48:55 -0700
Date:   Tue, 19 May 2020 19:48:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200519164853.GA19706@linux.intel.com>
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 01:03:25AM +0200, Thomas Gleixner wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
> > On Mon, 2020-05-18 at 08:34 -0700, Andi Kleen wrote:
> >> > Yes, for SGX this is functional feature because enclave entry points,
> >> > thread control structures (aka TCS's), reset FSBASE and GSBASE registers
> >> > to fixed (albeit user defined) values. And syscall's can be done only
> >> > outside of enclave.
> >> > 
> >> > This is a required feature for fancier runtimes (such as Graphene).
> >> 
> >> Can you please explain a bit more? What do they need GS for?
> >
> > Apparently, uses only wrfsbase:
> >
> > https://raw.githubusercontent.com/oscarlab/graphene/master/Pal/src/host/Linux-SGX/db_misc.c
> >
> > I'm not too familiar with the codebase yet but by reading some research
> > papers in the past the idea is to multiplex one TCS for multiple virtual
> > threads inside the enclave.
> >
> > E.g. TCS could represent a vcpu for a libos type of container and on
> > entry would pick on a thread and set fsbase accordingly for a thread
> > control block.
> 
> That justifies to write books which recommend to load a kernel module
> which creates a full unpriviledged root hole. I bet none of these papers
> ever mentioned that.

Fully agree that oot lkm for this is a worst idea ever.

That's why I want to help with this.

/Jarkko
