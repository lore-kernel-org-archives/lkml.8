Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8C5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBB12067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQbRVPQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHXVKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:10:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21690 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726138AbgHXVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598303435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=98P4pw0MSJfjYTwg7Jr3bMvh36DJTSmp1NgoIinTZVY=;
        b=AQbRVPQ5OkMoXBg3kUhGbeMt1LVzqxvnBmZQxhhrv0PiPXUu3Gkw4qpL9wwhAiy4TeoPMw
        5S7RwLZaFxEUlYYR+KN2vqYABXQYrFuqgOpVY0i+Xdtj0HGcqkPds5Fv1z1Xtv+zSPY0f8
        33U3gPbURsWupNIT6RtZAZIW9vvi61A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-3KxpaBvbNsiOc6l5ve7Cvw-1; Mon, 24 Aug 2020 17:10:34 -0400
X-MC-Unique: 3KxpaBvbNsiOc6l5ve7Cvw-1
Received: by mail-qv1-f69.google.com with SMTP id k17so7296043qvj.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=98P4pw0MSJfjYTwg7Jr3bMvh36DJTSmp1NgoIinTZVY=;
        b=kK0Ynx1dfR+qtgFkb3lyyvP3BT0u+ATsiGD9sKQKY4zjcefmOHBAGEzNQKK7dRi57q
         3vNmuM25804Ad1v5y0uLjrKUPIHqp6QztMLyshSHMo4tO/TyQrDRd2R6ofz/UEBnRRqK
         bzmtUMYXQdYHeAJ4b1MN2wzmGEEhI88yWBsj/M+bqwvE61N18tZ/g79s3RLRZBUC2lE6
         2ayQhcD4YrwOBR9WNq2mGK/urB948d+SvjDCnUPPIRtP953tZz26fsLC4SNAWOqHSjHg
         S+s+nA29ie0ENBDFvJPNxc+c079682JFUtP8Ae+iqvoumZJFm+0JMzEMocxk74d5v7tG
         i0HQ==
X-Gm-Message-State: AOAM532r7LaoEgGAkiIP04a4PiYGbZoMix6CXBf6ks4INPIuWmyD51xE
        bJMpHYCZLcjHBSQo4V+S1Yw1kaHmg36sdmYbEDzLfrxTfH4KEqq0yII5hX2jOsXjXE052OVNyjb
        Uc0xPEc0osUIOWmHyzfVQo/O4
X-Received: by 2002:ac8:3894:: with SMTP id f20mr6679734qtc.243.1598303433825;
        Mon, 24 Aug 2020 14:10:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS7pZM6tz74vKWqZ0073bXmrovICgMLihNHEaqZgQPStkNvmVP3ub77pZRv8l2/JBnLnEvCw==
X-Received: by 2002:ac8:3894:: with SMTP id f20mr6679720qtc.243.1598303433555;
        Mon, 24 Aug 2020 14:10:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 198sm4681833qkh.19.2020.08.24.14.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:10:32 -0700 (PDT)
From:   trix@redhat.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] usb: storage: initialize variable
Date:   Mon, 24 Aug 2020 14:10:27 -0700
Message-Id: <20200824211027.11543-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this representative problem

transport.c:495:15: warning: Assigned value is garbage or
  undefined
        length_left -= partial;
                   ^  ~~~~~~~
partial is set only when usb_stor_bulk_transfer_sglist()
is successful.

So set partial on entry to 0.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/storage/transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 238a8088e17f..044429717dcc 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -414,6 +414,9 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
 {
 	int result;
 
+	if (act_len)
+		*act_len = 0;
+
 	/* don't submit s-g requests during abort processing */
 	if (test_bit(US_FLIDX_ABORTING, &us->dflags))
 		return USB_STOR_XFER_ERROR;
-- 
2.18.1

