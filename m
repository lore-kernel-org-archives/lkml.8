Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F77C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD8820890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLRIwPp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgFRT4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgFRT4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:56:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAFFC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:56:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so3294903pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6WxuJi3UfQEqC50/z7v1HAPWAobzlEVFkfWhBJ8zFb8=;
        b=BLRIwPp48LTeq9dM8BwXEFv5h/k53jK72H77U2P6ZO0Z+qF0jqS9BYG2WOWGi2uLAP
         TuUxSPxtQumf9pjuTW1EkIpK17VdeP8VSj7bgQ7xYLKugmWBM1Uaf8TG4Fpne5U6bQ10
         4L4OW4EB3085D6soCS/bXnsER6BHuOq4aBaQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6WxuJi3UfQEqC50/z7v1HAPWAobzlEVFkfWhBJ8zFb8=;
        b=LaUboBFSy+4QbUm9JM/i7I86ErWm60UKfwx/GXDmo18RiC2/jB7MH+e9Z/adVoUCWD
         dkqgCNEkYhYyw6AzQlCng++xJ53naph/9BeQ2eSldCxeCJy4iF0r8I7ROGbP8HqKw9Ka
         rtoil8X/9k6GT+i61/XxDP881VYJTQwF4a1msZFLSvKNjdvpOfwYhuBnWrfoKAtvOdo/
         /vYuJqOlSgbGAv1ld+116ENBgNtrUVJM70lP/WFiye5ERxZ0QJoPq282RwE+4gMBPFgf
         zpmdDhxb83YBCI0IhpYI4Ro/B0rVQyQmAT34I3b0HPTb1YO6p4Z7LURHwtOtfSQaFKYu
         1n3A==
X-Gm-Message-State: AOAM533IHShLExQMRb/4qCKYtZBykbz7v6C/InlMd7va1ed8KEs0oBUE
        pccVuVJ6V7P+xcbxaR7CAqXAHA==
X-Google-Smtp-Source: ABdhPJxp3L2hsMhtTetcJVLB1ubkKk/0FvqLGsh2lPF4B0wBPnAb1y6cbMAMewS7FT35u7jNXr0hZw==
X-Received: by 2002:a63:7d4e:: with SMTP id m14mr171075pgn.391.1592510193055;
        Thu, 18 Jun 2020 12:56:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m16sm3593977pfh.187.2020.06.18.12.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 12:56:32 -0700 (PDT)
Date:   Thu, 18 Jun 2020 12:56:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 7/9] mm, slub: introduce kmem_cache_debug_flags()
Message-ID: <202006181256.062C1F2@keescook>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-8-vbabka@suse.cz>
 <949b90ed-e0f0-07d7-4d21-e30ec0958a7c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949b90ed-e0f0-07d7-4d21-e30ec0958a7c@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:37:07AM +0200, Vlastimil Babka wrote:
> On 6/10/20 6:31 PM, Vlastimil Babka wrote:
> > There are few places that call kmem_cache_debug(s) (which tests if any of debug
> > flags are enabled for a cache) immediatelly followed by a test for a specific
> > flag. The compiler can probably eliminate the extra check, but we can make the
> > code nicer by introducing kmem_cache_debug_flags() that works like
> > kmem_cache_debug() (including the static key check) but tests for specifig
> > flag(s). The next patches will add more users.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Please add this fixup per reviews.
> ----8<----
> From 25793252a31a36f8d1d4ccf0f27ed3e43fba54d8 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 18 Jun 2020 10:34:53 +0200
> Subject: [PATCH] mm, slub: introduce kmem_cache_debug_flags()-fix
> 
> Change return from int to bool, per Kees.
> Add VM_WARN_ON_ONCE() for invalid flags, per Roman.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
