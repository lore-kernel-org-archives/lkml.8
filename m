Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BA9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E7021734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgAUM13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:27:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37146 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:27:29 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C66DB14EFC238;
        Tue, 21 Jan 2020 04:27:26 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:27:25 +0100 (CET)
Message-Id: <20200121.132725.1938964059289099578.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     sam@ravnborg.org, stable@vger.kernel.org, ldv@altlinux.org,
        dalias@libc.org, libc-alpha@sourceware.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc32: fix struct ipc64_perm type definition
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200114132633.3694261-1-arnd@arndb.de>
References: <20200114132633.3694261-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jan 2020 04:27:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Jan 2020 14:26:14 +0100

> As discussed in the strace issue tracker, it appears that the sparc32
> sysvipc support has been broken for the past 11 years. It was however
> working in compat mode, which is how it must have escaped most of the
> regular testing.
> 
> The problem is that a cleanup patch inadvertently changed the uid/gid
> fields in struct ipc64_perm from 32-bit types to 16-bit types in uapi
> headers.
> 
> Both glibc and uclibc-ng still use the original types, so they should
> work fine with compat mode, but not natively.  Change the definitions
> to use __kernel_uid32_t and __kernel_gid32_t again.
> 
> Fixes: 83c86984bff2 ("sparc: unify ipcbuf.h")
> Link: https://github.com/strace/strace/issues/116
> Cc: <stable@vger.kernel.org> # v2.6.29
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: "Dmitry V . Levin" <ldv@altlinux.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: libc-alpha@sourceware.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied and queued up for -stable, thanks Arnd.
