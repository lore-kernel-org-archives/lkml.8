Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA7C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801E620771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgC3TQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:16:28 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:47348 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgC3TQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:16:28 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7155D20024;
        Mon, 30 Mar 2020 21:16:20 +0200 (CEST)
Date:   Mon, 30 Mar 2020 21:16:19 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Qiujun Huang <hqjagain@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        maarten.lankhorst@linux.intel.com, daniel.thompson@linaro.org,
        ghalat@redhat.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbcon: fix null-ptr-deref in fbcon_switch
Message-ID: <20200330191619.GF7594@ravnborg.org>
References: <20200329085647.25133-1-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329085647.25133-1-hqjagain@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8
        a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=NVFoAeSCgwShZuBWzHEA:9
        a=ViYWLu_RVrLAkblt:21 a=QLy0bD8Az-XStLsx:21 a=CjuIK1q_8ugA:10
        a=W4TVW4IDbPiebHqcZpNg:22 a=cQPPKAXgyycSBL8etih5:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiujun

On Sun, Mar 29, 2020 at 04:56:47PM +0800, Qiujun Huang wrote:
> Set logo_shown to FBCON_LOGO_CANSHOW when the vc was deallocated.
> 
> syzkaller report: https://lkml.org/lkml/2020/3/27/403
> general protection fault, probably for non-canonical address
> 0xdffffc000000006c: 0000 [#1] SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
> RIP: 0010:fbcon_switch+0x28f/0x1740
> drivers/video/fbdev/core/fbcon.c:2260
> 
> Call Trace:
> redraw_screen+0x2a8/0x770 drivers/tty/vt/vt.c:1008
> vc_do_resize+0xfe7/0x1360 drivers/tty/vt/vt.c:1295
> fbcon_init+0x1221/0x1ab0 drivers/video/fbdev/core/fbcon.c:1219
> visual_init+0x305/0x5c0 drivers/tty/vt/vt.c:1062
> do_bind_con_driver+0x536/0x890 drivers/tty/vt/vt.c:3542
> do_take_over_console+0x453/0x5b0 drivers/tty/vt/vt.c:4122
> do_fbcon_takeover+0x10b/0x210 drivers/video/fbdev/core/fbcon.c:588
> fbcon_fb_registered+0x26b/0x340 drivers/video/fbdev/core/fbcon.c:3259
> do_register_framebuffer drivers/video/fbdev/core/fbmem.c:1664 [inline]
> register_framebuffer+0x56e/0x980 drivers/video/fbdev/core/fbmem.c:1832
> dlfb_usb_probe.cold+0x1743/0x1ba3 drivers/video/fbdev/udlfb.c:1735
> usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
> 
> accessing vc_cons[logo_shown].d->vc_top causes the bug.
> 
> Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index bb6ae995c2e5..5eb3fc90f9f6 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1283,6 +1283,9 @@ static void fbcon_deinit(struct vc_data *vc)
>  	if (!con_is_bound(&fb_con))
>  		fbcon_exit();
>  
> +	if (vc->vc_num == logo_shown)
> +		logo_shown = FBCON_LOGO_CANSHOW;
> +
>  	return;
>  }

Looks much better than the previous version.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I expect Bartlomiej to review/apply.

	Sam
