Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D560C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7414E206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="AYQWm2ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgEKRTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbgEKRTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:19:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C84C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:19:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so10383133ljl.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjilQVaMW5bj1pstvVNrQfVUnVke7cHNmi4yKLCUZ6w=;
        b=AYQWm2psEssn6RcwA/1ys2dBNI/JI+tBpIv11JuKCaOXFMe7jgQKAqs4DPisAZBYJp
         1Vqe/i0BZRyNzYYunmt6K6lRXeC+XC4qcq9nUI7y4OdEIIOZSF9cb+Y3kA4SsQAIkYqt
         MOdoqylx00o2aJcTgTdDR413rNIAwZ//EhPeILleb0aDCK6eCDUIqjQPDNc6B0oEZuXN
         n7m9FCtOrS3Xlrz6h6IZ5dBjvXA9D7RZg7w/Zs0grINq40y2rXdw9n9MNOFVb8l8rdLP
         US1dtfiH+bAxICJnCCmIQaCjUVmS5HLU1V6h68YVlKPkbw77j1fpKe4PpTfvo1z3It3a
         nkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjilQVaMW5bj1pstvVNrQfVUnVke7cHNmi4yKLCUZ6w=;
        b=uPs5Cy+VWkBNKBXFpmvjD/uFnNOfs+4Vrog+5tP6cjR77WIYA0BHSpyKWZvaoKBAsP
         BIpjCShV5OUkKMiW+kV5kupKly/a6FHZ+d+txm7tUcM8hOpvfuC03y/UMMNqKTpuRfTs
         3vonB138hzPY/CRwde+z1UmfFtHjkpWR6wwOw5iQcG6P2in3lfYrPS99EDygV9/SQG0m
         /rscSp06TTTVcGXKIeqoIF8vEncemK0M7L2z60B8d7yztQbTyhw0tGgtycdGniJI10NP
         2v6+jlJdhwGDkc7NMVACaNbA+NsBkC6BBE9LXMjtexifyzwsI7JgWKreoam3rKgHA53T
         NZew==
X-Gm-Message-State: AOAM531sMvOqIesy16U8IWe3szmLj0RqxU4/r0khOIJbwubq6wGMON+n
        rgPMq69Q6lJN28vJnXvLoYHTRhSD8d212h3oJ9BUeQ==
X-Google-Smtp-Source: ABdhPJw+Gpn0+EhlnD4SdYB5UdkdBPhPbGkg64H3e47IhbM3cIzbaAAhJ8fU69wfv5sEfZh1PMjcJtj/fZkQ55I7EEc=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr11187530ljw.55.1589217581389;
 Mon, 11 May 2020 10:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200511110250.23869-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200511110250.23869-1-nsaenzjulienne@suse.de>
From:   Eric Anholt <eric@anholt.net>
Date:   Mon, 11 May 2020 10:19:30 -0700
Message-ID: <CADaigPV7JAPtXqkVf8ooPFFn8hxZYcV_iabzO5mGZO18+ZB4dA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Raspberry Pi development repository
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 4:02 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Eric Anholt's repo isn't used anymore. List current one.

Acked-by: Eric Anholt <eric@anholt.net>
