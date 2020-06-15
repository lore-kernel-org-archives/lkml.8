Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B34C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 04:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67F420747
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 04:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTiW/phG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgFOENZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 00:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgFOENY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 00:13:24 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EF7C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 21:13:23 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d13so8291664ybk.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 21:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/+Hcg0/3J9I3AxA1tGH/O1FSezeXt+zyW36H9kmc+0=;
        b=rTiW/phGaeTJk5Cu8UPYwcysQscXKX/ltfldOkyNePn1iaouMwIxkVSKkBthYiSQ2q
         v/PDs41DDaiCHOlCrAqCnfNVVh4VEhjXhaRBHGt63widXmFI3riRndmM1Q1ehdUCflWu
         I8HliMQSF4bv1pTtCpN3H7GkE5WDzbJUoHxsOdhWw1j5bAuiG4L8LxRLVRmw0ghquQIs
         7M4Ki2UZ6sMoKIjZKDkXsQe+IMcELV+uiXP5OR7a9KXQywYEsvpVEVRFoj9PHd0WhS71
         H5/XqdhOGKD1rFvKy7hRBqK3mwouD/1PnwkUU5nnIogbfTwRluu1rG9KoUc+qISCevYh
         EL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/+Hcg0/3J9I3AxA1tGH/O1FSezeXt+zyW36H9kmc+0=;
        b=DMNNH4hj+CDOvkzXQw6CkPRjLr8oBYzFBdOR/n6j8CR7LTPphDdKmyhFNnR7MvyjBs
         qaLbvA+eRFe9HKW19A/jsjNJDgmoc0iWvqNYRhTgbW4rt1zvVlMi+SOZQ0JkOIGm+rS9
         /NBLnUCUu6v4mDjU7TtCVrEH7eHI9xoJR4whXOzbP8DhgPtGSWNlPAL/XKn6j+NC0TzN
         UqenAWKDqhgs+2bnvhG3azLuoVnzDKme6DhI5sgmVfgjn9554MPzbkHl/ECrjHTu55np
         6c1HqbzdczBkysbtNeaiHjsIjxFM5Dq2Ott0JoIo6a9NBa9ONZx/Wc60xurJN+mCV7lZ
         hcbw==
X-Gm-Message-State: AOAM531ds4pyP305Shke1ZciYoiSVYnd9tnp/qQJr6c43F9NiFSY0O4i
        heyKj/m3zU4CKxuJey4Mycb65Pa9rnRSSAq+3QZx3g==
X-Google-Smtp-Source: ABdhPJyiPMHvaILosjLc/KHQg0liU6EZkZNf+Bt2vYIicOF0yfOZqmDiG+sd4hvCsUWKhOOdrxnWKBmwFAVclYKWiVM=
X-Received: by 2002:a5b:cc9:: with SMTP id e9mr28140746ybr.287.1592194401312;
 Sun, 14 Jun 2020 21:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <12c2afd1-2dcf-2ea0-02aa-bc2759729c77@infradead.org>
In-Reply-To: <12c2afd1-2dcf-2ea0-02aa-bc2759729c77@infradead.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Sun, 14 Jun 2020 21:13:07 -0700
Message-ID: <CANN689E5sSwTKLeswEuDVrcOFAuGm2UvanzUMK4GDuBX_ey44Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix filesystems/locking.rst malformed
 table warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 8:22 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Sphinx malformed table warnings in filesystems/locking.rst:
>
> lnx-58-rc1/Documentation/filesystems/locking.rst:443: WARNING: Malformed table.
> Text in column margin in table line 8.
>
> lnx-58-rc1/Documentation/filesystems/locking.rst:620: WARNING: Malformed table.
> Text in column margin in table line 2.
>
> Fixes: ec23eb54fbc7 ("docs: fs: convert docs without extension to ReST")
> Fixes: c1e8d7c6a7a6 ("mmap locking API: convert mmap_sem comments")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Michel Lespinasse <walken@google.com>
Thanks for the fixes !

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
