Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15717C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E0420780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="y8e63kEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgF2XX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgF2XX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:23:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69867C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:23:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id by13so4614211edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHKzrk/z/kMGPeyIpM+M4V0Dj+/IWbE197hNLvsYk+s=;
        b=y8e63kEOiL0z1ZBt1c02QAEtZTZHRqK//Ug1u6KjrDyx1rLoCxf8z9CCuSrOGVsdH+
         ewnjBmWSDRcXPrysQgXVVue1EwnbhOsLSQ+FaUb6fIyf3btmYqjVJpLQanF+56lej5dr
         Sy2sZUzy8bP8KWamcOT8rX0R+VyGu8AIpH1/wC8+4UOVTtqxmcM06Zyq1v2+YXW75wuM
         JjBNeI9woLfYhD8spmKWaqCfJbE5GMvVCB4GCaY9QCUvyw+sD3jjqJC/ckhZBjCb42bI
         VVxV3q+BP9Urm8p41VtQkJmSYrt3TlZbIdBM3ZsgBSDfPCBfJAx0PjxxxASZ51iNtpdw
         djyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHKzrk/z/kMGPeyIpM+M4V0Dj+/IWbE197hNLvsYk+s=;
        b=AkyVG09wS9FHD+efTUrjurYXquHRUUQh2oiR6nuUfmWlRvQJIpWapmez9E107EEvA4
         qT0tny/CprTmUoKSw+7KEozIVLHoubmyo+7rIV3zL4UhNHxNavxenCSVCjtmB+3uVy40
         GDXN430rGRxdxkC2ODnH6T0YANBlAxpLufyBcPsBqxdc3kNpy8hzRa01vkSJ9JI2oJG8
         nFVI9cUZI8bVeHAYnIgzgezO0hNowA4ycI3SyFwP0FDxuFr8net3tvcravo5bda1Feta
         Uf0HH9rRIQ+KQBPXhKpgItT+av4E8X9A0nfRO7OXLE7orBtiiODyVgPPwR9sG/v3j1yp
         yxQg==
X-Gm-Message-State: AOAM531/jO3oLWDVNUwKeOklZbGO+gVDgk5DRu5AtFJm6ckeNdn+sijp
        vo0k1VU/eQGmvCZCpEV/vTPYgPSbesQNHe06LvUy
X-Google-Smtp-Source: ABdhPJxyA+6RjLsB9FF9dnCzR+IB1u8N4C+wjXzo4Gq6/z6kzwoYhfqAoDIm8F+VuXxiiZdIu2uJmXU5hbA7P0ACG4A=
X-Received: by 2002:aa7:d6cf:: with SMTP id x15mr19695792edr.164.1593473035100;
 Mon, 29 Jun 2020 16:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <3eda864fb69977252a061c8c3ccd2d8fcd1f3a9b.1593278952.git.rgb@redhat.com>
In-Reply-To: <3eda864fb69977252a061c8c3ccd2d8fcd1f3a9b.1593278952.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Jun 2020 19:23:44 -0400
Message-ID: <CAHC9VhR3qiFeWnC8=jJro8d=qEco7+uReR=RNFzTkQm7vd9zFw@mail.gmail.com>
Subject: Re: [PATCH ghak124 v3fix] audit: add gfp parameter to audit_log_nfcfg
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>, fw@strlen.de,
        twoerner@redhat.com, Eric Paris <eparis@parisplace.org>,
        tgraf@infradead.org, dan.carpenter@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 11:25 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Fixed an inconsistent use of GFP flags in nft_obj_notify() that used
> GFP_KERNEL when a GFP flag was passed in to that function.  Given this
> allocated memory was then used in audit_log_nfcfg() it led to an audit
> of all other GFP allocations in net/netfilter/nf_tables_api.c and a
> modification of audit_log_nfcfg() to accept a GFP parameter.
>
> Reported-by: Dan Carptenter <dan.carpenter@oracle.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Passes audit-testsuite.
>
>  include/linux/audit.h           |  8 ++++----
>  kernel/auditsc.c                |  4 ++--
>  net/bridge/netfilter/ebtables.c |  6 +++---
>  net/netfilter/nf_tables_api.c   | 33 +++++++++++++++++++++------------
>  net/netfilter/x_tables.c        |  5 +++--
>  5 files changed, 33 insertions(+), 23 deletions(-)

Merged into audit/next.

-- 
paul moore
www.paul-moore.com
