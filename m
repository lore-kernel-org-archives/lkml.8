Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574D1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3376F206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594122026;
	bh=3rOu6zQTuzN/64VgOaN5FFa2W8skbKpgjFiXBosXTH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y66gv8bgNsv2NoGjdf6B7mdvktXSOEgGcl2JkR/9CgKCF9HLJlxbHPqYVdNLhPdJh
	 onj0SQc6brjGU1ez/5ht8POCbLrvWZ9nqf3c/n225+TDboL0u/T6J+rO9zKuwc3whr
	 zhJM9aIvJpL4raIJSxCK3ZOxyEKTl33fgAUVfNeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGGLkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:40:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39437 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:40:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5so44762215wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TYzmEtg/Kj0i964ThN6Qo6tqP9/EQZBPoedHzLNj/F8=;
        b=GJC9OL0+i9DWAo9bwdhhGi/e+ozTBfQUBo7HrNeg84olo4fj2YN5F0orLV1azTlJdq
         mpTygsJXI18tUeENhZFm1LmDZW5No7mAgqXZ91m3KHVkxsF095bP2vyA0/jLNQBQRDzH
         IYJtVJ+LAlRFY6XiJ2LE8grRzIktLfD4vr1ft1Gi4Gz5QcviRYfk7ZKLOK/6J9rv7BRM
         c1DZ7+vT3YpKy+spRQb8hxKg9JUlqrzTmWgxi0eeIyyyz3S1obk7FTfaZGybjJWcp1tf
         LyZ/caQAg3MDvJ3Cbqg1aKw9OFtRcdsFAOusAHK6XAxCnNLiXaAbIw2M3ojaKph+7ti4
         B2jA==
X-Gm-Message-State: AOAM53330ZCLZ8TGdN3ojMz1gve1yNKowAZbMGBqQ4KpaxglyVl2z0sd
        Xb0aewRoDAZ9TrBeWFCIGTw=
X-Google-Smtp-Source: ABdhPJyCUpFQXAvN1uQvadCMYh7ObchD7W+fGup6uatezxdeECrMSV3cMOD/yD3txHQVZXAAdSHPgg==
X-Received: by 2002:a5d:650e:: with SMTP id x14mr56294076wru.187.1594122021224;
        Tue, 07 Jul 2020 04:40:21 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id o9sm650992wrs.1.2020.07.07.04.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:40:20 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:40:19 +0200
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
Subject: Re: [PATCH v4 05/11] mm/migrate: clear __GFP_RECLAIM for THP
 allocation for migration
Message-ID: <20200707114019.GI5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 16:44:43, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> In mm/migrate.c, THP allocation for migration is called with the provided
> gfp_mask | GFP_TRANSHUGE. This gfp_mask contains __GFP_RECLAIM and it
> would be conflict with the intention of the GFP_TRANSHUGE.
> 
> GFP_TRANSHUGE/GFP_TRANSHUGE_LIGHT is introduced to control the reclaim
> behaviour by well defined manner since overhead of THP allocation is
> quite large and the whole system could suffer from it. So, they deals
> with __GFP_RECLAIM mask deliberately. If gfp_mask contains __GFP_RECLAIM
> and uses gfp_mask | GFP_TRANSHUGE(_LIGHT) for THP allocation, it means
> that it breaks the purpose of the GFP_TRANSHUGE(_LIGHT).

GFP_TRANSHUGE* is not a carved in stone design. Their primary reason to
exist is to control how hard to try for different allocation
paths/configurations because their latency expectations might be
largerly different. It is mostly the #PF path which aims to be as
lightweight as possible I believe nobody simply considered migration to be
very significant to even care. And I am still not sure it matters but
I would tend to agree that a consistency here is probably a very minor
plus.

Your changelog is slightly misleading in that regard because it suggests
that this is a real problem while it doesn't present any actual data.
It would be really nice to make the effective change really stand out.
We are only talking about __GFP_RECLAIM_KSWAPD here. So the only
difference is that the migration won't wake up kswapd now.

All that being said the changelog should be probably more explicit about
the fact that this is solely done for consistency and be honest that the
runtime effect is not really clear. This would help people reading it in
future.
-- 
Michal Hocko
SUSE Labs
