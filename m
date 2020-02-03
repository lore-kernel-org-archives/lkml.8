Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75740C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3DE2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746873;
	bh=Arc0U913xpYMv6QaRiyEBGeYzW3xkup4GFG9woCvfAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qnbrTP+aN4Et2yaDnzHK4ORwg9l5oMrLXPdBmt92CsM1Vle6vii7t8HZh4nN068Yy
	 SsQ2MTqlLiMFVRP3feheHa/lt9J2NrzVhpnUADTlPvVtirxS30WfbTDnGesjxjbf2G
	 Mb4EfJtKAkK5Jm+Nwq1oVy+TD/7WgOwEUaoqqvDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgBCQVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:32974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgBCQVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:09 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1522082E;
        Mon,  3 Feb 2020 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746869;
        bh=Arc0U913xpYMv6QaRiyEBGeYzW3xkup4GFG9woCvfAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haoDnF+yle9GqgaIjSw5REIe6z4U+gOdNCjk/yQbg73+p6lmj8G+KQFJyYI01hbur
         TQQnqLLS+WoEHK7cyZL1crFFElA6OK6v0EeKQxG7ira5e++s2xBNe/cqJHUojvYRci
         jcKBVXSIshRVx50igdty4RHshB+ZxCAhdC1TN9xA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 4.4 08/53] staging: wlan-ng: ensure error return is actually returned
Date:   Mon,  3 Feb 2020 16:19:00 +0000
Message-Id: <20200203161904.626327949@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 4cc41cbce536876678b35e03c4a8a7bb72c78fa9 upstream.

Currently when the call to prism2sta_ifst fails a netdev_err error
is reported, error return variable result is set to -1 but the
function always returns 0 for success.  Fix this by returning
the error value in variable result rather than 0.

Addresses-Coverity: ("Unused value")
Fixes: 00b3ed168508 ("Staging: add wlan-ng prism2 usb driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200114181604.390235-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wlan-ng/prism2mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -940,7 +940,7 @@ int prism2mgmt_flashdl_state(wlandevice_
 		}
 	}
 
-	return 0;
+	return result;
 }
 
 /*----------------------------------------------------------------


