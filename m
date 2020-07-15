Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADE120658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbgGOODH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:03:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58029 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgGOODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:03:07 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06FE35Bp056463;
        Wed, 15 Jul 2020 23:03:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Wed, 15 Jul 2020 23:03:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06FE2xxt056225
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 15 Jul 2020 23:03:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct
 fbcon_ops"->clear_margins.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        George Kennedy <george.kennedy@oracle.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam>
 <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
Message-ID: <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
Date:   Wed, 15 Jul 2020 23:02:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/15 20:17, Tetsuo Handa wrote:
> On 2020/07/15 18:48, Dan Carpenter wrote:
>>> @@ -216,7 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
>>>  	region.color = color;
>>>  	region.rop = ROP_COPY;
>>>  
>>> -	if (rw && !bottom_only) {
>>> +	if ((int) rw > 0 && !bottom_only) {
>>>  		region.dx = info->var.xoffset + rs;
>>                             ^^^^^^^^^^^^^^^^^^^^^^
>>
>> If you choose a very high positive "rw" then this addition can overflow.
>> info->var.xoffset comes from the user and I don't think it's checked...
> 
> Well, I think it would be checked by "struct fb_ops"->check_var hook.
> For example, vmw_fb_check_var() has
> 
> 	if ((var->xoffset + var->xres) > par->max_width ||
> 	    (var->yoffset + var->yres) > par->max_height) {
> 		DRM_ERROR("Requested geom can not fit in framebuffer\n");
> 		return -EINVAL;
> 	}
> 
> check. Of course, there might be integer overflow in that check...
> Having sanity check at caller of "struct fb_ops"->check_var might be nice.
> 

Well, while

        const int fd = open("/dev/fb0", O_ACCMODE);
        struct fb_var_screeninfo var = { };
        ioctl(fd, FBIOGET_VSCREENINFO, &var);
        var.xres = var.yres = 4;
        var.xoffset = 4294967292U;
        ioctl(fd, FBIOPUT_VSCREENINFO, &var);

bypassed

  (var->xoffset + var->xres) > par->max_width

check in vmw_fb_check_var(),

----------
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -216,6 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
        region.color = color;
        region.rop = ROP_COPY;

+       printk(KERN_INFO "%s info->var.xoffset=%u rs=%u info->var.yoffset=%u bs=%u\n", __func__, info->var.xoffset, rs, info->var.yoffset, bs);
        if ((int) rw > 0 && !bottom_only) {
                region.dx = info->var.xoffset + rs;
                region.dy = 0;
----------

says that info->var.xoffset does not come from the user.

----------
 bit_clear_margins info->var.xoffset=0 rs=1024 info->var.yoffset=0 bs=800
----------
