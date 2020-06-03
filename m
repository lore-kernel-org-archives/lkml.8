Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82615C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5944F2074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fQbCD8GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFCTNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgFCTNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:13:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01910C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 12:13:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so1334918pfw.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K3kGe1mJiZJ6dwCK1eiMjr6x1I5RcW2yQKwe0qCmt18=;
        b=fQbCD8GIVJ5wlkL5wGfpFvF9FNSn8t1F2Oc5rQJeL2UIwAsPyIRuO/le76qQAiUrSR
         BTAZkFkepzS3NK6NSIj+g+Q7TD/6wailngAlm+56RsYRqrFiqObLM77Cs5rcrPIvZmJO
         H0QVCBeb4/ISJiEKXBnF9w/aUj0K6G56zsYZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K3kGe1mJiZJ6dwCK1eiMjr6x1I5RcW2yQKwe0qCmt18=;
        b=liwqN62wtJjPI0VA8eDF1e4ppGiqS1kzZKgvyiaP1ktzDEMNZDb/q0PlFthCT3Tp3m
         JErNA8JIOpC2CWTePJXmFWXb/ALej4yQb4pJb98h0CE6VKw1XKdhvvQf3A3clG+GnIal
         2J3h7AHb4ZOeVW1mSBqIPUW6HWZz2biGzNtdhWo3woF7SjLpPjr4Bz69oJAIdsq3o+9i
         B7PBY4ZlHk3YkK3JmqKxu2jcGNdMDrt6jGXkguZnBj5JEKHoW4Uuv13158b5BVwmK1Qy
         dsnrDhilVYwckv9iJZ8/M7FDR2UJM0WvVK1Vl4oazlUGRz/EUMGFn+hfxXckeqPA3vkT
         uZNA==
X-Gm-Message-State: AOAM531I6JcEt3yY4M5Ll+TYwgNJNJ8G9ncjOO4lLkgLnuaNmhlWDTxx
        EmBuynJtqSnI8C5IN+EP/Q05MQ==
X-Google-Smtp-Source: ABdhPJxj0hOg6AUFynVtgZDAvjxLUryk6PRML6xdrmhLy5oiE/ayjNYWvzrvlI0TEgDotnbEbAI+OA==
X-Received: by 2002:a63:5812:: with SMTP id m18mr779730pgb.407.1591211620629;
        Wed, 03 Jun 2020 12:13:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2sm3292501pjk.52.2020.06.03.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 12:13:39 -0700 (PDT)
Date:   Wed, 3 Jun 2020 12:13:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/vt: check allocation size in con_set_unimap()
Message-ID: <202006031213.22D9D875@keescook>
References: <20200603102804.2110817-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603102804.2110817-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 01:28:04PM +0300, Denis Efremov wrote:
> The vmemdup_user() function has no 2-factor argument form. Use array_size()
> to check for the overflow.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
