Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86076C34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8072465D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055812;
	bh=9ywhAYA701m1EHwH2msV5Pz/2sBLkQudXHocBsn18Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rge4z3toepKlY/m8DhnDhmMMvA4qumJQH8Hg8jXiw+eHYoT+YtK1FUspy0aZ4MZfH
	 q/gpzrZHlnl8ZD6holxPMcLCF5QoleZfbm/LlhgF0+p14juyKLRe4gXydAAOEazvZC
	 91ZIZxjo8ZtNLhXLKRKaFKYXeV3N0lNy//IF7Ips=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgBRT4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbgBRT4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:56:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B30872465D;
        Tue, 18 Feb 2020 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055807;
        bh=9ywhAYA701m1EHwH2msV5Pz/2sBLkQudXHocBsn18Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLc2h4mgvhKTQdSBa7n/r4+TGTb9zs2dlK0A6Ph1jEh4l9Kjvxnx6TB9gVwdIfGu1
         FOvDgZMz/feZ3DjBKA+SaKmf7A3XS4wGsFcjq31q2KmXGpet5q/MVy/eI5l2cu20A2
         GF7Qe4EvILEVWZ5g12vt24XLhPmACiyytgk82tKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 03/38] Input: synaptics - remove the LEN0049 dmi id from topbuttonpad list
Date:   Tue, 18 Feb 2020 20:54:49 +0100
Message-Id: <20200218190418.929869076@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190418.536430858@linuxfoundation.org>
References: <20200218190418.536430858@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 5179a9dfa9440c1781816e2c9a183d1d2512dc61 upstream.

The Yoga 11e is using LEN0049, but it doesn't have a trackstick.

Thus, there is no need to create a software top buttons row.

However, it seems that the device works under SMBus, so keep it as part
of the smbus_pnp_ids.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200115013023.9710-1-benjamin.tissoires@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -149,7 +149,6 @@ static const char * const topbuttonpad_p
 	"LEN0042", /* Yoga */
 	"LEN0045",
 	"LEN0047",
-	"LEN0049",
 	"LEN2000", /* S540 */
 	"LEN2001", /* Edge E431 */
 	"LEN2002", /* Edge E531 */
@@ -169,6 +168,7 @@ static const char * const smbus_pnp_ids[
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
+	"LEN0049", /* Yoga 11e */
 	"LEN004a", /* W541 */
 	"LEN005b", /* P50 */
 	"LEN005e", /* T560 */


