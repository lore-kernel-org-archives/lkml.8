Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E8C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1134C206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgC1SNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:13:06 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:35612 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgC1SNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:13:06 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CF34D80609;
        Sat, 28 Mar 2020 19:13:00 +0100 (CET)
Date:   Sat, 28 Mar 2020 19:12:59 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        maarten.lankhorst@linux.intel.com, daniel.thompson@linaro.org,
        ghalat@redhat.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: fix null-ptr-deref in fbcon_switch
Message-ID: <20200328181259.GA24335@ravnborg.org>
References: <20200328151511.22932-1-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328151511.22932-1-hqjagain@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=hSkVLCK3AAAA:8
        a=pGLkceISAAAA:8 a=UqxoRI4XFovwuTuz1dAA:9 a=CjuIK1q_8ugA:10
        a=cQPPKAXgyycSBL8etih5:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiujun

Thanks for looking into the sysbot bugs.

On Sat, Mar 28, 2020 at 11:15:10PM +0800, Qiujun Huang wrote:
> Add check for vc_cons[logo_shown].d, as it can be released by
> vt_ioctl(VT_DISALLOCATE).
> 
> Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index bb6ae995c2e5..7ee0f7b55829 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2254,7 +2254,7 @@ static int fbcon_switch(struct vc_data *vc)
>  		fbcon_update_softback(vc);
>  	}
>  
> -	if (logo_shown >= 0) {
> +	if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
>  		struct vc_data *conp2 = vc_cons[logo_shown].d;
>  
>  		if (conp2->vc_top == logo_lines
> @@ -2852,7 +2852,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
>  			return;
>  		if (vc->vc_mode != KD_TEXT || !lines)
>  			return;
> -		if (logo_shown >= 0) {
> +		if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
>  			struct vc_data *conp2 = vc_cons[logo_shown].d;
>  
>  			if (conp2->vc_top == logo_lines

I am not familiar with this code.

But it looks like you try to avoid the sympton
which is that logo_shown has a wrong value after a
vc is deallocated, and do not fix the root cause.

We have:

vt_ioctl(VT_DISALLOCATE)
 |
 +- vc_deallocate()
     |
     +- visual_deinit()
         |
	 +- vc->vc_sw->con_deinit(vc)
	     |
	     +- fbcon_deinit()

Would it be better to update logo_shown
in fbcon_deinit()?
Then we will not try to do anything with
the logo in fbcon_switch().

fbcon_deinit() is called with console locked
so there should not be any races.

I did not stare long enough on the code to come up with a patch,
but this may be a better way to fix it.

	Sam
