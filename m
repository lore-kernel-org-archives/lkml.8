Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E58C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE1020760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594194506;
	bh=fe7zKReyGfBIJORKxFkhSpDtkWDdH1BOWQajZLEMr90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q4mgMVJ/KCfQN0kKn0GXk8nVsNF5okpPegH4MKA3hRuaeP9gMVyaZTKCwYxQv3WWo
	 AZHWe8q7dHXTwG4e7DEOesJqlwhDgwqOWcU/2Ve+sS+vw5sgOb6W6cYu+QefZNJz/g
	 NDjMn25G4khWQej7Pp9XOCs/BZuIjZoTtdkddBUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGHHsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:48:25 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46751 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:48:24 -0400
Received: by mail-ej1-f67.google.com with SMTP id p20so49283030ejd.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zry+YVLnJazpbmt6mpkdVvSYbOfVb62kd++eIeoVHS4=;
        b=KSWJHQAWf7P8efzd0BL1J69PcoH2K/QJN8WFjmC8sehRc29WzSHtPF3A1s9Irw4b3x
         kxAwuoE8DoiLLt6kwv7w3zicO0ccuxrtOI/PBw3MiM5oqWEEQnPzz/d4pN2/NqhbWrkm
         OVlechoud+ITq8NHsOefEm3os4feixx04++7a5ovjfTGB6uyAsfoscN0WkiVcDE0+4gX
         hUhAGMpugxfL3w5vHHYT/8ptQPpO6lnRte9s/HAg/OZGL5pRBUK/BIRH1CTqAdaohFL6
         qwXoPms25GegFmOozp4/mAIoJEHcoGpPVSd1WkUvMlsg4weQ6WR/siKm8ggMBj7CwTn+
         y5uQ==
X-Gm-Message-State: AOAM5337Hji15SnpIk7nl5SKdRqP3QblatDT2UswUr9f9Mjr67r5RW8V
        o/fJNDqY0ggxgTo9jWLTz5Q=
X-Google-Smtp-Source: ABdhPJwYTvNQiCzblN90hUL+sRhmBKLa163qzpvJPNOECJZNnioVpqTsfuMIhgfngcwgomaL2jfSMg==
X-Received: by 2002:a17:906:d143:: with SMTP id br3mr48735485ejb.268.1594194502861;
        Wed, 08 Jul 2020 00:48:22 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id ay27sm27136473edb.81.2020.07.08.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:48:21 -0700 (PDT)
Date:   Wed, 8 Jul 2020 09:48:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v4 05/11] mm/migrate: clear __GFP_RECLAIM for THP
 allocation for migration
Message-ID: <20200708074820.GE7271@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20200707114019.GI5913@dhcp22.suse.cz>
 <20200708071916.GD16543@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708071916.GD16543@js1304-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-07-20 16:19:17, Joonsoo Kim wrote:
> On Tue, Jul 07, 2020 at 01:40:19PM +0200, Michal Hocko wrote:
[...]
> Subject: [PATCH] mm/migrate: clear __GFP_RECLAIM for THP allocation for
>  migration
> 
> In migration target allocation functions, THP allocations uses different
> gfp_mask, especially, in regard to the reclaim gfp_mask. There is no
> reason to use different reclaim gfp_mask for each cases and it is
> an obstacle to make a common function in order to clean-up migration
> target allocation functions. This patch fixes this situation by using
> common reclaim gfp_mask for THP allocation.

I would find the following more understandable, feel free to reuse parts
that you like:
"
new_page_nodemask is a migration callback and it tries to use a common
gfp flags for the target page allocation whether it is a base page or a
THP. The later only adds GFP_TRANSHUGE to the given mask. This results
in the allocation being slightly more aggressive than necessary because
the resulting gfp mask will contain also __GFP_RECLAIM_KSWAPD. THP
allocations usually exclude this flag to reduce over eager background
reclaim during a high THP allocation load which has been seen during
large mmaps initialization. There is no indication that this is a
problem for migration as well but theoretically the same might happen
when migrating large mappings to a different node. Make the migration
callback consistent with regular THP allocations.
"

-- 
Michal Hocko
SUSE Labs
