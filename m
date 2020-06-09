Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE534C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFD620801
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591724975;
	bh=JWfUK1UurEc1IJd4vKsIl1wbDbG8V745DfuhATHNP6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AMz7CeAYMJD+piEJPlIUSshmlPg1FkYlQXSahCwC7PyuXpJxNHEoXmnqdzsU2D3Gz
	 Oy3YXmu6vwWdFPmeSoMKm8MBQqma4xeolKWDw1snYxyqV5AP0br4H3m+uzXICPELIB
	 M8zftgxdj13/g4mA0Uc7rYoYA1gb7vyGpaxEYWPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgFIRte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732477AbgFIRtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:49:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC95207F9;
        Tue,  9 Jun 2020 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724952;
        bh=JWfUK1UurEc1IJd4vKsIl1wbDbG8V745DfuhATHNP6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzfqydS8X0dYYZ37fABPLfc6aC8Q01t3yoOod/uLw4Sdi4qDH8KH9/26F06fRrN5n
         mTroJHHaRpRX96SGpFDkecdOqavmIr6aoe9hmfmU5hznLppqzJ8hC8yHDfgKkljLGj
         D85DjB1K+4RqRa9tGRrIUnwHFn5l8TF0Cvx1k/cA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Jolly <Kangie@footclan.ninja>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 28/42] USB: serial: qcserial: add DW5816e QDL support
Date:   Tue,  9 Jun 2020 19:44:34 +0200
Message-Id: <20200609174018.537831820@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174015.379493548@linuxfoundation.org>
References: <20200609174015.379493548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Jolly <Kangie@footclan.ninja>

commit 3429444abdd9dbd5faebd9bee552ec6162b17ad6 upstream.

Add support for Dell Wireless 5816e Download Mode (AKA boot & hold mode /
QDL download mode) to drivers/usb/serial/qcserial.c

This is required to update device firmware.

Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/qcserial.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -177,6 +177,7 @@ static const struct usb_device_id id_tab
 	{DEVICE_SWI(0x413c, 0x81b3)},	/* Dell Wireless 5809e Gobi(TM) 4G LTE Mobile Broadband Card (rev3) */
 	{DEVICE_SWI(0x413c, 0x81b5)},	/* Dell Wireless 5811e QDL */
 	{DEVICE_SWI(0x413c, 0x81b6)},	/* Dell Wireless 5811e QDL */
+	{DEVICE_SWI(0x413c, 0x81cb)},	/* Dell Wireless 5816e QDL */
 	{DEVICE_SWI(0x413c, 0x81cc)},	/* Dell Wireless 5816e */
 	{DEVICE_SWI(0x413c, 0x81cf)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */


