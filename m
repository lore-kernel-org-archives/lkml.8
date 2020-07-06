Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C48C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E95A20674
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="XzQ9cwHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgGFUZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:25:17 -0400
Received: from mail.alarsen.net ([144.76.18.233]:53556 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFUZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:25:16 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2020 16:25:16 EDT
Received: from oscar.alarsen.net (unknown [IPv6:2001:470:1f0b:246:a933:6a30:e75c:eb92])
        by joe.alarsen.net (Postfix) with ESMTPS id A9D772B80BD9;
        Mon,  6 Jul 2020 22:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1594066797; bh=QgSSLcWUiu1FHgdCpD2D067MWOpF1pFkgTcuWYDmxWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzQ9cwHxoazggXLG5Dpx+hpwMFGwg7rg+QUCSImvaZbSUAqZA3GLszm1QCHNqMI02
         7RAm1NSm1RDqkbrkURDWIrqZL+877+Cl28PBByuxft0teFdMHEibLedxPbxozjxK2f
         4ow40GhFFYQDgAYe3Dr+VXjDIcbYCLoNYq56IuMc=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 8743F27C0DDA;
        Mon,  6 Jul 2020 22:19:57 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: QNX4
Date:   Mon, 06 Jul 2020 22:19:57 +0200
Message-ID: <11471313.geHk1C00m9@alarsen.net>
In-Reply-To: <20200706173905.19376-1-grandmaster@al2klimov.de>
References: <20200706173905.19376-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 2020-07-06 19:39 Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  fs/qnx4/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/qnx4/Kconfig b/fs/qnx4/Kconfig
> index 45b5b98376c4..6ba0e5a1303f 100644
> --- a/fs/qnx4/Kconfig
> +++ b/fs/qnx4/Kconfig
> @@ -5,7 +5,7 @@ config QNX4FS_FS
>  	help
>  	  This is the file system used by the real-time operating systems
>  	  QNX 4 and QNX 6 (the latter is also called QNX RTP).
> -	  Further information is available at <http://www.qnx.com/>.
> +	  Further information is available at <https://www.qnx.com/>.
>  	  Say Y if you intend to mount QNX hard disks or floppies.
>  
>  	  To compile this file system support as a module, choose M here: the

Acked-by: Anders Larsen <al@alarsen.net>




