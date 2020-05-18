Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87287C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECE420829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823732;
	bh=Dxtp7wZr+KCgB4BFiDjfvZsiwpeRcjrdT8Aibw8qr8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x9vwgfy+6Hx/yJtLCyl4oQSjoa8Selv0MH239WweztNfKeIDZesx7MSdC7za1XtVF
	 cEduRT/2nYq0nTZ0wsKqO/RO7up6tiDWGyjYUlcKjOhxqGWmshAf1JucwPegZLhkES
	 K2BTL7Wyu39n5MMaWYDQHhkGviWW0d+a28cM0ljA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgERRmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbgERRl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:41:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 218CE207C4;
        Mon, 18 May 2020 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823719;
        bh=Dxtp7wZr+KCgB4BFiDjfvZsiwpeRcjrdT8Aibw8qr8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMfRCmm3mheiNcfqWKrRHTCuYaY1ZmJmmYV0GtDcLSMEU1alK5q1Km2gJYhoBvQfw
         ID3vBQV0vCCLdXGc9w/uzFlH9Jxm0jPQEChqFZdoicegevE2KlmSXDgamSddwfkG9d
         AP0u01lEdMQLe0pgeN/a4Gc94vNsGmy1v+A/2RmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Jolly <Kangie@footclan.ninja>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 01/90] USB: serial: qcserial: Add DW5816e support
Date:   Mon, 18 May 2020 19:35:39 +0200
Message-Id: <20200518173451.222554323@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
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
@@ -177,6 +177,7 @@ static const struct usb_device_id id_tab
 	{DEVICE_SWI(0x413c, 0x81b3)},	/* Dell Wireless 5809e Gobi(TM) 4G LTE Mobile Broadband Card (rev3) */
 	{DEVICE_SWI(0x413c, 0x81b5)},	/* Dell Wireless 5811e QDL */
 	{DEVICE_SWI(0x413c, 0x81b6)},	/* Dell Wireless 5811e QDL */
+	{DEVICE_SWI(0x413c, 0x81cc)},	/* Dell Wireless 5816e */
 	{DEVICE_SWI(0x413c, 0x81cf)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */


