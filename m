Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD3B20829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="HG4WQqEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHMP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMP1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:27:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2418C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:27:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d14so5477214qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G9xj0y6YeO21IlkG6XCM+8OPoUpTIPBGk2H9BHdLfSg=;
        b=HG4WQqEJcLlVKhUoZ+ZzL2ku31xqzCdktta2BUIcGHOHeXS2x+Z+bpSKozf/uKsSU6
         nH7FjwY8wREbLLxUQ0XutkdGbEKbrqq2maifB1FgpRjn0gi4ASzmNZTkeAoeONFbjGSK
         AMrXPvoE5cT0o0gmAciyEZSK5xawGLw+Qq7J6orOfK2N8RSPMApEKs3SQ6RnOIxcXOPO
         yJESYqBLxp2AeIhjY9Khe6Xzs/ORGoGruEctyh3JEfGl8DGxJk/Xe6vxtlES6FOFF7uD
         7L6Df9CYLSzw/igPnf62aobisTPa7qmceeUvn5HRLK8QZwqNHxCHgcSZtMeO6prczf3v
         GFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G9xj0y6YeO21IlkG6XCM+8OPoUpTIPBGk2H9BHdLfSg=;
        b=S/ccpsVNoAZj4sJQm4QHEugLtWJ2oQwt6AkpZeNjt1Eh46w8jIyYFE1OM4lfwb2mwW
         d5Nlrf0RputRazhuxQIXdKO44h3VhdRVHnLJ/76xC76Q3JrYYrFYIHij2McTU89zYJPt
         37zmxd1c7AZk756CB8LSstyHOQVXfxq8mCQL8/kkdbXsEp0vCkJ+CPwBpuRoJkNWNn/j
         remLEQZ3u0O77hSc6LnliMeJ5MC54MKvDwDY/yndMN0f083tZUiGx2U8NoMQ2vb2YBvv
         7Lx1VWHDuG65tayY/nUgvpK0P86Fem1XLaXAMNIQjOD9bXnwb5TIJQY8hoD0pA/ta1jv
         7PIQ==
X-Gm-Message-State: AOAM533RuxrR9WCUcbN+vKB9K3fy96HV92zPiikcL1H1iZzeTGj2CXm5
        OjF5jOjntMeZ9pTT0LbAhxKf6g==
X-Google-Smtp-Source: ABdhPJzR1UcCuoUmRFqwdqkJEoSmaPgweCv6fOxpFKvhmjozMwxU2Pt3O9TcNKReAtBXHTwq7sUN1g==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr5037864qke.289.1597332460693;
        Thu, 13 Aug 2020 08:27:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:7cdc])
        by smtp.gmail.com with ESMTPSA id n184sm5795880qkn.49.2020.08.13.08.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:27:40 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:26:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     syzbot <syzbot+35d35ef677516d65bdda@syzkaller.appspotmail.com>,
        Roman Gushchin <guro@fb.com>, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
Subject: Re: upstream boot error: WARNING in mem_cgroup_css_alloc
Message-ID: <20200813152634.GB701678@cmpxchg.org>
References: <00000000000019317f05acbf31bd@google.com>
 <20200813104416.GE9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813104416.GE9477@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:44:16PM +0200, Michal Hocko wrote:
> This smells like 3e38e0aaca9e ("mm: memcg: charge memcg percpu memory to
> the parent cgroup").

I just replied to the other thread on this issue here:

https://lore.kernel.org/lkml/20200813152033.GA701678@cmpxchg.org/
