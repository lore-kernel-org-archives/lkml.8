Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B848C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180E12074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595881024;
	bh=kXZt7HjcimyQ7gHCIkCfWCPAkxIMuHkU2XCAZ2NKJcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QxeTxtzRnkOgDSSvQzZGDEMFWRGnwcB6GfIHJOoEFiY7aaftJgTKflS69BEh3RJJx
	 mpQVqbvIpP8DVKHOnlazTHC6/yFDEUqY7s0nHj+JWY86lixigoi6dmdk89WuMvogcl
	 XT5rak3wkvwuCyVsYNg9j8LUZjM7JVIwxVKVMGZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgG0URC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgG0URC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:17:02 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FDE20729;
        Mon, 27 Jul 2020 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595881022;
        bh=kXZt7HjcimyQ7gHCIkCfWCPAkxIMuHkU2XCAZ2NKJcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCMOeV24Ye5OcFTXhAdspm5djI90/dDVIJfsZkpHlrzKn01mbF7gO977CHwp0jTOo
         PzmQ6KUn8XMMPyolAqTEyE74cB4jYelAzXJbdi3PlP2VBS2Qscc2+3u+3LyhrMRwnF
         xpAwUL41PrMpSMmGtocMFVvs/Fr5CqNLLfNbIPZg=
Date:   Mon, 27 Jul 2020 16:17:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     John Donnelly <john.p.donnelly@oracle.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (resend) [PATCH [linux-4.14.y]] dm cache: submit writethrough
 writes in parallel to origin and cache
Message-ID: <20200727201700.GJ406581@sasha-vm>
References: <37c5a615-655d-c106-afd0-54e03f3c0eef@oracle.com>
 <20200727150014.GA27472@redhat.com>
 <20200727191809.GI406581@sasha-vm>
 <D8DDA535-33D5-4E80-85B3-62A463441B5F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <D8DDA535-33D5-4E80-85B3-62A463441B5F@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 02:38:52PM -0500, John Donnelly wrote:
>
>
>> On Jul 27, 2020, at 2:18 PM, Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Mon, Jul 27, 2020 at 11:00:14AM -0400, Mike Snitzer wrote:
>>> This mail needs to be saent to stable@vger.kernel.org (now cc'd).
>>>
>>> Greg et al: please backport 2df3bae9a6543e90042291707b8db0cbfbae9ee9
>>
>> Hm, what's the issue that this patch addresses? It's not clear from the
>> commit message.
>>
>> --
>> Thanks,
>> Sasha
>
>HI Sasha ,
>
>In an off-line conversation I had with Mike , he indicated that :
>
>
>commit 1b17159e52bb31f982f82a6278acd7fab1d3f67b
>Author: Mike Snitzer <snitzer@redhat.com>
>Date:   Fri Feb 28 18:00:53 2020 -0500
>
>   dm bio record: save/restore bi_end_io and bi_integrity
>
>
>commit 248aa2645aa7fc9175d1107c2593cc90d4af5a4e
>Author: Mike Snitzer <snitzer@redhat.com>
>Date:   Fri Feb 28 18:11:53 2020 -0500
>
>   dm integrity: use dm_bio_record and dm_bio_restore
>
>
>Were picked up  in  "stable" kernels picked up even though
>neither was marked for stable@vger.kernel.org
>
>Adding this missing  commit :
>
> 2df3bae9a6543e90042291707b8db0cbfbae9ee9
>
>
>Completes the series

Should we just revert those two commits instead if they're not needed?

-- 
Thanks,
Sasha
