Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C43AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB412078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbgFWVv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387541AbgFWVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:51:58 -0400
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E36C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:51:58 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 4DCDB600BC;
        Tue, 23 Jun 2020 23:51:55 +0200 (CEST)
Date:   Tue, 23 Jun 2020 14:51:55 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Kook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
In-Reply-To: <20200623212214.GA41702@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.1.446.2006231435450.3892@trent.utfs.org>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org> <20200623211218.GA40110@localhost.localdomain> <20200623212214.GA41702@localhost.localdomain>
User-Agent: Alpine 2.22.1 (DEB 446 2020-06-13)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Alexey Dobriyan wrote:
> > >   process '/usr/bin/rsync' started with executable stack
> > > But I can't reproduce this message,
> 
> This message is once-per-reboot.

Interesting, thanks. Now I know why I cannot reproduce this. I still 
wonder what made rsync trigger this message today. The machine is running 
for some weeks, rsync is run a few times an hour the whole day, regularly 
and automatically, with always the same parameters. But oh, now I see, 
rsync had been upgraded (automatically) over night:

 > [ALPM] upgraded rsync (3.1.3-3 -> 3.2.0-1)

And indeed, the _older_ version had NX enabled:

$ wget https://archive.archlinux.org/packages/.all/rsync-3.1.3-3-x86_64.pkg.tar.zst
$ zstd -dc rsync-3.1.3-3-x86_64.pkg.tar.zst | tar -xf - usr/bin/rsync
$ checksec --format=json --extended --file=usr/bin/rsync | jq
{
  "usr/bin/rsync": {
    "relro": "full",
    "canary": "yes",
    "nx": "yes",
    "pie": "yes",
    "clangcfi": "no",
    "safestack": "no",
    "rpath": "no",
    "runpath": "no",
    "symbols": "no",
    "fortify_source": "yes",
    "fortified": "10",
    "fortify-able": "19"
  }
}

So, while I still think a PID would have been nice, now I know that it's 
pr_warn_once and won't be printed again until after the next reboot. Going 
to ask the Arch folks why NX has been disabled...

Thanks,
Christian.
-- 
BOFH excuse #211:

Lightning strikes.
