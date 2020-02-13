Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2324C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA9A20656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610175;
	bh=GA+fYb+0DRK+VeQeKUaCgGZFbiP+DH5OSDA2JxVANdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P2CEcSnYkvLa0XEsna7qDcRIqGloflJh7Um03mHY+VXY4XmatIS9pd9ZYGJ5WaBVh
	 1N9wGIz2VNJqTdxeVnzP8YMu3/c1LJ+RZaZFQ97DQyA7s94QK+xTku0d0MlQojbk0q
	 SW75fOVrn1ftcfP+EYZYZ7fiT1DVQ0zzVmRigvqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgBMQJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgBMPWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:46 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D0420848;
        Thu, 13 Feb 2020 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607364;
        bh=GA+fYb+0DRK+VeQeKUaCgGZFbiP+DH5OSDA2JxVANdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUw9oQouQCOnJTf01fKwbjsENNHpvCb+q27LDuCyIdTDJe86B/1ZrHivl3Uy9twO6
         eiNu6dGnmHviOiGgkodPoZzDQBEQVjG3/nNXkw+7SLNqAXvuduASDMbxoX3qV009Gm
         A7yecDuKMzYURv4hZ9JMhSDAiZk6/3ZhMGGIstEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 52/91] NFC: pn544: Adjust indentation in pn544_hci_check_presence
Date:   Thu, 13 Feb 2020 07:20:09 -0800
Message-Id: <20200213151841.756541891@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
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
@@ -704,7 +704,7 @@ static int pn544_hci_check_presence(stru
 		    target->nfcid1_len != 10)
 			return -EOPNOTSUPP;
 
-		 return nfc_hci_send_cmd(hdev, NFC_HCI_RF_READER_A_GATE,
+		return nfc_hci_send_cmd(hdev, NFC_HCI_RF_READER_A_GATE,
 				     PN544_RF_READER_CMD_ACTIVATE_NEXT,
 				     target->nfcid1, target->nfcid1_len, NULL);
 	} else if (target->supported_protocols & (NFC_PROTO_JEWEL_MASK |


