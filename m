Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC313C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5AB2206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725327;
	bh=ViZa30ypR7/xokQKb3odmSsdv+h/Zb0AyqQm1aaQY/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iFqdRZsAuwFuw2TThCKJmfYr5JjgR7G/zsHoUcZH9kmfnsvgKEHkoHAd8fh46ZqxL
	 CjrlhXyquKBDV/sGg3gcw6H0Jz8KUW7a9GbgzbPMtCUnwzwo+kn/zHUasZrPe/ShxY
	 exGO1wvNvL0cehtqgMzJBi0/a4MwgK64dMTvziS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbgFIRzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbgFIRxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:53:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E315D207C3;
        Tue,  9 Jun 2020 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725212;
        bh=ViZa30ypR7/xokQKb3odmSsdv+h/Zb0AyqQm1aaQY/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwnljX3Q1iclmZQz29HZTBLKgU+Xn933AFtQeFUXy7EbzL0W5MTN2jqufNQNXYNKr
         I2ex/UI07/IP+xdGx904kAFkX4EsUWoMhlzjsaEL0EWCUkPZ2HdX8EXeqIqhNGcS0A
         cs0wsi8DoFSEltqSpT4bYzOLmsaAfKycgSWrsJuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 06/41] net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a
Date:   Tue,  9 Jun 2020 19:45:08 +0200
Message-Id: <20200609174112.719785772@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174112.129412236@linuxfoundation.org>
References: <20200609174112.129412236@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

[ Upstream commit f2fb6b6275eba9d312957ca44c487bd780da6169 ]

For rx filter 'HWTSTAMP_FILTER_PTP_V2_EVENT', it should be
PTP v2/802.AS1, any layer, any kind of event packet, but HW only
take timestamp snapshot for below PTP message: sync, Pdelay_req,
Pdelay_resp.

Then it causes below issue when test E2E case:
ptp4l[2479.534]: port 1: received DELAY_REQ without timestamp
ptp4l[2481.423]: port 1: received DELAY_REQ without timestamp
ptp4l[2481.758]: port 1: received DELAY_REQ without timestamp
ptp4l[2483.524]: port 1: received DELAY_REQ without timestamp
ptp4l[2484.233]: port 1: received DELAY_REQ without timestamp
ptp4l[2485.750]: port 1: received DELAY_REQ without timestamp
ptp4l[2486.888]: port 1: received DELAY_REQ without timestamp
ptp4l[2487.265]: port 1: received DELAY_REQ without timestamp
ptp4l[2487.316]: port 1: received DELAY_REQ without timestamp

Timestamp snapshot dependency on register bits in received path:
SNAPTYPSEL TSMSTRENA TSEVNTENA 	PTP_Messages
01         x         0          SYNC, Follow_Up, Delay_Req,
                                Delay_Resp, Pdelay_Req, Pdelay_Resp,
                                Pdelay_Resp_Follow_Up
01         0         1          SYNC, Pdelay_Req, Pdelay_Resp

For dwmac v5.10a, enabling all events by setting register
DWC_EQOS_TIME_STAMPING[SNAPTYPSEL] to 2’b01, clearing bit [TSEVNTENA]
to 0’b0, which can support all required events.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -630,7 +630,8 @@ static int stmmac_hwtstamp_set(struct ne
 			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
-			ts_event_en = PTP_TCR_TSEVNTENA;
+			if (priv->synopsys_id != DWMAC_CORE_5_10)
+				ts_event_en = PTP_TCR_TSEVNTENA;
 			ptp_over_ipv4_udp = PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp = PTP_TCR_TSIPV6ENA;
 			ptp_over_ethernet = PTP_TCR_TSIPENA;


