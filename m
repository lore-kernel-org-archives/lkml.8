Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D7C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC507205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLUq4/RN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgCQGzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:55:00 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45681 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgCQGy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:54:59 -0400
Received: by mail-pf1-f201.google.com with SMTP id a188so681925pfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cF0mn8RFp/NzGOPpgquFoVLhCbRSN6dQrHYHqFzbKxU=;
        b=qLUq4/RNPb7PhrgnudeQu/ls8asTv9i4YDOfr3NggSvcNYi4UxSfYMit8S1WUgfRKZ
         hZbbZQPFLrVYc4w+L0UZzkonnR+9Rm8+cgeDoLy//zUl/eEx1tyOtsRTwwk0IC1GmMk5
         7CS7xqEvKVY1hdXlUYzYVEQFG7dy5X2lR4whv4tssypZlespqwDBYf2ykgBrHzGRsoWw
         KSyWF/LIwFFvygdQi7hxsX3du+o+gHjUR3p65oe+tr2Bc5ohTBv5n7uD892DON5VSkoX
         pinFPh3FrUqi+8QXt/ZEbxdi0FQwUvd8TPga7GUwJMefUnNRxfnPnWu3NX9YAlqNlHUu
         10hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cF0mn8RFp/NzGOPpgquFoVLhCbRSN6dQrHYHqFzbKxU=;
        b=bO0zT3aXNtLRhVGhMEO6Gg88ikXUCCQ+DavhDvP2SH1c9nORDT11cCGVALIpm/ZvVa
         5twzsqOqAZiS4IH1HiXXszuyAO7KxqIOtah9aavnKs0XLUhjTtpfWC67Nvw5+o9lV2g5
         m5nFXCHKIwA+QZirlluQdqwjeM1C7tkvvN/dKToIxh0PoIXgrLWPALVvGDIBDQzXlBi6
         FRqx3IkgMot7lOntxLtXYNiGzVK0waKTmuDwR0p5GClwVVY7D1IbDxgVqyszCZBmnKdp
         HZVStlokzjrAD1BGE35ALZirpTdo5lmcWeUrTNfzdzqBB57TQlqfoPLHGaKNWvxp1t/W
         uvag==
X-Gm-Message-State: ANhLgQ2082ISvPpzS+cX18n8epQQegZ/TFUkYonJBizVcOX88y8ZCRbA
        S/accbaVTF1J5b24SWlHuVHuPXbW7cZqGbA=
X-Google-Smtp-Source: ADFU+vt2Zvqf1px/Dmb35lmQnUB5JpW8RvY7l95YZat6XfupQdXF2UMeOYFTa4BNyZ32vltscuYTU3kAv+PeRtc=
X-Received: by 2002:a63:8342:: with SMTP id h63mr3660917pge.141.1584428098211;
 Mon, 16 Mar 2020 23:54:58 -0700 (PDT)
Date:   Mon, 16 Mar 2020 23:54:46 -0700
Message-Id: <20200317065452.236670-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v1 0/6] Fix device links functional breakage in 4.19.99
From:   Saravana Kannan <saravanak@google.com>
To:     stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in an earlier email thread [1], 4.19.99 broke the ability
to create stateful and stateless device links between the same set of
devices when it pulled in a valid bug fix [2]. While the fix was valid,
it removes a functionality that was present before the bug fix.

This patch series attempts to fix that by pulling in more patches from
upstream. I've just done compilation testing so far. But wanted to send
out a v1 to see if this patch list was acceptable before I fixed up the
commit text format to match what's needed for stable mailing list.

Some of the patches are new functionality, but for a first pass, it was
easier to pull these in than try and fix the conflicts. If these patches
are okay to pull into stable, then all I need to do is fix the commit
text.

Thanks,
Saravana

[1] - https://lore.kernel.org/stable/CAGETcx-0dKRWo=tTVcfJQhQUsMtX_LtL6yvDkb3CMbvzREsvOQ@mail.gmail.com/#t
[2] - 6fdc440366f1a99f344b629ac92f350aefd77911


Rafael J. Wysocki (5):
  driver core: Fix adding device links to probing suppliers
  driver core: Make driver core own stateful device links
  driver core: Add device link flag DL_FLAG_AUTOPROBE_CONSUMER
  driver core: Remove device link creation limitation
  driver core: Fix creation of device links with PM-runtime flags

Yong Wu (1):
  driver core: Remove the link if there is no driver with AUTO flag

 Documentation/driver-api/device_link.rst |  63 +++--
 drivers/base/core.c                      | 293 +++++++++++++++++------
 drivers/base/dd.c                        |   2 +-
 drivers/base/power/runtime.c             |   4 +-
 include/linux/device.h                   |   7 +-
 5 files changed, 265 insertions(+), 104 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

