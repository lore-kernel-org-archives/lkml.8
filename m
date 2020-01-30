Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5E8C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3164D20702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgA3J4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:56:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52590 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgA3J4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:56:32 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 56F6615AB0D01;
        Thu, 30 Jan 2020 01:56:29 -0800 (PST)
Date:   Thu, 30 Jan 2020 10:56:23 +0100 (CET)
Message-Id: <20200130.105623.2251053622156610557.davem@davemloft.net>
To:     geert@linux-m68k.org
Cc:     peter.krystad@linux.intel.com, pabeni@redhat.com, fw@strlen.de,
        cpaasch@apple.com, mathew.j.martineau@linux.intel.com,
        matthieu.baerts@tessares.net, kuba@kernel.org,
        netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: Fix undefined mptcp_handle_ipv6_mapped for
 modular IPV6
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200130094526.22483-1-geert@linux-m68k.org>
References: <20200130094526.22483-1-geert@linux-m68k.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jan 2020 01:56:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Jan 2020 10:45:26 +0100

> If CONFIG_MPTCP=y, CONFIG_MPTCP_IPV6=n, and CONFIG_IPV6=m:
> 
>     ERROR: "mptcp_handle_ipv6_mapped" [net/ipv6/ipv6.ko] undefined!
> 
> This does not happen if CONFIG_MPTCP_IPV6=y, as CONFIG_MPTCP_IPV6
> selects CONFIG_IPV6, and thus forces CONFIG_IPV6 builtin.
> 
> As exporting a symbol for an empty function would be a bit wasteful, fix
> this by providing a dummy version of mptcp_handle_ipv6_mapped() for the
> CONFIG_MPTCP_IPV6=n case.
> 
> Rename mptcp_handle_ipv6_mapped() to mptcpv6_handle_mapped(), to make it
> clear this is a pure-IPV6 function, just like mptcpv6_init().
> 
> Fixes: cec37a6e41aae7bf ("mptcp: Handle MP_CAPABLE options for outgoing connections")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks good, applied, thank you.
