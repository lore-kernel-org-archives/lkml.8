Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B515AC433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9001E20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo/NdRrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJQLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgGJQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:11:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0286DC08C5DC;
        Fri, 10 Jul 2020 09:11:05 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so4804257qtm.10;
        Fri, 10 Jul 2020 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y861TMCTvpy5racGqaIyx07iIXHTPCR4jkREHmo0X5A=;
        b=Wo/NdRrrqJwONxOj542PxpeohJSIuPR2d8D8UJ1NhigILOhHqNScqYXo4FuVZW2m3/
         4RPeZrUFgFC2r6OcczdiXafs3KAFyuFac9hPAx3VIFAquc2YLN5wZfJR2/AZuPOe/1IB
         80KfxaoKKw1yQV2CGz+SqD5mNjW2/O6nfzxTVu+Rj1AiYHvNEG5AMiv3ZGINdzhcZQFi
         i24JSldDuvZ+7xCh4BqUniylYKz/mZrnfDtPiG32tlf5xy6WYBzVSuI3/TBYee1hqDwc
         kYBrYUkhB0uSwY/2RQ0g13WfbTUrqPAhz991mdMZprIDnTXUlkHEb6evurkptYXEuxON
         7XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y861TMCTvpy5racGqaIyx07iIXHTPCR4jkREHmo0X5A=;
        b=J+QlFEn0nDg0PmFFtiooI0TqHzzfeonzKbATDgoqyNfi72egORJrFMmsbueit2S7pz
         TmZQy/oDow4zkGl4gdlYU+/J8nbPHgUFW63LxJt3pGSxekN6vxyMsC+DJJhMaZbv6/tG
         noaJnMSzPt0au+B9KYEYk27nroLKBpeqZTO4LhpQU5DYDVZe4hLNRoSy7iQsoQFlg8bw
         1P7wEPnkUTKeq87TPSy06kiUrgaRqfXzfYub1Wq/se3uiywFv2ETUuigfcqFtUY3fqdq
         L+JSu3C/5ZY1kf95j/bzUqaxezJj43s8lZm56xhr6VxbCSHN5wcrhlh0UwyhR6l3fDDw
         /iPg==
X-Gm-Message-State: AOAM5337nmwuiiVT+cjxBGrO2GMRuMunhj9Q4X00PSRfnpRdVK81wXhx
        hQi+7bCJ8VPIbZehsxN5G5o1ZoJpiioU
X-Google-Smtp-Source: ABdhPJzpzxl71N47ydC8eo3OOanW2bRGZsq9dHQ51PlHyGRFUZjTOqsaik7xr3g2ncxiofZqEgzKxA==
X-Received: by 2002:ac8:7454:: with SMTP id h20mr26634878qtr.84.1594397465192;
        Fri, 10 Jul 2020 09:11:05 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id o18sm7360586qkk.91.2020.07.10.09.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:11:04 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v3] net/bluetooth: Fix slab-out-of-bounds read in hci_extended_inquiry_result_evt()
Date:   Fri, 10 Jul 2020 12:09:15 -0400
Message-Id: <20200710160915.228980-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709130224.214204-1-yepeilin.cs@gmail.com>
References: <20200709130224.214204-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check upon `num_rsp` is insufficient. A malformed event packet with a
large `num_rsp` number makes hci_extended_inquiry_result_evt() go out
of bounds. Fix it.

This patch fixes the following syzbot bug:

    https://syzkaller.appspot.com/bug?id=4bf11aa05c4ca51ce0df86e500fce486552dc8d2

Reported-by: syzbot+d8489a79b781849b9c46@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v3:
    - Minimum `skb->len` requirement was 1 byte inaccurate since `info`
      starts from `skb->data + 1`. Fix it.

Changes in v2:
    - Use `skb->len` instead of `skb->truesize` as the length limit.
    - Leave `num_rsp` as of type `int`.

 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 03a0759f2fc2..13d8802b8137 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4375,7 +4375,7 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
-	if (!num_rsp)
+	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
-- 
2.25.1

