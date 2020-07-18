Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6458C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DAF2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="oKdcHxt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgGRHQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgGRHQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:16:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A9AC0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 00:16:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so17760734wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xHVnQvxmbGU9Ko0uL8p4tnJQ0J1CLCT6xz7M4Ccg8MQ=;
        b=oKdcHxt3cYiLH9F6JeaENxb3L0suuIESYrWnz4LMdoxe18XhXLj8d43wOtim0uIAme
         zPJVkdIlbZiiY72xPKODgFXZOO4UxfjZJ2SUbMkjOAAS6ptdt4+ntKvReVn4Z2SDdm2B
         3yVGvFT9fXvAbYkt5QRFUB2AstxiC87gcclw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xHVnQvxmbGU9Ko0uL8p4tnJQ0J1CLCT6xz7M4Ccg8MQ=;
        b=Ol2hkKsV+3rwYJVxtpvULTeqTJxY6MOjTW0SSHxVOEUObstR4YcP/VdCyPHh2gUoVG
         CkGPJ+V7knhJb03jb22ICaatgPLeJTXSuoerMGNHtHOV2LaJIESJd2V/0g6CzLCQQQ4O
         PBVprF7IpF8ywnFc6g0pXS/HZ6mLxv+78rahwLhm5uwWn93cudub7/p7bzkIBeFVDzCk
         2A3zQP81Ge+vbyDevRixiHXyAWYxyLO9+XUmyMb4Nck5gXdyZPTYI5r49zdjuFUpzgca
         u9nNPqXeIdeAVNZizRFFr4OHTXFjUqkeretOi/THriILUpD6f8F8SHgXf3ARNZWH5ubV
         gnFg==
X-Gm-Message-State: AOAM533ZvqLLAXbA74BZ94v/fEh4dJWGqCC3HAOoiu9z6yxO2vXZJxLy
        2MUvD4TeMUuL9O/EJZkdcgGR0g==
X-Google-Smtp-Source: ABdhPJwDu/WXFihY/rK4j6j/qIbeQLSuG278GwIf99LSLS+GmPXKjvZGiqEP3BMycjQA3h2sqx5d7A==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr12532502wmg.123.1595056613105;
        Sat, 18 Jul 2020 00:16:53 -0700 (PDT)
Received: from localhost ([195.68.125.34])
        by smtp.gmail.com with ESMTPSA id 59sm19792133wrj.37.2020.07.18.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 00:16:52 -0700 (PDT)
Date:   Sat, 18 Jul 2020 09:16:51 +0200
From:   Chris Down <chris@chrisdown.name>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] memcontrol: drop duplicate word and fix spello in
 <linux/memcontrol.h>
Message-ID: <20200718071651.GA467892@chrisdown.name>
References: <b04aa2e4-7c95-12f0-599d-43d07fb28134@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b04aa2e4-7c95-12f0-599d-43d07fb28134@infradead.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap writes:
>From: Randy Dunlap <rdunlap@infradead.org>
>
>Drop the doubled word "for" in a comment.
>Fix spello of "incremented".
>
>Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>Cc: cgroups@vger.kernel.org
>Cc: linux-mm@kvack.org
>Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Chris Down <chris@chrisdown.name>
