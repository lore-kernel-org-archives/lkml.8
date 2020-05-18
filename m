Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F19C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BFF206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgERUBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:01:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:9690 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgERUBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:01:18 -0400
IronPort-SDR: dRsUXzK0oTH5Ju1HZCDl76t9qTlbfY3ZGox7G5hlx5L68PJrzjiejdnItnVm1+sd/kj8KJbg41
 o1yi9gkDhTpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 13:01:18 -0700
IronPort-SDR: 3qfK7AynXe71zqJ5Bvdl7NRf5LA+A3fwZINumvmqUc80o4Kmt1AbGwzME3vhvh+M/rbouZPkaX
 sO/Y6TuT18uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="267637992"
Received: from afloress-mobl2.amr.corp.intel.com ([10.252.56.85])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2020 13:01:12 -0700
Message-ID: <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Date:   Mon, 18 May 2020 23:01:11 +0300
In-Reply-To: <20200518153407.GA499505@tassilo.jf.intel.com>
References: <20200511045311.4785-1-sashal@kernel.org>
         <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
         <20200515164013.GF29995@sasha-vm>
         <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
         <20200518153407.GA499505@tassilo.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 08:34 -0700, Andi Kleen wrote:
> > Yes, for SGX this is functional feature because enclave entry points,
> > thread control structures (aka TCS's), reset FSBASE and GSBASE registers
> > to fixed (albeit user defined) values. And syscall's can be done only
> > outside of enclave.
> > 
> > This is a required feature for fancier runtimes (such as Graphene).
> 
> Can you please explain a bit more? What do they need GS for?

Apparently, uses only wrfsbase:

https://raw.githubusercontent.com/oscarlab/graphene/master/Pal/src/host/Linux-SGX/db_misc.c

I'm not too familiar with the codebase yet but by reading some research
papers in the past the idea is to multiplex one TCS for multiple virtual
threads inside the enclave.

E.g. TCS could represent a vcpu for a libos type of container and on
entry would pick on a thread and set fsbase accordingly for a thread
control block.

/Jarkko

