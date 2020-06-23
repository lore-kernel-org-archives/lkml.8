Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47953C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0DD2137B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbgFWWCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbgFWWCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:02:42 -0400
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E7C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 15:02:42 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 6AEF55F87E;
        Wed, 24 Jun 2020 00:02:41 +0200 (CEST)
Date:   Tue, 23 Jun 2020 15:02:41 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
In-Reply-To: <20200623215042.GA43266@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.1.446.2006231456380.3892@trent.utfs.org>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org> <202006231131.AD0A7F5F@keescook> <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org> <20200623215042.GA43266@localhost.localdomain>
User-Agent: Alpine 2.22.1 (DEB 446 2020-06-13)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Alexey Dobriyan wrote:
> BTW this bug was exactly the one described in the changelog:
> compiling assembly brings executable stack by default:

Great, thanks for the pointer, will wait until this lands in Arch. My 
search engine brought up the lkml discussion though, no the thread[0] on 
rsync-cvs ;-)

Christian.

[0] https://lists.samba.org/archive/rsync-cvs/2020-June/007661.html
-- 
BOFH excuse #211:

Lightning strikes.
