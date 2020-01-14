Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC3CC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F603207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgANJVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:21:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43711 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANJVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:21:01 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1irINZ-000420-DH; Tue, 14 Jan 2020 10:20:53 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1irINX-0004kf-RU; Tue, 14 Jan 2020 10:20:51 +0100
Date:   Tue, 14 Jan 2020 10:20:51 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     quanyang.wang@windriver.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: fix memory leak from c->sup_node
Message-ID: <20200114092051.autszasi2rmywtyk@pengutronix.de>
References: <20200114054311.8984-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114054311.8984-1-quanyang.wang@windriver.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:20:10 up 190 days, 15:30, 87 users,  load average: 0.30, 0.21,
 0.28
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 01:43:11PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The c->sup_node is allocated in function ubifs_read_sb_node but
> is not freed. This will cause memory leak as below:
> 
> unreferenced object 0xbc9ce000 (size 4096):
>   comm "mount", pid 500, jiffies 4294952946 (age 315.820s)
>   hex dump (first 32 bytes):
>     31 18 10 06 06 7b f1 11 02 00 00 00 00 00 00 00  1....{..........
>     00 10 00 00 06 00 00 00 00 00 00 00 08 00 00 00  ................
>   backtrace:
>     [<d1c503cd>] ubifs_read_superblock+0x48/0xebc
>     [<a20e14bd>] ubifs_mount+0x974/0x1420
>     [<8589ecc3>] legacy_get_tree+0x2c/0x50
>     [<5f1fb889>] vfs_get_tree+0x28/0xfc
>     [<bbfc7939>] do_mount+0x4f8/0x748
>     [<4151f538>] ksys_mount+0x78/0xa0
>     [<d59910a9>] ret_fast_syscall+0x0/0x54
>     [<1cc40005>] 0x7ea02790
> 
> Free it in ubifs_umount and in the error path of mount_ubifs.
> 
> Fixes: fd6150051bec ("ubifs: Store read superblock node")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>

Looks good.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  fs/ubifs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 7d4547e5202d..a4412c259bb3 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -1599,6 +1599,7 @@ static int mount_ubifs(struct ubifs_info *c)
>  	vfree(c->ileb_buf);
>  	vfree(c->sbuf);
>  	kfree(c->bottom_up_buf);
> +	kfree(c->sup_node);
>  	ubifs_debugging_exit(c);
>  	return err;
>  }
> @@ -1641,6 +1642,7 @@ static void ubifs_umount(struct ubifs_info *c)
>  	vfree(c->ileb_buf);
>  	vfree(c->sbuf);
>  	kfree(c->bottom_up_buf);
> +	kfree(c->sup_node);
>  	ubifs_debugging_exit(c);
>  }
>  
> -- 
> 2.17.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
