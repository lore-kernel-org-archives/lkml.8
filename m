Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71569C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478DF208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fgh0EBDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgHZNz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:55:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53086 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730401AbgHZNxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598450026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=a6/9RWVH+HHXGBzEDVLsEfL1x5d6HiPRbZYXddcAxi4=;
        b=Fgh0EBDHnwgzntyr2ZRCNIs93/lZx+s491I7tBV+igCpaSoTWUpvBSi77Bps6IRAlUia8h
        9inKnEAv9UNvdF7GstDwxv8CS2UGJRWItATl5S7Zntby0paW7pYziVHncu19r7hqALGSa1
        dcnA3GxjYXniB6KAKVby01uBNX5llck=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-21eCWtFsODCtr-C72N-74A-1; Wed, 26 Aug 2020 09:53:43 -0400
X-MC-Unique: 21eCWtFsODCtr-C72N-74A-1
Received: by mail-qk1-f199.google.com with SMTP id s186so1675424qka.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a6/9RWVH+HHXGBzEDVLsEfL1x5d6HiPRbZYXddcAxi4=;
        b=KUNkuKhde6X1umqVdQxWpCqigZQnmxj8v1eyFNfee3KUGNrhN6uSMs3tarHQw9zz18
         3G6YMQaBdmz9SdgMUhLMEmW8bjJTPzkg+HrZ2fUqCgpZ+70sVvVpyO8XMkq6lgxj4Oy3
         8XbVad89tuVxTPYMpWGA7uN5CLkf7s4TWozc3chHBTga2Ccn19bEk7BIkly4oxXfFMXy
         GY97Rn3TLD/j/JxLKXAC909hb6OM2+1vRi0x1MYLSFS9xg9y8HE8Mr6OdjcdqLySbl6K
         VAupmPzDePytKkBM4nr6UJzKNxAfjeZzRtP4rGoM/DlZE+XxGbUR6cRY8sE8DgvewQKr
         +O7A==
X-Gm-Message-State: AOAM532B5SxdvkoyVTSOEvg+8BhSn+nlk2ZlNb5cdS69/EI+0slNvvUy
        lgEv+INOb+NKkz56KzLHF+wen66qtJx9MhbNidozTUgcScA9V9aNmBLzVpM8D1jk5OxcEhbu+em
        4XELm9z9z7K9UpvwBZYf+lEc6
X-Received: by 2002:aed:2f02:: with SMTP id l2mr14551678qtd.48.1598450023032;
        Wed, 26 Aug 2020 06:53:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLU0PrX4ZdOSvRvZ8983Or49LFMt1CgFYZh5EvWoyUBtaJfQNhfYmHygx4Cu2kvYhZdlFppg==
X-Received: by 2002:aed:2f02:: with SMTP id l2mr14551653qtd.48.1598450022746;
        Wed, 26 Aug 2020 06:53:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o16sm1725687qkj.18.2020.08.26.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:53:42 -0700 (PDT)
From:   trix@redhat.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        rikard.falkeborn@gmail.com, rogerable@realtek.com,
        lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: rtsx: improve status check
Date:   Wed, 26 Aug 2020 06:53:37 -0700
Message-Id: <20200826135337.17105-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

rtsx_usb.c:505:10: warning: The left operand of '&'
  is a garbage value
        if (val & cd_mask[card])
            ~~~ ^

val is set when rtsx_usb_get_card_status() is successful.  The
problem is how it checks its callers returns.

	/* usb_control_msg may return positive when success */
	if (ret < 0)
		return ret;

This is correct for the usb_control_msg() the call. However,
the call to rtsx_usb_get_status_with_bulk is only successful
when 0 is returned.

So make status checking block specific.

Fixes: 730876be2566 ("mfd: Add realtek USB card reader driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/cardreader/rtsx_usb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 59eda55d92a3..bd392b0c66af 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -304,14 +304,15 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 		*status = *buf;
 
 		kfree(buf);
+
+		/* usb_control_msg may return positive when success */
+		if (ret < 0)
+			return ret;
 	} else {
 		ret = rtsx_usb_get_status_with_bulk(ucr, status);
+		if (ret)
+			return ret;
 	}
-
-	/* usb_control_msg may return positive when success */
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rtsx_usb_get_card_status);
-- 
2.18.1

