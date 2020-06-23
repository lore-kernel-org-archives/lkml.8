Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D920320702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946242;
	bh=li/oRgdLLDIhMxiF7/Lp7mtYZP2mwCtijwdf+7Qnn5g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=Vd5zo3u3EVZS8Waj0CnpPVJCdt2UmXI4+SQf0TZVEq1SPMeqWgZquapWpitSztm7V
	 lfdq6hD6BEQLeNNkIgac4Y4L0GJ7+u9LzWOyrsmCNDb9D5ktXswZmF3u7fpYXMk1jd
	 WX9OIvpxsPlI8BNc2aTndDjgbYCLCci1jFR+cnQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392413AbgFWVEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389281AbgFWVDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:03:51 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0EE20663;
        Tue, 23 Jun 2020 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592946230;
        bh=li/oRgdLLDIhMxiF7/Lp7mtYZP2mwCtijwdf+7Qnn5g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G2j4A721OYP7lRsAgAZ2dEgJm/gKD9ZGtJpxpdMzlIvttpwekkgi7e7mv1OzfobGr
         q9OOfDDkm+4g9P+COxHy3lBe85MF9zuVhLsInZfUjpCoE/hGclSsrQjO9WrOS837Do
         CUY8/Aa4RijfnDYj/Oxt9TOuL3afhElqSw5gXnhI=
Message-ID: <bdcdd6d10342005a8c773f4ffb882dabf398e5ac.camel@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Fix config dependency and trigger parser
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Jun 2020 16:03:48 -0500
In-Reply-To: <159262474473.185015.177609153974879988.stgit@devnote2>
References: <159262474473.185015.177609153974879988.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sat, 2020-06-20 at 12:45 +0900, Masami Hiramatsu wrote:
> Hi,
> 
> These are some fixes which I found recentry on ftrace.
> 
>  - Since the boot-time tracing synthetic event feature is decoupled
>    from trigger recenty, it should use CONFIG_SYNTH_EVENT.

Oops, yeah, I missed this one in the update, thanks for finding it.

>  - The parser of event trigger seems rejecting some redundant
>    spaces. But it is hard users to find the wrong point. Such
>    spaces should be accepted.
> 

Agreed, your patch makes things much better, thanks.

You can add my reviewed-by for both patches.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom

> BTW, I also found the trigger parser accepts some inputs which
> may not correctly formatted, e.g.
> 
>  # echo "traceon 1" > events/ftrace/print/trigger
> 
> (from the document, it must be "traceon:1")
> But I think this does not decrease the usability.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       tracing/boot: Fix config dependency for synthedic event
>       tracing: Fix event trigger to accept redundant spaces
> 
> 
>  kernel/trace/trace_boot.c           |    2 +-
>  kernel/trace/trace_events_trigger.c |   21 +++++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

