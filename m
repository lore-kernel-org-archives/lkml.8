Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B28C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F6520714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759471;
	bh=/iKgduoUkNVKU9ZrPkIW5sERPFZkvrGAQfa5/ot1PG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nPND9d1IEPgt0BWZZlFuIooPmjk46cuvV8DvneqFyavCA6Tf4hD4yqqmK9SbgF+2/
	 BO0pN/KfOEXSacLCtburYislEZUv60prS7FuSTKxEizZbPS1MDpGdJQaZMcCoG5/fq
	 4arnFctJxxaYmOObVzf0CKYZHmr6LF74Crz+d41Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbgDAQo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389332AbgDAQoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:44:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7849F2071A;
        Wed,  1 Apr 2020 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759464;
        bh=/iKgduoUkNVKU9ZrPkIW5sERPFZkvrGAQfa5/ot1PG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVfi/NlC+iuameqyOInwkXf8r6f4aERlBJXlHN6uqiXMjllOH5RxoK1E26fPGwxjz
         mB7IhEzlxdNbQ8YDbrvZWuswKHYpA2MKK6pHL2w8e7gs7emhYjxttxQ3Faf3itgkXd
         x22cFEXda0JnlroJNE3FSkHExABmvdUyio55DSVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yussuf Khalil <dev@pp3345.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 089/148] Input: synaptics - enable RMI on HP Envy 13-ad105ng
Date:   Wed,  1 Apr 2020 18:18:01 +0200
Message-Id: <20200401161601.558458533@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
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
@@ -189,6 +189,7 @@ static const char * const smbus_pnp_ids[
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
+	"SYN3257", /* HP Envy 13-ad105ng */
 	NULL
 };
 


