Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662DFC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3756620644
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607903;
	bh=zl6dEku4PXUVnXqBlgEnAQo+bXF7mPhIBPgiQ12HFHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uujqUOHPkaeESslTOobTv4UTVuy4Vq8zsiN+T7LmZg5oddWHUVp/S+99qMum0BHs0
	 L5r3qS6QzEufkrN+nAtzXTwhbPGJ6+/gVNkZWaZXWGUSGBqCnI2yB/HduSMQ3kgfwd
	 4KnVVzsvSlUzRpdnWOr4qHdLGHCJom3XgP/nGYKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgDKMRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbgDKMRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:17:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C55720644;
        Sat, 11 Apr 2020 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607421;
        bh=zl6dEku4PXUVnXqBlgEnAQo+bXF7mPhIBPgiQ12HFHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fbtj0SpqpLH4BhrxdFHv2CmwOIVtn+Qmae3DJ8maXsnjktB67P1Axuff25QBD5fqU
         MFieZkc9ioeBlrVPaH/I5DpZavB20CFIKia+vHYY8pLDCe0xPv588Ag0aV8stpTsvn
         lJsoj2jzg8Rj8Q812GJGNHu+GfMGat1svCltUmAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 13/41] mlxsw: spectrum_flower: Do not stop at FLOW_ACTION_VLAN_MANGLE
Date:   Sat, 11 Apr 2020 14:09:22 +0200
Message-Id: <20200411115505.036796995@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115504.124035693@linuxfoundation.org>
References: <20200411115504.124035693@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit ccfc569347f870830e7c7cf854679a06cf9c45b5 ]

The handler for FLOW_ACTION_VLAN_MANGLE ends by returning whatever the
lower-level function that it calls returns. If there are more actions lined
up after this action, those are never offloaded. Fix by only bailing out
when the called function returns an error.

Fixes: a150201a70da ("mlxsw: spectrum: Add support for vlan modify TC action")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -123,9 +123,12 @@ static int mlxsw_sp_flower_parse_actions
 			u8 prio = act->vlan.prio;
 			u16 vid = act->vlan.vid;
 
-			return mlxsw_sp_acl_rulei_act_vlan(mlxsw_sp, rulei,
-							   act->id, vid,
-							   proto, prio, extack);
+			err = mlxsw_sp_acl_rulei_act_vlan(mlxsw_sp, rulei,
+							  act->id, vid,
+							  proto, prio, extack);
+			if (err)
+				return err;
+			break;
 			}
 		default:
 			NL_SET_ERR_MSG_MOD(extack, "Unsupported action");


