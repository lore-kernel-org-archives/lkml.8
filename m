Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E27C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD9C2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590533484;
	bh=Iwnq+0PLVIW/wTxxSSJYZn9hBX0RhzrKVgiIaqvXdfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xMZpUvP9tXSEmJP076HEbpL5BTB1hGZl0Ph/bHSRLur5OBcw/+lUOYURMElsqsT9n
	 QGxJ7crdWe3zoQOYq2UfvKgQ4NyltePziH9e7TB0AftSY6p8rv5hCy2dE5JQRh+nBk
	 lp0u+dfYdXPRSCWoIjkCTxPwqkEEfPn/Gq0xMLZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404566AbgEZWvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404557AbgEZWvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:51:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8E82075F;
        Tue, 26 May 2020 22:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590533481;
        bh=Iwnq+0PLVIW/wTxxSSJYZn9hBX0RhzrKVgiIaqvXdfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kkne23X7TYidyChop6jl4HJ/ZaMCUsL0eWZd64FhOjF3Dq2q+3h6oo3uB+7cs7j0Z
         8/hZvshsLWwMkPOSG1RBW7cY3PIIVQtJXbcNnMtXXv9mSHznFUiBDL8FY7HelCQbId
         44b/CwtAsYtFyjiHBw2r+vFL68b+04mQQ2DLKslU=
Date:   Tue, 26 May 2020 18:51:20 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Don Porter <porter@cs.unc.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200526225120.GH33628@sasha-vm>
References: <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <20200526202739.GG33628@sasha-vm>
 <7a25e82a-9ef1-f13b-be42-2d7a693592b4@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a25e82a-9ef1-f13b-be42-2d7a693592b4@cs.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:03:35PM -0400, Don Porter wrote:
>On 5/26/20 4:27 PM, Sasha Levin wrote:
>>I'm really worried about the disconnect between how you view the current
>>state of Graphene (and the industry) vs Intel and the various cloud
>>providers.
>>
>>You keep suggesting that its just past the academic research state,
>>while Intel and the big cloud providers are already pushing it to
>>external customers.  Every one of those cloud providers has a preview/GA
>>secure enclave offering.
>>
>
>I wonder if you are conflating Graphene with SGX?  I understand that 
>many cloud vendors are offering SGX in preview/GA, but there are other 
>frameworks to build these offerings on, such as Intel's SGX SDK or 
>Haven.  It would be news to me if every major cloud vendor were 
>putting Graphene in production.

Sorry, I wasn't trying to suggest that all cloud vendors are pushing
Graphene, but rather than SGX enabled platforms became a commodity
product, users will end up using Graphene-like applications.

Let me provide an example:
https://www.alibabacloud.com/blog/protecting-go-language-applications-with-the-graphene-library-os-on-intel%C2%AE-sgx%C2%AE-secured-alibaba-cloud_594889
- a "practical" guide on how to run Graphene in production environment
   on one of the big cloud vendor platforms. 

-- 
Thanks,
Sasha
