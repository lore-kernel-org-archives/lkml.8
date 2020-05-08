Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3A4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C44E24968
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941726;
	bh=iJSSwgbjwlw+bhfTaVrzdgSQJxv45InytS0Mp514Yvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m+NOVLPsTzmqruvbbESOO5MhzFrbi1xsXpYtq+BHgiqn/OVRvZ2tqkX1LDzayaZwy
	 oQ6KpggC5evuCfgHAnQhvOTkAx9ZHRhHR616Tct5ftXNJKygVPbFAdyNzlvUOQ4/+h
	 ZD6Nd7VxQkgJ8wfcyqVKu3rCfPyP/Swy4wymzVTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgEHMmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgEHMlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:41:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B87372496A;
        Fri,  8 May 2020 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941715;
        bh=iJSSwgbjwlw+bhfTaVrzdgSQJxv45InytS0Mp514Yvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOmm7Q1do5ezE+ukBwkwjT9Ec3PNjAlvwyuq8wHS7uDC+7Aamcrtq3Q/Cjsjm204c
         SHfDpttOx3JpfuxRD5t4pOkRgDeZHjQaoMHYcAxOTp/FxSJVL+VhY/er0kc5QJuuNN
         P5XHBSDAe/rtyaPuxpUCSMocLom2GjeDTmDcAVBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 106/312] mlxsw: spectrum: Disable learning according to STP state
Date:   Fri,  8 May 2020 14:31:37 +0200
Message-Id: <20200508123131.955732121@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

commit 454911333b1d86e1d58a557be271bc6b7e9e7f10 upstream.

When port is put into LISTENING state it shouldn't populate the FDB, so
set the port's STP state in hardware to DISCARDING instead of LEARNING.
It will therefore keep listening to BPDU packets, but discard other
non-control packets and won't perform any learning.

Fixes: 56ade8fe3fe1 ("mlxsw: spectrum: Add initial support for Spectrum ASIC")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -90,10 +90,10 @@ static int mlxsw_sp_port_stp_state_set(s
 	case BR_STATE_FORWARDING:
 		spms_state = MLXSW_REG_SPMS_STATE_FORWARDING;
 		break;
-	case BR_STATE_LISTENING: /* fall-through */
 	case BR_STATE_LEARNING:
 		spms_state = MLXSW_REG_SPMS_STATE_LEARNING;
 		break;
+	case BR_STATE_LISTENING: /* fall-through */
 	case BR_STATE_DISABLED: /* fall-through */
 	case BR_STATE_BLOCKING:
 		spms_state = MLXSW_REG_SPMS_STATE_DISCARDING;


