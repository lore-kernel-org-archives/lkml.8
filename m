Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEDDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB5922B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="e6djTCYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgGTIny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:43:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D94C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:43:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so19314260ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ktede3490cF8xrICApRVvg9tnZvpytnPociFCS3lvDc=;
        b=e6djTCYWEj2Fmi95lUFWKgkZcJHCyeTSf7Syl643UoYLetz7sglV0iZEAzz9bdhAWy
         AV2kduveWFWI+JWAlK2oNtidKKo/CEuAaKD0MJ5Pp2tRK5UEZOnqUQB+URJ8qpBiS3E0
         7BLXT/fa/imiZu0Qgtj10PZL/JBmO+Pz1dtSqFtftbPH5ryJlZX1B4ohWJEXiBEEvDCm
         QXR5JmQwVkqYm8SkgaPhzlXf0D9fpQhWmfdlnKXyWsNJSVXFpVk2mp2087rkuizdb6pR
         gp9yJayr7YSyuNloyVlOeoyOmDejlgs1239X59/cPzNKO7ss8eXDNgChuv/x7qWhxATI
         9lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktede3490cF8xrICApRVvg9tnZvpytnPociFCS3lvDc=;
        b=CMHRftXflLOZh5dK2SxGbPhDS9ng+zvGXqGrDnI8Ujwjn9XUVU1zzFPmnVA4P9RBzq
         y6JBs6GJY5ykj6vDj0IjwpdpukBqPSEqQtUglVSwPajCu52gsQbiY2iF1p5Tzgc7fNSe
         VzrSDh+nqSwBygA1bcpsF8edVasJfzzx14FfQEwliCqIo3/j8ofws9PtSwrgP8x2xWv1
         Yhmr2H7nLiOTEbWz6clKJre3pqn0R2k49CNXMUZqtW8xrARK7UOReGkixHuWyPNcRsYt
         ULpH4oPmBP1UABVUR4wylZ6iQ9EB9b8sV89jiWStPbld3ZqldDGusQI7eAKAIGDSznjM
         noPQ==
X-Gm-Message-State: AOAM533Mq7MIrPORP/nexjmGqMWYUXXBrlrLc3LwtsUkGl418XLX9s98
        8BSPZJlAnYEhF/sk/RQQXD1pZg==
X-Google-Smtp-Source: ABdhPJxDpc+xGL9gCU4hB6aJTaR2Pfe9WrNdwYB5SAzencPCUUdqx2ZecSSoIxaZ/WyEMlHA9/Z3Zg==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr9133434ljm.116.1595234632369;
        Mon, 20 Jul 2020 01:43:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s62sm3101085lja.100.2020.07.20.01.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:43:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E7866102393; Mon, 20 Jul 2020 11:43:51 +0300 (+03)
Date:   Mon, 20 Jul 2020 11:43:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v16 06/22] mm/thp: clean up lru_add_page_tail
Message-ID: <20200720084351.v3skr3pluudy6fer@box>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-7-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594429136-20002-7-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 08:58:40AM +0800, Alex Shi wrote:
> Since the first parameter is only used by head page, it's better to make
> it explicit.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
