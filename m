Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40ED2078B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590355189;
	bh=WE2kW/Hh64n5TAy/jvjJY9wl3IFEMH5x7/Au5mTP5Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lmfXNjqifgewZPUWSGV7gSbpmYtJGDLZCQetjMuTjyH7N1LR+v1UH0iYiRTeAiPGI
	 e0/YQw8OBwtKapHVFG7E/hPILhmoSJNr6DvCt3GNPAmMiOxTpuSr4DqWRvRXFfeWH+
	 1gfif2VxcpqTM4tHtp2hGBOJE3tbTqFZYumYjUPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbgEXVTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387830AbgEXVTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:19:47 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A092076C;
        Sun, 24 May 2020 21:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590355187;
        bh=WE2kW/Hh64n5TAy/jvjJY9wl3IFEMH5x7/Au5mTP5Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwCim7mYUE563gvdWuF9JmGSjn4pW3SdxT5xYfrksFP0BNINc+jhilYZ57uas3Aoz
         ZQATiM3oS/Q/bC9v+eqbrk6F+hjuJPvAJ6iIfTOQpMxCjxLoSSL9qAxsxFjWf5jwtY
         jlj97QHR1BgZXDZgXeQHJzsVt+P5DVSqsjVk49J8=
Date:   Sun, 24 May 2020 17:19:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     hpa@zytor.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, dave.hansen@intel.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200524211945.GX33628@sasha-vm>
References: <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 12:45:18PM -0700, hpa@zytor.com wrote:
>There are legitimate reasons to write a root-hole module, the main one being able to test security features like SMAP. I have requested before a TAINT flag specifically for this purpose, because TAINT_CRAP is nowhere near explicit enough, and is also used for staging drivers. Call it TAINT_TOXIC or TAINT_ROOTHOLE; it should always be accompanied with a CRIT level alert.

What I don't like about our current system of TAINT_* flags is that
while we can improve it as much as we want, no one outside of the kernel
tree seems to be using it. While Thomas may have been commenting on
Graphene's behaviour, look at any other code that did the same thing:

- Graphene: https://github.com/oscarlab/graphene-sgx-driver/blob/master/gsgx.c
- Occlum: https://github.com/occlum/enable_rdfsbase/blob/master/enable_rdfsbase.c
- SGX-LKL: https://github.com/lsds/sgx-lkl/blob/master/tools/kmod-set-fsgsbase/mod_set_cr4_fsgsbase.c

None of which set even the CRAP flag.

-- 
Thanks,
Sasha
