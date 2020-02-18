Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBFC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8138B24672
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056106;
	bh=alfaClgMPQx9gqsYJzeSw3F99GdWFoISOuD0fIcZiQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SaAm/jnZJh6H/Ri22B2E5PbKvVevHTM7/81upOSX957eVPBJ+TlrXpD8IoPURigZ1
	 T4Tx+ooxyr4AlX1O+qvAh6CikC+R40lF9lxZ3N5qu4zS8e5gTadUYxgFcUNrSZQcJX
	 wwrXE6Tqw/M7yGEBgozOuPw2Mv4hbgOdZLdwsbPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgBRUBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgBRUBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:01:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9D824125;
        Tue, 18 Feb 2020 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056100;
        bh=alfaClgMPQx9gqsYJzeSw3F99GdWFoISOuD0fIcZiQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkyl8lxIihl1otb1zUwz5/AwpvXhN84RlK3OBfeYKzvQgEJgmliCtbFdMA4aOiMLU
         +1Hd5/PWxRFuGRIOwpMpapSKQ2jXjxkPYhLwhYzTbr/M7BMkknMoZtOzTp9Pygw+Kb
         hApp7tQjkKcMlGF+/jICOkmKlGtYjElvPHBRIZt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.5 05/80] Input: synaptics - remove the LEN0049 dmi id from topbuttonpad list
Date:   Tue, 18 Feb 2020 20:54:26 +0100
Message-Id: <20200218190432.579393316@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
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
@@ -146,7 +146,6 @@ static const char * const topbuttonpad_p
 	"LEN0042", /* Yoga */
 	"LEN0045",
 	"LEN0047",
-	"LEN0049",
 	"LEN2000", /* S540 */
 	"LEN2001", /* Edge E431 */
 	"LEN2002", /* Edge E531 */
@@ -166,6 +165,7 @@ static const char * const smbus_pnp_ids[
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
+	"LEN0049", /* Yoga 11e */
 	"LEN004a", /* W541 */
 	"LEN005b", /* P50 */
 	"LEN005e", /* T560 */


