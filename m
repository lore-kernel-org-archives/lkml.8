Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E0C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988B324670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBTBqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:46:15 -0500
Received: from kernel.crashing.org ([76.164.61.194]:32974 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgBTBqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:46:15 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01K1j37O028226
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Feb 2020 19:45:07 -0600
Message-ID: <b3e13274d2d55fe83908b2f28d7f734a8ea5f48a.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 0/3] printk/console: Fix preferred console handling
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Feb 2020 12:44:59 +1100
In-Reply-To: <20200218095232.q6tqjmome4fhc6f5@pathway.suse.cz>
References: <20200213095133.23176-1-pmladek@suse.com>
         <20200217130308.GA447@jagdpanzerIV.localdomain>
         <20200218095232.q6tqjmome4fhc6f5@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 10:52 +0100, Petr Mladek wrote:
> On Mon 2020-02-17 22:03:08, Sergey Senozhatsky wrote:
> > On (20/02/13 10:51), Petr Mladek wrote:
> > > Hi,
> > > 
> > > I send this on behalf of Benjamin who is traveling at the moment.
> > > It is an interesting approach to long terms problems with
> > > matching
> > > the console preferred on the command line.
> > > 
> > > Changes against v3:
> > > 
> > > 	+ better check when accepting pre-enabled consoles
> > > 	+ correct reasoning in the 3rd patch
> > > 	+ update a comment of CON_CONSDEV definition
> > > 	+ fixed checkpatch warnings
> > 
> > Looks good to me,
> > 
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> The patchset is commited in printk.git, branch
> for-5.7-preferred-console.

Thanks a lot guys ! (I'm back now btw :-)

Cheers,
Ben.


