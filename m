Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF47C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64505221F7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941980;
	bh=UQTb17VpJF7rVet1z8Fd6o6uOUt3kxUY1QCJt/O4V34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wD9Fto0ehduCITOf5B/Cf9zFbF+2nrcT/S0kne1tQPXVlyEYEMjJBcXy0CCiYtAlC
	 AdzW+jmJ+zDhQAXYpKCvKePh+d7pWxyu7KJznM7PvEuLxxwIzcHTrZIkHyc5Cc25Hn
	 vtvSD/c5ZJKWlg0Q+1ixE2VwNn4/QmvRBReGTIUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgEHMqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbgEHMqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:46:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04F62145D;
        Fri,  8 May 2020 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941971;
        bh=UQTb17VpJF7rVet1z8Fd6o6uOUt3kxUY1QCJt/O4V34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZykJ76YcYo5Bt0WRjXEYf0t3o9Nn5aoFG2mereW6bPzlnmVX/wLSu5xVNew5wnL8
         0kHnlOg7K/K8iorqAjBbBNz1z58sRM32oOthb956skRQAilcvcwSuylrECqbYdQ+l1
         oNu/xhsCrcNjU6MJYTfHqMh7VABnWBNMG55l2N/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tahsin Erdogan <tahsin@google.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.4 246/312] dm: fix second blk_delay_queue() parameter to be in msec units not jiffies
Date:   Fri,  8 May 2020 14:33:57 +0200
Message-Id: <20200508123141.719047130@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tahsin Erdogan <tahsin@google.com>

commit bd9f55ea1cf6e14eb054b06ea877d2d1fa339514 upstream.

Commit d548b34b062 ("dm: reduce the queue delay used in dm_request_fn
from 100ms to 10ms") always intended the value to be 10 msecs -- it
just expressed it in jiffies because earlier commit 7eaceaccab ("block:
remove per-queue plugging") did.

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Fixes: d548b34b062 ("dm: reduce the queue delay used in dm_request_fn from 100ms to 10ms")
Cc: stable@vger.kernel.org # 4.1+ -- stable@ backports must be applied to drivers/md/dm.c
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2192,7 +2192,7 @@ static void dm_request_fn(struct request
 	goto out;
 
 delay_and_out:
-	blk_delay_queue(q, HZ / 100);
+	blk_delay_queue(q, 10);
 out:
 	dm_put_live_table(md, srcu_idx);
 }


