Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2FBC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A756620748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PM3B9HXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgGJToQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJToP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:44:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B1FC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1VmzFcnP3/YHRUmS2rHUD2i9AUE3TqsbsQgcN7fI++c=; b=PM3B9HXGyD27uvwZ30Ek7dMPFA
        5CV7hg4LgGNw2eihia5l3D8My2/QsOar16IfP9pas9NO/wYLRWnys5QalMMuTo7/K4OPQihIL5sVH
        7bs7BglerBuOv/xMGOrMYZhRWJxz26+77TZe/Xc8ogjTY8ZP3SRdOLSJWsYEjLAMoSWO/v5ck7WTR
        C5V13cE7dd29OF94UPrcuZ4DF22bNSGklyxw3SeI6IrfkSVtctby668q8sQPRDNbkBTu4H15kZN7Z
        D4dU6awKKOryTe1y8k4QsiSsh5D2jquztQzJQo59RQe3vgB+QLHXWWyiwc9UlO5le6HFtepFiMkDt
        7ZZlG2xg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtywI-0003Qt-5f; Fri, 10 Jul 2020 19:44:06 +0000
Date:   Fri, 10 Jul 2020 20:44:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1] mm/vmalloc.c: Add an error message if two areas
 overlap
Message-ID: <20200710194406.GP12769@casper.infradead.org>
References: <20200710194042.2510-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710194042.2510-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:40:42PM +0200, Uladzislau Rezki (Sony) wrote:
> Before triggering a BUG() it would be useful to understand
> how two areas overlap between each other. Print information
> about start/end addresses of both VAs and their addresses.
> 
> For example if both are identical it could mean double free.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5a2b55c8dd9a..1679b01febcd 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -549,8 +549,13 @@ find_va_links(struct vmap_area *va,
>  		else if (va->va_end > tmp_va->va_start &&
>  				va->va_start >= tmp_va->va_end)
>  			link = &(*link)->rb_right;
> -		else
> +		else {
> +			pr_err("Overlaps: 0x%px(0x%lx-0x%lx), 0x%px(0x%lx-0x%lx)\n",
> +				va, va->va_start, va->va_end, tmp_va,
> +				tmp_va->va_start, tmp_va->va_end);

It might be helpful to have a "vmalloc:" prefix to that string to indicate
where to start searching.  And I don't think we're supposed to use %px
without a really good justification these days.

Can we do without the BUG()?  Maybe just break out and decline to insert
the conflicting range?

>  			BUG();
> +		}
>  	} while (*link);
>  
>  	*parent = &tmp_va->rb_node;
> @@ -1993,6 +1998,9 @@ static void vmap_init_free_space(void)
>  			insert_vmap_area_augment(free, NULL,
>  				&free_vmap_area_root,
>  					&free_vmap_area_list);
> +			insert_vmap_area_augment(free, NULL,
> +				&free_vmap_area_root,
> +					&free_vmap_area_list);

This is surely testing code that you forgot to delete?
