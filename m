Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747F92078B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgE0Ibd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:31:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:64869 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgE0Ibd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:31:33 -0400
IronPort-SDR: 6Uwn63Q+F6VC27jI+cgsZwvhh8sL+raHdDWcxnBrw3sNwD52yoUWOg5gMIn8My9suQzQz3F46O
 Bsx/UrrgpkkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 01:31:32 -0700
IronPort-SDR: 9q7bc2meWnX5N+ybF+NHmK3eYUgfL4FBOl7EKJx1NEUxeJPKQZIJC9hCvXI5EI3ukRcTy3RVdA
 O4Ats3aINUEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="scan'208";a="284729574"
Received: from rharrie2-mobl.ger.corp.intel.com ([10.252.56.247])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2020 01:31:29 -0700
Message-ID: <331d5ea30b9d290aa451ec2e8389415823b909d8.camel@linux.intel.com>
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Don Porter <porter@cs.unc.edu>
Cc:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Date:   Wed, 27 May 2020 11:31:28 +0300
In-Reply-To: <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com>
References: <20200511045311.4785-1-sashal@kernel.org>
         <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
         <20200515164013.GF29995@sasha-vm>
         <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
         <20200518153407.GA499505@tassilo.jf.intel.com>
         <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
         <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
         <20200519164853.GA19706@linux.intel.com>
         <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
         <87h7w7qy18.fsf@nanos.tec.linutronix.de>
         <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-24 at 12:45 -0700, hpa@zytor.com wrote:
> On a related topic (needless to say, this should never have happened
> and is being raised at the highest levels inside Intel):
> 
> There are legitimate reasons to write a root-hole module, the main one
> being able to test security features like SMAP. I have requested
> before a TAINT flag specifically for this purpose, because
> TAINT_CRAP is nowhere near explicit enough, and is also used for
> staging drivers. Call it TAINT_TOXIC or TAINT_ROOTHOLE; it should
> always be accompanied with a CRIT level alert.

Are these flags easy to bump into in the first place for a person with
no prior familarity with the kernel?

/Jarkko

