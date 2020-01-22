Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B386224125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699143;
	bh=zHGxkpxG/eZRsdg4/16Zck/ramCs3aNedGgjwlOlSDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IzxsU0mgRl7Zw+rlIkSae5N1MhLVtXcAluhLLRRHmDrzwU+jzZ8EIurKwEOAUG7fe
	 C9xBTC4w90smKLdlxzR4XWb263aiu2B6jxUnYAzvi44A44ji/qn+krti5LjGIquXGu
	 Gjf/YbVKqQblVhYsyT2iwsB2tGp26ht8xDzRGeXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgAVNTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:19:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbgAVNS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:18:56 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C9424125;
        Wed, 22 Jan 2020 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699135;
        bh=zHGxkpxG/eZRsdg4/16Zck/ramCs3aNedGgjwlOlSDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxqbLnmkwN+KqkiGcug85yFSc622iYRce77cW1OjIlwiuOqysicyLmF9B18cxR7RT
         HxI5/7VCHC2qz+fk823eo/hmmnvo7ds01dwHGOSC0sXjKCx/TxyseD/X9sEOEBYPAA
         r/WSwP2BFctfknnmaKIwFmbulY9iAtLB59gKWpZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 051/222] USB: serial: keyspan: handle unbound ports
Date:   Wed, 22 Jan 2020 10:27:17 +0100
Message-Id: <20200122092837.265058198@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 3018dd3fa114b13261e9599ddb5656ef97a1fa17 upstream.

Check for NULL port data in the control URB completion handlers to avoid
dereferencing a NULL pointer in the unlikely case where a port device
isn't bound to a driver (e.g. after an allocation failure on port
probe()).

Fixes: 0ca1268e109a ("USB Serial Keyspan: add support for USA-49WG & USA-28XG")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/keyspan.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -1058,6 +1058,8 @@ static void	usa49_glocont_callback(struc
 	for (i = 0; i < serial->num_ports; ++i) {
 		port = serial->port[i];
 		p_priv = usb_get_serial_port_data(port);
+		if (!p_priv)
+			continue;
 
 		if (p_priv->resend_cont) {
 			dev_dbg(&port->dev, "%s - sending setup\n", __func__);
@@ -1459,6 +1461,8 @@ static void usa67_glocont_callback(struc
 	for (i = 0; i < serial->num_ports; ++i) {
 		port = serial->port[i];
 		p_priv = usb_get_serial_port_data(port);
+		if (!p_priv)
+			continue;
 
 		if (p_priv->resend_cont) {
 			dev_dbg(&port->dev, "%s - sending setup\n", __func__);


