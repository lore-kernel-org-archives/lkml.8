Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79FEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB53207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgG2H7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:59:49 -0400
Received: from nsfocus.com ([221.122.62.131]:58050 "HELO nsfocus.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S1727082AbgG2H7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:59:48 -0400
Received: (qmail 3331 invoked from network); 29 Jul 2020 07:51:42 -0000
Received: from unknown (HELO ?192.168.7.10?) (221.122.62.131)
  by nsfocus.com with SMTP; 29 Jul 2020 07:51:42 -0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
To:     Jiri Slaby <jslaby@suse.cz>, b.zolnierkie@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>, Solar Designer <solar@openwall.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        Security Officers <security@kernel.org>,
        linux-distros@vs.openwall.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20200729070249.20892-1-jslaby@suse.cz>
From:   =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
Autocrypt: addr=zhangyunhai@nsfocus.com; keydata=
 xsFNBFXf+bQBEADB+vY6HC3E/hdYvhlVSXWcxXNxk2yHU+P2Rz0dWB5LibtRCm8SAdwFOBRr
 iyws5OnV1T6j/HnXPR7ENtYbpL+fIcAv5o7jJyEl4cosbpDl0H88Tj/Py0YYEOJg0nm1F0LW
 0NlIRG3OSSJQ8UHsCzFPqHQnUJaymfwoyYgIexxkG4Oi+cXVHVnbV3Qafe3H+siB29dfPFuf
 iZzPhIDnE2K/MF8/RmeB7CTc2Y4lc1CCbKiJsLYMx4CBrQ2qkGyC3XRorMfBRvhglmIY51Lx
 nHrd5s2vS13YbeeOyU9l54SjipL6XQRdSo/j/xTJBhT7y/c22E52AtsqeuH7gJU7MQnkS+cp
 FN2b2EcQdWlbUKIm3Tlbs0Y2vjV2cpNNDMc8uVGwddVeNdMjq9tXFkgLQww8SAEs+g15ai5v
 /LiGy/4NJodl9wSiamsgjBSn8AuFJTazy99k6ug+wLYp0kzD/sB0Otg/UbR7yTS4xjwhyk09
 WOk3/wLptYujh/0BBWpaCXsLW117PGFz/iSu7QAJhOdlNaaJYxOUDHB4dZPEpRSE6tGGYpZ6
 AyHkgprFD/lpAluSsSbskjAgPCqdzrU6kZItcc1uu8QIh3Vd1j0iFo8sBLSrg0WXyE2N6mgg
 MZxkMtQLxy3XkQ7iofoeqgvujufN3pyfBeBzCjRi30W72IOsdwARAQABzSZaaGFuZyBZdW5o
 YWkgPHpoYW5neXVuaGFpQG5zZm9jdXMuY29tPsLBeQQTAQgAIwUCVd/5tAIbAwcLCQgHAwIB
 BhUIAgkKCwQWAgMBAh4BAheAAAoJEP4mMEaS5e9PRhsQAJsAmfByeSyMLVFKqVV+A13ESSGn
 zQW7SzVdcN++WgpGpSUpaQavCRKhzV6InJTUEVpPOphV3v/wFJL3cVYSfm1zxdjd63E116Ow
 utq4PcavcPkRch9scTrHKKodxbrSwepD50iCqOiQZpVd+bPy14oT/naKCnif58H/9+ZEwgZ3
 EQh79MBvzN29uzIc1e4sOFwCS+Ew3OrzLZWaNRPLnonsOAkTVEBcMXOxqx+XPexfKHHc4Ukf
 omKJUO/Q8a7F1SlLa0jcY1Yq5AAAYFJ1DgwPqMVRF69+mE9C7Q9FBKXM8ShGF9VhYjefmBq1
 UczE/idMAAlUvOVZ/eMeicn1QirKCISSw5yIkLhv8np+1ZBJo8oroEP87Z4JIStGa6sX7E3H
 s7/3lo8M8oEDl4IyqbXkV/i/pXEiWCd2fVrq+2S45xPOJZgpJ9tKuRxcGYHku9U7LKVG3kni
 YV/DqOGeCkoxv8mk9C8/CSfJaIrOwqLr86NFnNkL+lXaaPjvvKvpQ3ijIImtDI7TbK9n8Gzd
 8V6A7Oy0EqYtfjSp1yZkeF3viYWFyDGyiSuL3NhC0jszTWxQXFIvgUgjEDcYiaMVF1oBh7iA
 MAuzUGjLd0cj4rjokSmYT2JrxQzx5PeUtIh7JXl1Zj0uBxg1s9y9OZ8mmYBwqZ/UdeYtnThe
 26MoIZ6+zsFNBFXf+bQBEADhCv4euKnMwXnMePjAkToO68fjA6qg1wNDzezo+xQcO01k23us
 bTdvtkrAEhRkA/fy+M3q6yaP+STObQbF41Er0Bfmwtaxt8yXG5OmHNTpvBzM/aW5I9XNPCUj
 NcOZDGadoPMmo50S0krzA/i6ah/KHnsaB6ZhWRQxXITKs9xxswuNuRIQ7u1VeQlmADh8mfJ8
 YhFHCioeMSu7HNr+hI+jrZyUE1gPmSmLFnFZ96ONonN5pIJkGa0Lmdshn7nTsiu//QzPQasa
 hFm4REKTauIFMchDmjkzhWCEHTheaYqzfqFRnsiQi1iOqQ7i+Mnt6YjLaGJe1ZfKQaNTJsvL
 yInE3Ienoh3gVy4pEgC5wCbuBt7cZ9YYgjTN5JBGKZxahUd4kfto2L0ya5pLcjF1YVtYLaUI
 xJ28h01tVU4zmiBMVmhCMS++fO3RdGwYSd49jOt0KKi26rukvuKgb16yjD6nNajlJpUsVOBP
 n7165+7GKM6P2uFps2Qn39FxU29bGTxwHGjIYP7oc22wlh69SZ/EXDup4OhjifZnAyyMsHYq
 DjLLT6Kjqvh0pDs/ay1+Hs8Qq2z9Bl2/Y4dqLmhtRHzPC3LXwn6OXYoiiojjO+z+aJ0AfdE1
 s0iDw1oQhKCQsH6ReiLd3R1cmOovotyQREXDml136OPwEnWiL2sNH6dE/wARAQABwsFfBBgB
 CAAJBQJV3/m0AhsMAAoJEP4mMEaS5e9PzywP/jdR9cn0s2PNa0fQEPo7Ai6v6qy2dHp0lopa
 8k/KoIpZEhgnFgy3aVL+vL+9AuaZfSdm3gwW4t4V5GbR5HilQ6Nfp0sJVpE8F/JOF1P9SLSy
 fIsna0tcqE79/isyF+ockZwVK5rgwJHqEIzr50TOKob2yY4AF0ZFQUSrpU/AmE9OK1EH5d88
 gIki0kOYQwteL8hLTjkRlecjiBSljA9V4VZVwpXyCHUDO3sCxJQYMaiSTjGEztswoAyUy0Q+
 xnpzelyw670W/y9DAgafdaN5MJldyAapUOv8yIRSlQ5M2f3ZFyjJOAozNXfqXiuHkKoXgsbW
 Sfh/o9HfPE5y8NCPJY1IoHRr1pUklwVNIwM77xpQxBFhBPNUbL43igdqRf6hApk4aJ/jT7pF
 wPKclsAKfZTkqYOksT1Qh0FURhr8S6xUe3aV9omGXIOLGMIbpHuZSbP0akdHA0nzUY6HYbN1
 0T3X0bi33lOUefj2uAnhuPeReyAP02CjvkNJVfBRho3h/D56ofuPdvfAetT46d6y+tQVdoka
 5tO7oLXD/f5GPuDoYSjfOiIlU4d/tIDUdyXXfml0Ez8DZk0c+3z61TNXRDV1tzXKmC1oV+6m
 Ql46hjmfjnRfvq72kL55kj+YzWjlM9h98+4vqknUPPYIq+lUz4hO7I3b64i5sPkBWtN7DLkm
Message-ID: <55075898-bf95-1805-3358-b0d1438feaa9@nsfocus.com>
Date:   Wed, 29 Jul 2020 15:53:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729070249.20892-1-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch dosen't fix the issue, the check should be in the loop.

The change of the VT sze is before vgacon_scrollback_update, not in the
meantime.

Let's consider the following situation:
	suppose:
		vgacon_scrollback_cur->size is 65440
		vgacon_scrollback_cur->tail is 64960
		c->vc_size_row is 160
		count is 5
	
	Reset c->vc_size_row to 200 by VT_RESIZE, then call
vgacon_scrollback_update.
	
	This will pass the check, since (vgacon_scrollback_cur->tail +
c->vc_size_row)
	is 65160 which is less then vgacon_scrollback_cur->size(65440).

	However, in the 3rd iteration of the loop, vgacon_scrollback_cur->tail
is update
	to 65360, the memcpy will overflow.

To avoid overflow, the check should be
           if ((vgacon_scrollback_cur->tail + c->vc_size_row * count) >=

However, this will break the circular of the buffer, since all 5 lines
will be copy at the beginning.

To avoid break circular, we have to detect if wrap occurs, use a loop to
copy lines before
wrap, reset vgacon_scrollback_cur->tail to 0, then use another loop to
copy lines after wrap.
Of course the 2 loop can be combine into 2 memcpy, that will be similar
to Linus's patch.

Thus, I think the check should be in the loop.
The 2 check in the loop seems to be redundancy, Zhang Xiao from
Windriver suggest that the check after the memcpy can be remove.
I think he was right, but not very sure.
Thus, I suggest we discuss that too.

Regards,
Yunhai Zhang / NSFOCUS Security Team


On 2020/7/29 15:02, Jiri Slaby wrote:
> The current vgacon's scroll up implementation uses a circural buffer
> in vgacon_scrollback_cur. It always advances tail to prepare it for the
> next write and caps it to zero if the next ->vc_size_row bytes won't fit.
> 
> But when we change the VT size (e.g. by VT_RESIZE) in the meantime, the new
> line might not fit to the end of the scrollback buffer in the next
> attempt to scroll. This leads to various crashes as
> vgacon_scrollback_update writes out of the buffer:
>  BUG: unable to handle page fault for address: ffffc900001752a0
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  RIP: 0010:mutex_unlock+0x13/0x30
> ...
>  Call Trace:
>   n_tty_write+0x1a0/0x4d0
>   tty_write+0x1a0/0x2e0
> 
> Or to KASAN reports:
> BUG: KASAN: slab-out-of-bounds in vgacon_scroll+0x57a/0x8ed
> 
> So check whether the line fits in the buffer and wrap if needed. Do it
> before the loop as console_sem is held and ->vc_size_row cannot change
> during the execution of vgacon_scrollback_cur. If it does change, we
> need to ensure it does not change elsewhere, not here.
> 
> Also, we do not split the write of a line into chunks as that would
> break the consumers of the buffer. They expect ->cnt, ->tail and ->size
> to be in harmony and advanced by ->vc_size_row.
> 
> I found few reports of this in the past, some with patches included,
> some even 2 years old:
> https://lore.kernel.org/lkml/CAEAjamsJnG-=TSOwgRbbb3B9Z-PA63oWmNPoKYWQ=Z=+X49akg@mail.gmail.com/
> https://lore.kernel.org/lkml/1589336932-35508-1-git-send-email-yangyingliang@huawei.com/
> 
> This fixes CVE-2020-14331.
> 
> Big thanks to guys mentioned in the Reported-and-debugged-by lines below
> who actually found the root cause.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Reported-and-debugged-by: 张云海 <zhangyunhai@nsfocus.com>
> Reported-and-debugged-by: Yang Yingliang <yangyingliang@huawei.com>
> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Fixes: 15bdab959c9b ([PATCH] vgacon: Add support for soft scrollback)
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Solar Designer <solar@openwall.com>
> Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
> Cc: Anthony Liguori <aliguori@amazon.com>
> Cc: Security Officers <security@kernel.org>
> Cc: linux-distros@vs.openwall.org
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/console/vgacon.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index f0f3d573f848..13194bb246f8 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -250,6 +250,11 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>  
>  	p = (void *) (c->vc_origin + t * c->vc_size_row);
>  
> +	/* vc_size_row might have changed by VT_RESIZE in the meantime */
> +	if ((vgacon_scrollback_cur->tail + c->vc_size_row) >=
> +			vgacon_scrollback_cur->size)
> +		vgacon_scrollback_cur->tail = 0;
> +
>  	while (count--) {
>  		scr_memcpyw(vgacon_scrollback_cur->data +
>  			    vgacon_scrollback_cur->tail,
> 

-- 
张云海
绿盟科技 安全研究部 研究员
地址：北京市海淀区北洼路4号益泰大厦三层
邮编：100089
电话：(010)68438880-8510
传真：(010)68437328
手机：13691192782
邮箱：zhangyunhai@nsfocus.com
网站：http://www.nsfocus.com
