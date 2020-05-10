Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8CBC47257
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506B221775
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgEJAvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 20:51:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65189 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgEJAvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:51:11 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04A0p77S032175;
        Sun, 10 May 2020 09:51:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Sun, 10 May 2020 09:51:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04A0p1V9031999
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 10 May 2020 09:51:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 05/20] tomoyo_write_control(): get rid of pointless
 access_ok()
To:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-5-viro@ZenIV.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b67a5f6e-0192-f350-e797-455fe570ce93@i-love.sakura.ne.jp>
Date:   Sun, 10 May 2020 09:50:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200509234557.1124086-5-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Al.

I think that this access_ok() check helps reducing partial writes (either
"whole amount was processed" or "not processed at all" unless -ENOMEM).
Do you think that such attempt is pointless? Then, please go ahead...

On 2020/05/10 8:45, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> address is passed only to get_user()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/tomoyo/common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index 1b467381986f..f93f8acd05f7 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -2662,8 +2662,6 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
>  
>  	if (!head->write)
>  		return -EINVAL;
> -	if (!access_ok(buffer, buffer_len))
> -		return -EFAULT;
>  	if (mutex_lock_interruptible(&head->io_sem))
>  		return -EINTR;
>  	head->read_user_buf_avail = 0;
> 

