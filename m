Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71500C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B32207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594389787;
	bh=NsGHIumwEJQGZIlIFO01NQYZOuiErljXBYDpyxfaOXc=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
	 References:List-ID:From;
	b=LXbc8I5djGtXAvPDDSnpvxYVR9R3j2BvqyBKVqSPoNKquDZLucHWkYiK1Y88uNbO/
	 o5VARBujypPZVcvJc4/JNtZs6O++9YAzApjD8JOZqb2zR+K3vYGTDuzF0XI3P6Zog/
	 CHzRAVl+hIMXfv6/N2z+2JIhZlb+E1WRk7DM52fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgGJODF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGJODB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:03:01 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45AFE207DF;
        Fri, 10 Jul 2020 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594389781;
        bh=NsGHIumwEJQGZIlIFO01NQYZOuiErljXBYDpyxfaOXc=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
         References:From;
        b=aQ5gK03Z3XoN4vVKNnZdNQlzieSIw0z2N1yoJ3VRBa4K9RozR6l4TayvdWhvl0U2v
         A4pT55XTBYaEK2NpXE+Rt4gkrAdG5+iSL7K2+vWxehq30i2chFSGjbVS9umwtkjmcW
         63YRqbfsvq8gIxrGSJ6p5zr42iGixaGCs9VQrweA=
Date:   Fri, 10 Jul 2020 14:03:00 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>
Cc:     Huang Ying <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/shuffle: don't move pages between zones and don't read garbage memmaps
In-Reply-To: <20200624094741.9918-2-david@redhat.com>
References: <20200624094741.9918-2-david@redhat.com>
Message-Id: <20200710140301.45AFE207DF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: e900a918b098 ("mm: shuffle initial free memory to improve memory-side-cache utilization").

The bot has tested the following trees: v5.7.6, v5.4.49.

v5.7.6: Build OK!
v5.4.49: Failed to apply! Possible dependencies:
    e03d1f78341e8 ("mm/sparse: rename pfn_present() to pfn_in_present_section()")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
