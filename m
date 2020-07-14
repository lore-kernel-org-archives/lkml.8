Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1576C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF85322202
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGNK1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:27:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65421 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgGNK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:27:49 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06EARkFL000526;
        Tue, 14 Jul 2020 19:27:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Tue, 14 Jul 2020 19:27:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06EARkMn000520
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 14 Jul 2020 19:27:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] fbdev: Detect integer underflow at "struct
 fbcon_ops"->clear_margins.
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200712111013.11881-2-penguin-kernel@I-love.SAKURA.ne.jp>
 <CGME20200714072231eucas1p17c53f0a661346ebfd316ebd5796ca346@eucas1p1.samsung.com>
 <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e00078d1-e5fb-a019-3036-cb182ed2e40b@i-love.sakura.ne.jp>
Date:   Tue, 14 Jul 2020 19:27:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/14 16:22, Bartlomiej Zolnierkiewicz wrote:
> How does this patch relate to:
> 
> 	https://marc.info/?l=linux-fbdev&m=159415024816722&w=2
> 
> ?
> 
> It seems to address the same issue, I've added George and Dan to Cc:.

George Kennedy's patch does not help for my case.

You can try a.out built from

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/fb.h>

int main(int argc, char *argv[])
{
        const int fd = open("/dev/fb0", O_ACCMODE);
        struct fb_var_screeninfo var = { };
        ioctl(fd, FBIOGET_VSCREENINFO, &var);
        var.xres = var.yres = 16;
        ioctl(fd, FBIOPUT_VSCREENINFO, &var);
        return 0;
}
----------

with a fault injection patch

----------
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1214,6 +1214,10 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 
 	if (new_screen_size > KMALLOC_MAX_SIZE)
 		return -EINVAL;
+	if (!strcmp(current->comm, "a.out")) {
+		printk(KERN_INFO "Forcing memory allocation failure.\n");
+		return -ENOMEM;
+	}
 	newscreen = kzalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
 		return -ENOMEM;
----------

. What my patch workarounds is cases when vc_do_resize() did not update vc->vc_{cols,rows} .
Unless vc->vc_{cols,rows} are updated by vc_do_resize() in a way that avoids integer underflow at

	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
	unsigned int bh = info->var.yres - (vc->vc_rows*ch);

, this crash won't go away.

[   39.995757][ T2788] Forcing memory allocation failure.
[   39.996527][ T2788] BUG: unable to handle page fault for address: ffffa9d180d7b000
[   39.996529][ T2788] #PF: supervisor write access in kernel mode
[   39.996530][ T2788] #PF: error_code(0x0002) - not-present page
[   39.996531][ T2788] PGD 13a48c067 P4D 13a48c067 PUD 13a48d067 PMD 1324e4067 PTE 0
[   39.996547][ T2788] Oops: 0002 [#1] SMP
[   39.996550][ T2788] CPU: 2 PID: 2788 Comm: a.out Not tainted 5.8.0-rc5+ #757
[   39.996551][ T2788] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   39.996555][ T2788] RIP: 0010:bitfill_aligned+0x87/0x120 [cfbfillrect]
