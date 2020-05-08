Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE1BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86012173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoq8L2xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgEHS03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbgEHS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:26:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92F2C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:26:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so1106301plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yGCB9uiSAoSgGC4H6BsrZxK0G4i0rxwy4q1TeUNsNGY=;
        b=uoq8L2xfIgd2892o6m3BUUi737IcFRPoLZTj+nW/FpAQrfQJx+ZJ4Dh/dbRw2FfVZm
         /eK9PiVqICu093YxzS2CehKztY0h+2iyv9KfkMR6KghQdrOQVCEMyDpv9yfeX4zdQJqW
         jEJFzHmxVC17Sf/7BHUJR8OHAii3P7i/PqI7yaL+WjAzSK8//WqR01/y5Ko0JgxthwVK
         VEEyLrLdpFi3jdMTcBx99l1mriCbrlnN5R+xZv+fMrUMW3iUHlLc48GQaOenmUq9DElC
         DO1lAR1NrwVpCLRCkYsSF3nEw6hzuVhChkm19nyhuIIKFSzBel6juHo04mL+XS15vQym
         ewrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yGCB9uiSAoSgGC4H6BsrZxK0G4i0rxwy4q1TeUNsNGY=;
        b=Rz5Hz2EHqGo9oB1Sz48p8YenmG0jSiVHV6Ygl8KLZbfs5EKZ0CYpHM0zN2v3Bddd74
         Kf8NjMwdLeZM3DYo7pU/byFAFWar05D4AMoXl5SREpP6l/TwBh+AfIMYJtySd2iroyxd
         kRVw30CwD4sNC2uar4bnpGgATe0kvxgDuScDGgFmT8VAbyLfwfyRM4uE2GcL/F6xu6tF
         EZQllg6ICsOvs4qcXjIcqORR8UCgqFBuDYyNuPz6fJtkE1Wtw1ReNElVznMbAjPDeJs8
         Y2yJJWgzxIB/NNMKgfIWkTUSZpvk82Q5TrrIihJey58V9hWZw2uDip+Hz0vDM7fBy22c
         XW4A==
X-Gm-Message-State: AGi0PuZZs/N9lqkDYXLML5VN5kMcKki+9lwU1SmBFH0CvSPSH+Y8p2Ys
        zqPnB4LtWg74x5ohNCEnpbNo/w==
X-Google-Smtp-Source: APiQypK/tpjddlgAo4yz9wK1JF1/Zf8llc0RjiRlIYXqnp9UVnGBFIfNA7ECtSeVGwWx7bVOCoseIg==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr3353901pls.275.1588962387978;
        Fri, 08 May 2020 11:26:27 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 131sm1805269pgg.65.2020.05.08.11.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:26:27 -0700 (PDT)
Date:   Fri, 8 May 2020 11:26:26 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: Replace zero-length array with flexible-array
In-Reply-To: <20200507192204.GA16270@embeddedor>
Message-ID: <alpine.DEB.2.22.394.2005081126120.236131@chino.kir.corp.google.com>
References: <20200507192204.GA16270@embeddedor>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020, Gustavo A. R. Silva wrote:

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: David Rientjes <rientjes@google.com>
