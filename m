Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415ABC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DB12088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgFXFe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:34:59 -0400
Received: from trent.utfs.org ([94.185.90.103]:42712 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388470AbgFXFe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:34:59 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 55F3E5F838;
        Wed, 24 Jun 2020 07:34:57 +0200 (CEST)
Date:   Tue, 23 Jun 2020 22:34:57 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
In-Reply-To: <202006231619.38108DE0@keescook>
Message-ID: <alpine.DEB.2.22.1.446.2006232231410.3892@trent.utfs.org>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org> <20200623211218.GA40110@localhost.localdomain> <20200623212214.GA41702@localhost.localdomain> <202006231619.38108DE0@keescook>
User-Agent: Alpine 2.22.1 (DEB 446 2020-06-13)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020, Kees Cook wrote:
> > If you run something with exec stack after the message
> > you shouldn't get it second time.
> 
> If you want to reset this flag, you can do:
>  # echo 1 > /sys/kernel/debug/clear_warn_once

Thanks. Although, I tend to not mount /sys/kernel/{config,debug,tracing} 
and other things, I always thought they are not needed and could maybe 
lower the attack surface if not mounted. Or maybe my tinfoil hat needs 
some adjustment...

Christian.
-- 
BOFH excuse #279:

The static electricity routing is acting up...
