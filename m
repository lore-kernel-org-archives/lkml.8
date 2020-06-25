Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B4DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F020781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593086073;
	bh=sXbH6CdpIzVrlqFVihXEftwDkL13+L7YnWTkDkKQzxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DhXzu1ksN+Rr2ROAc3tnDfy4JKlstb3lwLFI+Vd4i/dgdw/LI1wfvjQ2kIFXqZIgF
	 Z3i2TwLvFVHjeWu8FveKbWNnVmt5lb+8Y8gBauC4h8ogqoTXjhXFh9zzUBdrsGWQtC
	 18vU7BRplGCWPqyihdYxGUwa53gTy3rabwNeNfWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404568AbgFYLyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:54:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38249 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404309AbgFYLyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:54:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id z13so5538980wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KkyD/dCsP/NUyZaxekBryRpKElEY0AMZnqKJIyE/Nxc=;
        b=sUqI7NK/ZR0XRHyyzmFwa5pyDam8t01P9eP0aTCYR90//sGVE5k+cW6is5834+E8ag
         Eb88vcrLJdMZuVcgiEtUwMiiYfaw8DHS3IvGxsJ7lAsoiMciWOHF9A9SN8nmPp54SBY6
         hanQUMuzvWdPmypuJlde4Rm8UTH90ZcLKve0EQ671jCgy/SeM2x8y9HOmK40BtktZsqK
         aXRZRU3MwWvYWO/unAzOvHRDeEhYcRwAikgkPevVu0O3G8v9aSdd6UK37x/KXHLa9jLK
         q7WiZNWETxzBhXBiAFgGJ1c8Rbbc/cwhGcaxW57epiDCErU4y8WNZfpFlL1insDXvxJw
         ou4g==
X-Gm-Message-State: AOAM5324V2Jc1PaCVkt4ktfaekQ3xoTH07W45yWvfV/9i/Olim5I4PND
        4pBEfIiA9dc779D8NwSo2lQ=
X-Google-Smtp-Source: ABdhPJyYLIWJ0qs3W4JrMU6uNxO0FsVfTw5Yn+cvRovv5F4hHCwbE+Gqtjc0S2QRJWZvDM7N0AXVnw==
X-Received: by 2002:a05:6000:111:: with SMTP id o17mr11435758wrx.178.1593086063961;
        Thu, 25 Jun 2020 04:54:23 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id u84sm8646313wme.42.2020.06.25.04.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:54:23 -0700 (PDT)
Date:   Thu, 25 Jun 2020 13:54:22 +0200
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
Subject: Re: [PATCH v3 4/8] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200625115422.GE1320@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-06-20 15:13:44, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> new_non_cma_page() in gup.c which try to allocate migration target page
> requires to allocate the new page that is not on the CMA area.
> new_non_cma_page() implements it by removing __GFP_MOVABLE flag. This way
> works well for THP page or normal page but not for hugetlb page.

Could you explain why? I mean why cannot you simply remove __GFP_MOVABLE
flag when calling alloc_huge_page_nodemask and check for it in dequeue
path?

Your current calling convention doesn't allow that but as I've said in
the reply to previous patch this should be changed and then it would
make this one easier as well unless I am missing something.
-- 
Michal Hocko
SUSE Labs
