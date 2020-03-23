Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A3C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798262072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="K4+MbrGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgCWRSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:18:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36444 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbgCWRSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:18:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id d11so16128658qko.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=orTSxsMJ+JQ9HjvxGEhoTIMaWd3DHC8NKnugPwQWsqg=;
        b=K4+MbrGHFGuHITXcZmfSbETYyufstpJ5KQ+95cbaiC4I5FADSQf+3tSYpqK5VyeIZJ
         0d63o1ZAJhYG5qmQTjx+USByr6wt/1fVEXd2K5rKX8gnBzUxJvtJgOfLRagZjzjuSXWA
         Lnnk5vWNy4D6TuyzWpzzu6roTer8tQRU3VRxH+Vt+ICSFejuqGCPK5QB4FkJino0BTQ8
         sag9IsqsG+8gfE07Dby0U3hx/FtAnKXnVbAEOGyTQObkxLyaSmnEYTezvmo+xtryR37J
         kJduixZHSA9EPFgbMEZSSGaGz8De4Iwxa0TpqgT6wVZV9RNhRb+hFupywuy+lwKWYpRv
         Ufhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=orTSxsMJ+JQ9HjvxGEhoTIMaWd3DHC8NKnugPwQWsqg=;
        b=KrEglUAlB1M0acY8q9UO1/zzA7zgWrRM6KgwqPyZN6YM8R8qRtSpbwctxFm/UDOBvk
         tZ1a/B2WK/dUUPu9TPBEnSZ3A65/5QJSwjWyWLnwyXqmFGOaXQTC2wRAdtxNoxp1UpmC
         xLcWMWOFIsQ2aZhUqQVgKuMXbLsu5OEcFsaN4dUbbV4l0zZR472UM8sHloiCAKF+r4/0
         ae+ZDhpg7dYj4AytfPvy/ft5ffBrRnrvU8tqBqAFiwCQBb1+5lKTELKHcUlxLy3/VENY
         mn54T8PpObSFp5j50ffmZmbhTbg1dLuC1OU1SKPRBHDw/SiGGKlYsCc6oKy5VOtXETB5
         GvWQ==
X-Gm-Message-State: ANhLgQ2qDVXe9apWxjl5BD/5KXpoQvf1M9fa6NXmURO76K8yciaaIL/t
        hHcuv+pv/SV6aUT1Fu79rP+HINFy2B8=
X-Google-Smtp-Source: ADFU+vsYPf+fXgT6ZuHuU3lcMfcEPd0PZ+KxTAojHcRPn9Q/2+2/XOsEcYkP1rycNzuLXnwkx9DXlA==
X-Received: by 2002:a37:4fd0:: with SMTP id d199mr6411014qkb.121.1584983891789;
        Mon, 23 Mar 2020 10:18:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id 79sm11259334qkg.38.2020.03.23.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:18:10 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:18:09 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 7/8] mm/vmscan: restore active/inactive ratio for
 anonymous LRU
Message-ID: <20200323171809.GE204561@cmpxchg.org>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-8-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584942732-2184-8-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:52:11PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Now, workingset detection is implemented for anonymous LRU.
> We don't have to worry about the misfound for workingset due to
> the ratio of active/inactive. Let's restore the ratio.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
