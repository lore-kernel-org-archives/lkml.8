Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB409C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7338C222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579099594;
	bh=ONKtgCd1Ee7gDwqFBM5X7wb+Ew29uYw9hnWkbetDzh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iB1BBEJV6jczchTS0ex5FW4eBxW5NR6Xz04EJ2pTMYRrbi+5MHMAURUg8uAnMVE9G
	 uL7crtqkVfkUg62EO6son7biyeAd5B1kmXg4IDBFBlUvGzWqAi1MACGzh9vvci6sHf
	 k8IE1zyAWMcRqQr0Ahv4eXOVSTcbePY9qYq1yZJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAOOqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:46:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54537 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgAOOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:46:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so121545wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1ihlJxSMXD6WCn9ytjlwpvSulRqTRbie1gLYg4oqfak=;
        b=kI5kD5x8F8OVGfw5WMBErCdmuiNeRAOHsBy9hYfcroN2DnbfzJdjq3QEzN3qJSJ6f7
         tavoq3MAUARHJLfZnudtasdIqBTNW7K7VVglGDiOlmdYFfAtg/9UseZyCd/39Cz+r0SO
         3mgnJ6+UuO4dUiKwtGnRVA6S+BOigf1xRANd9B16jOkHXrPKfGp5Ryha5AhxxazN4+7a
         2XmPkzEbEP3SXmg1LQKp/MDdJxyvW3i541xDR1WUBf5lCbcU2pjJa5Ae3Jj2iWg3dweW
         +21N0sQufbmQp+KuSRRM7vTFcHWf8sCctsAipdc2oXtUH9JsPrYjuSKkBN01kN7iIB1K
         XivA==
X-Gm-Message-State: APjAAAXZXmOtqJmbz7kWkIh1TbiuvHIHV1/S6e8wMYgz1DZdkxxMDLGn
        ZJ4zhvNeOt1g33VqKLondO4=
X-Google-Smtp-Source: APXvYqx3h4N9YUl0YcYyI4yYQlqoeuwjUK+bi8ae7B9X1eP0yz0+lcAoIkTIqhEDDcTnz4LfX/U+xg==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr146422wma.34.1579099591698;
        Wed, 15 Jan 2020 06:46:31 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a1sm39823wmj.40.2020.01.15.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:46:30 -0800 (PST)
Date:   Wed, 15 Jan 2020 15:46:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH -next v2] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200115144629.GG19428@dhcp22.suse.cz>
References: <20200115092221.GX19428@dhcp22.suse.cz>
 <39D75B58-A5CE-4837-BCD3-8026E2C88861@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39D75B58-A5CE-4837-BCD3-8026E2C88861@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-01-20 07:35:45, Qian Cai wrote:
> 
> 
> > On Jan 15, 2020, at 4:22 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Is this correct? CMA pages cannot be comound?
> 
> I never saw a CMA page also a compound page. Also, in
> alloc_contig_range(), it calls migrate_pages()—>
> unmap_and_move_huge_page() which will free the old huge page, so I
> think that will clear pageCompound.

This sounds like the implementation detail. I do not think you want to
depend on that. Anyway, see my other response. If you rebase on top of
Vlastimil's patch you do not really have to care.
-- 
Michal Hocko
SUSE Labs
