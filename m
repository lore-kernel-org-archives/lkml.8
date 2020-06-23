Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62ADC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46EC20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393601AbgFWVd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:33:57 -0400
Received: from trent.utfs.org ([94.185.90.103]:44226 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387982AbgFWVdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:33:54 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 3A97B6015C;
        Tue, 23 Jun 2020 23:33:50 +0200 (CEST)
Date:   Tue, 23 Jun 2020 14:33:50 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
In-Reply-To: <202006231131.AD0A7F5F@keescook>
Message-ID: <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org> <202006231131.AD0A7F5F@keescook>
User-Agent: Alpine 2.22.1 (DEB 446 2020-06-13)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020, Kees Cook wrote:
> > $ checksec --format=json --extended --file=`which rsync` | jq
> > {
> >   "/usr/bin/rsync": {
> >     "relro": "full",
> >     "canary": "yes",
> >     "nx": "no",
> ^^^^^^^^^^^^^^^^^^
> 
> It is, indeed, marked executable, it seems. What distro is this?

Arch Linux (x86-64) with 5.6.5.a-1-hardened[0], running in a Xen DomU.

Christian.

[0] https://git.archlinux.org/svntogit/packages.git/tree/trunk?h=packages/linux-hardened
-- 
BOFH excuse #211:

Lightning strikes.
