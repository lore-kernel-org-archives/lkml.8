Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DCFC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8280E24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056339;
	bh=FTkTj5MSQJ93p85m2u0gptLel5AoLasvSC6c9NVykF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bcnx7CuTlXG8wReFWONbJjVtv1qAk88pF3Y1MiBv3Pxxhca5abnWEVOe4q0DxH60q
	 zC0wY3/FkS9+Qx2BULcEo15l1N0Ux1dV13ppiVLwsKxm+iU14MBOb09dDCvf/WJgXB
	 b8QbYb3kAKwkqzSUJgBxk+9nggwMpoFzHYUOSA38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgBRUBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:01:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgBRUB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:01:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA292465D;
        Tue, 18 Feb 2020 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056089;
        bh=FTkTj5MSQJ93p85m2u0gptLel5AoLasvSC6c9NVykF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdaSw6Wh0TNtAiXB+oxxl2koAzKuTH3MRfnod9ompDusHvMCk/zesIr8Dbq62Zupz
         JDELYc82yUwO7U0gUIaO3DO/h0nLwJc7RNdGMzdq1cOTxDNbDdlCrfPWU/JcKlSMts
         TtN38vP9gaoW+4D9ISbb+H3KEyZFBsOxAAbi43OY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.5 03/80] Input: synaptics - switch T470s to RMI4 by default
Date:   Tue, 18 Feb 2020 20:54:24 +0100
Message-Id: <20200218190432.375143466@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit bf502391353b928e63096127e5fd8482080203f5 upstream.

This supports RMI4 and everything seems to work, including the touchpad
buttons. So, let's enable this by default.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200204194322.112638-1-lyude@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -169,6 +169,7 @@ static const char * const smbus_pnp_ids[
 	"LEN004a", /* W541 */
 	"LEN005b", /* P50 */
 	"LEN005e", /* T560 */
+	"LEN006c", /* T470s */
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */


