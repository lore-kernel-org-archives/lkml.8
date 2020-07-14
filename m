Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A137C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F88722453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgGNMgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgGNMgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:36:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13E47AD3A;
        Tue, 14 Jul 2020 12:36:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 49B501E12C9; Tue, 14 Jul 2020 14:36:15 +0200 (CEST)
Date:   Tue, 14 Jul 2020 14:36:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, jack@suse.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: DISKQUOTA
Message-ID: <20200714123615.GH23073@quack2.suse.cz>
References: <20200708171905.15396-1-grandmaster@al2klimov.de>
 <20200713113044.3af1002c@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713113044.3af1002c@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-07-20 11:30:44, Jonathan Corbet wrote:
> On Wed,  8 Jul 2020 19:19:05 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
> >  The interface uses generic netlink framework (see
> > -http://lwn.net/Articles/208755/ and http://people.suug.ch/~tgr/libnl/ for more
> > +https://lwn.net/Articles/208755/ and http://people.suug.ch/~tgr/libnl/ for more
> 
> That other link is 404, no reason to keep it around...

I've already queued a patch that replaces the second link with a working
one...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
