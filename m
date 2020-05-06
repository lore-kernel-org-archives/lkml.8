Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05185C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D911221655
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgEFP02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:28 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:37094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729936AbgEFP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 17CEDFB47;
        Wed,  6 May 2020 15:26:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soda31_704d25b6cc816
X-Filterd-Recvd-Size: 2183
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 May 2020 15:26:11 +0000 (UTC)
Message-ID: <dfe10cb0359c37dff46c93dfacf909dd33b2593f.camel@perches.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 06 May 2020 08:26:10 -0700
In-Reply-To: <344199f1-639b-ee93-2388-57b0549641f9@i-love.sakura.ne.jp>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <20200425004609.GE8982@jagdpanzerIV.localdomain>
         <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
         <20200427062117.GC486@jagdpanzerIV.localdomain>
         <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
         <344199f1-639b-ee93-2388-57b0549641f9@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-06 at 18:45 +0900, Tetsuo Handa wrote:
> On 2020/04/28 20:33, Tetsuo Handa wrote:
> > On 2020/04/27 15:21, Sergey Senozhatsky wrote:
> > > > KERN_NO_CONSOLES is for type of messages where "saved for later analysis" is
> > > > important but "printed for immediate notification" is not important.
> > > > In other words, KERN_NO_CONSOLES is NOT for dying messages where "printed for
> > > > immediate notification" is important.
> > > 
> > > per-console loglevel is a user configurable parameter.
> > > KERN_NO_CONSOLES is a hard-coded policy.
> > 
> > But given that whether to use KERN_NO_CONSOLES is configurable via e.g. sysctl,
> > KERN_NO_CONSOLES will become a user configurable parameter. What's still wrong?
> > 
> 
> Any problems remaining?

printk_get_level / printk_skip_level and the various
uses of %pV using printk_get_level

