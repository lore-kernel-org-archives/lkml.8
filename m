Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED17C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31F720671
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgEPJu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:50:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:40822 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgEPJu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:50:28 -0400
IronPort-SDR: PjK0q3DxK+GGLWu8B8VgIkCXE0rR1I5j4nZQZGm6A06TQbZtZECZAW5GM/tHlqT2XM6Tjv9jvX
 2n9XH763V8Xw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 02:50:28 -0700
IronPort-SDR: nFTCwLlqppcjqjYKmCkoUbTQMVYzvh3UjWauQmjHwpbpZsO1LcKcZb4JuxiXZLpsGVoJeFSqnw
 QE6TDmnDKmMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="252604869"
Received: from dbobocel-mobl1.ger.corp.intel.com ([10.252.55.115])
  by fmsmga007.fm.intel.com with ESMTP; 16 May 2020 02:50:23 -0700
Message-ID: <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
        tony.luck@intel.com, ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Date:   Sat, 16 May 2020 12:50:23 +0300
In-Reply-To: <20200515164013.GF29995@sasha-vm>
References: <20200511045311.4785-1-sashal@kernel.org>
         <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
         <20200515164013.GF29995@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-15 at 12:40 -0400, Sasha Levin wrote:
> > Can you put me to the CC-loop for this patches. Some SGX-enabled
> 
> Sure!
> 
> > frameworks such as Graphene use out-of-tree changes to achieve this.
> > That's where the interest to possibly test this comes from.
> 
> Indeed, we've seen a few hacks that basically just enable FSGSBASE:
> 
>  - https://github.com/oscarlab/graphene-sgx-driver
>  - https://github.com/occlum/enable_rdfsbase
> 
> And would very much like to get rid of them...

Yes, for SGX this is functional feature because enclave entry points,
thread control structures (aka TCS's), reset FSBASE and GSBASE registers
to fixed (albeit user defined) values. And syscall's can be done only
outside of enclave.

This is a required feature for fancier runtimes (such as Graphene).

I'll try the next version by patching Graphene to use this instead of the
out-of-tree drive. That should give at least fairly realistic
workload (an arbitrary dynamically linked executable running inside an
enclave) for this patch set.

/Jarkko

