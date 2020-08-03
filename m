Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E07C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56C220775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgHCTul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:50:41 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:46920
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgHCTuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:50:40 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1k2gTm-0002C8-1v
        for linux-kernel@vger.kernel.org; Mon, 03 Aug 2020 21:50:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] gve: Fix the size used in a 'dma_free_coherent()' call
Date:   Mon, 3 Aug 2020 21:50:33 +0200
Message-ID: <639bc995-9d51-3cb7-a9d1-9979ecd9c912@wanadoo.fr>
References: <20200802141523.691565-1-christophe.jaillet@wanadoo.fr>
 <20200803084106.050eb7f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <3a25ddc6-adaa-d17d-50f4-8f8ab2ed25eb@wanadoo.fr>
 <69b4c4838cb743e24a79f81de487ac2e494843ef.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <69b4c4838cb743e24a79f81de487ac2e494843ef.camel@perches.com>
Content-Language: en-US
Cc:     netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200803195033.nkC41sFPqsBKP7yg0xWLEB4XwnQyHiXISlYcYBbEFaI@z>

Le 03/08/2020 à 21:35, Joe Perches a écrit :
> On Mon, 2020-08-03 at 21:19 +0200, Christophe JAILLET wrote:
>> Le 03/08/2020 à 17:41, Jakub Kicinski a écrit :
>>> On Sun,  2 Aug 2020 16:15:23 +0200 Christophe JAILLET wrote:
>>>> Update the size used in 'dma_free_coherent()' in order to match the one
>>>> used in the corresponding 'dma_alloc_coherent()'.
>>>>
>>>> Fixes: 893ce44df5 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>
>>> Fixes tag: Fixes: 893ce44df5 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
>>> Has these problem(s):
>>> 	- SHA1 should be at least 12 digits long
>>> 	  Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>>> 	  or later) just making sure it is not set (or set to "auto").
>>>
>>
>> Hi,
>>
>> I have git 2.25.1 and core.abbrev is already 12, both in my global
>> .gitconfig and in the specific .git/gitconfig of my repo.
>>
>> I would have expected checkpatch to catch this kind of small issue.
>> Unless I do something wrong, it doesn't.
>>
>> Joe, does it make sense to you and would one of the following patch help?
> 
> 18 months ago I sent:
> 
> https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/
> 
> 
> 

Looks like the same spirit.
I've not tested, but doesn't the:
    ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
at the top short cut the rest of the regex?

I read it as "the line should have something that looks like a commit id 
of 12+ char to process further".

So smaller commit id would not be checked.
Did I miss something?


Basically, my proposal is to replace this 12 by a 5 in order to accept 
smaller strings before checking if it looks well formatted or not.

CJ

