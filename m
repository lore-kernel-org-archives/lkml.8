Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFECCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C200E2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646087;
	bh=6+miePqbsWnqPWj5QsrnY3qI0o3oL7KNQ57soRmKgJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y72AL9NSPn2CDmMRvR43W4Gl3L+D3ul4lm9wgyUMx6/H8eL5bTC9zcg509RnMP/FK
	 hY1pK+yymHviDvfYQVdyRUFoVA0fz7zev0zeuz4bEnxWMTIaugfRLNI0tlTa1Xe2KH
	 AXVo7JlA7pS3cxAr+ncgKZ/F2O2if9Abyxf0Djko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbgCaJOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbgCaJOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:14:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9399C20675;
        Tue, 31 Mar 2020 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646083;
        bh=6+miePqbsWnqPWj5QsrnY3qI0o3oL7KNQ57soRmKgJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1I5pIPT1mdLgh6Y5bjgot9EjYi4pmwU8GFxcmNtJWAflsh1HzW0ZpG/cBEMLTAFA
         XX1pPPpxAV6FOUDteDHhRZi4EbvlW6xzTPTUrkyZr6dVgJPlS/TaOhMJZfYn9iXhm9
         VQxP7t4Btgwefj8vFVxj2+zu/v53z4hTjAQT4WIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yussuf Khalil <dev@pp3345.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.4 079/155] Input: synaptics - enable RMI on HP Envy 13-ad105ng
Date:   Tue, 31 Mar 2020 10:58:39 +0200
Message-Id: <20200331085427.207521769@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yussuf Khalil <dev@pp3345.net>

commit 1369d0abe469fb4cdea8a5bce219d38cb857a658 upstream.

This laptop (and perhaps other variants of the same model) reports an
SMBus-capable Synaptics touchpad. Everything (including suspend and
resume) works fine when RMI is enabled via the kernel command line, so
let's add it to the whitelist.

Signed-off-by: Yussuf Khalil <dev@pp3345.net>
Link: https://lore.kernel.org/r/20200307213508.267187-1-dev@pp3345.net
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -186,6 +186,7 @@ static const char * const smbus_pnp_ids[
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
+	"SYN3257", /* HP Envy 13-ad105ng */
 	NULL
 };
 


