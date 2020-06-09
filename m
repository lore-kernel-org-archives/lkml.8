Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3731DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0536B20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591711466;
	bh=1RH/FbEqgcKqWW/LKiigR0IqoUKTNDj73rs+MeuYx9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yiqo1s9/WmvgHgAj2t827LB6v3QnVfee9OWrdz0NG8bPFMw1UqBYnWYSWXETqMKKz
	 2zoflarmE5zZxoAKyIBWflvRu6qNIuJCSIECTIh97VqB0xs6rYf+EMRmwW+E4uuME1
	 +trtsxJrV5472Vz93rItxQ2UbE/eZB3js7C7ktdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgFIOEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:04:24 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:35673 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgFIOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:04:22 -0400
Received: by mail-ej1-f66.google.com with SMTP id y13so22524470eju.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 07:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rADE/GPer5pfmlG1o046PpkI8Ugu5r7+dgrjwwvPKsw=;
        b=nG6/g0nGHwzPfr+5/xMVb+ZGbxqe7tQ2ePW27CIkUiTQcQWj3kj43amiqdC616X+PC
         WcHZwxvsjl0t6p3QZWRZ9+cW2L96NdzRo5FFssKgdQnRKafrD685Hwy51TkMNwvyg53E
         RNH8HA5b1e4O8Og9JwjSMHe6Wnn5nSSLSL7lOzy22QTfXqA0BYZLkDrOgaPPvOoYe1ZT
         bBMsrQ7hMGO/5l0SRlZoAdsXqv2ZQx4NWULok8GF1KM4jHIh8NcbdjzOkHwzyoOEfFuT
         Fojj/kGBbHqZ6GwcP6SarBodjOn3lnxYpilpHKqJV0ORcqAIUouFgz5RP+aojg+j2A0a
         7sYw==
X-Gm-Message-State: AOAM530LFP1Dw18Z768q94oo1inrix0qSIF3vOQwYn0m33WGaSjv9AIG
        JzGx3LaX/P71udwYyq/S6YEWhyWN
X-Google-Smtp-Source: ABdhPJye3E4nF9Tfgq0sYEhkY/VSEO4GQ036arOykcbaFKSmVp+Ky5eyQGTAiB8RhWhxG/9yKBVBCw==
X-Received: by 2002:a17:906:dbda:: with SMTP id yc26mr18056921ejb.82.1591711460158;
        Tue, 09 Jun 2020 07:04:20 -0700 (PDT)
Received: from localhost (ip-37-188-174-195.eurotel.cz. [37.188.174.195])
        by smtp.gmail.com with ESMTPSA id cx13sm15237750edb.20.2020.06.09.07.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 07:04:19 -0700 (PDT)
Date:   Tue, 9 Jun 2020 16:04:18 +0200
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
Subject: Re: [PATCH v2 08/12] mm/migrate: change the interface of the
 migration target alloc/free functions
Message-ID: <20200609140418.GJ22623@dhcp22.suse.cz>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-9-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590561903-13186-9-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-05-20 15:44:59, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> To prepare unifying duplicated functions in following patches, this patch
> changes the interface of the migration target alloc/free functions.
> Functions now use struct alloc_control as an argument.

It also pulls private argument into alloc_control and keeps it that way.
Wouldn't it be better to use explicit types and names in a union? Each
allocation callback has to understant the meaning anyway. I would
consider the resulting code cleaner that way. What do you think?
-- 
Michal Hocko
SUSE Labs
