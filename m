Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA5C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9014A217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgCBPne convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:43:34 -0500
Received: from mail-oln040092254068.outbound.protection.outlook.com ([40.92.254.68]:8942
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbgCBPnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:43:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbPU4YQzS2b04VZMGnuDL534Z7BQgoilgLRhvY7Yu916rZJIf9K9Ytpszcnzyny4EXmNlOGRN13ru/z8STDeuT7HJkFxCc7HPG1bdHUHjmD/xowzHAl3EPUWeK+tfpCCOBNzSbEGsnp8UbhMNLZluIQVm0gR3f6GVKH/2xstBHpTSe8vvP+5QgE136xUpqzJTUD7X33ck1OkUmhV5XkMCI6qXp9k0WNVESLIcD5HviT/oV2aK1YabhQ2PQnvgiX2U7T9BAFHviNnxKeJ3TAhEBDIuovHcpr/fbLSG19wIS/rd/qzAUHbWothnBWG+gsa4OMEvQgU4ixUsbykCNDi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHrQfmweTMEoNFtUiG5dlAvEFxu31/biZJwyPszszgQ=;
 b=MJj25CdrkKIsFIOSwfhhMPDlEt0voxog9HU+pbD+DAxx8E/GCVJs0dEP+itvBSNMqylwIGE/3rhFbla6LX6Q2JIvELRD3B+sQuYlAO/dvP8L2Mo0bMGeWS1hwVE9UYX09QYND9oEovhrM6wqjRt9vx1TnG0GcSnTkcZtoF0KtTmlkLCotFhTVR9j//3ZT9vai+4qfTl3lj4BcnVsNXNF0W/504xDJAlSquxBJ94k/Jy56jfq4vKXjFBqDXm+Nfpv3/+PKO7rodF6epBiFIYfb27Ppmc/X7aYxjjBFU5+boQgsiGB7FcgPLCIkDh9jy5AODw5scPosencqt892L6s5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::38) by
 PU1APC01HT081.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::284)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 15:43:29 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 15:43:29 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 15:43:29 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:44cc:a624:8145:fa79) by ME2PR01CA0064.ausprd01.prod.outlook.com (2603:10c6:201:2b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 15:43:28 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 3/3] Revert "thunderbolt: Prevent crash if non-active NVMem
 file is read"
Thread-Topic: [PATCH v2 3/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Thread-Index: AQHV8KlS3XYq90/jLkW1+zKh/mLy4g==
Date:   Mon, 2 Mar 2020 15:43:29 +0000
Message-ID: <PSXP216MB04388C56BECC4CE5EC81EA2680E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0064.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::28) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:2D50C9D10288A8929A633F25961440531D1E2B9ECD2AC7E9E137FC9EB34207D7;UpperCasedChecksum:0CA51D05F807693BC92CBC23C91A286C5B8C420C893BE8320F74D9C7000ECE8C;SizeAsReceived:7856;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [0liB1Wzf/ianTt9u8E32Ozks24dCYd/ayZc22nBBehvrxEI/N2NzRWY9ckAAjJGn]
x-microsoft-original-message-id: <20200302154322.GA481006@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: acd34931-e75b-4679-e977-08d7bec0747f
x-ms-exchange-slblob-mailprops: S/btQ8cKWiR7zL3p/sYosB1cR4mu1sxVWNzyiwZVoeIaabYY3CbYD6c2bGLp6LXhknC8ITBgBQZ9rEU9Gs5K/GauZrkWOlMhHBkdEFrHuoe+qXJX/szud8fP4cxrCzLKolsZIB0uehC6YTRqY8L9P0iy8vqvo4f0dPiqtEmgtDKpoIYrBXuNmYJG3h+//SHtucowlWVniGn5Na7MU2UjlHMDuoM2xndfA1k/kib2nRrcbMOKbDGcZVNHerKN3VlAYy+O3i+7iiVjzTn8cxDrZRj5Ws+B9AdNX0aLOrQqh6VmVZZbqN9j4qhtIuauJ0HNP9KBOeAVh09jBAC0fRPy/APxNi1UrHomeneZreE11L43iSlEYwtuf7x2low82UyHKsjJ4sGo7pvxaym2qekzkV7tcHa2iBzfiMQuuz1nnH8r6V7JkxVhCaLydve4jPVUiau85Jm0zsx+fnoWfELetrjVZwCgzCNxiywD6jpvDZ+p4kN4pjzMvSGkvgz1QcYlRZ11Cl1kg4Gk8WZexubeF4WrZoeyUGUFbX/8bi4MCIYc+jVckCg+GZZVyJrprtZ/cS7ShQlISNa+1dyns1e3n8QOFX8sYclhH6Gt1lJhc04vB+Nj4jfPMugYRGEeTirPj4b4pj+2Jn/XHZSQu8GgO5Tf8lWr8xQIEqagE1veczLbx8AWWqcfI1KiEGzcTU/DNkavrJrBU5vAHWy2rEk4EpBDWO7+apRF4UCf/y04NoPA4uGgsULfeX3qoq3fTH7ivZxHDVicrig=
x-ms-traffictypediagnostic: PU1APC01HT081:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WzWzs3qtNYFXwhmpfBKR/OWNubXPvV1Yn47TTkmnEUchr6dRf46llF/DvM2GipL/2y4uBdEFX/facy1O7ehWg6umiBQ8721tFJK2PblINsHhu1fhOENHXxx+AAkQIS1wpzgRD/LxneViN/xg4XnU8NYNmY0ac6XAxdC1tpNazy8MiWw+4a/P09/AWzrU639G
x-ms-exchange-antispam-messagedata: YS5o03/5FKZvGeITAAFodIiYVN9b47P4s7psS6lIrg7fIvAAUh1LzkBRtEwdmAFEtnsB9LdmeeVB1860wtlPbmYj/7VxhaP88KD3OlAFigdBXJvDiE+nouysAnDy2LjvixX0w7nY8kM47SgNx+5XsLAQib5REx9AG976Yx1khXMgstkanLlXvREnWv+XTdMc3n5LgRXVD2lFBChbJ17N8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <111194DE43A13D489888F0C46FA39259@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: acd34931-e75b-4679-e977-08d7bec0747f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 15:43:29.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.

Since NVMEM subsystem gained support for write-only instances, this
workaround is no longer required, so drop it.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/thunderbolt/switch.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7d6ecc342..ad5479f21 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -348,12 +348,6 @@ static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
 	return ret;
 }
 
-static int tb_switch_nvm_no_read(void *priv, unsigned int offset, void *val,
-				 size_t bytes)
-{
-	return -EPERM;
-}
-
 static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
 			       size_t bytes)
 {
@@ -399,7 +393,6 @@ static struct nvmem_device *register_nvmem(struct tb_switch *sw, int id,
 		config.read_only = true;
 	} else {
 		config.name = "nvm_non_active";
-		config.reg_read = tb_switch_nvm_no_read;
 		config.reg_write = tb_switch_nvm_write;
 		config.root_only = true;
 	}
-- 
2.25.1

