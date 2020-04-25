Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AF5C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A78720704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDYQXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:23:00 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:46346 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDYQXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 12:23:00 -0400
Date:   Sat, 25 Apr 2020 12:22:59 -0400
From:   Rich Felker <dalias@libc.org>
To:     Rob Landley <rob@landley.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-sh@vger.kernel.org
Subject: Re: [PATCHv3 31/50] sh: Add loglvl to printk_address()
Message-ID: <20200425162259.GK11469@brightrain.aerifal.cx>
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-32-dima@arista.com>
 <20200420155237.1b6532c0d0c6940fccd1b762@linux-foundation.org>
 <92cf0382-bdb4-6966-5a77-2ade50fdc451@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92cf0382-bdb4-6966-5a77-2ade50fdc451@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 11:06:41AM -0500, Rob Landley wrote:
> On 4/20/20 5:52 PM, Andrew Morton wrote:
> > I guess it doesn't matter much, as sh seems to be rather dead.
> 
> The j-core guys are using it.

Yes. There are also Debian/SH folks using classic SH4.

Rich
