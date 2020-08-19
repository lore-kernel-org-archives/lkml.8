Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B2C207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZT8cMYJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHSTwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgHSTw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:52:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C22C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:52:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so12190277pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QuTX2pJz6snBZU3mAO8kjCgwPh7RzZTS1Q+PwFSLk4s=;
        b=ZT8cMYJ4jVS0X11WlEN82Dj88OSIWjw39G/zENopPETBRWnX7NRbcdgTH7fKk+B6/A
         6o1jE2RHJrBzPDn+W8Tx2Eg0+11uIWiPKYi/2D4QtNf39vRdPlRiQI6ivc7jArh5LV7+
         lfnIGd6jRUjA3jXZExV5D06MSxTC4Er3ocFgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QuTX2pJz6snBZU3mAO8kjCgwPh7RzZTS1Q+PwFSLk4s=;
        b=pB/kPt4+U8rQZc+HwE2Cx+G1QwHecHYPtLYPxFw1qMcDWkSBov1gV4Lrn2FHdphqqp
         PdPphFaZTU4xgTJe8u9EZSVrgcLTLzdbNpXMKhvcyrtQfGfWUDicRsqge4fgmcZe7O6k
         dILd5XPEaBe8uEMus++wqgXrWDWdNqk8w1aHoGj2O7wA6gdTwmrcZvtbASP84XcT6GZ4
         gUo0T/RzU1K0/tBo7YunXwFPiQ+4CHxPnzLQdxvVXeC6KnpBFbZJyLMJ675MFwNFSYcw
         EEwOpsa9VVcBi4Oa5ENGZxcK5ZDc6PrsnA7J+L+BsQLvywVcdQ3b9uPKUpgqJSgOmM5K
         q4OQ==
X-Gm-Message-State: AOAM530biiRiUWaUZPIbseVwIopxLXEBX5y83xhAoX5y7I3uAznvBR6r
        EGlkmKi8fXzsKOHUHWfSALy39Q==
X-Google-Smtp-Source: ABdhPJw72rEz0qENbiJ8siJOsBPl54GcytMVrFEGkPdfUPSs6+SuYFW9QdMJztJgE14olTkK9mgbMw==
X-Received: by 2002:a62:77d2:: with SMTP id s201mr20101364pfc.213.1597866748670;
        Wed, 19 Aug 2020 12:52:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s23sm2857633pjr.7.2020.08.19.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:52:27 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:52:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Make debug_obj_descr const
Message-ID: <202008191251.B7EDB6FA3@keescook>
References: <20200815004027.2046113-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815004027.2046113-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 05:40:25PM -0700, Stephen Boyd wrote:
> These patches make debug_obj_descr into a const pointer. The second
> patch can be split up into many patches if desired and sent to
> respective susbsytem maintainers.
> 
> Stephen Boyd (2):
>   debugobjects: Allow debug_obj_descr to be const
>   treewide: Make all debug_obj_descr's const
> 
>  drivers/gpu/drm/i915/i915_active.c   |  2 +-
>  drivers/gpu/drm/i915/i915_sw_fence.c |  2 +-
>  include/linux/debugobjects.h         | 32 ++++++++++++++--------------
>  kernel/rcu/rcu.h                     |  2 +-
>  kernel/rcu/update.c                  |  2 +-
>  kernel/time/hrtimer.c                |  4 ++--
>  kernel/time/timer.c                  |  4 ++--
>  kernel/workqueue.c                   |  4 ++--
>  lib/debugobjects.c                   | 30 +++++++++++++-------------
>  lib/percpu_counter.c                 |  4 ++--
>  10 files changed, 43 insertions(+), 43 deletions(-)

Yay more read-only memory! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
