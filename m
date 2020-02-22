Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F30C35673
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E80214DB
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582397864;
	bh=mC0oXdHLRn4JZ38YS63IufJ4vPZBjzIX8GqLZZsP5GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AZY16OnVaFpKxo909W2D5bHfMt15K75IxMIvo6tMWKe441a2h3qFMsazXXj7q2ppv
	 H4BeQ7kkMi0vzWgHRKw4+tBrsXxVi1FpicBPMrAplWqXxJyQBi5Tsz48KnyLGOZckW
	 hFTQk/2hv1uLd9TeEbAnUE0pvy10mdE4Aijrs6bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBVS5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVS5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:57:43 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C55C206EF;
        Sat, 22 Feb 2020 18:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582397862;
        bh=mC0oXdHLRn4JZ38YS63IufJ4vPZBjzIX8GqLZZsP5GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2S8jXIbKNj9oQS+9rPPq028+mxkcME+XhNTuiDsvIw7rKhdp6zJ4joflVrYGuOSRc
         yW23vvy4cZfmierN/FzgFSUDj/1lDfmw3jWh8UGQ7HRlqgJdmEtsfjdqzE5H1sw0jH
         Gzi7vAjfoqIGP6RQ/HZlFtPR78kYOB8Y1vW/Ynak=
Date:   Sat, 22 Feb 2020 13:57:41 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 5.5 293/399] ACPI/IORT: Fix Number of IDs handling in
 iort_id_map()
Message-ID: <20200222185741.GB26320@sasha-vm>
References: <20200221072402.315346745@linuxfoundation.org>
 <20200221072430.253096930@linuxfoundation.org>
 <20200221095019.GA29220@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200221095019.GA29220@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:50:19AM +0000, Lorenzo Pieralisi wrote:
>On Fri, Feb 21, 2020 at 08:40:18AM +0100, Greg Kroah-Hartman wrote:
>> From: Hanjun Guo <guohanjun@huawei.com>
>>
>> [ Upstream commit 3c23b83a88d00383e1d498cfa515249aa2fe0238 ]
>
>Hi Greg,
>
>this patch should not be applied to stable kernels, not yet at
>least, please drop it.

I've dropped it, thank you.

-- 
Thanks,
Sasha
