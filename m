Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB4AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9076920721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="etNjUDmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405456AbgE1RQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405372AbgE1RQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:16:13 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EADC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:16:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g18so629914qtu.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=atthkvZPtmuffgqI3U1N92nhhfohScsuYraFPx1a33w=;
        b=etNjUDmYG/GoUh6tlvW65FzID7MhbLN6fmu5w4+qhKKoJPNlpoymnwadrQfmgoqUiQ
         lRYk6V4zjlAp1JoiKlZG7EnTqD9m/LUK2LUxhTjK6XSYT1Qm5Wm13M/uiw0pbGdyJz84
         G4lqCSxJgN5+v+05NyelPzHo0kpcv6Ih5o4w6a6n68b318tTQF7/zNt8STf2OTad3Cx6
         c+5+5OIB9NVG04+b0XA4N+rWS376QGJKQC45cnbq29In09VIZYjftadLqnIw8Jro0HHB
         Uzpsy0cJlADEg5EH40MR2pIpshdxFwaahEEMvaLa2M1R8R0GrhmwOUGvKvbY4ZaT5aVC
         /H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atthkvZPtmuffgqI3U1N92nhhfohScsuYraFPx1a33w=;
        b=kSSh/MbuZMsb2IK9sZVZeftT+xuSl8GdfPFBUyHt24cgG3m4LHfQrbjf97BYErxXVi
         P9w8jRHoFvZnEs6USmMBtqbRcz25qcRpbpkP+PTx7inxC0l6GCXcswTzhwx22w89sLt3
         6Np4XYqivgiRDBIyvHjpt2B7DYwk6hlq+xQ0ju0VjiA6F/HCAM1HADaH2NeIjcxCY6hJ
         p5/nO40orAQks9ZEHL9nFS4TGrBsVs8UDfawR8Zlc/JKVKISgWxcy/C4zWbm3DAcUZ81
         6YRSXSNJae2+Qkss4Sp4xqUhfGOxwZs+hZjqO2DzIPRHUqX5+WZgHSFcs/IzPQaVcEGH
         n09Q==
X-Gm-Message-State: AOAM530dEngKWJZ9dYtF1M5FY5c/ns5x153tcZJOCbQKJOYM+8vDmdK/
        FC1KaZPB9em3c9hzwYf2SaeL3g==
X-Google-Smtp-Source: ABdhPJwCS97f+Iq6+tL1/KnrLqj2AxEmCpMkEGzROblPiVDpZcR44Tj9rcHcOqb5SgmD+uPHIgwdJg==
X-Received: by 2002:ac8:7112:: with SMTP id z18mr4329049qto.274.1590686171203;
        Thu, 28 May 2020 10:16:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id 10sm5614427qkv.136.2020.05.28.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 10:16:10 -0700 (PDT)
Date:   Thu, 28 May 2020 13:15:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix an unused-function warning
Message-ID: <20200528171543.GB69521@cmpxchg.org>
References: <20200528095640.151454-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528095640.151454-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:56:26AM +0200, Arnd Bergmann wrote:
> On NOMMU kernels without CONFIG_MEMCG_KMEM, we now get a harmless
> warning about an unused function:
> 
> mm/memcontrol.c:2595:13: error: unused function 'cancel_charge' [-Werror,-Wunused-function]
> 
> Hide this function in a matching #ifdef.
> 
> Fixes: 5bd144bf764c ("mm: memcontrol: drop unused try/commit/cancel charge API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Arnd!
