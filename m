Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1089C3F2DA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E412072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="o3YE+cY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgCERW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:22:57 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52955 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCERW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:22:56 -0500
Received: by mail-pj1-f68.google.com with SMTP id lt1so2763310pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fYgwNPn+hzRISUrcnyS4RtnmnpZ3Kb0VaVci8GbrKTU=;
        b=o3YE+cY0AMvX9FIW61axswC5hLklVI8JTAIAQgcBVazuzotTqc/h+Pg/g6abfRuyzX
         4tXglOcKGcpc3Vagoluun7pQ18V4NCAMAXN4KVIey9I3n/1BsqLmzHVTuYyPZDoMVbS9
         GO/1VbUKbSM4tglRQh3iDgaRKj9fi/5oH2waIvdNhUu7AFyImdXwXpx21mwDy2i4i583
         gsNE50sIgAG7q8VTCuKUIRa9C0XTWAXjU/lPN0+zsdp6Mhxfvpxo9x0ciDBWiSofPoLW
         XYl/9twPKE5N9aeDYfS3VDDx0eVriYJZRqtpPPdiX7+DsxzXzILz+SDuaSXU9Xn3dwjf
         PB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fYgwNPn+hzRISUrcnyS4RtnmnpZ3Kb0VaVci8GbrKTU=;
        b=e5qBgvG3pjkcHziZd/qL5JK2bsmwTm8gMTpo0m23xE30zicoxT4X+YfK76axvV4L3E
         Trogr6yW0cY6mqC4Mn6mowOWMaXKHJXMbTjwOWHxlxWJXc7AWtkAxsTbeTAQl/QlpiVy
         7qUmGpBlgEvHH+wYaN+Qwr9ranD5AsQLcxgkQJhTmqCL5r8Xibet3Mn7CC1FCu2T/MjU
         Uwfr2zzxpCN3V9wx2kuhnO8srE/h7Y11z/eGDlMipSkZPdBrUbDuLh+zCpc6PqOuwTLf
         rvPVK0QLZoY6axHoUcTMufYMEqJk69jAiOnOUmnM+9uAQKaCA5Iw+U7/zblhjXCieHQM
         RffA==
X-Gm-Message-State: ANhLgQ0yMRb8fnUGSUuu5z35rMEsH6fXNNNJo0kwXXcK591aTKKTcSGe
        zUq9EI+UhzfkHNvetW+IHe9WNw==
X-Google-Smtp-Source: ADFU+vu5hq4I0Ryc8m9cr+fBrdw4pFYXc4hKs8nOlBf+e8bunC7kkHnRLwz1LIohkT6ORGzit+5H6g==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr10057159pjq.47.1583428974706;
        Thu, 05 Mar 2020 09:22:54 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:6216])
        by smtp.gmail.com with ESMTPSA id 9sm28532487pge.65.2020.03.05.09.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:22:53 -0800 (PST)
Date:   Thu, 5 Mar 2020 12:22:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: Make mem_cgroup_id_get_many() __maybe_unused
Message-ID: <20200305172248.GB2508@cmpxchg.org>
References: <20200305164354.48147-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305164354.48147-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:43:54PM +0000, Vincenzo Frascino wrote:
> mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
> configuration options are enabled. Having them disabled triggers the
> following warning at compile time:
> 
> linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
> but not used [-Wunused-function]
>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
>  int n)
> 
> Make mem_cgroup_id_get_many() __maybe_unused to address the issue.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Vincenzo.
