Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702942075D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597585846;
	bh=r5pCUfa+7GL4gvMpA6LRaUpmJ+k+6F3pLpgO3AsGBSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H5AWXM7VeG5KFeiLKxrGXBH+mAGHGs+1si+LgZTiCvDNUA75MuablKRTpfHKOa4u4
	 lNQojgKw2hduoV6oyPZ5cqEsZoOrBFq9mx0+xK1X9SJJuJnlhQ3Ly8wy7BlarulQWA
	 7oyoIPVafrrRn7FaET6b8LR+9yHNZuiN6YU4CNgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgHPNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 09:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgHPNuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 09:50:44 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F4620708;
        Sun, 16 Aug 2020 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597585843;
        bh=r5pCUfa+7GL4gvMpA6LRaUpmJ+k+6F3pLpgO3AsGBSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcIXJ1m/11WVz17PkicGhPZwiDKLAHg/eDa+E8BGdOl1IBp5Be/eQDep5QcmIesQK
         D1mNV2pP53kE2UTreAa3r9JB0NoUqwQ5Z94svNW9L6y3YpdfsQksmCkiIez4fNWBN3
         CdMRfV8AEpBpgSPbYWpmN5Pw9Aqb3wLVzATjvJEk=
Date:   Sun, 16 Aug 2020 09:50:42 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Martin Wilck <mwilck@suse.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.8 70/72] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
Message-ID: <20200816135042.GU2975990@sasha-vm>
References: <20200808233542.3617339-1-sashal@kernel.org>
 <20200808233542.3617339-70-sashal@kernel.org>
 <1899fe01e1eb5c23270541e1833b12365818c150.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1899fe01e1eb5c23270541e1833b12365818c150.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 05:37:54PM +0200, Martin Wilck wrote:
>On Sat, 2020-08-08 at 19:35 -0400, Sasha Levin wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> [ Upstream commit fbd6a42d8932e172921c7de10468a2e12c34846b ]
>>
>> When nvme_round_robin_path() finds a valid namespace we should be
>> using it;
>> falling back to __nvme_find_path() for non-optimized paths will cause
>> the
>> result from nvme_round_robin_path() to be ignored for non-optimized
>> paths.
>>
>> Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
>> Signed-off-by: Martin Wilck <mwilck@suse.com>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/nvme/host/multipath.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>
>Hello Sasha,
>
>this patch needs a fix that I recently submitted to linux-nvme.
>The same holds for the respective 5.7 and 5.4 AUTOSEL patches.
>
>http://lists.infradead.org/pipermail/linux-nvme/2020-August/018570.html

I'll grab it too, thanks!

-- 
Thanks,
Sasha
