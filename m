Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16FFC2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 21:45:54 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFCA20732
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 21:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKxRtOU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFCA20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgDLVpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 17:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgDLVpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 17:45:52 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAECC0A3BF5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 14:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586727951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDOZbGbYc6a0ITpk5OWVoS7nLueP9baBRaeKv2m/AsE=;
        b=bKxRtOU9M86FRrdFRljo6imbElJXMN+Bq7pfCe/MKCFOPqH59FOmJK8GSdN5aLh1zicJeD
        lFhg3oZ2HcRNjeZjifgTTRTeLQNxN4FCGH4FBuA4FRXlPeDaEEYwNBzxUetNc/PfeIhgGI
        uTd0lGG1kmY0wvcbR5dLXjbFnC9W1cE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-6H7jhS_jPq2Q4KJLWsXsSw-1; Sun, 12 Apr 2020 17:45:47 -0400
X-MC-Unique: 6H7jhS_jPq2Q4KJLWsXsSw-1
Received: by mail-qk1-f200.google.com with SMTP id r64so6972821qkc.17
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 14:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDOZbGbYc6a0ITpk5OWVoS7nLueP9baBRaeKv2m/AsE=;
        b=JRxzmEVmY56pF8y6MYeX0NePZ0L3FOYPIcagIj+HglCNjOk0unpu4cKvfx5CEQyY+o
         IRxP+CA2NUP+WSsib5u/vjNZ/GazhS6bmp2dhU9xoNwFQ4kdU5+lnmRFd08kVDze/OiN
         fYmh5LWSRYxhJ0qIWFDY8qXLa2c7MZOpxLfhEwffIdT/iIAL+bSkqiszdXEqe3+D9H+n
         f7igszZwefKJoDPzunQQZ3ErO4hSXLW+zMm9TbHmIl/BawHWhh6BxylOEkmXlid7kmME
         hKUuDhX8I4IxpVYb0t620Z7qyMXCSBuUFMq6VUvvOBug/PEH7SZNa/ZpphbWGyvMm5Ny
         Fbnw==
X-Gm-Message-State: AGi0PuasEaW/Tq9it/6PSIYAXfVgL2aoixMYjQHVVzjB5NkAtxg1Cbzs
        R/S5/z4s938uVWYlbC/BAkoi/E0F8eQyCAHociLEvYZN5wQqqmc04hFoyysZXhUDhQnnxnAVi3C
        Q4jIcaEb93+FlYmyAHVE5FIzq
X-Received: by 2002:a0c:ffcb:: with SMTP id h11mr2115023qvv.166.1586727946967;
        Sun, 12 Apr 2020 14:45:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypJHpqxXU+mPC9x54gU9Fp9TiGbPpXJJG6ATF65B0HQPWkrjAxOez+nEQRO0BEdJ//5gIJignA==
X-Received: by 2002:a0c:ffcb:: with SMTP id h11mr2115009qvv.166.1586727946729;
        Sun, 12 Apr 2020 14:45:46 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id u14sm6944716qtq.41.2020.04.12.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 14:45:46 -0700 (PDT)
Date:   Sun, 12 Apr 2020 17:45:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: f45ec5ff16 ("userfaultfd: wp: support swap and page migration"):
 [  140.777858] BUG: Bad rss-counter state mm:b278fc66 type:MM_ANONPAGES
 val:1
Message-ID: <20200412214545.GC38470@xz-x1>
References: <20200410002518.GG8179@shao2-debian>
 <20200410073209.11164-1-hdanton@sina.com>
 <20200412125408.18008-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200412125408.18008-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 08:54:08PM +0800, Hillf Danton wrote:
> 
> On Fri, 10 Apr 2020 11:32:34 -0400 Peter Xu wrote:
> > 
> > I'm not sure this is correct.  As I mentioned, the commit wanted to
> > apply the uffd-wp bit even for the swap entries so that even the swap
> > entries got swapped in, the page will still be write protected.  So
> > IIUC think we can't remove that.
> 
> Yes you are right.
> 
> Now both CONFIG_MIGRATION and swap entry are restored after making uffd_wq
> survive migrate the same way as soft_dirty.
> 
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -236,6 +236,8 @@ static bool remove_migration_pte(struct
>  		pte = pte_mkold(mk_pte(new, READ_ONCE(vma->vm_page_prot)));
>  		if (pte_swp_soft_dirty(*pvmw.pte))
>  			pte = pte_mksoft_dirty(pte);
> +		if (pte_swp_uffd_wp(*pvmw.pte))
> +			pte = pte_mkuffd_wp(pte);
>  
>  		/*
>  		 * Recheck VMA as permissions can change since migration started
> @@ -243,15 +245,11 @@ static bool remove_migration_pte(struct
>  		entry = pte_to_swp_entry(*pvmw.pte);
>  		if (is_write_migration_entry(entry))
>  			pte = maybe_mkwrite(pte, vma);
> -		else if (pte_swp_uffd_wp(*pvmw.pte))
> -			pte = pte_mkuffd_wp(pte);
>  
>  		if (unlikely(is_zone_device_page(new))) {
>  			if (is_device_private_page(new)) {
>  				entry = make_device_private_entry(new, pte_write(pte));
>  				pte = swp_entry_to_pte(entry);
> -				if (pte_swp_uffd_wp(*pvmw.pte))
> -					pte = pte_mkuffd_wp(pte);
>  			}
>  		}
>  
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -139,11 +139,13 @@ static unsigned long change_pte_range(st
>  			}
>  			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
>  			pages++;
> -		} else if (is_swap_pte(oldpte)) {
> +		} else if (IS_ENABLED(CONFIG_MIGRATION)) {
>  			swp_entry_t entry = pte_to_swp_entry(oldpte);
>  			pte_t newpte;
>  
> -			if (is_write_migration_entry(entry)) {
> +			if (!non_swap_entry(entry)) {
> +				newpte = oldpte;
> +			} else if (is_write_migration_entry(entry)) {
>  				/*
>  				 * A protection check is difficult so
>  				 * just be safe and disable write
> @@ -164,7 +166,7 @@ static unsigned long change_pte_range(st
>  				if (pte_swp_uffd_wp(oldpte))
>  					newpte = pte_swp_mkuffd_wp(newpte);
>  			} else {
> -				newpte = oldpte;
> +				continue;
>  			}
>  
>  			if (uffd_wp)
> 
> 

Hi, Hillf,

Feel free to have a look at another report, which I think is the same
issue of this:

https://lore.kernel.org/lkml/CA+G9fYsRGvkqtpdGv_aVr+Hn17KgYq04Q=EE=pB774qVxRqOeg@mail.gmail.com/

IMHO this bisected commit is correct itself, it's just that we
shouldn't enable uffd-wp on 32bit system.

Thanks,

-- 
Peter Xu

