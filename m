Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778D22084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593776403;
	bh=j9mk/zoE6UAYWQVw6K+UZFeokVdeFIAtsouE3NU5+I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=id1RnYer+Lrdqu68XRMnNEZRF39Am57mRVFPIMiEow1LDAfSsPJOqa3JiCS4W6gRB
	 yf2sXncCJWkKdE/jGm9bdL3L8hePwJkRy94g/gqwtk6sqT6jKn1e0nBQMdKK6Zl4AS
	 QeCB98rdgJhAkfG472sywHIj9ERNHa813Q/LQNmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGCLkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGCLkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:40:02 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECE420772;
        Fri,  3 Jul 2020 11:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593776401;
        bh=j9mk/zoE6UAYWQVw6K+UZFeokVdeFIAtsouE3NU5+I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngZqbyRcGttY2/0Iru9ipEL+a2cl0bzK5HnkxkGDVJwf54PXu89DJ/hAvRLTQBCtA
         WGYq0ct4mAMiRYQZPdgiRagjOgwglmr2dCfMGQSFTqOfIJSTwBOT4vraEABxOezMDc
         ESUtFe8drgUulk7elcY/CEzCrCYZyMB+AVakfmlA=
Date:   Fri, 3 Jul 2020 07:40:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4.19 119/131] tracing: Fix event trigger to accept
 redundant spaces
Message-ID: <20200703114000.GG2722994@sasha-vm>
References: <20200629153502.2494656-1-sashal@kernel.org>
 <20200629153502.2494656-120-sashal@kernel.org>
 <20200702211728.GD5787@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200702211728.GD5787@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:17:28PM +0200, Pavel Machek wrote:
>Hi!
>
>> commit 6784beada631800f2c5afd567e5628c843362cee upstream.
>>
>> Fix the event trigger to accept redundant spaces in
>> the trigger input.
>>
>> For example, these return -EINVAL
>>
>> echo " traceon" > events/ftrace/print/trigger
>> echo "traceon  if common_pid == 0" > events/ftrace/print/trigger
>> echo "disable_event:kmem:kmalloc " > events/ftrace/print/trigger
>>
>> But these are hard to find what is wrong.
>>
>> To fix this issue, use skip_spaces() to remove spaces
>> in front of actual tokens, and set NULL if there is no
>> token.
>
>For the record, I'm not fan of this one. It is ABI change, not a
>bugfix.
>
>Yes, it makes kernel interface "easier to use". It also changes
>interface in the middle of stable series, and if people start relying
>on new interface and start putting extra spaces, they'll get nasty
>surprise when they move code to the older kernel.

We promise users that they can upgrade their kernels and we won't be
breaking any of their usecases no matter what. However, if they choose
to downgrade their kernels then all bets are off.

-- 
Thanks,
Sasha
