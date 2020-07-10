Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16114C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D4A20853
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG7WGrtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgGJToI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:44:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E4C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:44:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so7718979ljm.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vysk606sA8Of187qvDUDNcu+jxfwy3DGDePacF31O0s=;
        b=hG7WGrtSDxdwGVkQjtZ+Y0iAl4ZZqcd3EQ8sd8z6by6q5DAINsG5VezAUyhGVnIW1M
         ab7K3ppN6SalgSu0tnFSzp7FZSERs9Zg84KqXPEl5RpHUmV1g4D3XvAho0vxhuG0uk/o
         A6Cm+x4GRLR9hovvB6CIUJnUiV9zXG7bsbBROrMZvNa+XaSVshWMh40w+QBzmBWT7hpC
         /wq4NEY5awSO1vegII9l9SX/soRTyUltBVR9tzsnqzKAz1AIIx3YdnrxDQd+XIpSsT0h
         tJo/pCJmtre+eI/Bc7TGY70cI9znBEtCii8C3cfCYsZz653i8B0ewKfEtWlF2PouQMKA
         bhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vysk606sA8Of187qvDUDNcu+jxfwy3DGDePacF31O0s=;
        b=Pkdchb42z5cKDKOPVRib1RsqjvHhTK0ZklEKZCp0wQPXyZNJ5VeUd0S8Ln3e6JA8ER
         O1CRNDqRLOtDfAOsgKL9DykOl4tWEQ3XMiWP5CMWOhO8uf0+bh1Il5gU5sk1lT7o7Pwk
         wsOoZAUWXXVvuImxaAlNDF8FYlQtIjEoJZP+146zIJ3h8cffeVfTtVFsnyDdzrZ9q2up
         wBPcO8R1GPrZIDXN8d2ca2zlIXqgsDdkpJrlBnKvQIX07lDdYnDgAVT5EB3Dn4gCgD6L
         pooeTBcwOxyjBRkVNZSBaNbsBoSKUB12aPmminX2N8ZBhindVhOE8qmJ172XM54FynVB
         UKUQ==
X-Gm-Message-State: AOAM530UUwmS7kXP6LjrlWnUDQibanGgXKjxKHbLgNDsLQwhm0uuam/C
        AA/ymkkSPYHKbxyuaNNoO7I=
X-Google-Smtp-Source: ABdhPJwz3TpyJMmekzxnbo03lbvdeO6i0Wor3mW4aXErkdi+M0+pbDMj2RTXVokJ+ciJGa2xfMhM+g==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr25458864ljn.38.1594410246213;
        Fri, 10 Jul 2020 12:44:06 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 16sm2181362ljw.127.2020.07.10.12.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:44:05 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 10 Jul 2020 21:44:03 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1] mm/vmalloc.c: Add an error message if two areas
 overlap
Message-ID: <20200710194403.GA19388@pc636>
References: <20200710194042.2510-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710194042.2510-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> +
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
>  		}
>  	}
>  }
> 
Please ignore this patch, i will upload v2.

Sorry for inconvenience.

--
Vlad Rezki
