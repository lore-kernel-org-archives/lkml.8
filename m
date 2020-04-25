Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A677EC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C2A2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdSKweh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDYXeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDYXeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:34:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63FC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 16:34:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so16091984wrq.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 16:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GR6Zp93w2P9nAEpmtk3P+nTTTrGY8uPP/pZ5DAWZeKk=;
        b=MdSKweh+JscsTN879u2NQv0JkN49sSglDkE7v9OyXfLIFFcZdXbEtdsD0cNjLClc/1
         X/HHqsMuojP0QuiaBhnsJs0f8e5QIj7JL0PSBpmZPiH+12T2l7O95iVE3ii0ToxM5uPO
         lqBKieSlOC3Cmx9ufSY+IBUbMlSNviJ/5FBbhPaflyQSpIfDksgDIfP2X9QAj9DiQlR/
         kSak9HxW6BghvVRtNZ5ujuwIg/weqGaH71P7xYYTe6tRefRXnHQ4lfoKJ5LChKuYdspG
         qzrH7qACTE2Jz8Y1bPmuCPlO0E41XrM4Lmuaw6RaFrR+3Nbg64tZ3BGp86A/uH1RyMb0
         9vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GR6Zp93w2P9nAEpmtk3P+nTTTrGY8uPP/pZ5DAWZeKk=;
        b=XbjX1Iv85hndGEnR7xpsMEiu/Z1Ba0kOIaa33lglQWHZcnl34/7FfzVcYG4Ds4xXlx
         kaKbrbZ8SXGVxcg66VoYWFuR5ohUmnhdekM/xMUXTB2+U7PWtynhlb7jSq96coWluQIj
         NNKi/FqQKxLkoX1DNACjn5v26ALnSZDXTxAdbh9aPlhzlR7kvh3NCGVhe255YCfZjRbb
         gVnEUYf/TL9D6xqVgFvoRzSvNyvc/ifEsb0Q0eRq6/J6Na+xkGbnz/YY1FtDvEMRv8gQ
         jtVTZCRfeFMMBo+8ZFhdg2GJePyj1yN1W2O7+ar78Gfs/O5LVY3j7ahiwiDThDQ8blEN
         D2bQ==
X-Gm-Message-State: AGi0Pubtl6kKsMKJ4VVpBVIfud+dIMlsRaasJwiLyrchdF6u1eo+O9YG
        JiIQSZMtMkp9nn66Xo7tH44=
X-Google-Smtp-Source: APiQypIUc0sCBKsFLqPzqpWHrlBzRSIyhcwP3/mDcDrbqAyZ55yL5C6sFnXLtGyBafxCZ0XgEsJGGA==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr19840423wrx.239.1587857640288;
        Sat, 25 Apr 2020 16:34:00 -0700 (PDT)
Received: from josarchlaptop.nilsvital.de (pD9F5358A.dip0.t-ipconnect.de. [217.245.53.138])
        by smtp.gmail.com with ESMTPSA id l5sm8886988wmi.22.2020.04.25.16.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 16:33:59 -0700 (PDT)
Received: by josarchlaptop.nilsvital.de (sSMTP sendmail emulation); Sun, 26 Apr 2020 01:33:58 +0200
From:   Johannes Hostert <jojohostert@gmail.com>
Cc:     Johannes Hostert <jojohostert@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Eric Biggers <ebiggers@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vt: vt_ioctl: Add new ioctl to read vt switch lock state
Date:   Sun, 26 Apr 2020 01:14:34 +0200
Message-Id: <20200425231436.535671-1-jojohostert@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing ioctls VT_LOCKSWITCH and VT_UNLOCKSWITCH can be used to
allow/disallow switching the virtual terminal. However, no mechanism
exists that allows software to read this lock state.

Userspace programs that try to switch to another virtual terminal
like chvt have no mechanism to figure out whether they will be able
to actually switch the terminal. When eg. chvt is run while terminal
switching is disabled, it simply sleeps forever waiting for the target
terminal to become active.

This commit introduces a new ioctl VT_GETLOCKSWITCH that allows
reading the current state of the switch lock flag. Userspace
software can then use that flag and handle not being able to switch
virtual terminals.

Example program using this:

#include <linux/vt.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
#include <error.h>
#include <unistd.h>
const char* console_device = "/dev/tty0";
int main(int argc, char* argv[]) {
	int fd;
	while ((fd = open(console_device, O_RDWR)) == -1 && errno == EINTR);
	if (fd < 0)
		error(1, errno, "Opening %s", console_device);
        int ret;
	while ((ret = ioctl(fd, VT_GETLOCKSWITCH, 1)) == -1 && errno == EINTR);
	if (ret == -1)
		error(1, errno, "%s: VT_GETLOCKSWITCH", console_device);
	printf("VT switching is %s\n", ret == 1 ? "locked" : "unlocked");
	close(fd);
	return 0;
}

Signed-off-by: Johannes Hostert <jojohostert@gmail.com>
---
 drivers/tty/vt/vt_ioctl.c | 5 +++++
 include/uapi/linux/vt.h   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index daf61c28ba76..08b808e1fbf0 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -1028,6 +1028,11 @@ int vt_ioctl(struct tty_struct *tty,
 			return -EPERM;
 		vt_dont_switch = false;
 		break;
+	case VT_GETLOCKSWITCH:
+		if (!capable(CAP_SYS_TTY_CONFIG))
+			return -EPERM;
+		ret = vt_dont_switch ? 1 : 0;
+		break;
 	case VT_GETHIFONTMASK:
 		ret = put_user(vc->vc_hi_font_mask,
 					(unsigned short __user *)arg);
diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index e9d39c48520a..13a1e82dfb14 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -61,6 +61,7 @@ struct vt_consize {
 #define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
 #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
 #define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
+#define VT_GETLOCKSWITCH 0x5610  /* return vt switch lock state */
 #define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
 
 struct vt_event {
-- 
2.26.2

