Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B2AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592C020848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703418;
	bh=JDf7PQti/bDgDc8YDS6Y6Ao2ql2nqK2+/wsQZo2wlDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOmMuVEkkDvN/nWjmQIK3Wl5ai8zRqnrmROCvsyFnilcN+jfEzm6CxnesgtBsYg2a
	 lZlkvhh2/St+wdNm1uC2y6qKxJg+wMkNf0WDfggkeOg6xJz/6g+xoSSxux9haEC/T7
	 CGH4/yCDFoeidL7UWYzNda7xaKRApsDRJbC3uEdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgBNSDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:03:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387523AbgBNPzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:55:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2591F222C4;
        Fri, 14 Feb 2020 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695740;
        bh=JDf7PQti/bDgDc8YDS6Y6Ao2ql2nqK2+/wsQZo2wlDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqA3zKdopo+ZEQWfo+QTSBsQ4/bFGKfAMQLuwQ71SmxWDsN3CCzIK6TDd24IxZveC
         0HR6hRsnoB5SdMjRlilfYUtDGZ9C++hNWiHg1ZLxtjo6P131ws8Fo9uX/R6xzABDai
         lYyYGROV6te+IsyXp9UwLfO6B7tffjRzcZByqAAY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.5 313/542] staging: rtl8188: avoid excessive stack usage
Date:   Fri, 14 Feb 2020 10:45:05 -0500
Message-Id: <20200214154854.6746-313-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit c497ae2077c055b85c1bf04f3d182a84bd8f365b ]

The rtl8188 copy of the os_dep support code causes a
warning about a very significant stack usage in the translate_scan()
function:

drivers/staging/rtl8188eu/os_dep/ioctl_linux.c: In function 'translate_scan':
drivers/staging/rtl8188eu/os_dep/ioctl_linux.c:306:1: error: the frame size of 1560 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]

Use the same trick as in the rtl8723bs copy of the same function, and
allocate it dynamically.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20200104214832.558198-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 710c33fd49658..47f4cc6a19a9a 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -222,18 +222,21 @@ static char *translate_scan(struct adapter *padapter,
 
 	/* parsing WPA/WPA2 IE */
 	{
-		u8 buf[MAX_WPA_IE_LEN];
+		u8 *buf;
 		u8 wpa_ie[255], rsn_ie[255];
 		u16 wpa_len = 0, rsn_len = 0;
 		u8 *p;
 
+		buf = kzalloc(MAX_WPA_IE_LEN, GFP_ATOMIC);
+		if (!buf)
+			return start;
+
 		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.ssid.ssid));
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 		if (wpa_len > 0) {
 			p = buf;
-			memset(buf, 0, MAX_WPA_IE_LEN);
 			p += sprintf(p, "wpa_ie=");
 			for (i = 0; i < wpa_len; i++)
 				p += sprintf(p, "%02x", wpa_ie[i]);
@@ -250,7 +253,6 @@ static char *translate_scan(struct adapter *padapter,
 		}
 		if (rsn_len > 0) {
 			p = buf;
-			memset(buf, 0, MAX_WPA_IE_LEN);
 			p += sprintf(p, "rsn_ie=");
 			for (i = 0; i < rsn_len; i++)
 				p += sprintf(p, "%02x", rsn_ie[i]);
@@ -264,6 +266,7 @@ static char *translate_scan(struct adapter *padapter,
 			iwe.u.data.length = rsn_len;
 			start = iwe_stream_add_point(info, start, stop, &iwe, rsn_ie);
 		}
+		kfree(buf);
 	}
 
 	{/* parsing WPS IE */
-- 
2.20.1

