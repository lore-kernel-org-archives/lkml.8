Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8986C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892D720665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hckcvRnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgH1O6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:58:44 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:61184
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726571AbgH1O6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3OxK3yXrAD7PNwpxy207H1wpboHj22i5UKfT6TZiYhkiDdLyI/3WMqNWDx2QFwxD1GOa+O2bqsMG/VnX40xYg+25ob+q7MNA1A8hGK8+7RBfOSSNxm4+oFWAhO5dP162bJg9BVbZVH5zks2cOWfHKNwoVBIKU/uE69HyXklHo+9St4NC8O204m21MAOQ+tiLNzSftVAYBao0pH3pMlX2tbD2YBrSXT5gv305C9HsTKqIOMiiTtfS3y/8xXkDdIyP14M8fPg7+n2y+dvcCgsvZMUtJIdOGu8Ma67u2lJIPxXhFlYrTw/j2I5jzy+dxZ6t6HzlrtBoWTp+yufIM4M8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgRg+a625mbmdM6n9hiYMI39qtK++OTcntI7TW/VhHQ=;
 b=nfjFEd/nzOZEcpkYumchdV9szIQ2RjUNBqy0SN/5m1/1X1woWoCXiDO6lg7kFf8Gc6A67PbpOOwna9qGGSSg57YYiPlO1ElDAfASDsvk1CvcCp6NSYBoxPnY2oh3SKAJgx5hVyLA+e/a41TiKK96d6tpO/3Xr/OonfJuGsHjTPi1F/jDaFlFzgmDxoufps/Eoc2LR+RyZxiGKajDZ2dKmjeZmVd9UFksn8AjO3ua1pFliJg0HjDmzQ82sowl+ME2m0yYP3bzSxE+5ZORgyLlrFwB/r5Mi8CMp7Iu8S0eUnXhAUtFnBj/JFGeqAq8a75MdwVvYjmFFSmUt5yi89tG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgRg+a625mbmdM6n9hiYMI39qtK++OTcntI7TW/VhHQ=;
 b=hckcvRnjPKb61vsc6nbBm4jVCgkLIDAREht8XIpvvW0vBDEazfuW7aMFRkfFTDzROmAnq/NtZVNK/3cdzdsCEMk+/BjIdITIbTuiGR7CND60bYEvVn0gE0qFjoXQfpoBlHLVUt5hEGVPCbJoOwWFE7m3zvvAO4+bA7SttAil+eY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0401MB2598.eurprd04.prod.outlook.com (2603:10a6:4:39::7)
 by DB6PR0401MB2293.eurprd04.prod.outlook.com (2603:10a6:4:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 28 Aug
 2020 14:58:39 +0000
Received: from DB6PR0401MB2598.eurprd04.prod.outlook.com
 ([fe80::19ed:520c:8c98:e334]) by DB6PR0401MB2598.eurprd04.prod.outlook.com
 ([fe80::19ed:520c:8c98:e334%4]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 14:58:39 +0000
From:   "Robert Chiras (OSS)" <robert.chiras@oss.nxp.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] drm/panel: rm67191: Remove CLOCK_NON_CONTINUOUS flag
Date:   Fri, 28 Aug 2020 17:58:33 +0300
Message-Id: <1598626713-5595-1-git-send-email-robert.chiras@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:205::30)
 To DB6PR0401MB2598.eurprd04.prod.outlook.com (2603:10a6:4:39::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1664-120.ea.freescale.net (83.217.231.2) by AM4PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:205::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 14:58:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0943744-9a3b-4288-6136-08d84b62d8a5
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2293:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB229302E093CEA7071E172CF6A2520@DB6PR0401MB2293.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ad2GG+1yD8mFAZjWIFDXlDGxyeyHEAeahFCBL2UN2/eO+ka+PAOPPMQxd+ibvDcsHiXiKyzwCPbLpqMfcrUPsCbuBR21ShehmvF09Wml3jNaH8lVm4R0iot39mvXOGWIarzUcXrMIBiwl3XL3YoDlkEmlORHW/1+quaWYtHxx5103mHM9UbiitNP7x4RYmqpeC4p80+cjtSUDDQKG4npbQyxH2vxyn5YnlIok4PMEupwMDLLO3RQSsXxpPYo4N7WplpNYGil8KpLaY+EinbTebJqud/vtO5EqEVp1Pky6AN2ChijD2oKwuogUxECM3eAcxoJv6i4ZHNiBabeYgkXew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2598.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(6486002)(2906002)(478600001)(186003)(16526019)(52116002)(8936002)(83380400001)(26005)(956004)(86362001)(6512007)(8676002)(2616005)(6506007)(5660300002)(316002)(6666004)(4744005)(110136005)(66946007)(54906003)(66556008)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R7VqjYz5eK8yxxzxPIdJT1xcfVWcFXtYeaoETp8C1qaQTbliOClsNsKhmZ85sQ4W4JgvJeOdXCsCKrRzlFbAfn3VslCUm9y1sBXV/gh4CtAd8gggGmNG4VqSSI4x+8F0+E4knEGUVNzajjm0POvI0o+or/C47GEa3soc9m3ykH1qY8RfA7LnsmRMNfkSoFhErZho8iv0O1bWjfO1yZMvhNHiNuNdIVN2MLjvORts22PvH9RZvZNo1joipHbw1MNvZT+6/4Q8sOi2dc6nshnQGAz83xnlOIeK638z5sxBLYtCQ0o78BLskSpfztzii58Wf6YCrUt4v2InVJwIcyDbmVfN+rCla/dBE575/kuWShlGhaDeLogaVIPwaq51sfhTXqVqaEC95Q9cMzECOqyLHdWCFJnYL7QJWgk0xfrESfi8QmepBzmArj4foGoiJfNoTQws6vL3LBR250jiu1mQ+kzvZSEgDH7ojFYzjnjR3YCCM13Sccz1kItKrSWGMXa9skjy1zhIbJJO5oxnRUFKl9g3PSryV144bLscfoTqo1ISf+zE/8XqiOigzs0/KDkbN52bVY9y3MmKyYDJsrl7WfhIKMv+oUcUz/qiajeowSbTdGFJn1Jcv5tg9VvUL+zKugfpOOqBEXTVI1qtth7mkA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0943744-9a3b-4288-6136-08d84b62d8a5
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2598.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 14:58:38.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjxHGOZN5/Cknp0tBY/af2/Y3JdWR/KD8CefycKi22W5T6RabS/ON7f1CHVU7Sha7MPAocmBw8XyzZpro9w5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Chiras <robert.chiras@nxp.com>

The flag MIPI_DSI_CLOCK_NON_CONTINUOUS was wrong used in the DSI driver,
so it was added to this panel, but not necessary.
So, remove this flag since it is not needed.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index 23b6208..572547d 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -552,8 +552,7 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
 	panel->dsi = dsi;
 
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags =  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
-			   MIPI_DSI_CLOCK_NON_CONTINUOUS;
+	dsi->mode_flags =  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO;
 
 	ret = of_property_read_u32(np, "video-mode", &video_mode);
 	if (!ret) {
-- 
2.7.4

