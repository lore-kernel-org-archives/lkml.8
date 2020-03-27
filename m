Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130F5C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43B120714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgC0UJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:09:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgC0UJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:09:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04FC9AE1A;
        Fri, 27 Mar 2020 20:09:40 +0000 (UTC)
Date:   Fri, 27 Mar 2020 13:09:34 -0700
From:   Tony Jones <tonyj@suse.de>
To:     Paul Clarke <pc@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
Message-ID: <20200327200934.GB2715@suse.de>
References: <20200325164053.10177-1-tonyj@suse.de>
 <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:32:26PM -0500, Paul Clarke wrote:
> > +		and 'lbr'.  The value 'dwarf' is effective only if libunwind
> > +		(or a recent version of libdw) is present on the system;
> > +		the value 'lbr' only works for certain cpus. The method for
> > +		kernel space is controlled not by this option but by the
> > +		kernel config (CONFIG_UNWINDER_*).
> 
> Your changes are just copying the old text, so this isn't a criticism of your patches.
> 
> Do we have information to replace "a recent version of libdw", which will quickly get stale?

Hi Paul.

The original "(libunwind or a recent version of libdw)" text was from Feb 2016.   So a while ago.

bd0419e2a5a9f requires >= 0.157 but this is for probing.  0a4f2b6a3ba50 specifies >= 0.158 but I see no mention of 
why in the commit but since it's from 2014 and elfutils is now at 0.178,  I think it's safe to just remove the 
reference.

As an aside, there is a lot of detail in perf-config.txt that's available in some of the other subcomands help files.
Seems a good way for things to get stale.   It could also do with some grammatical cleanup.

Tony
