Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DB3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49D52070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKy3hwHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgGTDq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgGTDq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:46:59 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ABCC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 20:46:58 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r12so12072477ilh.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=a1D5IvnLIw6eOoDUSvZwCn256QlPXNdEfwkFkSghmTc=;
        b=kKy3hwHDJiu5X0/GyHMRKTHtTUZ47hgCwgKRWkzuWq0eguRYagL0FmWYa5/YsJY6oO
         oLj+JA05/1dlx5Scp6SAvc5KCTDLPKAU6OcspirNKCyTFCI1xNoNQ9JY5CFHWwplrm+d
         eWUn2VgraTcgUXOgyhte69csm+byYjpJzwgmmvA3N6lxztyaN5SrNP8YVIQGzkdwf/je
         vvocsDZS/9dkAm7s3mEEtiP8vi3F29HXFj4I06Z7fsylnd3J2qdHbXcRM5lknb8IbGX1
         PnG07qoKMwJ/F96prDsUxyVHvr4h1bshjwViZPszvJLYqGNyWuQZNwCcNO9sn07oB3Mn
         GbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=a1D5IvnLIw6eOoDUSvZwCn256QlPXNdEfwkFkSghmTc=;
        b=WGTFdg98Hfvd67CI1aA7ZVxkIFxEFURiYjQX48+h5GWj049DOaIAf9LUiHKGgxK09x
         83/roTq/vo19Ga1YE31icCOFr9ZwNyk/uNFLnOyoDB1PBVBebSbgPrJ3JYDgJd4Ty84T
         UJoQhBBGuU2Weoxbq18f6NF32oKUYtLqikopCVgiNrYd56BidYwNOEBUdkvh92CTgcz+
         5v1cRZIroLfzrlqqzmOefTqb4hI11VDx/DgM4F9uvRv1+Gvf7aZczj4rNYxsGJEVhG1f
         lobBWa5iW3Sh1VbZHXg+YKYXHgza6GEJdGEujq1U669pGuz1sRrHYhZQfBj+PRm+mI72
         jEfg==
X-Gm-Message-State: AOAM53398u9FdCHU6nIfFTARar5dC41VjwZUg/MEZafFeWa3kQ2qWLwr
        PNm+Jt9Serjxm8ifZxRncqvcgiRyvDjUFYEM0aT+hxqva8M=
X-Google-Smtp-Source: ABdhPJyS/UGslgi2H3gEFVGP0PO+kDewpH7BpEnA5hWpGZPwZD+Hsr2q2raBOoC4E970IKQg1dtcPqwo4YHgpe1BLh0=
X-Received: by 2002:a92:d843:: with SMTP id h3mr22246540ilq.255.1595216818314;
 Sun, 19 Jul 2020 20:46:58 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 20 Jul 2020 05:46:47 +0200
Message-ID: <CA+icZUUGO0__SEZ7YvuQzfSdaWfTnCHW=73-3W4X=Vz51wHd+w@mail.gmail.com>
Subject: Re: Linux 5.8-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the new RC.

I wonder why there is a time gap between tagging v5.8-rc6 in [1]
(first) and [2] (15-16mins later).
Can you explain that?
( Here it is UTC+2 means 9 hours ahead of your local-time - I started
my build 01:02 a.m. local-time. )

Thanks.

Regards,
- Sedat -

[1] https://github.com/torvalds/linux
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
