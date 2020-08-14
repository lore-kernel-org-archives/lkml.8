Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7778FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4642A20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHvzzwHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHNWF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNWF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:05:27 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDDFC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:05:27 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id n25so5413028vsq.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GRwU2/0b36iuZqr/sDprR8pEI69nPlYkieZC+ARTjpg=;
        b=jHvzzwHz1ANfK0bsLX84iLf9uK8jkJc7yCz0tAv6/sqkMflvkajjdtS1UA5U9Zaz8K
         ocn7FhaGnCA07CuIEm4em0H1FZMgWRTCRXUO1n9h88z2KxyzJ0mdCS22ANMUsYHJsj9y
         MeNtSFPN9uDjG1oRg6Tz1JK4PaIq/XYz1VXzzpFuXSpjY+p5izcu+6iKJ3Oj5lcyRPbU
         PtyXB4DUNCB9EQOQwZ8FBXzpCQNzDh3gmqIoo9fa4lxl76OyoIiuRqks+l+bn9Y8Jb5T
         2XQyXG99rX3DVWlSpjCr2TnWi+Lckk2OyuUd4/yhjfzqgvnaw+F3+C83n+myuC9jOrhv
         x69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GRwU2/0b36iuZqr/sDprR8pEI69nPlYkieZC+ARTjpg=;
        b=E3NqPLHau6PaiLv8nIVnhE+HKCz5YaxE7z9Rk/KYDjfKCGaIu69bpUNd9aUhgZ6L1Z
         QDDfA8f39YO5BG1oE327/tYC2Ba0bd4pjsfmZR+NGCekhFgOix6dMSe1mrscmcFwavPY
         GV6ATGlF2h0U8piG5un090u5vStTLzI1wFBTIHhGT5TLdF5NWiHe2Sa07hKhzEAAjjMb
         1ICxJdMl0S7qoAmGyIec2+2HNRrlHEZ0YCiY0XpQwi3YMj+r7I3mEpHG1jkaazmNJ1+U
         USspQa9Y0Ca91wDHkXX8HMOSlxcWHKYXzl3TfjSa+f6B6dLKq9YfzWoWWxxp8Cq9gqRH
         hBEA==
X-Gm-Message-State: AOAM532SEygDWmkyHgihps4PSf7Nmf5s5+UOmc4fO2QxlDOmMtaQY9mF
        KvSqMWRELHmgicd/gZaS8Jtm9qQ3L2237UWkAA4Ou0lpfaY=
X-Google-Smtp-Source: ABdhPJwvAxCyAYC0vML2cc35xil52jp0LJL7TSXaJI0gI062+K37K1xq05aZbEdTVUVZEBlvfOxE6dT0oT5BriLIJ/o=
X-Received: by 2002:a67:edd8:: with SMTP id e24mr2857633vsp.150.1597442726645;
 Fri, 14 Aug 2020 15:05:26 -0700 (PDT)
MIME-Version: 1.0
From:   David Shlemayev <davidshlemayev@gmail.com>
Date:   Sat, 15 Aug 2020 01:05:15 +0300
Message-ID: <CAP2zNjPshnHWr=a7UZEiJdh3DuM+krjBM1HO+Aq07Q5pcZA93g@mail.gmail.com>
Subject: I created a service that shows addition/removal of functions by Git tag
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

My service takes each tag of a repo and runs ctags on it.
Then it diffs each version with the next, and presents it in a neat timeline.
The code for the indexer and server is available on GitHub (linked in the site).
You may see it at the following URL: https://sourcedigger.io/

I think this complements the Elixir cross referencer, and may be useful for devs
working on older versions.

Any feedback is appreciated.

Have a great day,
- David
