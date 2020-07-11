Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DFDC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D8B2077D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="PbiCT6rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGKKHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgGKKHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:07:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D2C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 03:07:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so8643065ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VvgPMzxaIWY8gu27wsl9NLTmMwdfSRe2LBQ+aoof43M=;
        b=PbiCT6rnYpxjcdz78JSzc66U2jCPCKyCvdzn3eSBaprRlJVi0AoRb7r5GY28HdyQV8
         0kzDCApIGdgRErMQYrTaNgOIeW7F+TnstVOfQnIBrJ74RW9Kp2lAyXtPSRwI3uYjnVdG
         RQVkMbMwPbpZHLiAwg8k5GsMrWWHsanOzaPZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VvgPMzxaIWY8gu27wsl9NLTmMwdfSRe2LBQ+aoof43M=;
        b=UEoESDQ7G7GtTZ+82He+g0ZIK8ihfExOcUNh4ea0SOFpZV9QYeiQMrqOaE8WK87Wr/
         c2cGgYn+SPFH/Ogb9Y38ZzOR5FWi4vaoZxQhHxhM1OcAHGhebmYeI4FaqanDFV85nFIU
         bUDf1Mmgq23baFoucD0vdmeMuMSjcjVxoxM/dwkJFAZWSWY73vs6JKbbd6ARblAbJT/V
         igFshgOWw4J/r8qD4V0GuXU1kUjydltedML+08JzRUw2w3wR4HtvFOqI0EVldtQG5/77
         ZI3aYYXDvI9umPk3ojs51hv0VKRwKpCOPm/9h1UVnk06VBweL/if7AXY7J40Hr5Kvlb7
         uCRw==
X-Gm-Message-State: AOAM5302zfQyVZcq0e8ZVeAbsECW93/r0tefJRvrFxeqTO3ty9RypHMw
        YElSQNQl3f+4c9VdgsQBxP5WsQ==
X-Google-Smtp-Source: ABdhPJwDfkL/WJa2Dbdi6wpQKziY+VZNw5BInEihKFhEvNyxeYNGxcpd3iw/1vjMlfuO1RYGaRPc9g==
X-Received: by 2002:a17:906:ca56:: with SMTP id jx22mr64001808ejb.494.1594462067714;
        Sat, 11 Jul 2020 03:07:47 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:8860])
        by smtp.gmail.com with ESMTPSA id y11sm5150377ejw.63.2020.07.11.03.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 03:07:47 -0700 (PDT)
Date:   Sat, 11 Jul 2020 11:07:46 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: consistent update to pgrefill
Message-ID: <20200711100746.GA814207@chrisdown.name>
References: <20200711011459.1159929-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200711011459.1159929-1-shakeelb@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel Butt writes:
>The vmstat pgrefill is useful together with pgscan and pgsteal stats to
>measure the reclaim efficiency. However vmstat's pgrefill is not updated
>consistently at system level. It gets updated for both global and memcg
>reclaim however pgscan and pgsteal are updated for only global reclaim.
>So, update pgrefill only for global reclaim. If someone is interested in
>the stats representing both system level as well as memcg level reclaim,
>then consult the root memcg's memory.stat instead of /proc/vmstat.
>
>Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Chris Down <chris@chrisdown.name>
