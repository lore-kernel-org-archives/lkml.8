Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D78C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7AF2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgHDLRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:17:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50871 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgHDLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:15:49 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 074BFkur012924;
        Tue, 4 Aug 2020 20:15:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Tue, 04 Aug 2020 20:15:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 074BFkWK012916
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 4 Aug 2020 20:15:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] vt: defer kfree() of vc_screenbuf in vc_do_resize()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
References: <1596034621-4714-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <0c9d8003-ba3f-8f2d-7c5a-56c5ca7db750@i-love.sakura.ne.jp>
Date:   Tue, 4 Aug 2020 20:15:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1596034621-4714-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you think this approach is acceptable? Or, do we need to modify set_origin() ?

On 2020/07/29 23:57, Tetsuo Handa wrote:
> syzbot is reporting UAF bug in set_origin() from vc_do_resize() [1], for
> vc_do_resize() calls kfree(vc->vc_screenbuf) before calling set_origin().
> 
> Unfortunately, in set_origin(), vc->vc_sw->con_set_origin() might access
> vc->vc_pos when scroll is involved in order to manipulate cursor, but
> vc->vc_pos refers already released vc->vc_screenbuf until vc->vc_pos gets
> updated based on the result of vc->vc_sw->con_set_origin().
> 
> Preserving old buffer and tolerating outdated vc members until set_origin()
> completes would be easier than preventing vc->vc_sw->con_set_origin() from
> accessing outdated vc members.
> 
> [1] https://syzkaller.appspot.com/bug?id=6649da2081e2ebdc65c0642c214b27fe91099db3
> 
> Reported-by: syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/tty/vt/vt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 42d8c67..c9ee8e9 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1196,7 +1196,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	unsigned int old_rows, old_row_size, first_copied_row;
>  	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
>  	unsigned int user;
> -	unsigned short *newscreen;
> +	unsigned short *oldscreen, *newscreen;
>  	struct uni_screen *new_uniscr = NULL;
>  
>  	WARN_CONSOLE_UNLOCKED();
> @@ -1294,10 +1294,11 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	if (new_scr_end > new_origin)
>  		scr_memsetw((void *)new_origin, vc->vc_video_erase_char,
>  			    new_scr_end - new_origin);
> -	kfree(vc->vc_screenbuf);
> +	oldscreen = vc->vc_screenbuf;
>  	vc->vc_screenbuf = newscreen;
>  	vc->vc_screenbuf_size = new_screen_size;
>  	set_origin(vc);
> +	kfree(oldscreen);
>  
>  	/* do part of a reset_terminal() */
>  	vc->vc_top = 0;
> 

