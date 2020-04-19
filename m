Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD41C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CD92145D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgDSIT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 04:19:29 -0400
Received: from verein.lst.de ([213.95.11.211]:35777 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgDSIT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:19:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5319B68BEB; Sun, 19 Apr 2020 10:19:26 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:19:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove set_fs calls from the exec and coredump code v2
Message-ID: <20200419081926.GA12539@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <87r1wl68gf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1wl68gf.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:41:52PM -0500, Eric W. Biederman wrote:
> > this series gets rid of playing with the address limit in the exec and
> > coredump code.  Most of this was fairly trivial, the biggest changes are
> > those to the spufs coredump code.
> >
> > Changes since v1:
> >  - properly spell NUL
> >  - properly handle the compat siginfo case in ELF coredumps
> 
> Quick question is exec from a kernel thread within the scope of what you
> are looking at?
> 
> There is a set_fs(USER_DS) in flush_old_exec whose sole purpose appears
> to be to allow exec from kernel threads.  Where the kernel threads
> run with set_fs(KERNEL_DS) until they call exec.

This series doesn't really look at that area.  But I don't think exec
from a kernel thread makes any sense, and cleaning up how to set the
initial USER_DS vs KERNEL_DS state is something I'll eventually get to,
it seems like a major mess at the moment.
