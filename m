Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A19C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCC220663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgFRMoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:44:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:37648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgFRMoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:44:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9F67AB3D;
        Thu, 18 Jun 2020 12:44:00 +0000 (UTC)
Date:   Thu, 18 Jun 2020 14:44:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 19/21] dyndbg: extend ddebug_parse_flags to accept
 optional leading filter-flags
Message-ID: <20200618124400.GA7536@alley>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
 <20200617162536.611386-22-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617162536.611386-22-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-17 10:25:34, Jim Cromie wrote:
> Change ddebug_parse_flags to accept optional filterflags before the
> required operator [-+=].  Read the flags into the filter_flags
> parameter added in the previous patch.  So this now supplies the
> filterflags to ddebug_exec_query.
> 
> filterflags work like query terms, they constrain what callsites get
> matched before theyre modified.  So like a query, they can be empty.
> 
> Filterflags let you read callsite's flagstate, including results of
> previous modifications, and require that certain flags are set, before
> modifying the callsite further.
> 
> So you can build up sets of callsites by marking them with a
> particular flagstate, for example 'fmlt', then enable that set in a
> batch.
> 
>   echo fmlt+p >control
> 
> Naturally you can use almost any combo of flags you want for marking,
> and can mark several different sets with different patterns.  And then
> you can activate them in a bunch:
> 
>   echo 'ft+p; mt+p; lt+p;' >control
> 
> + * Parse `str' as a flags-spec, ie: [pfmlt_]*[-+=][pfmlt_]+

This interface is simply _horrible_ and I do not see a point in this feature!!!

I as a normal dynamic debug user am interested into:

   + enabling/disabling messages from a given module/file/line/function
   + list of available modules/files/lines/functions
   + list of enabled modules/files/lines/functions

I do not understand why I would ever want to do something like:

   + enable messages that print module name and line number
   + disable message that does not print a module name

In fact, IMHO, all the 'flmt' flags were a wrong idea and nobody
really needed them. This information in not needed by other
printk() messages. Why pr_debug() would need them?
They just made the code and interface complicated.

Please, stop all this non-sense!!!

Best Regards,
Petr
