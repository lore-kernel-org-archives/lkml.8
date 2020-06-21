Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 20:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EBC2528B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 20:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Cm6eHqFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgFUUyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbgFUUya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 16:54:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3BFC061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 13:54:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d15so11978393edm.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Fxeo892Xd0EGs3eDXfjXWElkMo4o1Rn9QPeImEgGuFc=;
        b=Cm6eHqFVEH8ZbMjVNb6vE6XKOFxYuSkKt1/OPZrXyt86N4CB3Cc7c/Ys5tDLRpwurN
         A1YGyH10ekZ5dXM5Kw3hsOGarzfcSHBmuxw+5Q7qwKcRRRZEFyaAZSkTY+ORAM5/zAAB
         ccpvzVFO9tHnc6fPYY3oCnjqwf3JAgj5PTZvJCEGXam42HZRaGvPBjUoqsb2JGzabRHr
         hNdoTnfa2mk4NQnCvzngmSE/qZ9szhTUPk5epawuI5TWs1Cw3zl2C4KTsSqdPvYe5OwM
         2WX90vD9fcP1dqcUT5GZSNshdEpl4P1ExmbULnzviRckPfccwbccPWK9v5+6xR/+VxhQ
         Ot5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Fxeo892Xd0EGs3eDXfjXWElkMo4o1Rn9QPeImEgGuFc=;
        b=gEqH9f/NqqWQ/3NIoB8rESDNZqpTbfdoIWTXX5Q8oe4jN1BpJSu/zl6TRFBcCEhWlM
         vbCeM2yduJTjkrDr6MNAS0nTEAn+UROPWu+nZ2QiS4vbZsJyYuiJdIxbhj+duI6E0Xpa
         PQUwQ2U6STuFGqsQTEEe+36rtKC9hedSPrQ02BK2H8TbIuHTR1QYIbxIpjExdHjALuJc
         G0WH42Aiu8Orm/3bKyQcYzPB8z++u00gpG7KDiqHofB2V0dfG7Oop66KFy6A39GS2FmZ
         1hIAeb+0rydkm6GZBRFli/IM9mr9RF+0oZbOhcU8IDr/mUC+NMY5BxsT6GKEBA3I/6Ee
         jdRQ==
X-Gm-Message-State: AOAM533tRzTiUS2zSMYlCreEjvFdClAXJEmVVeI3g3h5xhkv32910u/Z
        3nMmt3fi3hpmFkCK/zReEFmU+hiO6/ANJiRCLdaH
X-Google-Smtp-Source: ABdhPJwqkvqnVxNRdV5MvD6SdPikXCfdA5vmAMA3RLX/mZxQLF7YtJN6D4Hjjo6bQ44hUAWVymjMJtFxSsUC+MgmKL0=
X-Received: by 2002:a50:a881:: with SMTP id k1mr13707390edc.12.1592772867486;
 Sun, 21 Jun 2020 13:54:27 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 21 Jun 2020 16:54:16 -0400
Message-ID: <CAHC9VhQbP754KV8RsaBgnxmuy8gWeL-YccRqQOc8R7DrvtZBvA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.8 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Three small patches to fix problems in the SELinux code, all found via
clang.  Two patches fix potential double-free conditions and one fixes
an undefined return value.  All are pretty easy to understand and the
commit descriptions are reasonably good so I don't think there is a
need to go into more detail here.  Please merge these for v5.8-rcX.

Thanks,
-Paul

--
The following changes since commit fe5a90b8c14914397a3bb0c214d142103c1ba3bf:

 selinux: netlabel: Remove unused inline function
   (2020-05-12 20:16:33 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20200621

for you to fetch changes up to 8231b0b9c322c894594fb42eb0eb9f93544a6acc:

 selinux: fix undefined return of cond_evaluate_expr
   (2020-06-17 17:36:40 -0400)

----------------------------------------------------------------
selinux/stable-5.8 PR 20200621

----------------------------------------------------------------
Tom Rix (3):
     selinux: fix double free
     selinux: fix a double free in cond_read_node()/cond_read_list()
     selinux: fix undefined return of cond_evaluate_expr

security/selinux/ss/conditional.c | 21 ++++++++-------------
security/selinux/ss/services.c    |  4 ++++
2 files changed, 12 insertions(+), 13 deletions(-)

-- 
paul moore
www.paul-moore.com
