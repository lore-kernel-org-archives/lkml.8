Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB0EC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2FE20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579253720;
	bh=5xZ0SvyVEX/laARvg21yAgQaUwOXkCsgmcP0bHJmAEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FdGQkCslYoBv3ljvUXEuZI7uzK3dvB1B2vJNPmHZjOfapCHdO6DwzdYH6oVojAUYf
	 yJbijKGZz+JRj3j3stID9wfE4TfUEIA+mimZVE04yAwnTLFE+o3F2XSRpBruI16BmG
	 hNWKz1SnWPV8xx7EmstmZwnhaY2ii9C+mQWLdKr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAQJfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:35:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44253 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgAQJfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:35:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so21970198wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7gwrvz7ruAHA3SFXBx/tLBPi8mLd0GYtPIPaLfycq9U=;
        b=bADdxA3vql8xQNRTXGin7fYGei40Pn/ItHd93V9lDoc4uiHXpkkk2FTr/LN/beubG5
         32to6Ek2L1aZ1JHRatsl9sLiGlyve+y4Yrz61MwxJtqupVIGGJ0Pck4BZl/ltfksBbxT
         ZRRDKLRG75t928T+3VUfDwG5BZs3VKepxiPrSMqSCUIYVvtFTIFkJmUu1jK9jM+NvzeI
         D+blAxLapqQZY9U7BYZRlOycrcHjvpHC9DopWZaKBn0cNSdCcSVKNUVXrJEO/CQKt0HB
         HErjv2tgyt/Ix8cwo1DCEoMBq0aBQTARco6bW/4IlhHVaRnky0j1iPqmhwmzd00Y4LM7
         FFkA==
X-Gm-Message-State: APjAAAVA4JjglDfTOLjCGd5kEdZOcJ33Bh2hgr41HSrdKcLiK7AmWVOI
        kl+tSGEapcWwA8H1SMf4u6o=
X-Google-Smtp-Source: APXvYqy9tO+u02lTrwIibulmYqlXXZMnVPkbGMsJVRWqsSy+/8HvCr25zmuKZzueYNYsb7kdpC2dpg==
X-Received: by 2002:adf:e550:: with SMTP id z16mr2013469wrm.315.1579253716736;
        Fri, 17 Jan 2020 01:35:16 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d8sm32437954wrx.71.2020.01.17.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:35:15 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:35:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Donald Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200117093514.GO19428@dhcp22.suse.cz>
References: <20191217193238-1-cheloha@linux.vnet.ibm.com>
 <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
 <181caae3-ffb8-c745-a4c9-1aef93ea6dd5@redhat.com>
 <20200116152214.GX19428@dhcp22.suse.cz>
 <765a07fe-47e9-fe3d-716a-44d9ee4a5e99@redhat.com>
 <fe92b4f0-0cd7-c705-1ed9-239175689051@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe92b4f0-0cd7-c705-1ed9-239175689051@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-01-20 17:17:54, David Hildenbrand wrote:
[...]
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index c6d288fad493..c75dec35de43 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -19,7 +19,7 @@
>  #include <linux/memory.h>
>  #include <linux/memory_hotplug.h>
>  #include <linux/mm.h>
> -#include <linux/radix-tree.h>
> +#include <linux/xarray.h>
>  #include <linux/stat.h>
>  #include <linux/slab.h>
>  
> @@ -58,11 +58,11 @@ static struct bus_type memory_subsys = {
>  };
>  
>  /*
> - * Memory blocks are cached in a local radix tree to avoid
> + * Memory blocks are cached in a local xarray to avoid
>   * a costly linear search for the corresponding device on
>   * the subsystem bus.
>   */
> -static RADIX_TREE(memory_blocks, GFP_KERNEL);
> +static DEFINE_XARRAY(memory_blocks);
>  
>  static BLOCKING_NOTIFIER_HEAD(memory_chain);
>  
> @@ -566,7 +566,7 @@ static struct memory_block *find_memory_block_by_id(unsigned long block_id)
>  {
>         struct memory_block *mem;
>  
> -       mem = radix_tree_lookup(&memory_blocks, block_id);
> +       mem = xa_load(&memory_blocks, block_id);
>         if (mem)
>                 get_device(&mem->dev);
>         return mem;
> @@ -621,7 +621,8 @@ int register_memory(struct memory_block *memory)
>                 put_device(&memory->dev);
>                 return ret;
>         }
> -       ret = radix_tree_insert(&memory_blocks, memory->dev.id, memory);
> +       ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
> +                             GFP_KERNEL));
>         if (ret) {
>                 put_device(&memory->dev);
>                 device_unregister(&memory->dev);
> @@ -683,7 +684,7 @@ static void unregister_memory(struct memory_block *memory)
>         if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
>                 return;
>  
> -       WARN_ON(radix_tree_delete(&memory_blocks, memory->dev.id) == NULL);
> +       WARN_ON(xa_erase(&memory_blocks, memory->dev.id) == NULL);
>  
>         /* drop the ref. we got via find_memory_block() */
>         put_device(&memory->dev);

OK, this looks sensible. xa_store shouldn't ever return an existing
device as we do the lookpup beforehand so good. We might need to
reorganize the code if we want to drop the loopup though.

Thanks!
-- 
Michal Hocko
SUSE Labs
