Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59FEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982ED206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iikiN/nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgFJSKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:10:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22620 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728420AbgFJSKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591812631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=74sBb+yxIp+tJHGKwpQ6iTCCpQrRwqCUIhMJtvCFJYM=;
        b=iikiN/nze1zJQ7J2/P9oWlDbLjVfYn7g1OBbuuBkPCijCZMAeDNwRZbnJgYHL4PYCZcSzv
        0t27YghHjWPMFCYIKfPvJPVrIYD8axPaoz7dAtjfCRNJm0VwbLtyuA6RUrKFC/FYTIUJEL
        DJJjyey1ov9nP1W+jBHf3gHwVqR6ph4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-IUR_ClQyNkyAzANObpTEEw-1; Wed, 10 Jun 2020 14:10:29 -0400
X-MC-Unique: IUR_ClQyNkyAzANObpTEEw-1
Received: by mail-qk1-f198.google.com with SMTP id a5so2833795qkk.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=74sBb+yxIp+tJHGKwpQ6iTCCpQrRwqCUIhMJtvCFJYM=;
        b=tKnb65Eo+AEY4n6ZzQpYwRI/kP1XiJqpX/z8rqcg3llrL4GxXIxJ3ENYq35GGG6w9S
         I0UpUba6U2R1gWz0GsdadAurk4AP1d1Wc4/1EkyU7ExKQKDlY1aADbGlbafIiJPS+AX3
         +bM7qR3bXRho3is6D8hEjKBPe0VxQrfHvsozrE5DSqK3jDLogQrySe0TpIy1efFYvevu
         3SBidXf4kMIQlHhh3kgaoB1YcYyjiyydlb5dmTD59kRe2kAGYgYzMP+yjkOtzgknRzmD
         2iE2NfPHhoqfUJK6JpxI3of2Q7pfOSzdIqnblwY0mjRK1IChA+KfXdOjthKU2DibfaBs
         AYnQ==
X-Gm-Message-State: AOAM531m+1YaX7Pvi9IWSH3Yky202zQulo0zlYlNx0G1aLcYU1mLRapZ
        16EwxBqFy6qSQZEkHXe90cwRk9r3r88fTmTHj1nSLHwm2+ED4nhqGVwe4KiYJ5B/5sKq5tjFlEH
        pkJBE60Xd8QhCSJpmDP3xYnKY
X-Received: by 2002:ae9:ed4c:: with SMTP id c73mr4376651qkg.309.1591812628980;
        Wed, 10 Jun 2020 11:10:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEaMK2wTrmwuS0DisPNUk+/CQtYQCLvOThCsH3bZsWrmkNzuZQ9rHWGQ2cnmbOk4hRyYZaXg==
X-Received: by 2002:ae9:ed4c:: with SMTP id c73mr4376624qkg.309.1591812628790;
        Wed, 10 Jun 2020 11:10:28 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w13sm339047qkb.91.2020.06.10.11.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:10:27 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, jeffv@google.com,
        rgb@redhat.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] selinux: fix double free
Date:   Wed, 10 Jun 2020 11:10:20 -0700
Message-Id: <20200610181021.19209-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Repo: linux-next
Tag: next-20200609

Running clang scan-view over linux-next uncovers many problem only a
few are memory related, this one looked like the most serious.

Tom Rix (1):
  selinux: fix double free

 security/selinux/ss/services.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.18.1

