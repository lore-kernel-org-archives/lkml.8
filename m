Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1B3206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFBJXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgFBJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:23:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB9C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 02:23:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jg39A-0005ra-3Z; Tue, 02 Jun 2020 11:23:48 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jg398-0002X0-Ul; Tue, 02 Jun 2020 11:23:46 +0200
Date:   Tue, 2 Jun 2020 11:23:46 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, yi.zhang@huawei.com
Subject: Re: [PATCH] ubi: fastmap: Don't produce the initial anchor PEB when
 fastmap is disabled
Message-ID: <20200602092346.GK11869@pengutronix.de>
References: <20200601091134.3794265-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601091134.3794265-1-chengzhihao1@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:00:25 up 103 days, 16:30, 118 users,  load average: 0.77, 0.35,
 0.25
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 01, 2020 at 05:11:34PM +0800, Zhihao Cheng wrote:
> Following process triggers a memleak caused by forgetting to release the
> initial anchor PEB (CONFIG_MTD_UBI_FASTMAP is disabled):
> 1. attach -> __erase_worker -> produce the initial anchor PEB
> 2. detach -> ubi_fastmap_close (Do nothing, it should have released the
>    initial anchor PEB)
> 
> Don't produce the initial anchor PEB in __erase_worker() when fastmap
> is disabled.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Fixes: f9c34bb529975fe ("ubi: Fix producing anchor PEBs")
> Reported-by: syzbot+d9aab50b1154e3d163f5@syzkaller.appspotmail.com
> ---
>  drivers/mtd/ubi/wl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
> index 5146cce5fe32..5ebe1084a8e7 100644
> --- a/drivers/mtd/ubi/wl.c
> +++ b/drivers/mtd/ubi/wl.c
> @@ -1079,13 +1079,19 @@ static int __erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk)
>  	if (!err) {
>  		spin_lock(&ubi->wl_lock);
>  
> -		if (!ubi->fm_anchor && e->pnum < UBI_FM_MAX_START) {
> +#ifdef CONFIG_MTD_UBI_FASTMAP
> +		if (!ubi->fm_disabled && !ubi->fm_anchor &&
> +		    e->pnum < UBI_FM_MAX_START) {

Rather than introducing another #ifdef you could do a

		if (IS_ENABLED(CONFIG_MTD_UBI_FASTMAP) &&
		    !ubi->fm_disabled && !ubi->fm_anchor &&
		    e->pnum < UBI_FM_MAX_START)

And I am not sure if the IS_ENABLED(CONFIG_MTD_UBI_FASTMAP) is necessary
at all because we do a ubi->fm_disabled = 1 when fastmap is disabled.

Regards,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
