Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8B9C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284AA2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgD2JmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:42:05 -0400
Received: from verein.lst.de ([213.95.11.211]:33583 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgD2JmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:42:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8CE8668BFE; Wed, 29 Apr 2020 11:42:01 +0200 (CEST)
Date:   Wed, 29 Apr 2020 11:42:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fixup! signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-ID: <20200429094201.GA2557@lst.de>
References: <20200428074827.GA19846@lst.de> <20200428195645.1365019-1-arnd@arndb.de> <20200429064458.GA31717@lst.de> <CAK8P3a1YD3RitSLLRsM+e+LwAxg+NS6F071B4zokwEpiL0WvrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1YD3RitSLLRsM+e+LwAxg+NS6F071B4zokwEpiL0WvrA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:07:11AM +0200, Arnd Bergmann wrote:
> > What do you think of this version?  This one always overrides
> > copy_siginfo_to_user32 for the x86 compat case to keep the churn down,
> > and improves the copy_siginfo_to_external32 documentation a bit.
> 
> Looks good to me. I preferred checking for X32 explicitly (so we can
> find and kill off the #ifdef if we ever remove X32 for good), but there is
> little difference in the end.

Is there any realistic chance we'll get rid of x32?
