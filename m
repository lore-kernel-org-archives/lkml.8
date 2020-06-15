Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A7F206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203346;
	bh=7xqClezn+XLBX7i3FDe2bv3gv8yisqFUxYU0iWm999I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2l/TRxJG0SB3eOCErM/o7HoUvI/VEMLF9RbxzyL20B/M57YC4ooJ2AtmLSwkEOpgM
	 gZoYTfCad2jjCnjndU8IqVyJExoS4+jbUy1OUlpd3IVlfm11Vd0oyy3BFv3KAtYa+3
	 lZXw2YNygQxjf0Zzhw/UL0cQfys2zP2/ydwlIHPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgFOGmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:42:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41645 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgFOGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:42:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id j10so15791321wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r5bbY+2GSPiy6U8SvmPVHs8hp2v5pEnTmjUC34UGuPc=;
        b=A135TxUplBv5TP7yop7xA4MgZCmzEHV4flpdG11OANUw20Joq4ZCG61C7vAehszwZM
         0WllDiDQTd64vv05gHJXNmo5hOlLM9U4GgUqoo8U0kuhZEs2HlrKStQ6W4opZjxs4KpT
         VZRXlpHbjbQzFAyj0noPGaoIJ1bonsD2ezmL7q9LiHAl8MB5/fMImUzHQMKdm28dyIv2
         qA6bFbExfV/lnLZBnhCAd32NtwC1WHFR75H+R1Wcztd0rm4nff9fWACxHOt2ysvFYX/j
         mLhjvlBxM8PY2Fd6qarlCA5D3rf9klQpU08zTjYxlYYWyDEIdk7vBcLkAP8clvDXNdlU
         xM6A==
X-Gm-Message-State: AOAM533VyMYk6Y2r76sbgJi7/0UU1yilVtD5dg82E71Kc/C/vHt07NeL
        9+yK3VypyPPWNwGgpIMVhOs=
X-Google-Smtp-Source: ABdhPJzuZ4QyVs1o9eY/IW0ZUzlwf4irr7o0CATLvQzfHAqo+xJXFL4GQptQe8/gC8HJp3y5qGV8yg==
X-Received: by 2002:adf:e4d1:: with SMTP id v17mr26738308wrm.224.1592203341583;
        Sun, 14 Jun 2020 23:42:21 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id h27sm26967510wrb.18.2020.06.14.23.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 23:42:20 -0700 (PDT)
Date:   Mon, 15 Jun 2020 08:42:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH] mm, memcg: prevent missed memory.low load tears
Message-ID: <20200615064219.GA25296@dhcp22.suse.cz>
References: <20200612174437.GA391453@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200612174437.GA391453@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12-06-20 18:44:37, Chris Down wrote:
> Looks like one of these got missed when massaging in f86b810c2610 ("mm,
> memcg: prevent memory.low load/store tearing") with other linux-mm
> changes.
> 
> Reported-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Chris Down <chris@chrisdown.name>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0b38b6ad547d..f7cc66a80348 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6416,7 +6416,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  
>  	if (parent == root) {
>  		memcg->memory.emin = READ_ONCE(memcg->memory.min);
> -		memcg->memory.elow = memcg->memory.low;
> +		memcg->memory.elow = READ_ONCE(memcg->memory.low);
>  		goto out;
>  	}
>  
> @@ -6428,7 +6428,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  			atomic_long_read(&parent->memory.children_min_usage)));
>  
>  	WRITE_ONCE(memcg->memory.elow, effective_protection(usage, parent_usage,
> -			memcg->memory.low, READ_ONCE(parent->memory.elow),
> +			READ_ONCE(memcg->memory.low),
> +			READ_ONCE(parent->memory.elow),
>  			atomic_long_read(&parent->memory.children_low_usage)));
>  
>  out:
> -- 
> 2.27.0
> 

-- 
Michal Hocko
SUSE Labs
