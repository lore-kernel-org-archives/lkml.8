Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6085C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F3920756
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="ah7RmwWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgEVQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgEVQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:06:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF43CC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:06:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f5so2079816wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtbmX0dyqTdFrd4tlTLyqr9RkMznchbfW/cN9uktbsE=;
        b=ah7RmwWxN9q7dxKf+gAuYNWjx6K6QPOaXvntt2YUcRn9h4NJFUGvkk1Ac/sTaqPucC
         brS1J2kyueAkaOOEsl7Jt5j1lSuy9e7MxolKLydJzGOCfm7pV2Itel7DowMiX6eBqwaW
         P6lIrkxT5Q6m19lxPitR+Wqn0NwtVXgOXDtfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtbmX0dyqTdFrd4tlTLyqr9RkMznchbfW/cN9uktbsE=;
        b=N+nRklw9/09seheGEjmV24LWZDA+Wc3xeH8xGdiNAPN+Zhree2lVAY7DuSRhIPboRf
         Z0cYGjI5h97EK9LT02gnEgK4KGzQqOHqmm4uheQIEVxjgSg30VSDDXcxScWq6LLZss1l
         J4osx5GPiLsVGXWmKHMxF1R9a6Uwaon+WdbFRjxxqkkduyHbV+oHjp78pVIJ16OVodBA
         +A9WtsxuEz/N1aBNLFLR463JnnUu2xZqpFN23ejlgCha17eMM1uLMpCN/CoZkyV8j/tj
         NjaXjoDeTZs/vnPI6Kb6aLP0Fp4pr7K4LPqhlpu4I0mx+Cyys4kERnvwHTiWsR7qRoFL
         Vjfw==
X-Gm-Message-State: AOAM532Oe0DtnTA8QI2Jb525VvPJqPcsbqC2P/4tCioA+TSuu6pTDaxL
        +j+EgkEsmtFmtrJ2eAlQCA3+jA==
X-Google-Smtp-Source: ABdhPJygEawD/lJudaTltpgXyXjT5L0fi1Rd5uEVjbbJe1bbL0UYGwlL+SuYBnoIwxkETsDzoBuWtg==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr14490673wma.170.1590163587553;
        Fri, 22 May 2020 09:06:27 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id n9sm9514256wrv.43.2020.05.22.09.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 09:06:26 -0700 (PDT)
Date:   Fri, 22 May 2020 17:06:26 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
Message-ID: <20200522160626.GB1112005@chrisdown.name>
References: <20200505084127.12923-1-laoar.shao@gmail.com>
 <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com>
 <CALOAHbBTt1pMo0kwheWqPfU7RTXcDHWJ-x8=5mpw327uiy2qzA@mail.gmail.com>
 <CA+G9fYtmpjunUetTmf2yquB1rwZA+nnWOiueWbAMx483c0wUvQ@mail.gmail.com>
 <CALOAHbCdXrU1AeLd4pWubutuG6HP4xKvxRkXeOv=sd_MMW58rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALOAHbCdXrU1AeLd4pWubutuG6HP4xKvxRkXeOv=sd_MMW58rg@mail.gmail.com>
User-Agent: Mutt/1.14.1 (2020-05-03)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yafang Shao writes:
>I will do it.
>If no one has objection to my proposal, I will send it tomorrow.

If the fixup patch works, just send that. Otherwise, sure.
