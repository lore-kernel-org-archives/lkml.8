Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E52C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CF8206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979724;
	bh=mI2ix3jDcTd6+yitBSFLtIfCRzJi7p2SJWcUmdKPOQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WWeT3eK70067wRr7Wxe7/9cr31Q6jcMQi1VJry0OobUmr0ZHWagKGd6Dq6MLWsjKL
	 gB5LMhkuZhkAxLnTK44xVIe4afw1oonmdIZZH+OirndlxqyKmQmpEOo6fuik5WUJOe
	 vQCdJ90EhQW9obttTtEzhnI41yOjaYFoRzidXfJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgIARCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbgIAPUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:20:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 600E22078B;
        Tue,  1 Sep 2020 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973641;
        bh=mI2ix3jDcTd6+yitBSFLtIfCRzJi7p2SJWcUmdKPOQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOaDF1hrjbP+f7rrwqut4cqd/wTycV5upev5kD+TcL+5QEMRc0yThaXXe0VOLi7jt
         VSKBGA3ESpBL4DJjWq4//65aLLoWttVjhS1db9Sx0Kw+h9JD8bXUonwL3NWVmErBcW
         5mkXbf87lORh8P+tHTRD5ErmXba3knto7l0UBapQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Kennedy <george.kennedy@oracle.com>,
        syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
Subject: [PATCH 4.14 63/91] vt_ioctl: change VT_RESIZEX ioctl to check for error return from vc_resize()
Date:   Tue,  1 Sep 2020 17:10:37 +0200
Message-Id: <20200901150931.291740317@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
References: <20200901150928.096174795@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Kennedy <george.kennedy@oracle.com>

commit bc5269ca765057a1b762e79a1cfd267cd7bf1c46 upstream.

vc_resize() can return with an error after failure. Change VT_RESIZEX ioctl
to save struct vc_data values that are modified and restore the original
values in case of error.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Cc: stable <stable@vger.kernel.org>
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/1596213192-6635-2-git-send-email-george.kennedy@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt_ioctl.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -893,12 +893,22 @@ int vt_ioctl(struct tty_struct *tty,
 			console_lock();
 			vcp = vc_cons[i].d;
 			if (vcp) {
+				int ret;
+				int save_scan_lines = vcp->vc_scan_lines;
+				int save_font_height = vcp->vc_font.height;
+
 				if (v.v_vlin)
 					vcp->vc_scan_lines = v.v_vlin;
 				if (v.v_clin)
 					vcp->vc_font.height = v.v_clin;
 				vcp->vc_resize_user = 1;
-				vc_resize(vcp, v.v_cols, v.v_rows);
+				ret = vc_resize(vcp, v.v_cols, v.v_rows);
+				if (ret) {
+					vcp->vc_scan_lines = save_scan_lines;
+					vcp->vc_font.height = save_font_height;
+					console_unlock();
+					return ret;
+				}
 			}
 			console_unlock();
 		}


