Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B4C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 02:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A412074A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 02:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhSZsLne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgIECEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 22:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIECEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 22:04:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E780C061244;
        Fri,  4 Sep 2020 19:04:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b16so4010366pjp.0;
        Fri, 04 Sep 2020 19:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+kZoKqKGDj4sxz/spgYXr9LUZZuZ+0ogBgOuprttQg=;
        b=uhSZsLneznox8j/wfTxJSSTDG30ykKmjtFg76kdzEeZLYy/fOrBdy2QgFGXwCKlf00
         TBtbJTueT11YFsFBkNqv2h7LKAf4bUOoigdlQZxT3U99VyTdqLoEeKJMYm/RYODVk6Fs
         LwjgGVYTI9gNPsPUxZFkT92XD244ihXCTgyY/bDaeEZ0LLT2OUgeWv5JDxBnbua2IP8i
         FrCxFp05KjRAaU5qD/0WwO8oHm86YSF9W3aksgUToopVNjzUclLczjEciCwoUGMlh5IJ
         6QSlRmCNY5K7ztgh6WsrLaCr38Jf+9hTlyY/D7Qr9r17CPEPIEErx7p2wCVsD538JqFb
         llRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+kZoKqKGDj4sxz/spgYXr9LUZZuZ+0ogBgOuprttQg=;
        b=dehFF2cN3brBxg/Wr5stzwLBdZG3sH/saP1j1LH/wx6s1VpFkvy3nNqmWqXqWJe3Wb
         RvJzLl8R5bnz2/De/eu31N42M315Mr+JVtpBJBeID6VjhgI364BucnVvIYAt7P5SQzGc
         8+zeJbtoBbvI7FJ5LRzzdA0ZNQs+s8GMZBgtNjeO7RPm2S5fME+p37AFPFtWlKd9D4Q0
         wEQ0yEfTCpDa1NFzUeTzEW+CRG1prVWbgu7R5qwYIqV+zPFhqZDaTev8sSGt+bfTBzZP
         9oeRBixPuwMUBmTJaxKh1v9PRsy9jb027owyo2zXay3TgK2umSi/p1ZcpuGmefbbVLal
         /RmQ==
X-Gm-Message-State: AOAM533UG0HQU+h9S0SmP4niNiS94Ze364hLUmTx2P9Zn7YFejxEWOex
        zcQYwXa3imkG/mc+NQfGcyDFqFRAqAW3io7q
X-Google-Smtp-Source: ABdhPJxseGxIt0034578p+AgKbObcHKZ69MVPLi1F41nrP4o5X6UV+hRLg5jABu0zSRgG8VcoBhCAw==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr10517822pjb.174.1599271474699;
        Fri, 04 Sep 2020 19:04:34 -0700 (PDT)
Received: from localhost.localdomain ([49.207.195.77])
        by smtp.gmail.com with ESMTPSA id x19sm2245332pge.22.2020.09.04.19.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 19:04:33 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] Fix uninit-value in hci_chan_lookup_handle
Date:   Sat,  5 Sep 2020 07:34:10 +0530
Message-Id: <20200905020410.20350-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the amount of data stored in the location corresponding to
iov_iter *from is less then 4, some data seems to go uninitialized.

Updating this condition accordingly, makes sense both intuitively and 
logically as well, since the other check for extreme condition done is if
len > HCI_MAX_FRAME_SIZE, which is HCI_MAX_ACL_SIZE (which is 1024) + 4;
which itself gives some idea about what must be the ideal mininum size.

Reported-and-tested by: syzbot+4c14a8f574461e1c3659@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
If there is some explicit reason why len < 4 doesn't work, and only len < 2 works, 
please do let me know.
The commit message that introduced the initial change 
(512b2268156a4e15ebf897f9a883bdee153a54b7) wasn't exactly very helpful in this 
respect, and I couldn't find a whole lot of discussion regarding this either.

 drivers/bluetooth/hci_vhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 8ab26dec5f6e..0c49821d7b98 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -159,7 +159,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 	__u8 pkt_type, opcode;
 	int ret;
 
-	if (len < 2 || len > HCI_MAX_FRAME_SIZE)
+	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
 		return -EINVAL;
 
 	skb = bt_skb_alloc(len, GFP_KERNEL);
-- 
2.25.1

