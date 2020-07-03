Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64006C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4744020870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJ9YkqRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgGCRnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgGCRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FD0C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so33374790wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ar/8CXa0JGn4ACsDbJKg13GYxeqcnHfkQOqZqxVb5Xk=;
        b=ZJ9YkqRCR08W7D/BoyIV25JCVqlnsEAFqL/a7+GssUrikvJ3UgUMYFFVr4kb6PlfkP
         PbEu/8Uy/n+c6uq+uHe3+nd6v/dr7FD5VjlMHCvl3xObQ5xGJshqkgN+Jxtt7679kskB
         QR6eC0Jr+WTrpNO/QE2ddYQ3aCYDTWlt0Zmc8ijuvi1X7m1BFEK4o9ssVxNpSo5a9Lg3
         DI5y2oxQ+iaeIfSi30Qo4bcIEd+idvYXfrz7+waxin9TDsyAFkMhisTWqauwWGKu2Hv2
         tmRh3A+nSgtNzrT5raJfpL0gBQUD8a/vgo3jBXXMWiSgBaf1Aof3yoiB0TXmXdxMNFhE
         u9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ar/8CXa0JGn4ACsDbJKg13GYxeqcnHfkQOqZqxVb5Xk=;
        b=XGlEOb6o4O+hKijzfQootjh7AdhUYT3Y7N6NVbXi2X8WdHJl0vJoXZ+P0PBbR8vVbg
         V7MD5G4F5avjhMfsWWcuU1xVI7bXzk6U/2sdXhChjjV9et6B/YCvR8qBbTGs6K9nOQpr
         dR5mBTd6I7HmFS+yDseiJiix0w/oRl2++SXTBlgUtHT5mrR/f43/gh02iIQDU5Ndumuf
         ASABcT1KYXvzxN5eA4x+xhqWe2wETM/CsuQdK/MJTr2KuQXDyvQ9FepevsTJCqa1n6RH
         N24Y11N6ObHrsaXw/zXuUwf9w/7pu0MH17MxhGL2mojbcdaaimNTL4AVFmVVpxKu5TFK
         k9wg==
X-Gm-Message-State: AOAM532b5KeZn/vJVZZEVeiizXKYamdF+7xTRzteNC4O98p81DkZtwqy
        9hIjw8W1gDTIPi1rKKvGKsNnXw==
X-Google-Smtp-Source: ABdhPJz/OvxTAkEUca7rh74VV65Ur3XQuwUIc/y51MuJ27q7FM/HDh2vT2rioaHvtnLRjIXkbXLZig==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr40040224wmh.159.1593798173424;
        Fri, 03 Jul 2020 10:42:53 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Christian Lucht <lucht@codemercs.com>,
        Stephane Dalton <sdalton@videotron.ca>,
        Stephane Doyon <s.doyon@videotron.ca>
Subject: [PATCH 24/30] usb: misc: iowarrior: Fix odd corruption issue in the file header
Date:   Fri,  3 Jul 2020 18:41:42 +0100
Message-Id: <20200703174148.2749969-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks although Stephane's name was corrupted somehow.

Cc: Johan Hovold <johan@kernel.org>
Cc: Christian Lucht <lucht@codemercs.com>
Cc: Stephane Dalton <sdalton@videotron.ca>
Cc: Stephane Doyon <s.doyon@videotron.ca>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/misc/iowarrior.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index dce20301e367a..40e8c06894bff 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -9,7 +9,7 @@
 
  *  usb-skeleton.c by Greg Kroah-Hartman  <greg@kroah.com>
  *  brlvger.c by Stephane Dalton  <sdalton@videotron.ca>
- *           and St�hane Doyon   <s.doyon@videotron.ca>
+ *           and Stephane Doyon   <s.doyon@videotron.ca>
  *
  *  Released under the GPLv2.
  */
-- 
2.25.1

