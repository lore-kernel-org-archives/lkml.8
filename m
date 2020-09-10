Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C9C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB07320756
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ogGgIj8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgIJGFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIJGEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:04:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C90C061786
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:04:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so3989063pfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uk2jhSlsyW0uEicGAMvJSDRERxJgCUtBRzjLszfNMEM=;
        b=ogGgIj8KanMA8t16REBPMJqN3hNG+13+3sebCcyTt+DetY1CQsREBYjwwl9/aoCJ+B
         rLLdYxsaBCtFoV5xtQAQvk0YgtUunOYQlh/9uZi2h4aS7VXxHS40Miif6HgcVgncgW09
         Ffl52LwJX72tEZzV/pKa9OP6Yp5WLTcvef/ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uk2jhSlsyW0uEicGAMvJSDRERxJgCUtBRzjLszfNMEM=;
        b=UcRJh2gcmMNIfQAhrR+nKNhbtgt4KqFOeAqjE1N5mZL+v4DJIGF+ZfZktJgrQf2L/q
         v7DSf0XZTbYep7FQ84phdbz/AUgTj8GNiu34IpX1qboXGjuXMJf97b7gaqu7yCFMy6cF
         duDsJJSwiApxDz89CulcFb1mFoZFWjcsV+5qUjDSmCFHDwm64DJ0st8Po8DyjJfbuKOk
         neTNPvai7nmxccTb+L+Gl1znB97xUWGW4Fita5k7YJM7cdYVP1CuEDPC4H+BY88w+M72
         WHOKPRd9E2Qt8/PitAE/aOLSXLC1V3mFZfdYfmHzD26j9si+mAt5VxT4/f/XCx9tDx8a
         zMng==
X-Gm-Message-State: AOAM53065bvFk5xYnFoMHDb6F1N5taMldP6MHzqHMfEmjfqDB7iOz/si
        +ASojpcD/UInqG+tNm+Q5weLCg==
X-Google-Smtp-Source: ABdhPJwe0+uwzDRgDCuX9b8VJcjpJiSEscjJ/j45LhdykkKdSMSbbDczNEseCea386az0fz/SY3oCw==
X-Received: by 2002:aa7:9edb:0:b029:13e:d13d:a059 with SMTP id r27-20020aa79edb0000b029013ed13da059mr4077835pfq.31.1599717858904;
        Wed, 09 Sep 2020 23:04:18 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id j14sm893236pjz.21.2020.09.09.23.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:04:18 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: sco: new getsockopt options BT_SNDMTU/BT_RCVMTU
Date:   Thu, 10 Sep 2020 14:04:02 +0800
Message-Id: <20200910140342.v3.2.I03247d3813c6dcbcdbeab26d068f9fd765edb1f5@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200910060403.144524-1-josephsih@chromium.org>
References: <20200910060403.144524-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines new getsockopt options BT_SNDMTU/BT_RCVMTU
for SCO socket to be compatible with other bluetooth sockets.
These new options return the same value as option SCO_OPTIONS
which is already present on existing kernels.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- Fixed the commit message.

Changes in v2:
- Used BT_SNDMTU/BT_RCVMTU instead of creating a new opt name.
- Used the existing conn->mtu instead of creating a new member
  in struct sco_pinfo.
- Noted that the old SCO_OPTIONS in sco_sock_getsockopt_old()
  would just work as it uses sco_pi(sk)->conn->mtu.

 net/bluetooth/sco.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index dcf7f96ff417e6..79ffcdef0b7ad5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1001,6 +1001,12 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_SNDMTU:
+	case BT_RCVMTU:
+		if (put_user(sco_pi(sk)->conn->mtu, (u32 __user *)optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.28.0.618.gf4bc123cb7-goog

