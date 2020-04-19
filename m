Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29298C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7DC206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSIDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 04:03:43 -0400
Received: from verein.lst.de ([213.95.11.211]:35696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSIDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:03:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ABB1568BEB; Sun, 19 Apr 2020 10:03:39 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:03:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/8] signal: clean up __copy_siginfo_to_user32
Message-ID: <20200419080339.GC12222@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-3-hch@lst.de> <87pnc5akhk.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnc5akhk.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:08:23PM -0500, Eric W. Biederman wrote:
> This bothers me because it makes all architectures pay for the sins of
> x32.  Further it starts burying the details of the what is happening in
> architecture specific helpers.  Hiding the fact that there is only
> one niche architecture that does anything weird.
> 
> I am very sensitive to hiding away signal handling details right now
> because way to much of the signal handling code got hidden in
> architecture specific files and was quite buggy because as a result.

I much prefer the unconditional flags over the crazy ifdef mess in
the current coe and your version.  Except for that and the rather
strange and confusing copy_siginfo_to_external32 name it pretty much
looks the same.
