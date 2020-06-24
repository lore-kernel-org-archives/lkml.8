Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EE2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551C120702
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vseo1ugw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406231AbgFXTuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406135AbgFXTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:50:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16CCC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:50:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so3939304ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Mj/yGW8ONhMxbR5CzLVYmCwJL3rVsa9cPjWbMT8ulQ=;
        b=vseo1ugwSe07vU6fNV+JbKP9by/udSjVA5IT0zkPX7pFiMBPaFBYaWQ8WB848kLusW
         zTm3R7GgTQVkhLJx+TNR9JZ+kngWxts6hqUjaVpjlO4Yo9fe1euCzE8EuytjCFAAwJzD
         dGnsX68/9ZmKzLcOYeXJZ/uS85JEbAC4q8tz7CSz5vR9BNnr6e/Wn1o+1h+BgMi+kY9H
         KyyMManllNA83kr1JJ16gZZQWrtDF7rCl+zxeDbbj7ebibXRwJIIkF8Pe6rsAlxg8Ews
         ovfSU643OKssf1/3HwOFOT7Mc+kiN4g/r99hjZi9uHAEQiW4kFEgX9pWmcJ6APA+zE9H
         1XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Mj/yGW8ONhMxbR5CzLVYmCwJL3rVsa9cPjWbMT8ulQ=;
        b=Cs4EdghFPVWB5LjEZkVTCxKSMa9kLayoN1zoMJd1RZNFc49FLOTjDWcm1XKMPyKaEP
         MFhzkpuAxs+nnMc4USk5uc4ueYa/tu6EYFomwFLEXlUIILyeYlu6Yq3K8Kidqz+8xoX/
         0hJW33Elm0XZgNHOpciHP6DMk6e37zVBt4xtojzdnMiB3WH464Xlo569XjCqu5TI5R4O
         xa+Guajhqq0EqxzyCX31kiVPrjG8VeY187ktvFdnmxY30at8Z/LfhBTnTxasoO9251Zk
         TUkFYahnat6k8f3kqRtoowP1BvePLrYFqPBqAXSwlwCNF9w2B2fVhoq7j5ML/R3yFX6Q
         AASQ==
X-Gm-Message-State: AOAM531yrTmpv0z+ewvg1SHbSIx74BV11QEuZXecZtNX76GC6y5HDl71
        J/JE9ZLiy+hUVynHA8Awa0x+Wu1itfGZf8vhYnHU1aeg
X-Google-Smtp-Source: ABdhPJyxJ6uerX7jbRi3TzQqfosJ1/jNxw0vBIlDJsvaEIsMCsWfdhWBVuE77htyUwJ7L6e0SEauVsoLce6YdaVi+Oc=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr16110312ljj.446.1593028203877;
 Wed, 24 Jun 2020 12:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <1593020612-13051-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1593020612-13051-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 24 Jun 2020 12:49:52 -0700
Message-ID: <CALvZod4+YxWbUJF5yCRkzOeT7-Kt0CHMPMFskKL5bfhk0BG=8g@mail.gmail.com>
Subject: Re: [PATCH] mm: filemap: clear idle flag for writes
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>, gavin.dg@linux.alibaba.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:43 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> Since commit bbddabe2e436aa7869b3ac5248df5c14ddde0cbf ("mm: filemap:
> only do access activations on reads"), mark_page_accessed() is called
> for reads only.  But the idle flag is cleared by mark_page_accessed() so
> the idle flag won't get cleared if the page is write accessed only.
>
> Basically idle page tracking is used to estimate workingset size of
> workload, noticeable size of workingset might be missed if the idle flag
> is not maintained correctly.
>
> It seems good enough to just clear idle flag for write operations.
>
> Fixes: bbddabe2e436 ("mm: filemap: only do access activations on reads")
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
