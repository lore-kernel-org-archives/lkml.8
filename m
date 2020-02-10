Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2FEC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC57B20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339518;
	bh=+vlZxH7/7WspdQ5tkO7amYkhKFFU+mFcdbP1wpj3Nhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wq3Ck1SnLhfvP99aRhdKHqPG10wNz4Tpeo3b6RWwFfNRt3yFQaLakyLdYR4dqG20U
	 IfgV/agTKf6zDe+2bSS1282GokoaG2vAOjMn/cUIf/XFlheqoJ186C8hDRlMykXTSD
	 R+Wm39jPZMmsVkjnfXHAO9ARD2z3mw5RRYWqggtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgBJMlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbgBJMij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:39 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1BC20838;
        Mon, 10 Feb 2020 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338318;
        bh=+vlZxH7/7WspdQ5tkO7amYkhKFFU+mFcdbP1wpj3Nhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNI6TMJLXzLBRzXEB1OYog4km+KBeBaFrEIiZrmYPP8G7YYNWCzyTtOh8hb8XP1de
         RMMkV++g1JxCN1kacYqKEh7zT5QlX4HoeijpNU4fl+UYXJKCpcqWx1OlZisz/118BH
         edinwGzFN5HYmclWeEm1Mbq0zFUwvX5EAHoOW1WE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 247/309] NFC: pn544: Adjust indentation in pn544_hci_check_presence
Date:   Mon, 10 Feb 2020 04:33:23 -0800
Message-Id: <20200210122430.240762189@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 5080832627b65e3772a35d1dced68c64e2b24442 upstream.

Clang warns

../drivers/nfc/pn544/pn544.c:696:4: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
                 return nfc_hci_send_cmd(hdev, NFC_HCI_RF_READER_A_GATE,
                 ^
../drivers/nfc/pn544/pn544.c:692:3: note: previous statement is here
                if (target->nfcid1_len != 4 && target->nfcid1_len != 7 &&
                ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: da052850b911 ("NFC: Add pn544 presence check for different targets")
Link: https://github.com/ClangBuiltLinux/linux/issues/814
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nfc/pn544/pn544.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -693,7 +693,7 @@ static int pn544_hci_check_presence(stru
 		    target->nfcid1_len != 10)
 			return -EOPNOTSUPP;
 
-		 return nfc_hci_send_cmd(hdev, NFC_HCI_RF_READER_A_GATE,
+		return nfc_hci_send_cmd(hdev, NFC_HCI_RF_READER_A_GATE,
 				     PN544_RF_READER_CMD_ACTIVATE_NEXT,
 				     target->nfcid1, target->nfcid1_len, NULL);
 	} else if (target->supported_protocols & (NFC_PROTO_JEWEL_MASK |


