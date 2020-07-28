Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79581C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D90206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="SLaBgESU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgG1OHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgG1OHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:07:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A1C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:07:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c16so393854ejx.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDO5xtNZ22C72a1tBmEqwRX/00TFY7M8B1T43bXeDoo=;
        b=SLaBgESU+1xIJqSNqhieu03SNXKyKL+9MH8hgBEP20Gv4XC0tv7Aigf51SuYFDsJ0+
         09GIRi4cOnfUbvnWrtl2Bj6Hz1USuSfKPbNvwk6y0GavN4M4MAnesqzHkieumXy0qARA
         QDirQJmvwSNdLa088Smv1pEnZ7tVhoCsP9bwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDO5xtNZ22C72a1tBmEqwRX/00TFY7M8B1T43bXeDoo=;
        b=I6hxvbEpi2q0dCDxaJYVQ5OIezGzsEuKjNpbOxbVhTqCFAR3NvY1dkxCrft2dWEphS
         hNo2VL3Eq1Bxg7KR2Y21tqNUE90CCTw1OkCJxKuW+bZAko6y5W7NAkY7eaJk81m3hV0B
         MXLuGHxf/TQe4HPJjekeLTaI/26SnCtD7X//DKLNbs38o83A/473YOjpK7YdUwU/ebBr
         HADcZQxeSbq/jMRVXHMnb9+OxP+Tgmf/D7C0WniyiaOXFfCJfUKdPdWWJutP64GMdUWn
         K9ka7galF8nQEKF5RhT5b0znnlZ6a9Ud1A83/nFcC4moNh+IovATzlYJnQHIXsB89uZZ
         /IHg==
X-Gm-Message-State: AOAM530P/LL0KBqTLRJUG12iqMbLvWXhbk8hSaaYhJtS5XskXY1foqLe
        glPP9JGTzjZyQU1/pLlXfXgBsA==
X-Google-Smtp-Source: ABdhPJxZ3wtzuEqLcFixIKCJsMltmAzdJGoi38PMs9K9jHC/4Hd5c2yQLO2nF6gN4LZSUmJ0jmor/w==
X-Received: by 2002:a17:906:854d:: with SMTP id h13mr13570039ejy.446.1595945231802;
        Tue, 28 Jul 2020 07:07:11 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:f8d8])
        by smtp.gmail.com with ESMTPSA id p21sm6722487eds.11.2020.07.28.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 07:07:11 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:07:11 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: restore proper dirty throttling when
 memory.high changes
Message-ID: <20200728140711.GA196042@chrisdown.name>
References: <20200728135210.379885-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200728135210.379885-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>Commit 8c8c383c04f6 ("mm: memcontrol: try harder to set a new
>memory.high") inadvertently removed a callback to recalculate the
>writeback cache size in light of a newly configured memory.high limit.
>
>Without letting the writeback cache know about a potentially heavily
>reduced limit, it may permit too many dirty pages, which can cause
>unnecessary reclaim latencies or even avoidable OOM situations.
>
>This was spotted while reading the code, it hasn't knowingly caused
>any problems in practice so far.
>
>Fixes: 8c8c383c04f6 ("mm: memcontrol: try harder to set a new memory.high")
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Chris Down <chris@chrisdown.name>
