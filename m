Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075AFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EA72176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="1ditQAJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGTIte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgGTItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:49:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D718C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:49:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so19352862ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tfIjuOSIlbet9/U1v7RlPXF9pVVwSHoUTTJkP/5CtL4=;
        b=1ditQAJ73I/pNYNr9SBkH/lg3J1Qh+5+0QLU2qG5EjXLx93eAZkNyUewnNXYvpWeTV
         YV/xN3j/4ZwEboXLMLnGfbfO4xeci2toTl8pyFqkRsxWyA9EvXVVSOr1g0MsPJskesbE
         k4PBkR2Ki4cPOgwtJbVTdk3Ytptep/N0TD+xqYef5fQ4TpfvGgac3p5P8weAUTMEGp4U
         Y3OoaUMDereGfXzrjFTsTAx/m6IYXSgwqVXhD8+qXC4el25pG3pP/FyI1ijaLYrVvkJ4
         Q6ZW4g2LmiRgteBMQu1yFt2zGwm4Px1npRWIIiydszKOm8aq45M/KXVDvuC+19ah2t5P
         6kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tfIjuOSIlbet9/U1v7RlPXF9pVVwSHoUTTJkP/5CtL4=;
        b=J+gxdScPjp4OMEkg2d/A92/p2FsYJ06BlfEBj/dd5bbPYJSFzgzqseqPR9MdKZInS9
         beDk4ys9imz9LqgcgWVkX1UfZPjOSYJq+bcFm3OXfBj2NFJLtLcQEIv7xBb35zixjs36
         6ZpBzGxeMD6sD4svghO5DGuh522EXLZwNXArA/95XdWvkBNK17EtkKOxZLsRCgkAaJEX
         zr3bIoa683bH4FwYtD+8+aLrwN9NVHwmjFmQupZAF4KRqXwMkLr+U49ZYo13/C2zkEMN
         jJJOrwZeyQB7ZXuFOIc2/vOyG3PZSPACQHi9OItAMw4Y5xRK/kEgG0hQ9bS+xuujCEyx
         zu+w==
X-Gm-Message-State: AOAM532W4vZIcQw5oeKhchAbub1w+vLedm+k2/FK/oObisZQyqPLdgr1
        YQ+RXMlPYpsn3zrm+Ec7V1X2DGjLqu4=
X-Google-Smtp-Source: ABdhPJwVNfyMQI2peB7wCDKanVUNIZeNAO0x0vZkGy2DHvW0CnQn7oDgafHuXBtvoqj/4i8RJE1VgQ==
X-Received: by 2002:a2e:8043:: with SMTP id p3mr10427887ljg.469.1595234971531;
        Mon, 20 Jul 2020 01:49:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y2sm3653160lfh.1.2020.07.20.01.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:49:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2ED97102393; Mon, 20 Jul 2020 11:49:31 +0300 (+03)
Date:   Mon, 20 Jul 2020 11:49:31 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>
Subject: Re: [PATCH v16 14/22] mm/thp: add tail pages into lru anyway in
 split_huge_page()
Message-ID: <20200720084931.jusstogio6j74uhs@box>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-15-git-send-email-alex.shi@linux.alibaba.com>
 <d478a44b-c598-e99b-d438-9387f208ad37@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d478a44b-c598-e99b-d438-9387f208ad37@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 05:30:27PM +0800, Alex Shi wrote:
> 
> Add a VM_WARN_ON for tracking. and updated comments for the code.
> 
> Thanks
> 
> ---
> From f1381a1547625a6521777bf9235823d8fbd00dac Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Fri, 10 Jul 2020 16:54:37 +0800
> Subject: [PATCH v16 14/22] mm/thp: add tail pages into lru anyway in
>  split_huge_page()
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Split_huge_page() must start with PageLRU(head), and we are holding the
> lru_lock here. If the head was cleared lru bit unexpected, tracking it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
