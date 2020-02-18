Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC90BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB6320659
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgBRJwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:52:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:55132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgBRJwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:52:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20384B4F0;
        Tue, 18 Feb 2020 09:52:34 +0000 (UTC)
Date:   Tue, 18 Feb 2020 10:52:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] printk/console: Fix preferred console handling
Message-ID: <20200218095232.q6tqjmome4fhc6f5@pathway.suse.cz>
References: <20200213095133.23176-1-pmladek@suse.com>
 <20200217130308.GA447@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217130308.GA447@jagdpanzerIV.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-02-17 22:03:08, Sergey Senozhatsky wrote:
> On (20/02/13 10:51), Petr Mladek wrote:
> > Hi,
> > 
> > I send this on behalf of Benjamin who is traveling at the moment.
> > It is an interesting approach to long terms problems with matching
> > the console preferred on the command line.
> > 
> > Changes against v3:
> > 
> > 	+ better check when accepting pre-enabled consoles
> > 	+ correct reasoning in the 3rd patch
> > 	+ update a comment of CON_CONSDEV definition
> > 	+ fixed checkpatch warnings
> 
> Looks good to me,
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patchset is commited in printk.git, branch
for-5.7-preferred-console.

Best Regards,
Petr
