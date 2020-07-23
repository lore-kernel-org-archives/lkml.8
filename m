Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C53C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07FD207C4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FH9HqSCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGWU6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGWU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:58:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95255C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:58:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i62so7847405ybc.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7FtAxHooqgZ8bYbSQNU2/0E4qw3ahA+xHDnMOW5hjTM=;
        b=FH9HqSCGivFhNIBkaRYcLc/3uaAPzqk1yMojTdojvaGnh9+p1xm2CHWAYknAXVf8bT
         VJ/LaPFh/gCl2KLRNNVPPm/700eNndvLPHu2pNEfBjV082Nc/HKBYRYQTdgpN3zsF5O6
         Ph0ItPH4iiuqYObz9i1ie38edk2UFOuQ+bkubv6Jzu30271cSd47PlxS5NOO9TnN9RX6
         9xfV6coq04yu/HpO9NdvV8rm0+yZu+zUU76rTWXlYW2QH+LTYL5ieM7IkOs591kcDGmk
         Zh9INjfGnsTgB1Jpfq8Ve5TtqWLhBGeahZBmHQdVE5MIfzKHF0fZYn6OJ21NR8LI3vcW
         Z4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7FtAxHooqgZ8bYbSQNU2/0E4qw3ahA+xHDnMOW5hjTM=;
        b=nV96YQdg8fJjcIoYe8YCkn0NAPOqqX0jiPSAwgnMrSJ9OYR3BCH5zJaVrw8UJQaE26
         lY+73DoObGbrpMMReYIETd9YuW0KvsMB1DpveJ6aeOhwBahbwnVxvucbCkZN5UA8x89H
         yIEpsxrUwzbR7uqavNTGs95M7oFcXvy5Qm0t2sqYkBRN8LT/NsBu7cVWhciT8kMxHJdG
         bgSzhWqZE2XGMekRmn8qPWUr/D3F+oEiheporIcgovwcd3UWV6uglJfgQMaohpwRDzxe
         Jbm6uW7kcMrwbvukBj6XQFH28yk73xBCHuw8Nt826ojFP5IJeKEvWqtmE3EauhiH3ect
         eDvw==
X-Gm-Message-State: AOAM531ghFlcmMf6Ynlnct+FumwUSKZlcF13wo1ghqncHhNtNjZDrKFD
        vV2V0zLUc99A7mGfP+2jr5gua2pEnkFIUyNxNk4=
X-Google-Smtp-Source: ABdhPJxpM9sqMDDRi78NValLg0D9pOqPRoDdTPKRwwJ0nsj8SxgFsCg6p6BYYZx/zHf/CkOD+cnjuXmrXh2EQgBZg64=
X-Received: by 2002:a25:b68d:: with SMTP id s13mr10666339ybj.330.1595537895811;
 Thu, 23 Jul 2020 13:58:15 -0700 (PDT)
Date:   Thu, 23 Jul 2020 13:58:11 -0700
Message-Id: <20200723205811.1104520-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 0/2] tracepoint bugfix and cleanup
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes a reported bug in iterating the
tracing/printk_formats sysfs node, and is tagged for stable.

The second patch is a small cleanup and is less important than the
first.

Nick Desaulniers (2):
  tracepoint: mark __tracepoint_string's __used
  tracepoint: used attribute definitions from compiler_attributes.h

 include/linux/tracepoint.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

