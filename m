Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD3AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D223820809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4aPDRYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgG3SC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3SC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:02:28 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC913C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:02:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w9so21012083qts.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNgWjzKHskwT0MftVG/9B5dX6kQx1rkKM1Y7gjwQfIo=;
        b=t4aPDRYed6LP/GqYAZ/1/OhlJjN7mYd7e8LPKEnQS9ZXO5Te0mHernQE6PfLgGDk0Y
         WHGyAeJr2LLBdPfyVLkyY4wilrUtQb+UrhCynaHFVINnCiAa4612slLDc5DjRVbuyO3g
         MxOb6Oytk9KLjLkeY0Z9cXet6Pzu02vXp0HYUCKqDjnLq1RnMilpp2JXkr7J5qEmmV5k
         o0NQodpHuAmj0bAKvTDjL/XQSM7NXO3SLR8bNqujETIk/vdwFcHJTvPOJs+/gzYjtnsn
         KHUTAKjiXpz+PWWwvA7MJPwNhZfKUgpBydweua4CKc9KuqBw0fbakFOjvd0iu7QGgWsq
         wprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cNgWjzKHskwT0MftVG/9B5dX6kQx1rkKM1Y7gjwQfIo=;
        b=quGykgoAfM58Tt52fg1xGP7SigLMiaN/HavF5pw/0ZVt9LqnNP1g7OSVnKjSpBYzKk
         y5HDUI9uZm9gdnujKfz7n/YX0guUZnfHU95pNNXTIoQtXqXHWqLbjqKg/yXOMOG3XPG7
         enZwG4C1rSlUIsZTPuEJ/QY8CnlNjZR3Hpyyq/xFdu6uuvSFtivO3tbSZgBZqYf8OQ8o
         dyMmGKEKvpNCWkYOp2Grt7cU+OPcR3eRYpVYTS+F0CcgAZ7YSkzukLpqJOZzJpvUDmx5
         AloKimQppT2ZxOUlUGPRMk+cdF/OHZd0ZoBDeRMBLQKaUYmr2GoLAnXa+KWsVx0D5ghv
         POrQ==
X-Gm-Message-State: AOAM532k2IgsMIElfpc+BnIEOoHF4AlW01GF3w93aBEQNYUU3rax3LR1
        lqD1lC5jUTMJaiBeiTlh3CpygBek
X-Google-Smtp-Source: ABdhPJwDyuHXDS+cQUsSX5+UlAGCpfGV+n/T74fdECgkw94+PxEhKiOfoisK0bXPBl5Rh8S3CW7d0w==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr4201192qtr.1.1596132147185;
        Thu, 30 Jul 2020 11:02:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e4sm5232739qts.57.2020.07.30.11.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 11:02:26 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 30 Jul 2020 14:02:24 -0400
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] x86/kaslr: Cleanup and small bugfixes
Message-ID: <20200730180224.GA1203420@rani.riverdale.lan>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
 <20200728225722.67457-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728225722.67457-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:57:01PM -0400, Arvind Sankar wrote:
> v2->v3:
> - Fix the first patch: command line size should be strlen + 1 to account
>   for terminating NUL. Avoid calling add_identity_map if cmdline was
>   NULL, though it should do nothing in that case anyway.

Hi Ingo, I noticed that WIP.x86/kaslr and x86/kaslr both have the v2
version of the first patch. That has a bug in the cmd_line_size
calculation (missing the +1).

Thanks.
