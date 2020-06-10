Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFBAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F802206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUnfDVj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgFJBTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgFJBTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:19:42 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C446C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 18:19:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 205so696504qkh.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 18:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Oio1yvJgCY2gmJTZMFGujeFBCwZ7yES6tEoLpmbLLCk=;
        b=aUnfDVj2Slo40XkVxjWV51Yp/wlhRXOcjW9lABo3jti8H3BE/ljViSltpDWV71e+ke
         UWsf34f/T9c0xXIwrO2cWPASNLu+Jhm8j1YTIBTZ6tnfair37d2Nr2w6+0aePl/ZBG2U
         OSsHx4ScfpJJc+uE6Hxi5du0L61hDntOOHQXiREuqbB1JnMNMPu4GtoShC+Du3l11Egr
         hbZ8SZtiG/u/95QNpbfm/lqWLjqaTv8sJqmCs9w8XjMJRUtKqEYYiwUYRAOcG9jnD5MS
         hnUGvoiuezpGZeP1Gjr6SHjjdQdchR9VIbLzwMzTflnZwQv7lnjCbW/tpTUD60wgs2ln
         lFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Oio1yvJgCY2gmJTZMFGujeFBCwZ7yES6tEoLpmbLLCk=;
        b=T0YQ5dXRefXrSfr37A1G8NNnfe4XGDRCotunBjcWpk/hsZ5UBk8Wo99hgoyoiC5K5+
         Zt/bq8UCfDwv2QXc9KqPmFpXE7hdLPBClNQ15G67s14oX7yJPbvaNfDkNiMFgzuLUNDo
         F/F6XZ8NsoOQ1a+ylLXHka1GG3C6fb4/fZVSOwl6h3zj5pzRtSTAQUzzsHyvhDteksa8
         tXqA1MfFFjqRp3EU4u1jHACLXu7MCrj+C1aoP4kCa3jTDbD4wagC5mpCWVH+lH5HXXh9
         TESB6wNL9tSJStlQZ1diMSJRvsjqlDk6ylMygvArPPnZ3XAU58TWJvN8ghborRyK6HHg
         pZOw==
X-Gm-Message-State: AOAM533qrP5WEAcDsLk7L0LwgbrRXt7XyrVhezW9GHokznQOig8cL13v
        GUKq3BZ9z3cxlJmnrsGFCl8Z6dv6Vk3WoNo=
X-Google-Smtp-Source: ABdhPJxr/kPdh+a9kmhpcYEAQxrwzHJBchZJTTu3AKa9m+4uzsv9p8VcvHieV368ZosqPw30q6BPKnKgp/TDxDM=
X-Received: by 2002:a0c:ee41:: with SMTP id m1mr885827qvs.95.1591751978222;
 Tue, 09 Jun 2020 18:19:38 -0700 (PDT)
Date:   Tue,  9 Jun 2020 18:19:32 -0700
Message-Id: <20200610011934.49795-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 0/2] fw_devlink: Improve cycle detection in DT
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2/2 explain the series. Just using a cover letter to thread the
series and add CC's.

-Saravana

v1 -> v2:
Patch 2/2:
- Added more comments
- Fixed missing put_device()
- Fixed stupid fall through in the error case

Saravana Kannan (2):
  driver core: Add device_is_dependent() to linux/device.h
  of: property: Improve cycle detection when one of the devices is never
    added

 drivers/base/core.c    |  2 +-
 drivers/of/property.c  | 62 ++++++++++++++++++++++++++++++++++++++----
 include/linux/device.h |  1 +
 3 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.27.0.278.ge193c7cf3a9-goog

