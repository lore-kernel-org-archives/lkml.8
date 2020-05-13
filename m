Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F5C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3115920740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363159;
	bh=A3Y2v+4SlLEutyfNVUrIBwwpsZ4l2T67ReBBophFU2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vc9JirldUP/aBlt2lFL24UHK4f30zJrKKtSOoQzBTK34Een9KZJc0d6QeEAfp/RTr
	 maSK6CBCCKB4yqBUepcBAiLdTBLKqtTsRRHCcvpz9EpXI13DlTr31KFw0kXidU9m5w
	 p9zY0lgUJTmQE8zsTVXh7ONY0xmsB9bBHVhU7Zm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgEMJp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730661AbgEMJp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:45:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21553206F5;
        Wed, 13 May 2020 09:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363156;
        bh=A3Y2v+4SlLEutyfNVUrIBwwpsZ4l2T67ReBBophFU2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9zexssXsyIC06zYQsyJOwX2wKYOjNL3PQqH2eLy0GKBoHK3JOkh/968+KmCyr+rI
         siyOROlye29Xcsz9iqNO8wuYEN5FR3gNHsVejBPXcuU5I+OaK3+zdy5YxGUNw6KXnl
         vZ95JItCTvqYX1zkfXo+W6EWLHUiCoSPCS9+/pks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Jolly <Kangie@footclan.ninja>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 01/48] USB: serial: qcserial: Add DW5816e support
Date:   Wed, 13 May 2020 11:44:27 +0200
Message-Id: <20200513094351.711902977@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
References: <20200513094351.100352960@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Jolly <Kangie@footclan.ninja>

commit 78d6de3cfbd342918d31cf68d0d2eda401338aef upstream.

Add support for Dell Wireless 5816e to drivers/usb/serial/qcserial.c

Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/qcserial.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -173,6 +173,7 @@ static const struct usb_device_id id_tab
 	{DEVICE_SWI(0x413c, 0x81b3)},	/* Dell Wireless 5809e Gobi(TM) 4G LTE Mobile Broadband Card (rev3) */
 	{DEVICE_SWI(0x413c, 0x81b5)},	/* Dell Wireless 5811e QDL */
 	{DEVICE_SWI(0x413c, 0x81b6)},	/* Dell Wireless 5811e QDL */
+	{DEVICE_SWI(0x413c, 0x81cc)},	/* Dell Wireless 5816e */
 	{DEVICE_SWI(0x413c, 0x81cf)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */


