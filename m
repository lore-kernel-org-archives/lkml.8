Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D70AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785FC246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582913121;
	bh=z4ICRfhyOxiRQX3i97/zE8kLkSh+ENDPFY6BQJNtGjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lbT9CwCyYnN6Ttc+/L3xGwfcIxYMdA5XhSowc2RXKoKkKtEEwi7FmxTiXwM8koynk
	 i/Qle79usxuYGWljutbvGnzwDm3e5wadoVhrxKmoC2s0tG+GHXI7XvgpccH/m7oPX5
	 IjntffHRlMCa7YzL0HAGtt4pGTNiIZk+QV9lQqyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgB1SFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgB1SFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:05:20 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46B88246AC;
        Fri, 28 Feb 2020 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582913119;
        bh=z4ICRfhyOxiRQX3i97/zE8kLkSh+ENDPFY6BQJNtGjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQc71ieby3SbISld+4GPOZvV7VLQ4TaHeVnnd81/DwSqbVd3rV6M35QxfbJRzAUGQ
         MouGViQ137aYuVtjnS4MpY67R0umTHFNd04vC2SYa4G5zpPpj+inLNaEFELgDAfkMZ
         WffjGay52oi+5sKJ+6P/bg7wOXcffmyoFhSqY+XY=
Date:   Fri, 28 Feb 2020 13:05:18 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4.19 60/97] lib/stackdepot: Fix outdated comments
Message-ID: <20200228180518.GA21491@sasha-vm>
References: <20200227132214.553656188@linuxfoundation.org>
 <20200227132224.337663006@linuxfoundation.org>
 <20200228130532.GA2979@duo.ucw.cz>
 <20200228132455.GA3021902@kroah.com>
 <20200228133036.GB3021902@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200228133036.GB3021902@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:30:36PM +0100, Greg Kroah-Hartman wrote:
>On Fri, Feb 28, 2020 at 02:24:55PM +0100, Greg Kroah-Hartman wrote:
>> On Fri, Feb 28, 2020 at 02:05:33PM +0100, Pavel Machek wrote:
>> > Hi!
>> >
>> > > [ Upstream commit ee050dc83bc326ad5ef8ee93bca344819371e7a5 ]
>> > >
>> > > Replace "depot_save_stack" with "stack_depot_save" in code comments because
>> > > depot_save_stack() was replaced in commit c0cfc337264c ("lib/stackdepot:
>> > > Provide functions which operate on plain storage arrays") and removed in
>> > > commit 56d8f079c51a ("lib/stackdepot: Remove obsolete functions")
>> >
>> > This is wrong.
>> >
>> > > +++ b/lib/stackdepot.c
>> > > @@ -96,7 +96,7 @@ static bool init_stack_slab(void **prealloc)
>> > >  		stack_slabs[depot_index + 1] = *prealloc;
>> > >  		/*
>> > >  		 * This smp_store_release pairs with smp_load_acquire() from
>> > > -		 * |next_slab_inited| above and in depot_save_stack().
>> > > +		 * |next_slab_inited| above and in stack_depot_save().
>> > >  		 */
>> > >  		smp_store_release(&next_slab_inited, 1);
>> > >  	}
>> >
>> > May have been outdated for mainline, but they are actually okay for
>> > 4.19.
>>
>> Good catch, I'll go drop this from the stable queues (4.14, 4.9, and 4.19).
>
>Ah, nope, this patch is needed for the "real" patch here, 305e519ce48e
>("lib/stackdepot.c: fix global out-of-bounds in stack_slabs")
>
>Hm, it's not that big of a deal, I'll go fix that up by hand...
>
>But that explains why it is included here.

I replied on the "FAILED:" email explaining why I took it even though
it's wrong:

Technically the comment change is wrong as the commit it addresses is
older, but no one should be coding against the stable tree, and doing it
by changing 305e519ce48e would cause merge conflicts in the future.

-- 
Thanks,
Sasha
