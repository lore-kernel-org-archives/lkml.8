Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFA3C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789672074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKSsICsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504566AbgDNS7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504540AbgDNS7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:59:05 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9605C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:59:05 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w3so727464plz.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vIh5eTB8uOZv+p6Eoz7dTqGKo5Rnh4f9sFKMcqBFlS8=;
        b=TKSsICsFBab9k1r/Gi5jGrU9d5rCvU8AKwKC4tWt+X4MHt8DCtd7JylXyPtfDr97It
         cWvrhcw8k895UD38eusJiJiXLt8LJcVf5Z0GTMQSaGZKkNGuX6QUnhfCUraiApk4aPVC
         zUkxuEaZUfBnb4dgp4Wh8RldstNeGPXqBLEoFg8r+Q29SKYCDPNTewavGBOmD/z5ndit
         sA0PM1rjsRpW6QeqWDeMcUTlWpnOqsT5kP59nabvANNNLjPhqSj+/KRdaXN56Hkl3e7x
         CBNpY6OGBXo+MK5RU/QXKqUxCMUGcDACNLYg8lKP/HdrZAgGjKO8EUe2ZDtvBqYc5LoE
         rfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vIh5eTB8uOZv+p6Eoz7dTqGKo5Rnh4f9sFKMcqBFlS8=;
        b=eP3p8lIell1qz7skrMBPWZ8kl16Z0kDLlO43AM+KsQKO1hgkP6En3oyaLUaV/QGied
         4ffQxOSw2EPN3oT51PcJqe6m3PFtro8fSvRsDefBQyXO6EBP7hUI2rCun44YftObIeWw
         6ll1UbGM/GaZLZuIh6KnUlphB7t6+d2bMUC5fjN0tMOH/yu69oBF4Qxpmis7sDxRMDpZ
         ZPL3nJm2gpCIftRfoDBNhWn0A4zSz9crDn+IUdbW3I1ONFwLnfjOlrEA00GoQLAEz0kg
         LCFOYQPAFEySrYukeS40QUIIekOOJPxRvrtLb7iIfOzwxj5K0iQhcfNRJiPbIyc9Z38S
         4E9w==
X-Gm-Message-State: AGi0PuYrPhWQTq6e59SANm+kw1VMPw/9fRbvm+E77+J7uoDd9Ioy7Tr6
        EbbIJzCp+k1iWkZyYID+dub/NEUEjnCcpQ==
X-Google-Smtp-Source: APiQypLCRwItYE4hAhA2TRPzwwyxc65C2HZuJqXdiigQnh9OCq/AJAhmepoJkaAhS7Huv9Y2QbNqd8iIqzVihw==
X-Received: by 2002:a17:90a:e02:: with SMTP id v2mr1764972pje.131.1586890745234;
 Tue, 14 Apr 2020 11:59:05 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:58:21 -0700
Message-Id: <20200414115512.1.I9dd050ead919f2cc3ef83d4e866de537c7799cf3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] Bluetooth: Terminate the link if pairing is cancelled
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user decides to cancel ongoing pairing process (e.g. by clicking
the cancel button on the pairing/passkey window), abort any ongoing
pairing and then terminate the link.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---
Hello Linux-Bluetooth,

  This patch aborts any ongoing pairing and then terminates the link
  by calling hci_abort_conn() in cancel_pair_device() function.

  However, I'm not very sure if hci_abort_conn() should be called here
  in cancel_pair_device() or in smp for example to terminate the link
  after it had sent the pairing failed PDU.

  Please share your thoughts on this.

Thanks and regards,
Manish.

 net/bluetooth/mgmt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6552003a170eb..1aaa44282af4f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3030,6 +3030,18 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
 				addr, sizeof(*addr));
+
+	/* Since user doesn't want to proceed with the connection,
+	 * abort any ongoing pairing and then terminate the link.
+	 */
+	if (addr->type == BDADDR_BREDR)
+		hci_remove_link_key(hdev, &addr->bdaddr);
+	else
+		smp_cancel_and_remove_pairing(hdev, &addr->bdaddr,
+					      le_addr_type(addr->type));
+
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
-- 
2.26.0.110.g2183baf09c-goog

