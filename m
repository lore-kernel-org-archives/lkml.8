Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA613C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87DD2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k73o73VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHNWXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHNWXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:23:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6859C061388
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:23:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so4784497plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jRl27RMtgZLeq7b/WHxRkukWBIOKeVCPevK+sNiPhQ=;
        b=k73o73VNd0qn9M+iiKly87GFMMXb6KyBorDW4eREbb7tWN2jSXYRFziRAoYgSezuUF
         FLz13Od/1weIFdHYZAkH4EE6DZ2zj7DIZfLAK/em3ojP/RtKqLTLGoQKKszjB6dJ4pV9
         mte4YoB6Bc6FECyWkOAdnIkWLrrXIYtyO/yYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jRl27RMtgZLeq7b/WHxRkukWBIOKeVCPevK+sNiPhQ=;
        b=jBgdRzznfNLmoYPcO5+HPpkboy6plBsqd4h1QVUp87h2jBmk5KatyvLaDvwUEhhIzM
         qmdWhwDwzax0TTJ7eCzpsXtylCxSI1CNh7vvkw4Us/AMm6Gy1XlFEMK/elXr15RVRvD9
         KWZhi6n/rjwLadR618iXXXnwqiDLulwofDvYvlLRa6hE0D3uFO6IJKU49cZA4cQcSCi8
         j2ro51T7doQF33Oq9b68YhXJZdO5lTOQKgourpQgNvGJe3kISEpuzMru95BguVSPCCfG
         HwuoO3k7HoaJoP+Vzq+lrvbcALKoOMUFJPifJ6aAn42gla6ARX+CCu8lQHKwAE3FxWab
         NSQw==
X-Gm-Message-State: AOAM530syvcmflvglFz81PnhKnkk+Sl2yId6V6SBKTWpYl/owSaetTT4
        //Uq9sKlRK8YddutYnXrHFzmaw==
X-Google-Smtp-Source: ABdhPJw4VToGF1Qswjip3GwGa5R4xOuQDDzZR0q80w8U/1h/s8l757szCrDYF3vT/E21VzKADGZyYA==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr3422745plz.239.1597443823248;
        Fri, 14 Aug 2020 15:23:43 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id a17sm9302460pgi.26.2020.08.14.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:23:42 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] bluetooth: Set ext scan response only when it exists
Date:   Fri, 14 Aug 2020 15:23:36 -0700
Message-Id: <20200814152323.1.Ib022565452fde0c02fbcf619950ef868715dd243@changeid>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only set extended scan response only when it exists. Otherwise, clear
the scan response data.

Per the core spec v5.2, Vol 4, Part E, 7.8.55

If the advertising set is non-scannable and the Host uses this command
other than to discard existing data, the Controller shall return the
error code Invalid HCI Command Parameters (0x12).

On WCN3991, the controller correctly responds with Invalid Parameters
when this is sent.  That error causes __hci_req_hci_power_on to fail
with -EINVAL and LE devices can't connect because background scanning
isn't configured.

Here is an hci trace of where this issue occurs during power on:

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x00
        Properties: 0x0010
          Use legacy advertising PDUs: ADV_NONCONN_IND
        Min advertising interval: 181.250 msec (0x0122)
        Max advertising interval: 181.250 msec (0x0122)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect...
        TX power: 127 dbm (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 1M (0x01)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
        Status: Success (0x00)
        TX power (selected): 9 dbm (0x09)
< HCI Command: LE Set Advertising Set Random Address (0x08|0x0035) plen 7
        Advertising handle: 0x00
        Advertising random address: 08:FD:55:ED:22:28 (OUI 08-FD-55)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Advertising Set Random Address (0x08|0x0035) ncmd
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35
        Handle: 0x00
        Operation: Complete scan response data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x0d
        Name (short): Chromebook
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Daniel Winkler <danielwinkler@google.com>
---

 net/bluetooth/hci_request.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e0269192f2e536..e17bc8a1c66ddd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1533,11 +1533,14 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 
 		memset(&cp, 0, sizeof(cp));
 
-		if (instance)
+		/* Extended scan response data doesn't allow a response to be
+		 * set if the instance isn't scannable.
+		 */
+		if (get_adv_instance_scan_rsp_len(hdev, instance))
 			len = create_instance_scan_rsp_data(hdev, instance,
 							    cp.data);
 		else
-			len = create_default_scan_rsp_data(hdev, cp.data);
+			len = 0;
 
 		if (hdev->scan_rsp_data_len == len &&
 		    !memcmp(cp.data, hdev->scan_rsp_data, len))
-- 
2.28.0.220.ged08abb693-goog

