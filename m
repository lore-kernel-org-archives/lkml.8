Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBFC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A48720801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJ4OQghv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgBUHuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:50:46 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:53036 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgBUHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:50:43 -0500
Received: by mail-pj1-f73.google.com with SMTP id u10so516244pjy.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 23:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n/XyRO5w8YKIHeCODmQxQccE1QGfd6EQfKVrGlZTWG0=;
        b=wJ4OQghvFIEgehwpwm2fIQUqdMFpB5UvxQdGDNhYvjydKLrTltOxuV/GhJkzRuaY2S
         rk/M7igEIinkgpsmUBC3x42EYUkYZd4oR2j/HrD0UXghwgH54YEkPKyVWQbichp1kG/q
         XEm/c/Wth59/FOYs86Gwoa+IVcrQ/kK+/GyjRY1s6UCO5F8zsBgf6CLt0uX220RKJnN8
         Fds7vXL1ad4/oc0ZtqKpv/6/x8nOMgcqM6w5dIbYbo12i16/xCx6AR534xVJMMjV1U4a
         L8zpxCO3sPOYGEKtwUxaKKehcztTliXN58Cdh8ugsFMtkGsZDUSoXP0uNqX80ELRqzZ3
         UWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n/XyRO5w8YKIHeCODmQxQccE1QGfd6EQfKVrGlZTWG0=;
        b=mq2ogqrrAFPjoPqRjQ3kkR9IUhXX72s9IPjSCLNWec4GJRWRCdYyts9xm24+1uHX9p
         TQQTx60pfLDylkHlO+5eQZTlljDJIKRUTncvmNS4MMPZVUp/5WZLpOc5zwYqUigiZUWe
         DyjlTXfeRaS0oNJNm4LFrxxe/oLGwGPqfU6FKYoYFYF/08Rm1GSynYUnsf1x3ttuZM+G
         Gv+2euE4moUDuXuTKoRITMMFV0J4wcaQN1elX1vCQ8/BsZ61mmpRQbkiPgy7e95VFeaN
         OQtq9PI6P7pjHld92t6fAt+i46ghjIPfOmgufjN+AwDAA8g9SA+u3ZjUwhg7PNBh2x43
         6ztA==
X-Gm-Message-State: APjAAAX++vRNJVZmhtZ70FbKl7YtZTG/laBihKIz+IuarO9iqn1FKGBF
        DpiKUaOjFyxayYceCdE94MVJN/FTwNLjaMs=
X-Google-Smtp-Source: APXvYqytKuxBx4o8KL40muCv0kque5U8Uj+Zx9WcJIb02b4uVwwiiEAIeS64j+oYCWAO55j1sflbvYhGl4E3NTw=
X-Received: by 2002:a63:3c08:: with SMTP id j8mr37329882pga.223.1582271440692;
 Thu, 20 Feb 2020 23:50:40 -0800 (PST)
Date:   Thu, 20 Feb 2020 23:50:33 -0800
Message-Id: <20200221075036.181885-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 0/3] driver core: sync state fixups
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/3 fixes a bug where sync_state() might not be called when it
should be. Patches 2/3 and 3/3 are just minor fix ups that I'm grouping
together. Not much to say here.

-Saravana

Saravana Kannan (3):
  driver core: Call sync_state() even if supplier has no consumers
  driver core: Add dev_has_sync_state()
  driver core: Skip unnecessary work when device doesn't have
    sync_state()

 drivers/base/core.c    | 27 ++++++++++++++++++++-------
 include/linux/device.h | 11 +++++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

