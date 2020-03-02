Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B6DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185892467E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AESyjToZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgCBNmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:42:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35697 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgCBNmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:42:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id m3so10715310wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sEpI61AXMhQk+/7FRgpCLnFcPQkSVnPoQZAeagfx6ys=;
        b=AESyjToZUu4gv4B5N5XvM77kWp2ZhYaLupK1ZQJqpDx4a4CCjQfu/jqxbyZAX/RgKt
         rYQHo/iO0XliI8SeLLw3tT6z3Mh1it69mfikc6+UmS0YCtoKcSqLZMo/Osucieugl/8n
         MyFOeQ4DcnzLhvGSNWspHvMPwQONVKJ0AhRa0/bQVIYl2a4Sj+7L8bebkpjnNbn1LYBD
         MQKGyRhLgYcohdC3/RNrycprC8HfMM6SPGBRNTwa3aa8XRyb/Vg1vLboeXf+5GLeRrpR
         nJmWy1v3Nb8eyg+Biq4C037c+98DZdXBKNfjROLHRNb2Rgb9ZEWYXUJbrt7TGyxmLW9k
         ZJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sEpI61AXMhQk+/7FRgpCLnFcPQkSVnPoQZAeagfx6ys=;
        b=Ns5jt1W+Yp09qY6AzdmyLdpUN+GI89kEPH/4FATQWRENHEOoJ5aFHfNxLvXXvXFw4q
         8wl/uzS5NK+3g0vbkJ5oRyYlmwhny46KN2KEbWSDeHopCoGGld1YMQhPzo+zyIFEo2Db
         d1yvuX3p+FlSPrM/4abC9aqaRrml5Bv5RVdClu1A00caobuYYErUyqHN97/vY1HzGLEj
         BVAxU3Cj8GjNtjf9OgujxZL1hcRd8VgHZCTbnP6oRYyt9e03HCXrziM3yqXbJt+fjIbe
         m8Rtb3fyfBYWcIkJ+lfJABxmPaKp2FJBrDg/3lrT26zOSLsi7wtSb+jOrck1syuSuazy
         fTkw==
X-Gm-Message-State: APjAAAWoXeIOW9oVt+Kuq0bzmmp0QBo14/v15t3bqGT0bUUvDoRZHl3g
        7P+MWyHUehxDvYYcghkJXiI=
X-Google-Smtp-Source: APXvYqxpj6QHHeJQgvkTZb7OrMvzHfNPEFpnzqAPc4r2kDX4obZp3lH0Q5h1vucsMBWn7C9J4QpJlw==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr19477104wmd.23.1583156561969;
        Mon, 02 Mar 2020 05:42:41 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z16sm27524843wrp.33.2020.03.02.05.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 05:42:41 -0800 (PST)
Date:   Mon, 2 Mar 2020 13:42:40 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swapfile: fix data races in try_to_unuse()
Message-ID: <20200302134240.6i32e4qmgvqiztz2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1582578903-29294-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582578903-29294-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 04:15:03PM -0500, Qian Cai wrote:
>si->inuse_pages could be accessed concurrently as noticed by KCSAN,
>
> write to 0xffff98b00ebd04dc of 4 bytes by task 82262 on cpu 92:
>  swap_range_free+0xbe/0x230
>  swap_range_free at mm/swapfile.c:719
>  swapcache_free_entries+0x1be/0x250
>  free_swap_slot+0x1c8/0x220
>  __swap_entry_free.constprop.19+0xa3/0xb0
>  free_swap_and_cache+0x53/0xa0
>  unmap_page_range+0x7e0/0x1ce0
>  unmap_single_vma+0xcd/0x170
>  unmap_vmas+0x18b/0x220
>  exit_mmap+0xee/0x220
>  mmput+0xe7/0x240
>  do_exit+0x598/0xfd0
>  do_group_exit+0x8b/0x180
>  get_signal+0x293/0x13d0
>  do_signal+0x37/0x5d0
>  prepare_exit_to_usermode+0x1b7/0x2c0
>  ret_from_intr+0x32/0x42
>
> read to 0xffff98b00ebd04dc of 4 bytes by task 82499 on cpu 46:
>  try_to_unuse+0x86b/0xc80
>  try_to_unuse at mm/swapfile.c:2185
>  __x64_sys_swapoff+0x372/0xd40
>  do_syscall_64+0x91/0xb05
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>The plain reads in try_to_unuse() are outside si->lock critical section
>which result in data races that could be dangerous to be used in a loop.
>Fix them by adding READ_ONCE().
>
>Signed-off-by: Qian Cai <cai@lca.pw>
>---
> mm/swapfile.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/mm/swapfile.c b/mm/swapfile.c
>index a65622eec66f..36fd1536a83d 100644
>--- a/mm/swapfile.c
>+++ b/mm/swapfile.c
>@@ -2137,7 +2137,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
> 	swp_entry_t entry;
> 	unsigned int i;
> 
>-	if (!si->inuse_pages)
>+	if (!READ_ONCE(si->inuse_pages))
> 		return 0;
> 
> 	if (!frontswap)
>@@ -2153,7 +2153,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
> 
> 	spin_lock(&mmlist_lock);
> 	p = &init_mm.mmlist;
>-	while (si->inuse_pages &&
>+	while (READ_ONCE(si->inuse_pages) &&

The change is not wrong. But since it is not protected by the lock, some
status in swap_info_struct could still be modified after we test this
inuse_pages is not zero. Would this be some problem?


-- 
Wei Yang
Help you, Help me
