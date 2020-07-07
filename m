Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEFEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD8A206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594122380;
	bh=Tf9vlF44bSWYAUL7aspDEhTqVuzCLyhxiP2bW00Xa14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M/6XjWohJUGn3inqRmA+mdCISLkb4aoAGlov4QFUbkv/e3d4EV4CeNUmeQoh4elHS
	 qoVFInKcNzjJVqBQOf2v5jhXWUOcw/BZqajkCmsn+3hYwItkEZrgSz27J9DKZ/Aqb6
	 9BbJ3VwezmH1Y+CVyR2IIsQgO4f2d8KBdrah+j5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgGGLqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:46:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39053 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgGGLqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:46:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5so44779319wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/159hiHL9x+UhJssAcBn7P97Ay6xtu9/dua98ccUME=;
        b=MGxsMd/T4jtE1UVERbmQEGB6wQRUXqYx3KRN8HB2RMuA4CoTK8uTaj8ASHT6jFml3a
         edvzKlo4Whpzl5DNjsZTdWeukvdIQEmIJ/hwJGt+COp+qFcfIYd3fIwJCMdkjDrPDhE4
         vfAeWeiOvhMrvlmZnsvqzE4pWt1BdLOZ5kaa0hLsqNaBNuoh0HrjGVJpL0DeId3u+N7x
         toV+PzMQyHxfmX7mA+T65q9NXmZ9J7yKdJ4hs8fhkuWgh4jAgmOBGM4jTSWWpdAX5HMf
         vcBPluiB5Nb7OylnlcEnwxA4STg3xBBuhWSVVteBPxiqtI7/oxzfnwaemNt6X9dtlX7e
         gKow==
X-Gm-Message-State: AOAM5311zuxYpdFyR4VYuWuHqbCIGl2qogOvCY7OufFgLvjDXnF0P3aJ
        tUkZJAGm8MQoVBT6zXNdiL0=
X-Google-Smtp-Source: ABdhPJwWrp1UV1Z9J4yD0goAu88tpuwWxfZeWYe6XbPUzoatqpKrdAJbxwZ4gfj+G5hcm77R9Pa/YA==
X-Received: by 2002:a5d:4b84:: with SMTP id b4mr56132552wrt.334.1594122376662;
        Tue, 07 Jul 2020 04:46:16 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id b23sm824230wmd.37.2020.07.07.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:46:15 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:46:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 07/11] mm/gup: use a standard migration target
 allocation callback
Message-ID: <20200707114614.GK5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-8-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594107889-32228-8-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 16:44:45, Joonsoo Kim wrote:
[...]
> @@ -1551,9 +1552,12 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>  
>  		gfp_mask |= htlb_alloc_mask(h);
>  		return alloc_huge_page_nodemask(h, nid, mtc->nmask,
> -						gfp_mask, false);
> +						gfp_mask, mtc->skip_cma);
>  	}
>  
> +	if (mtc->skip_cma)
> +		flags = memalloc_nocma_save();
> +

As already mentioned in previous email this is a completely wrong usage
of the scope API. The scope should be defined by the caller and this
should be all transparent by the allocator layer.

>  	if (PageTransHuge(page)) {
>  		/*
>  		 * clear __GFP_RECALIM since GFP_TRANSHUGE is the gfp_mask
> @@ -1572,6 +1576,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>  	if (new_page && PageTransHuge(new_page))
>  		prep_transhuge_page(new_page);
>  
> +	if (mtc->skip_cma)
> +		memalloc_nocma_restore(flags);
> +
>  	return new_page;
>  }
>  
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
