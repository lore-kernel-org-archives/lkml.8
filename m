Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CED8C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3870F22202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcg6gDxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgDQTBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDQTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:01:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C540C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:01:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id ay1so1307528plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fgsuV0uPrbMuuU+FIoyTnHiSv5/v5k3Bt0qEvULb1Fg=;
        b=gcg6gDxYLiUWROEJVYRTQhxHQJFHIqUhJKq3AHDhVB+rfx5orCalbTMhl1Ob/rH8H7
         +FWAvyrdG7fktuE6BHhgbcmVBpkw6c3k7yrAPa2k8Q+GHaABH7VJ7qOzfRkK+oNVqb6Y
         t8cqcCrWqVesbxIxSFU2VXPqzZxQS+HF0EsNCvFjDgr0pjq/KIDgujCenCR/eIb/n9mt
         4HSTXCw7/xgTb75TTIRVlFC1fMwZMW0PV0c3o8Cilcso/dY64zSeRvltPIIb37qjfIEC
         IhQmvip3RUD2kTk6ow8qWAMUqqBKuw2oVE0I5o0vLJyZEkiUMQ5MiUqUdxTleXhiiuO3
         MBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fgsuV0uPrbMuuU+FIoyTnHiSv5/v5k3Bt0qEvULb1Fg=;
        b=cbZ4NztX2UtWyr/sddG654b+5roQInOD6T885s85GXUJ5PumJEvMJfXDz/Ac1BAPUJ
         p3A8yfQnE/VfjJfd6FPjiKYHxJMInMN/fEoaUR2xSaG/v8cOO/o/FpiEwEIspTgdG8ds
         nxVE9J4ZfdtwCU+z/Uk4fM1wj3V7moZsOfWT/fs3LQHWdzM2ZMtzcxm8NXl0/SFQJrEY
         7+ysi5V2kk35yeCRmX8U/OIbGn9UEAHOUh84RpXnEadP6ErpRNgfO10nU7nlQmPF13zS
         wc1YnBwytwATYlEcQcHxiRCLOtxG27EeMwAP3x/wwx9/+gVTgADHXdaJL8RAhLnbj+5r
         eUxg==
X-Gm-Message-State: AGi0Pub+yJfX8Un6vebp/HYI2Fhze41iMvXUOtDjZ71iI7WDiimOYKjh
        D+pCbYFVv6do1PEzs+ck3HBuGA==
X-Google-Smtp-Source: APiQypJLSj37Xbhq5R/D+izZU9NClvPpafZDgHcUWI/RsLrHOblQ23UZqc+k/Nqu8BIbGavsK1dzKw==
X-Received: by 2002:a17:90b:1989:: with SMTP id mv9mr5900830pjb.70.1587150103744;
        Fri, 17 Apr 2020 12:01:43 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n24sm7296697pgh.85.2020.04.17.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:01:42 -0700 (PDT)
Date:   Fri, 17 Apr 2020 12:01:42 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     js1304@gmail.com
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Baoquan He <bhe@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v5 2/2] mm/page_alloc: integrate classzone_idx and
 high_zoneidx
In-Reply-To: <1587095923-7515-3-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.DEB.2.22.394.2004171201310.89859@chino.kir.corp.google.com>
References: <1587095923-7515-1-git-send-email-iamjoonsoo.kim@lge.com> <1587095923-7515-3-git-send-email-iamjoonsoo.kim@lge.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, js1304@gmail.com wrote:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> classzone_idx is just different name for high_zoneidx now.
> So, integrate them and add some comment to struct alloc_context
> in order to reduce future confusion about the meaning of this variable.
> 
> The accessor, ac_classzone_idx() is also removed since it isn't needed
> after integration.
> 
> In addition to integration, this patch also renames high_zoneidx
> to highest_zoneidx since it represents more precise meaning.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: David Rientjes <rientjes@google.com>
