Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F34C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5D1208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322101;
	bh=d97WpFy+5OREEuxVaheOyuxtpt3chE+sXqbZmAI3iho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kOSAnL7U3F4dGEVAASxZ8w0IOzgMriPpOlZvADLFEzAAygR0Nmaot4iF/CSN/k8wI
	 pemFO3AiEPvorejiHJtFHmRgMJ6Za7/LMD8K2kEN7p2YIEr0ru9obDdCbKToqYlfJM
	 wKj6LP1eLyGdNLR0dKv9Prd7A24H81Kt3roNsc50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgFPPlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbgFPPld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:41:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F631208E4;
        Tue, 16 Jun 2020 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322092;
        bh=d97WpFy+5OREEuxVaheOyuxtpt3chE+sXqbZmAI3iho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SctYqyZ3sqWsg1If4Z1gnMOJRfC/ZKNYKRS+8cROMMn0TdKwnXrET33o0C5415HPg
         UDS5QaBYHjV6fI4+alEP8DAH5BlNYUPAxu9WdbUmJrDY+XUUC8rD5EXXJtk+nJnWyX
         XR8wF2JRZSDCW6WUUXuH6iRblZcp1PqUtGnooIKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 5.4 132/134] xen/pvcalls-back: test for errors when calling backend_connect()
Date:   Tue, 16 Jun 2020 17:35:16 +0200
Message-Id: <20200616153107.109738183@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit c8d70a29d6bbc956013f3401f92a4431a9385a3c upstream.

backend_connect() can fail, so switch the device to connected only if
no error occurred.

Fixes: 0a9c75c2c7258f2 ("xen/pvcalls: xenbus state handling")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20200511074231.19794-1-jgross@suse.com
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/pvcalls-back.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -1087,7 +1087,8 @@ static void set_backend_state(struct xen
 		case XenbusStateInitialised:
 			switch (state) {
 			case XenbusStateConnected:
-				backend_connect(dev);
+				if (backend_connect(dev))
+					return;
 				xenbus_switch_state(dev, XenbusStateConnected);
 				break;
 			case XenbusStateClosing:


