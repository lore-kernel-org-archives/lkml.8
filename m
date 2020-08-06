Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C12C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55F22250E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596676755;
	bh=Q/nPyKFSTqrQ9nnopbWeCBGkmI0RyCRsimXLL0tW1mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1tju1D0Ws4YvYmxVjkx8XhCYLLHrBlLV1ewJU+VASdyG2l5lSRBbkgUgeVezO2dCq
	 2HE1OsjZbv4RsidnmzoJ2sugfusfLJxBNQDxYDxc+6zW0YFKBeDOeUvP9EMAFE9lT3
	 TDe2ChkZhEBTK4K+S7CDK3HFgs9zsu2fI6Anuf6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHFBTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgHFBTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:19:11 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD122245C;
        Thu,  6 Aug 2020 01:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596676750;
        bh=Q/nPyKFSTqrQ9nnopbWeCBGkmI0RyCRsimXLL0tW1mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=flZLcQ99Aj0xc2tl730AsZpuY1WF9t17S0WzyagItJtUU84hOLJCMBchIAdyVc2DD
         njfdx7bD4WYGC3CluvgMO1qkoAzYoQ/ngT3qmq+bC8doBFeKRuAbBqJG5K1oQYCunW
         iBnpbpOKAt7IzU5GIeCAbd6UA8xahL0n2dSWKrA8=
Date:   Wed, 5 Aug 2020 21:19:09 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     stable@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanglong19@meituan.com, heguanjun@meituan.com,
        Jiang Ying <jiangying8582@126.com>
Subject: Re: [PATCH v4] ext4: fix direct I/O read error
Message-ID: <20200806011909.GD2975990@sasha-vm>
References: <1596614241-178185-1-git-send-email-jiangying8582@126.com>
 <20200805085107.GC4117@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200805085107.GC4117@quack2.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:51:07AM +0200, Jan Kara wrote:
>Note to stable tree maintainers (summary from the rather long changelog):
>This is a non-upstream patch. It will not go upstream because the problem
>there has been fixed by converting ext4 to use iomap infrastructure.
>However that change is out of scope for stable kernels and this is a
>minimal fix for the problem that has hit real-world applications so I think
>it would be worth it to include the fix in stable trees. Thanks.

How far back should it go? It breaks the build on 4.9 and 4.4 but the
fix for the breakage is trivial.

It does however suggest that this fix wasn't tested on 4.9 or 4.4, so
I'd like to clarify it here before fixing it up (or dropping it).

-- 
Thanks,
Sasha
