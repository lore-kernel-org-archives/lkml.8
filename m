Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F311C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BC92076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubhnaz54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHLQHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:07:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEF3C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:07:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t10so2860635ejs.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=roFWW4idZSPrkc+cb/iYIWliDRvt+NhQWTQEf1GtCyw=;
        b=ubhnaz54GTYc6qTGiyUNH9W+bQXnxPga4CQ3bqcohpsujpPNoRj/xyZ/EiTr+4kaVs
         NgmDOE61mDvVuxyy3Aj+rJ4nyxVHVWbINKaXxrehiJnjGKibfOdzGDyYRojKj9h/wHqf
         AZOOrWTwpLOjO2FcyyZSa1J/CZpLiQcfSFJ4N4YHX78rix1NI+XpAFhe/6wY+Smi/bYY
         gW+bW5IgxUvNYTkR7KMVsvnc3lUO7DeFxZc6UoLF6stt1QQFuv8Q2A4XTG5DQI88zcDL
         EIie5be8TpZYv6vxXHuz+7TLj5N3UlqcJCs46PTpppRIahRI62vVp5ituRaozhO0K1Dh
         AcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=roFWW4idZSPrkc+cb/iYIWliDRvt+NhQWTQEf1GtCyw=;
        b=hS/sh+9EM9UYjZnmKn1/Qbv0CKeUrB75FKq4DdfEvQvuVsHvQbYN6ovhC2gupTA+ZV
         L/mm83ubceJLVXY4scyH+GElVQXdT2umTz/q8bvWfK4TnzeHE/6JMz2ZDt7938TA0UdG
         uilJi9yFQ3EDuGD/1a73crWicKzH5zA9XmbsX9CuekiXXm3EC47A5E8IBBhVISxBEV3+
         uSyBTrnfbk+TbhVQCDfJAUlzcJtUnBk3IQeI1nafm/ShwiDVuO2LdLHNBbDbV4H1Bl/K
         I8+ZSXqyQ+yvD+45qhlKDAYL7F5lZMEuQnO1XjLFu7iVht8zxphy0gRYAv/IT7umSPbZ
         G9Rg==
X-Gm-Message-State: AOAM530D1MhnnYsLlk8SNW5uNSOo2fGUUYIqHHKvjlbg9p9e/4vD7vyE
        VIFlSA/MR36Oh9xp0Jp/QXk=
X-Google-Smtp-Source: ABdhPJwrSR6wbm8JIlxtPyFsKHUfOigzmG1n/hbWAdHohIrsTMtzqcSLbTnAspzlbzTVDYPig5r/Kw==
X-Received: by 2002:a17:906:1a0f:: with SMTP id i15mr500757ejf.293.1597248471360;
        Wed, 12 Aug 2020 09:07:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1821:74c4:6c84:35b4:48ac:419a])
        by smtp.gmail.com with ESMTPSA id b9sm1948823ejz.57.2020.08.12.09.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:07:50 -0700 (PDT)
From:   Mohammed Rushad <mohammedrushad@gmail.com>
To:     gregkh@linuxfoundation.org, john.oldman@polehill.co.uk,
        kai.heng.feng@canonical.com, luk@wybcz.pl, vkor@vkten.in,
        nachukannan@gmail.com, mohammedrushad@gmail.com,
        hdegoede@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: fix function-name print using __func__
Date:   Wed, 12 Aug 2020 21:37:45 +0530
Message-Id: <20200812160745.7215-1-mohammedrushad@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch to the os_intfs.c fixes the printing of function names using
the preferred '"%s...", __func__' and alignment issues as pointed out by
the checkpatch.pl tool.

Signed-off-by: Mohammed Rushad <mohammedrushad@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 56 +++++++++++----------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 27f990a01a23..0460db4ae660 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -400,17 +400,17 @@ u16 rtw_recv_select_queue(struct sk_buff *skb)
 	memcpy(&eth_type, pdata + (ETH_ALEN << 1), 2);
 
 	switch (be16_to_cpu(eth_type)) {
-		case ETH_P_IP:
+	case ETH_P_IP:
 
-			piphdr = (struct iphdr *)(pdata + ETH_HLEN);
+		piphdr = (struct iphdr *)(pdata + ETH_HLEN);
 
-			dscp = piphdr->tos & 0xfc;
+		dscp = piphdr->tos & 0xfc;
 
-			priority = dscp >> 5;
+		priority = dscp >> 5;
 
-			break;
-		default:
-			priority = 0;
+		break;
+	default:
+		priority = 0;
 	}
 
 	return rtw_1d_to_queue[priority];
@@ -539,7 +539,7 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 {
 	u32 _status = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_start_drv_threads\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
 	padapter->xmitThread = kthread_run(rtw_xmit_thread, padapter, "RTW_XMIT_THREAD");
 	if (IS_ERR(padapter->xmitThread))
 		_status = _FAIL;
@@ -556,7 +556,7 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 
 void rtw_stop_drv_threads(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_stop_drv_threads\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
 
 	rtw_stop_cmd_thread(padapter);
 
@@ -710,7 +710,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 {
 	u8 ret8 = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
 
 	rtw_init_default_value(padapter);
 
@@ -773,29 +773,29 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 exit:
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_init_drv_sw\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-%s\n", __func__));
 
 	return ret8;
 }
 
 void rtw_cancel_all_timer(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_cancel_all_timer\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
 
 	del_timer_sync(&padapter->mlmepriv.assoc_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel association timer complete!\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("%s:cancel association timer complete!\n", __func__));
 
 	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel scan_to_timer!\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("%s:cancel scan_to_timer!\n", __func__));
 
 	del_timer_sync(&padapter->mlmepriv.dynamic_chk_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel dynamic_chk_timer!\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("%s:cancel dynamic_chk_timer!\n", __func__));
 
 	del_timer_sync(&(adapter_to_pwrctl(padapter)->pwr_state_check_timer));
 
 	del_timer_sync(&padapter->mlmepriv.set_scan_deny_timer);
 	rtw_clear_scan_deny(padapter);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel set_scan_deny_timer!\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("%s:cancel set_scan_deny_timer!\n", __func__));
 
 	del_timer_sync(&padapter->recvpriv.signal_stat_timer);
 
@@ -805,7 +805,7 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>rtw_free_drv_sw"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>%s", __func__));
 
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
@@ -829,7 +829,7 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_hal_free_data(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<==rtw_free_drv_sw\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<==%s\n", __func__));
 
 	/* free the old_pnetdev */
 	if (padapter->rereg_nd_name_priv.old_pnetdev) {
@@ -841,7 +841,7 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	if (padapter->pbuddy_adapter != NULL)
 		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_free_drv_sw\n"));
+	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-%s\n", __func__));
 
 	return _SUCCESS;
 }
@@ -994,7 +994,7 @@ static int  ips_netdrv_open(struct adapter *padapter)
 
 	status = rtw_hal_init(padapter);
 	if (status == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("ips_netdrv_open(): Can't init h/w!\n"));
+		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("%s(): Can't init h/w!\n", __func__));
 		goto netdev_open_error;
 	}
 
@@ -1007,7 +1007,7 @@ static int  ips_netdrv_open(struct adapter *padapter)
 
 netdev_open_error:
 	/* padapter->bup = false; */
-	DBG_871X("-ips_netdrv_open - drv_open failure, bup =%d\n", padapter->bup);
+	DBG_871X("-%s - drv_open failure, bup =%d\n", __func__, padapter->bup);
 
 	return _FAIL;
 }
@@ -1016,24 +1016,25 @@ static int  ips_netdrv_open(struct adapter *padapter)
 int rtw_ips_pwr_up(struct adapter *padapter)
 {
 	int result;
-	DBG_871X("===>  rtw_ips_pwr_up..............\n");
+
+	DBG_871X("===>  %s..............\n", __func__);
 
 	result = ips_netdrv_open(padapter);
 
-	DBG_871X("<===  rtw_ips_pwr_up..............\n");
+	DBG_871X("<===  %s..............\n", __func__);
 	return result;
 }
 
 void rtw_ips_pwr_down(struct adapter *padapter)
 {
-	DBG_871X("===> rtw_ips_pwr_down...................\n");
+	DBG_871X("===> %s...................\n", __func__);
 
 	padapter->bCardDisableWOHSM = true;
 	padapter->net_closed = true;
 
 	rtw_ips_dev_unload(padapter);
 	padapter->bCardDisableWOHSM = false;
-	DBG_871X("<=== rtw_ips_pwr_down.....................\n");
+	DBG_871X("<=== %s.....................\n", __func__);
 }
 
 void rtw_ips_dev_unload(struct adapter *padapter)
@@ -1087,7 +1088,8 @@ static int netdev_close(struct net_device *pnetdev)
 
 		rtw_dev_unload(padapter);
 	}
-	else*/
+	else
+*/
 	if (pwrctl->rf_pwrstate == rf_on) {
 		DBG_871X("(2)871x_drv - drv_close, bup =%d, hw_init_completed =%d\n", padapter->bup, padapter->hw_init_completed);
 
@@ -1144,7 +1146,7 @@ void rtw_dev_unload(struct adapter *padapter)
 		if (padapter->intf_stop)
 			padapter->intf_stop(padapter);
 
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ rtw_dev_unload: stop intf complete!\n"));
+		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ %s: stop intf complete!\n", __func__));
 
 		if (!pwrctl->bInternalAutoSuspend)
 			rtw_stop_drv_threads(padapter);
-- 
2.17.1

