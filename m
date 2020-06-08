Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E933C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646EB206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663197;
	bh=jToSYFS2vOMZ5n1wXwwMj/jz/gA41gucPfwOiuHznQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xfUMsCpkD8RNX/MKoO567dTihYojk+5rXadQ9AVSJFHkTIhav2FhWOpHC+sm1AVXW
	 JR5JO0lw2JpJHHrEhOPHMJpr+2e+dP0vMwLkvY1AK1XkVTPioF504eUub56noo+lYO
	 4dmlYQZ+JPBdFU3sVaiV0PTyAikCut59Ck6+E+a4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbgFIAj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgFHXNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2820021501;
        Mon,  8 Jun 2020 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657991;
        bh=jToSYFS2vOMZ5n1wXwwMj/jz/gA41gucPfwOiuHznQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFFreVBz/tqfg63N5qSO7+Iqor9MN0d0WxHNZWlmtAyhTPmRZz/3nRzGJRMLzO6CR
         dZa7gne1KMotqJ8NBkWbQVDFqK+FltoS4sywUD1PDsGwespxwCxMx4hAaBUHuKBLf3
         46xqzah11To64YyZ0zikqfJEbgTDJViGgb1JQqNE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 050/606] usb: gadget: net2272: Fix a memory leak in an error handling path in 'net2272_plat_probe()'
Date:   Mon,  8 Jun 2020 19:02:55 -0400
Message-Id: <20200608231211.3363633-50-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit ccaef7e6e354fb65758eaddd3eae8065a8b3e295 upstream.

'dev' is allocated in 'net2272_probe_init()'. It must be freed in the error
handling path, as already done in the remove function (i.e.
'net2272_plat_remove()')

Fixes: 90fccb529d24 ("usb: gadget: Gadget directory cleanup - group UDC drivers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/net2272.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index a8273b589456..5af0fe9c61d7 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2647,6 +2647,8 @@ net2272_plat_probe(struct platform_device *pdev)
  err_req:
 	release_mem_region(base, len);
  err:
+	kfree(dev);
+
 	return ret;
 }
 
-- 
2.25.1

