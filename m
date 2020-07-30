Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6131C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF61D206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596091598;
	bh=xvqWS7CZoxjvuY4gZz1/7/xQt6ZD0TfcxHp9St78Pjk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uF8CGC7irHHQ+GD7n5GffXuu73XmgFDkgwdLZTqHUC5yx9huMXOOEJN0DBNvulod3
	 AJtVW9rGjynmGRKxKLhtRgo0wNo7NdrBb/PqNw3+iCpz6yB5vZk+eIGknPpUsWMlMG
	 hrQxuoZJkMftzcDXOHqkVHSLRtd6ezpFCxQdVWmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgG3Gqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:46:37 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37500 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3Gqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:46:37 -0400
Received: by mail-ej1-f66.google.com with SMTP id qc22so12042345ejb.4;
        Wed, 29 Jul 2020 23:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VvW/5770zwdEjP0loB0rGyzZeqTV1S8hvb/EOvhH5ns=;
        b=K8Ncut16Dy74iSG9N70LUm44js+zJp+txfKEKYYwBqHjgkUThhfCo3imov/f3AP8n3
         +PoPDNORyU1WjCVCglgLVI7YwyfwCJ+ZtOQD6Xb/+KtWs3DPF3gqEsIncCTwMR//wALO
         9FkiRljCU+X5smUasRL9m0fX9olSSKFzBwCJbg8x1Dj+nPICgp8DnfntODVd8ifdWj0q
         Qq7SNzh6/bXwSiMMGeKd+7GRsdhesXKK1nQ6CjJfzLFkBb8KtQiB1VPW1RxJ2m783qAk
         FLFkHFmcwbuEEcZBKZreLppkqGNBYfBa5AYWe35r+fMbLYfqe+ldRC9u379CantMyDOI
         DsSQ==
X-Gm-Message-State: AOAM532XgSQUXyIUpjNBQW4scL7okC61NV5uHvVWINrKMqVLXQOuleSv
        DdUaJZ10lssrvG/IAxI3poYxsWdy
X-Google-Smtp-Source: ABdhPJz9oidJ37cVJXjWt97VdLi7NLqMYVy6XmEAAIyOjANEBvS0Sei67vqcg/JYxg4UqxI6pxM3FA==
X-Received: by 2002:a17:907:94c9:: with SMTP id dn9mr1149368ejc.355.1596091593696;
        Wed, 29 Jul 2020 23:46:33 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id t25sm4480562ejc.34.2020.07.29.23.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 23:46:32 -0700 (PDT)
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
To:     =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Solar Designer <solar@openwall.com>
Cc:     b.zolnierkie@samsung.com,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        xiao.zhang@windriver.com,
        DRI devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20200729130710.GA13262@openwall.com>
 <b764c575-70be-80dd-6718-e84370a7b2b3@nsfocus.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
Date:   Thu, 30 Jul 2020 08:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b764c575-70be-80dd-6718-e84370a7b2b3@nsfocus.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, OTOH, you should have CCed all the (public) lists.

On 30. 07. 20, 4:50, 张云海 wrote:
> Zhang Xiao points out that the check should use > instead of >=,
> otherwise the last line will be skip.
> I agree with that, so I modify the patch.
> Could you please verify that it is still correct and sufficient?

IMO, yes, correct -- I was thinking about this yesterday too. Just an
example: hypothetically, if we had:
size_row = 1
tail = 29
size = 30

data[29] would be the last accessible member. Writing to data + tail (as
"29 + 1 > 30" doesn't hold, so the modified check would pass), i.e.
data[29] is still OK. So yes, > is OK, >= would waste space and would be
actually incorrect.

> BTW, Zhang Xiao also points out that the check after the memcpy can be
> remove.
> I also think that was right, but vgacon_scrollback_cur->tail may keep
> the value vgacon_scrollback_cur->size in some case. That is not a
> problem in vgacon_scrollback_update because of the check before the
> memcpy. However, that may break some other code which assumes that
> vgacon_scrollback_cur->tail won't be vgacon_scrollback_cur->size. I do
> not know if there are such code, and if it is the code actually  should
> check it too. But I still not remove the check in the patch to make sure
> it won't breaks other code.

As I wrote about this yesterday:
===
I am also not sure the test I was pointing out on the top of this
message would be of any use after the change. But maybe leave the code
rest in peace.
===

I would let it as is in this particular code. Especially because
vgacon_scrolldelta takes ->tail into consideration and I was too lazy to
study the code there. But if you are willing to study the code there and
confirm the check is superfluous, feel free to remove it. Perhaps in a
separate patch. I was actually testing with the check removed and didn't
hit any issue (which means, in fact, exactly nothing).

> From ad143ede24ff4e61292cc9c96000100aacd97259 Mon Sep 17 00:00:00 2001
> From: Yunhai Zhang <zhangyunhai@nsfocus.com>
> Date: Tue, 28 Jul 2020 09:58:03 +0800
> Subject: [PATCH] Fix for missing check in vgacon scrollback handling
> 
> vgacon_scrollback_update() always left enbough room in the scrollback

"leaves enough"

> buffer for the next call, but if the console size changed that room
> might not actually be enough, and so we need to re-check.

Also, could you add reasoning why you are adding the check to the loop
and not outside (for instance, use your reasoning with numbers or CSI M
as an example).

Could you add a sample output here, something like I had:
===
    This leads to random crashes or KASAN reports like:
    BUG: KASAN: slab-out-of-bounds in vgacon_scroll+0x57a/0x8ed
===

It's then easier to google for when this happens to someone who runs
non-patched kernels.

> This fixes CVE-2020-14331.
> 
> Reported-and-debugged-by: 张云海 <zhangyunhai@nsfocus.com>
> Reported-and-debugged-by: Yang Yingliang <yangyingliang@huawei.com>
> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Fixes: 15bdab959c9b ([PATCH] vgacon: Add support for soft scrollback)
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Solar Designer <solar@openwall.com>
> Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
> Cc: Anthony Liguori <aliguori@amazon.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Oh, and we should:
Cc: stable@vger.kernel.org

> Signed-off-by: Yunhai Zhang <zhangyunhai@nsfocus.com>
> ---
>  drivers/video/console/vgacon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index 998b0de1812f..37b5711cd958 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -251,6 +251,10 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>  	p = (void *) (c->vc_origin + t * c->vc_size_row);
>  
>  	while (count--) {
> +		if ((vgacon_scrollback_cur->tail + c->vc_size_row) > 
> +		    vgacon_scrollback_cur->size)
> +			vgacon_scrollback_cur->tail = 0;
> +
>  		scr_memcpyw(vgacon_scrollback_cur->data +
>  			    vgacon_scrollback_cur->tail,
>  			    p, c->vc_size_row);

thanks,
-- 
js
suse labs
