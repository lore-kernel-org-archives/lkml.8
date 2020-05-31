Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35344C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127A1206F1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXcdWYKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgEaNAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgEaNAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 09:00:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE84C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 06:00:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so10165616wmn.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkBazEXFPT2Evha6vjR9imItMnoqhOw7XhTfpTqH9rw=;
        b=RXcdWYKdemNJFQW8hMxejs4ILZ+rGT8XMpBcXo8bZRN40SIynES4QylzQFrZOZINLL
         Fq21dXB0GPGQvp4xKwtHwUiM7EDBEHJOMfqnvHd1AYKJmHv1Z3YlIsQCCiH9jWy6l91h
         lHD+zlkH5wbXhdyOBvk1+1JCk0f7Xf6EACRN2BbKBp2TTGn6NMhOPmSk0yO12r81f7HL
         1hSfob138z8hKOvIJjgaGJoYk2DjMF/jj1n+A+OmsH52CehsNLKSciV10bmN31uaCj9R
         LHG/iUZj1orYcU5GHY0M1z1ErNgo8ZWoP+GdyUXMUHnldBNZPD1fiZTr+Vp3rlda7UNq
         tpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkBazEXFPT2Evha6vjR9imItMnoqhOw7XhTfpTqH9rw=;
        b=IWWFFWAxY2Dag5CMqA4N7jpeYVgncvFGYRN+c/9Of0yBivpfuBi0+T/PLVvG3wiH4A
         BfIUGX6Q2ei7Kg3fH6XW6jh8CHKWzCa8AWkh3/MROoePX4V7FcbA7QPdCDBlXfI77/aZ
         Ay2Yj6GjnWj8wBfI2DF90TRlQyIEZgzLHQTf7P/d/waKrjW4QHjkOgkgXtnG6ZO2UKIm
         3qrYXU986nS/mtLOSGs7ytBkampLQiuIBqD0iDmIk6B4N0tDDOHFPvrgItmwkhEh0hrh
         d4VoEQ2RAMzWNrePMW8Cv7vH4/srbL4c1VwC+yyycjy3780J9OXIbQKv0waqHw01lzO4
         B8OQ==
X-Gm-Message-State: AOAM533P7vNcGWeNMg/QHr+XiEx1g8d+DEy1z5/vjQI08Or3KMlcu67Y
        T/BitHp6VpO0clk3DMJiZMQIkh73YgYYz6LEcQU=
X-Google-Smtp-Source: ABdhPJyZGh/nAZnYHM6bUe3OC008OUh1mrmvPgpc+Iaz+DyNbzxfoBeezrvONC6jSfwdOLTXiSmQV7FrJPTm/ExbQXc=
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr16627280wmh.164.1590930022882;
 Sun, 31 May 2020 06:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200529084515.46259-1-jhubbard@nvidia.com>
In-Reply-To: <20200529084515.46259-1-jhubbard@nvidia.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sun, 31 May 2020 15:00:11 +0200
Message-ID: <CAM9Jb+gvGtmqB0a6uRnsHPP+uP3RTOZRr1rcUdCsxRJHXw0fDg@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: documentation fix for pin_user_pages*() APIs
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
