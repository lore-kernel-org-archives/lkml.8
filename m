Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2667BC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E643120740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz9M17el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCYQpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:45:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36978 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYQpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:45:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id h72so1318376pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8TyWZF/hKjoYHK9kozfXNfOetaQstcsdqGIUqpxVSWo=;
        b=dz9M17elo03t5YW8wGA9UpAawb+jWBG2PQMy0JsQVilQVNYxCRRmMmW6vE1gCdSSDS
         Jza2UJ9N6RYhJjNNHE8oy9FOE1QT8ZznAsPw4Bh6oAQNyww3L3nP0RrFfvJRJ4Ad+QNL
         cSz90mc4v23Ji7ewYC5gBiL9ZcDGPn7o2AaSXI139hrp9bqtjAuZqumDqh9Qe2TwOHTc
         hw5+PZRHvgWPogxNtkMLafRsqp+fChVnwRYWHNDS+xKqPfKXniWdD2U7d5Y+Sd8z3RH/
         Ykeo1OwGxEaK1ZGEsIqBuc+eOUefbjRuxgO6EvbvMmo2jtgrYa6drp76OUpo9l7yPjKd
         yJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8TyWZF/hKjoYHK9kozfXNfOetaQstcsdqGIUqpxVSWo=;
        b=Do7b4rbp55mBmLfxEwJw6Z5FT1CrBUnmv4D9rZie7aLjMgA3e1wwGu+HrrLNhebOSa
         3YlmMS3YHwA5MGnEMw6kKzU2Ey288xBmHNkxpkm2r6//L48YEI1W5arwFjhbSgsc8WPi
         tFZV4CJ/6Q9xt7EEU8HFGmHRbiTJ8jv2RyuXfHXRtgBaV3dIMiC9YHo8y9X0gH/PwNsa
         9FRC/sBNKpqxnMVd46V6G7J+IDD5hm+YwnLME0dtNa6Evh4lhk/leLw51jDok2viS28M
         UAvyPCr872x6sG7Uo94gOlyESECJ+ILpHjp6SygZS+SOmjT8TqgJkgBQAJMYPchOmg8u
         4+xg==
X-Gm-Message-State: ANhLgQ0K12gJPmRFcz11doR5Mzgn/atPAblYIWTiKwtfWdCnTilNfEwD
        tM+IgCCZIg9esgdM2RpKGAA=
X-Google-Smtp-Source: ADFU+vvoIyFeLN9VxSn6nckvi+mw7xVb808VZp/lp4AR2Nh4O8t9mTx8HnA3kMu5FPKSlE3l70KHTQ==
X-Received: by 2002:a63:4502:: with SMTP id s2mr3946982pga.391.1585154723293;
        Wed, 25 Mar 2020 09:45:23 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id o15sm4815290pjp.41.2020.03.25.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 09:45:22 -0700 (PDT)
Date:   Wed, 25 Mar 2020 22:14:52 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: rtl8723bs: Add line after variable declarations
Message-ID: <20200325164451.GA17569@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add whiteline after variable declarations to remove the checkpatch.pl
warning:
WARNING: Missing a blank line after declarations

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c642825ca8ef..8f9da1d49343 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -219,6 +219,7 @@ static RT_CHANNEL_PLAN_MAP RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03, 0x02};
 int rtw_ch_set_search_ch(RT_CHANNEL_INFO *ch_set, const u32 ch)
 {
 	int i;
+
 	for (i = 0; ch_set[i].ChannelNum != 0; i++) {
 		if (ch == ch_set[i].ChannelNum)
 			break;
@@ -2184,6 +2185,7 @@ unsigned int OnAction_sa_query(struct adapter *padapter, union recv_frame *precv
 	}
 	if (0) {
 		int pp;
+
 		printk("pattrib->pktlen = %d =>", pattrib->pkt_len);
 		for (pp = 0; pp < pattrib->pkt_len; pp++)
 			printk(" %02x ", pframe[pp]);
@@ -2486,6 +2488,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 		/* DBG_871X("ie len =%d\n", cur_network->IELength); */
 		{
 			int len_diff;
+
 			memcpy(pframe, cur_network->IEs, cur_network->IELength);
 			len_diff = update_hidden_ssid(
 				pframe+_BEACON_IE_OFFSET_
@@ -2500,6 +2503,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 			u8 *wps_ie;
 			uint wps_ielen;
 			u8 sr = 0;
+
 			wps_ie = rtw_get_wps_ie(pmgntframe->buf_addr+TXDESC_OFFSET+sizeof(struct ieee80211_hdr_3addr)+_BEACON_IE_OFFSET_,
 				pattrib->pktlen-sizeof(struct ieee80211_hdr_3addr)-_BEACON_IE_OFFSET_, NULL, &wps_ielen);
 			if (wps_ie && wps_ielen > 0) {
@@ -2700,6 +2704,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 			if (ssid_ie &&  cur_network->Ssid.SsidLength) {
 				uint remainder_ielen;
 				u8 *remainder_ie;
+
 				remainder_ie = ssid_ie+2;
 				remainder_ielen = (pframe-remainder_ie);
 
@@ -4280,6 +4285,7 @@ void site_survey(struct adapter *padapter)
 
 	{
 		struct rtw_ieee80211_channel *ch;
+
 		if (pmlmeext->sitesurvey_res.channel_idx < pmlmeext->sitesurvey_res.ch_num) {
 			ch = &pmlmeext->sitesurvey_res.ch[pmlmeext->sitesurvey_res.channel_idx];
 			survey_channel = ch->hw_value;
@@ -4323,6 +4329,7 @@ void site_survey(struct adapter *padapter)
 		if (ScanType == SCAN_ACTIVE) { /* obey the channel plan setting... */
 			{
 				int i;
+
 				for (i = 0; i < RTW_SSID_SCAN_AMOUNT; i++) {
 					if (pmlmeext->sitesurvey_res.ssid[i].SsidLength) {
 						/* IOT issue, When wifi_spec is not set, send one probe req without WPS IE. */
@@ -4351,6 +4358,7 @@ void site_survey(struct adapter *padapter)
 #if defined(CONFIG_SIGNAL_DISPLAY_DBM) && defined(CONFIG_BACKGROUND_NOISE_MONITOR)
 		{
 			struct noise_info info;
+
 			info.bPauseDIG = false;
 			info.IGIValue = 0;
 			info.max_time = channel_scan_time_ms/2;/* ms */
@@ -4518,6 +4526,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		p = rtw_get_ie(bssid->IEs + ie_offset, _HT_ADD_INFO_IE_, &len, bssid->IELength - ie_offset);
 		if (p) {
 			struct HT_info_element *HT_info = (struct HT_info_element *)(p + 2);
+
 			bssid->Configuration.DSConfig = HT_info->primary_channel;
 		} else { /*  use current channel */
 			bssid->Configuration.DSConfig = rtw_get_oper_ch(padapter);
@@ -4551,6 +4560,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		p = rtw_get_ie(bssid->IEs + ie_offset, _HT_CAPABILITY_IE_, &len, bssid->IELength - ie_offset);
 		if (p && len > 0) {
 			struct HT_caps_element	*pHT_caps;
+
 			pHT_caps = (struct HT_caps_element	*)(p + 2);
 
 			if (le16_to_cpu(pHT_caps->u.HT_cap_element.HT_caps_info) & BIT(14))
@@ -4584,6 +4594,7 @@ void start_create_ibss(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+
 	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
 
@@ -5388,6 +5399,7 @@ static void rtw_mlmeext_disconnect(struct adapter *padapter)
 	/* wakeup macid after disconnect. */
 	{
 		struct sta_info *psta;
+
 		psta = rtw_get_stainfo(&padapter->stapriv, get_my_bssid(pnetwork));
 		if (psta)
 			rtw_hal_macid_wakeup(padapter, psta->mac_id);
@@ -5425,6 +5437,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	struct sta_priv 	*pstapriv = &padapter->stapriv;
 	u8 join_type;
 	struct sta_info *psta;
+
 	if (join_res < 0) {
 		join_type = 1;
 		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
@@ -6047,6 +6060,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 
 	if (pmlmeinfo->state == WIFI_FW_AP_STATE) {
 		struct wlan_bssid_ex *network = &padapter->mlmepriv.cur_network.network;
+
 		start_bss_network(padapter, (u8 *)network);
 		return H2C_SUCCESS;
 	}
@@ -6810,6 +6824,7 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	if ((padapter->rtw_wdev != NULL) && (padapter->rtw_wdev->wiphy)) {
 		struct regulatory_request request;
+
 		request.initiator = NL80211_REGDOM_SET_BY_DRIVER;
 		rtw_reg_notifier(padapter->rtw_wdev->wiphy, &request);
 	}
-- 
2.17.1

