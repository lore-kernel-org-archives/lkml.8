Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95DF206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AQc3IgVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgEOJ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgEOJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:27:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B28C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:27:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so702461pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMOi5U83vahobRubdonT8bbur/MVa6A0w3GNhnyDUz4=;
        b=AQc3IgVYYvNRW4qGcvufZghnKSjxTPNroOiMoahmIELJkZLXL5dmyy9wxalXOuHT3Y
         r+tS6aqIvct3Fby8P19vx72oVTDtEHHDlLQkRC3YKH6Ar3gucQ5Na3/e0nCSTy0yqJF7
         OjmW2o9d63Jju7sSaV5QlbS6BwJB4eSNr2dng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMOi5U83vahobRubdonT8bbur/MVa6A0w3GNhnyDUz4=;
        b=alhvUFrCKCgfsmyO2GgnH37vvyO7Krr2kt0uF0olUw1XeQTpGp2UdvG5s/+JclNET8
         02Vaz36ztuapblsZmHj0eunjb4abWr8l9YqkS8KtDCOI3lF/7Kp0E3geadDdfFGis14A
         DEnGMwXTtKTABCnrxA0U2F5vAc/Bi10aATQe/jx10rn653EYgFZ/pGIDrL8k2mMR/mzb
         qG4gaplObGazxyYMlES26ydKQ0jFGI06JjKBoSbANDqi240lI2Or8WPAHZW5LnWbbdyR
         6FWrbTPdkQYsV4oCpuMrpzRKp+agis+Pn5Od6oU7ZgMoh3Z2F3jIMmJcFpToQo6ElRxK
         BG/g==
X-Gm-Message-State: AOAM532tnPCc6h8GdAA07/qc/1O4j6xUk61jgVnJ1SA0jrLfpUuaNJVj
        +y/cv3Q18l4Rel0nr43Jqmjchw==
X-Google-Smtp-Source: ABdhPJzHhXjBoIyj2ZJXGFU2c+94wmBwHsCvl+Pdg/bz4NgGDYbmPGTe6x67OlnPX+/nDgvf0f+81Q==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr2628500pll.273.1589534830054;
        Fri, 15 May 2020 02:27:10 -0700 (PDT)
Received: from hychaoz840.tpe.corp.google.com ([2401:fa00:1:10:a03d:e7d8:93ef:b2])
        by smtp.gmail.com with ESMTPSA id p9sm1340961pgb.19.2020.05.15.02.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 May 2020 02:27:08 -0700 (PDT)
From:   Hsin-Yu Chao <hychao@chromium.org>
X-Google-Original-From: Hsin-Yu Chao <hychao@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, alainm@chromium.org,
        linux-kernel@vger.kernel.org, Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH] Bluetooth: Add SCO fallback for invalid LMP parameters error
Date:   Fri, 15 May 2020 17:27:04 +0800
Message-Id: <20200515092704.902-1-hychao@google.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsin-Yu Chao <hychao@chromium.org>

Bluetooth PTS test case HFP/AG/ACC/BI-12-I accepts SCO connection
with invalid parameter at the first SCO request expecting AG to
attempt another SCO request with the use of "safe settings" for
given codec, base on section 5.7.1.2 of HFP 1.7 specification.

This patch addresses it by adding "Invalid LMP Parameters" (0x1e)
to the SCO fallback case. Verified with below log:

< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
        Handle: 256
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Setting: 0x0003
          Input Coding: Linear
          Input Data Format: 1's complement
          Input Sample Size: 8-bit
          # of bits padding at MSB: 0
          Air Coding Format: Transparent Data
        Retransmission effort: Optimize for link quality (0x02)
        Packet type: 0x0380
          3-EV3 may not be used
          2-EV5 may not be used
          3-EV5 may not be used
> HCI Event: Command Status (0x0f) plen 4
      Setup Synchronous Connection (0x01|0x0028) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256
        Count: 1
> HCI Event: Max Slots Change (0x1b) plen 3
        Handle: 256
        Max slots: 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
        Status: Invalid LMP Parameters / Invalid LL Parameters (0x1e)
        Handle: 0
        Address: 00:1B:DC:F2:21:59 (OUI 00-1B-DC)
        Link type: eSCO (0x02)
        Transmission interval: 0x00
        Retransmission window: 0x02
        RX packet length: 0
        TX packet length: 0
        Air mode: Transparent (0x03)
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
        Handle: 256
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 8
        Setting: 0x0003
          Input Coding: Linear
          Input Data Format: 1's complement
          Input Sample Size: 8-bit
          # of bits padding at MSB: 0
          Air Coding Format: Transparent Data
        Retransmission effort: Optimize for link quality (0x02)
        Packet type: 0x03c8
          EV3 may be used
          2-EV3 may not be used
          3-EV3 may not be used
          2-EV5 may not be used
          3-EV5 may not be used
> HCI Event: Command Status (0x0f) plen 4
      Setup Synchronous Connection (0x01|0x0028) ncmd 1
        Status: Success (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3
        Handle: 256
        Max slots: 5
> HCI Event: Max Slots Change (0x1b) plen 3
        Handle: 256
        Max slots: 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
        Status: Success (0x00)
        Handle: 257
        Address: 00:1B:DC:F2:21:59 (OUI 00-1B-DC)
        Link type: eSCO (0x02)
        Transmission interval: 0x06
        Retransmission window: 0x04
        RX packet length: 30
        TX packet length: 30
        Air mode: Transparent (0x03)

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
---
 net/bluetooth/hci_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 73aabca0064b7..f024b3d57a1c7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4337,6 +4337,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 	case 0x11:	/* Unsupported Feature or Parameter Value */
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
+	case 0x1e:	/* Invalid LMP Parameters */
 	case 0x1f:	/* Unspecified error */
 	case 0x20:	/* Unsupported LMP Parameter value */
 		if (conn->out) {
-- 
2.24.1

