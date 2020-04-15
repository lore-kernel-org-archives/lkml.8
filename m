Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48CCC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B8A20771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635299AbgDOHqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:46:14 -0400
Received: from verein.lst.de ([213.95.11.211]:43853 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635276AbgDOHpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:45:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95C4B68BFE; Wed, 15 Apr 2020 09:45:14 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:45:14 +0200
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
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
Message-ID: <20200415074514.GA1393@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-5-hch@lst.de> <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 03:15:09PM +0200, Arnd Bergmann wrote:
> I don't think you are changing the behavior here, but I still wonder if it
> is in fact correct for x32: is in_x32_syscall() true here when dumping an
> x32 compat elf process, or should this rather be set according to which
> binfmt_elf copy is being used?

The infrastructure cold enable that, although it would require more
arch hooks I think.  I'd rather keep it out of this series and to
an interested party.  Then again x32 doesn't seem to have a whole lot
of interested parties..
