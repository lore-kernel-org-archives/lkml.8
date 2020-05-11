Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF5C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8E92082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589172435;
	bh=/Mlb2q0Tz785tx5Tpwi6DAkt1Dqh6dX+9WwYZ3hNezc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pd2hG7rB7PtPK5N2jGyreXzWtF+r8r8l7KexGqgSFamrPRI0cLes6w2Ax54Qnda1n
	 zBNEOMNKBrxO+PTJYFCw5MmueiYnmMbNJI6NQ7FcD1l/lrLHrBSg9fF4eePdupzctl
	 ijT6Ev7hmNCVhIO7ShuxRKdoGz30qyL46aLg0OFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgEKErN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbgEKErL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:47:11 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E14620820;
        Mon, 11 May 2020 04:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172431;
        bh=/Mlb2q0Tz785tx5Tpwi6DAkt1Dqh6dX+9WwYZ3hNezc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmrA7QpJS/snXofFBGccySF0Qruca5pxPZZ6DA5HnT7SBa79xDYBn0RyRPm2YuY2z
         OX9paK7yrAiHrayCJXDegy2bP9/PzbBqXDAUjBGt2z+9AaPO63hTesEjX85oaKid4C
         DVVGAOUFBmKYOZFegUh0xp5rQxdtIpvA4udAu4gs=
Date:   Mon, 11 May 2020 00:47:09 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v11 00/18] Enable FSGSBASE instructions
Message-ID: <20200511044709.GN13035@sasha-vm>
References: <20200509173655.13977-1-sashal@kernel.org>
 <c4f62190-260a-c6e3-f1f6-6498660a7d1f@intel.com>
 <20200510141625.GL13035@sasha-vm>
 <20200511005319.GK3538@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200511005319.GK3538@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 05:53:19PM -0700, Andi Kleen wrote:
>> My interest in this is that we have a few workloads that value the
>> ability to access FS/GS base directly and show nice performance
>
>Can you please share some rough numbers, Sasha?

I don't have any recent numbers around these - this series effectively
enables certain workloads rather than just improve the performance
somewhat so benchmarking for exact numbers isn't too interesting here.

>I would expect everything that does a lot of context switches
>to benefit automatically, apart from the new free register (which
>requires enabling, but also has great potential)

And even more so when these registers are actually being used for the
purpose they were designed for (this is in the context of secure
computing/enclaves/etc).

-- 
Thanks,
Sasha
