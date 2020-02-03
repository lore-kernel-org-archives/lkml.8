Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF223C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E2920CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747952;
	bh=wuY22ular1rKxKb63oVD+ukgP8kNjdEQM+Si4zVm7Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E7DhezvXGDqbowaTpxHMIAEWvnKxJCIkEE8R77CK9VBcyd1fdduUB/+ij/cDhAq1X
	 Q6rR1yoHGsw4ljt12MUG9PZ20Aco8m8Siy/m5E3TjCHfHnz5BArMN2c/Zk2BXdUDSM
	 koj3MOBtGDe/BV0Ixn8ZnePblwqZlZGn2HQd2POc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgBCQjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730909AbgBCQh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:37:56 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8462051A;
        Mon,  3 Feb 2020 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747875;
        bh=wuY22ular1rKxKb63oVD+ukgP8kNjdEQM+Si4zVm7Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuMJXVaQGZPDxLnQmQzw1H3z66JWmeA06EqtIYePnq4vwxUN3zv64HQBaVSPsYH2L
         SHKi11eMerc2QG9qlkfa2esfF0VDYnYy/ec6YqHUx1EjgDh/oEp733idJtSap81Ifc
         agHTRzx6Zdsp/xi6a2joRefUvDPERiAR3xEIaaHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+ec869945d3dde5f33b43@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.5 17/23] media: vp7045: do not read uninitialized values if usb transfer fails
Date:   Mon,  3 Feb 2020 16:20:37 +0000
Message-Id: <20200203161905.867506901@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.288335885@linuxfoundation.org>
References: <20200203161902.288335885@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

commit 26cff637121d8bb866ebd6515c430ac890e6ec80 upstream.

It is not a fatal error if reading the mac address or the remote control
decoder state fails.

Reported-by: syzbot+ec869945d3dde5f33b43@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb/vp7045.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/drivers/media/usb/dvb-usb/vp7045.c
+++ b/drivers/media/usb/dvb-usb/vp7045.c
@@ -96,10 +96,14 @@ static int vp7045_power_ctrl(struct dvb_
 
 static int vp7045_rc_query(struct dvb_usb_device *d)
 {
+	int ret;
 	u8 key;
-	vp7045_usb_op(d,RC_VAL_READ,NULL,0,&key,1,20);
 
-	deb_rc("remote query key: %x %d\n",key,key);
+	ret = vp7045_usb_op(d, RC_VAL_READ, NULL, 0, &key, 1, 20);
+	if (ret)
+		return ret;
+
+	deb_rc("remote query key: %x\n", key);
 
 	if (key != 0x44) {
 		/*
@@ -115,15 +119,18 @@ static int vp7045_rc_query(struct dvb_us
 
 static int vp7045_read_eeprom(struct dvb_usb_device *d,u8 *buf, int len, int offset)
 {
-	int i = 0;
-	u8 v,br[2];
+	int i, ret;
+	u8 v, br[2];
 	for (i=0; i < len; i++) {
 		v = offset + i;
-		vp7045_usb_op(d,GET_EE_VALUE,&v,1,br,2,5);
+		ret = vp7045_usb_op(d, GET_EE_VALUE, &v, 1, br, 2, 5);
+		if (ret)
+			return ret;
+
 		buf[i] = br[1];
 	}
-	deb_info("VP7045 EEPROM read (offs: %d, len: %d) : ",offset, i);
-	debug_dump(buf,i,deb_info);
+	deb_info("VP7045 EEPROM read (offs: %d, len: %d) : ", offset, i);
+	debug_dump(buf, i, deb_info);
 	return 0;
 }
 


