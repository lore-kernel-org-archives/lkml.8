Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D15C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E402073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYY3K1M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCZNTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:19:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:18:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so2745301pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MJkPkspqNdlTX6vjl/CVTE6MfOICpoMgsRanROYZDJA=;
        b=ZYY3K1M9iitRcd6EivzWhtByjMfUm2QC7nJEzEqvmNi2BHtKjw1D0VwPlxDevm8XOG
         KY4kQmj1iOIlds+/r4wrch6lekBHMbNitd3cN/kLcDufaa75xMkzl5e1KLXAArD4Gv8o
         aOHFBtR7LGGQraP4yoK3Dxc4XUQCbA/APDgYzaGcETq6t9ljs+za/0OUXM9I9YwQOnVE
         KDGylfbCV7K6CbpXLpGCAG5KVzrRjPD/B84860n66Go1yoP7Kp7UQIPada57eU/nWDJp
         xoJzQOGllCn8LGGI1ZT2HmvnQaeCdZgUUDKU7fFmm5bamNufQ7cX3qdULpaNNbSw3Gom
         toCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MJkPkspqNdlTX6vjl/CVTE6MfOICpoMgsRanROYZDJA=;
        b=s0TvNait3TD8rTw+SVOgj9U8PRqe/zxHGUBxMZKC36UMgZwZW7WwzP2OYu7iL4zh/J
         CfHi+14Uk7aVvQpddF6/a+1LvTZh7uf27wOBrfwPTBP3SvVDW5DfD1MgKDmAi0OX32kc
         V+181u6JSEsLTNIHzrKQBAAV3oai6Dih2Z3wZ2p+NnvsB0Lxq1jlt31X1gzXjH7yLlod
         uObPslBVhKzLu2/uLIKy0PJckEKACnSeb0neNMy3GxpaKjyfXGBpSCWarMYenKw6RkY8
         7rV4Lv3SXSBFCqvSrSc66ZSnImx8AFGGwdU34fP+15lJQVJP63IgKtt8Hq/j2tOOo8BK
         xnyw==
X-Gm-Message-State: ANhLgQ1HjlE6v8AjMvSQldgkvywhQIKI5XPZl1FlH1oFdTgONm0jIpxm
        v10olXaHiqQu+j19ueSi07A=
X-Google-Smtp-Source: ADFU+vv8m75ygmS8rrbmOipJ/tGjAPTnpiZRwqj+1WUUWC8ibM7gtgVFzk0L6TywhtjKUZljawW/4Q==
X-Received: by 2002:a63:2166:: with SMTP id s38mr8012574pgm.83.1585228738689;
        Thu, 26 Mar 2020 06:18:58 -0700 (PDT)
Received: from localhost ([161.117.239.120])
        by smtp.gmail.com with ESMTPSA id h4sm1669270pgk.72.2020.03.26.06.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 06:18:58 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     gregkh@linuxfoundation.org, osdevtc@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        anenbupt@gmail.com, hdanton@sina.com,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] staging: wlan-ng: fix use-after-free Read in hfa384x_usbin_callback
Date:   Thu, 26 Mar 2020 21:18:50 +0800
Message-Id: <20200326131850.17711-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't handle the case length > WLAN_DATA_MAXLEN.
Because the size of rxfrm->data is WLAN_DATA_MAXLEN(2312), and we can't
read more than that.

Thanks-to: Hillf Danton <hdanton@sina.com>
Reported-and-tested-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index b71756ab0394..7fe64fcd385d 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -3372,6 +3372,8 @@ static void hfa384x_int_rxmonitor(struct wlandevice *wlandev,
 	     WLAN_HDR_A4_LEN + WLAN_DATA_MAXLEN + WLAN_CRC_LEN)) {
 		pr_debug("overlen frm: len=%zd\n",
 			 skblen - sizeof(struct p80211_caphdr));
+
+		return;
 	}
 
 	skb = dev_alloc_skb(skblen);
-- 
2.17.1

