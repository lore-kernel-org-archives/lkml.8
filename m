Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5817C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01C420885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="B0zXn8r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgHTR2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbgHTR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:28:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543CDC061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:28:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so1754150qts.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGSTy2S11pQaFof1yGnLyVAv1YOvYkkwg2xvJjtqeUQ=;
        b=B0zXn8r/1mchT7VpWpZ+mN4JB+LQTOAcThKwvNYAguEIUDOZHwwTrdR6gzmQZ5tubZ
         nadwJJP0FhhTUc6qtozlaIcQuD/FFdRoOqCSSFPC20808u50MokVC+zzcj74bSNK3564
         K2rPaPV6/LqFSt2EYvyidWPeBNnkH5k+UUHnDDp7LsHM+QUZl4RIfl0sMDasq2fgoDTh
         aEiFbkQ9IhmoLjkYAaQc2VPQYaxtLY7ONExn+cDWgW0LH7qwa/cgM2WtSkYRhS29jGEn
         +HZQ+jI+GqR+PBIfIjicJ0wnOj2ML6oSYHPVNMYabbRVYTlqLboSPlY8YiNQkmtdg/2E
         7wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGSTy2S11pQaFof1yGnLyVAv1YOvYkkwg2xvJjtqeUQ=;
        b=SEdaBxZlZUkg41PaAlPREptAb/bdmTSSxuK366r/OWIArB54eaW1hJozTU055rxMbF
         eAORcr/OQffWBcHbV2IZcC1mEQZgsQ9Zybkm1TS27JVLMdZSZrj8tG7+aVeJQAv5WSkg
         Socegeoolz5sn3nub9VUwgaQB1t0uuiwOeiictXKyI6PbD5G7HfRkohqEMdoFKwjpsCf
         FZVRL4fruDtAORzrs23S9lcxjFCP5NI16ziBTupmTZBsMXHHm5HKB9G0bv8KTA2faW4W
         uPQyCepWszT02RJS84UcdBEuaNPU0csXf2Xq9eG0RWEsTM44oqxV9EnesMDTrs3XLcn8
         NCpg==
X-Gm-Message-State: AOAM533OkkgI0gc2Z00Y7I1LqYrqsVXogsitR6iw+JzkJZ1x00qpXMyx
        sKLZFmXx5lwPmD8pOpKqqT4EWg==
X-Google-Smtp-Source: ABdhPJzxECzP6spyILQOPgtHzJiSltg/hxxoXq1qcxUwEjRfqOCr081RyncGF5PD5joh3rhL7RCH+w==
X-Received: by 2002:ac8:7c87:: with SMTP id y7mr3692080qtv.375.1597944521618;
        Thu, 20 Aug 2020 10:28:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3cdd])
        by smtp.gmail.com with ESMTPSA id r188sm2708541qkb.122.2020.08.20.10.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:28:40 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:27:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 1/3] mm/memcg: Clean up obsolete enum charge_type
Message-ID: <20200820172726.GA912520@cmpxchg.org>
References: <20200820130350.3211-1-longman@redhat.com>
 <20200820130350.3211-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820130350.3211-2-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:03:48AM -0400, Waiman Long wrote:
> Since commit 0a31bc97c80c ("mm: memcontrol: rewrite uncharge API") and
> commit 00501b531c47 ("mm: memcontrol: rewrite charge API") in v3.17, the
> enum charge_type was no longer used anywhere. However, the enum itself
> was not removed at that time. Remove the obsolete enum charge_type now.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
