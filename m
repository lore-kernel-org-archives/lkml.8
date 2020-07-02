Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5874FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D5F20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593673913;
	bh=fwq9ylvBh1yhPlknV9c24gSifSuNjfcp+A30FuXkf3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X3eF6BUfcwIJqbmN16GJ3OQKYHUbpEebHL+qvx+M3PMWKuugTMyymy50mRf6j9Oj8
	 PJ+Uuyzb5zHONqtAlNqBLrEkz8Qs3g6nwkLLN57uUGZR0wsgizq/DMdSKICou/Lm8/
	 W4v7MPCGDxX8FN1JWUQef/rtyxxKF1Rqr0iEEq5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgGBHLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgGBHLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:11:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0188A20874;
        Thu,  2 Jul 2020 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593673910;
        bh=fwq9ylvBh1yhPlknV9c24gSifSuNjfcp+A30FuXkf3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQurYMj5cFhw7Q5bIUWfXhNnVLJphL/hhWFXCwI4ThLtHm8D/oHDWohNXQ26bF1js
         dETRErWpp7PEzFCACmq3LD0/FczZ7NtxPJNQq0P8KUDDD378xLIY6Es/JLdoIaZX/p
         1BiGjiLX2Y1c595dY08OdrPNKE+Q6gOyF7cfMa9E=
Date:   Thu, 2 Jul 2020 09:11:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200702071154.GA961982@kroah.com>
References: <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <3b665cbd-7afb-b72d-22c0-7dc1543ac42e@amd.com>
 <BY5PR12MB37780DF07B437B9FFD1BB344F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
 <20200702061136.GA679876@kroah.com>
 <BY5PR12MB37789152C6311FDE04759806F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB37789152C6311FDE04759806F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Jul 02, 2020 at 06:14:05AM +0000, S, Shirish wrote:
> This one:
> https://lkml.org/lkml/2020/6/30/394

Please use lore.kernel.org for links, lkml.org is known for having
reliability issues and is not under our control.

> I did reply to all, not sure what I am missing while replying.

Proper email quoting?

thanks,

greg k-h
