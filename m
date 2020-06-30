Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAAAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D579E204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zSQj6OeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbgF3J0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:26:52 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:6145
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730256AbgF3J0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivcE1/zIBVyJcKbN0bSEtBPw4a8V/GsKPAfjYSlLDypuFtGkRRLGbqmPkTtEaioVtj7gAXZhQbZ5rM8nHK0kO+db1+JlLN/QLi/325JTvOJ3VvVr6ZNtvLfkT+uXC5Qhqdi8shCDgMs8bBQ3+zJzSqIRvUYcQ+vlV1ncby6azMycSjGB8OyDS3MxMVMTSiDcQXjjCNBsiWebnIzMRGe7DtCR/CFpM7UyDnsjHWJXIrEoQkc+r3d7wA259brxaYiTrFM9o/3UDmYu/YGnp/RkyEjIGhoqHNJDkYqmvOdCL7A3u6lYyfmAUVb8nUiZtJ5eDBku+rqN+zSwUat5vw4XJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+Bkqv502XsF+2UoF2W4Bs2a16FsinIR+9b5SqRgi+M=;
 b=hxf9eoRLJmZtl1HG+oc4w9VdZCYSZ59/h7kc6CnJidsFe7Pro9NN320+vPNNM7ulaMMLyP7+5664ElvS0X4BAdlrIpotFKnNitWEQo1UoTblSYItT0Ti6TGDudUCOYK8cEuQXAZFmPB52H9Ue6IsimD+RR2GPynyZ9m2FvcuBGs+L4M7RjXBwY3UFDkz7Qc13Rjgp2ruuxBPJSevoJ/Zkwk1quTNHsnXQClGGcC0VdtTUP7YqSNT3xts12dtv3aF3v1FYZhtCLqybXO7pzIw0yGFkjYl+MFzoAix5iJgfKzbLWJt40re3fl0zW1R5seW4RSXn784D6CH4uBBPPdZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+Bkqv502XsF+2UoF2W4Bs2a16FsinIR+9b5SqRgi+M=;
 b=zSQj6OeHnarqNXbNFQXsYr6ejsbHroCFFUKZQNZ016tT0K8CYfkj0EGknULqJxoXz/ayUlovmWAF/Ze/TR7mwT2YxiX0Sx6t/A1R52c0odNek8m68rRYg0pC7l0bGLgR4lFEt01X9/DsA/Cq01/AMA2Agy9ahE1vNIlMCWMtdg8=
Received: from CO2PR04CA0151.namprd04.prod.outlook.com (2603:10b6:104::29) by
 DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Tue, 30 Jun 2020 09:26:49 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::b9) by CO2PR04CA0151.outlook.office365.com
 (2603:10b6:104::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Tue, 30 Jun 2020 09:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 09:26:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 30 Jun
 2020 04:26:47 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 30 Jun
 2020 04:26:47 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 30 Jun 2020 04:26:44 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Akshu Agrawal" <akshu.agrawal@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: Rectifying Unbalanced pm_runtime_enable! issue
Date:   Tue, 30 Jun 2020 14:52:38 +0530
Message-ID: <20200630092242.7799-1-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(356005)(8676002)(70206006)(2616005)(186003)(70586007)(7696005)(82740400003)(47076004)(26005)(81166007)(86362001)(6666004)(478600001)(4326008)(83380400001)(109986005)(54906003)(8936002)(82310400002)(336012)(36756003)(5660300002)(2906002)(426003)(1076003)(316002)(266003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 180188f7-4532-46ca-900b-08d81cd7b71c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4313:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43139C8BADBA97D6C5FE00C9E76F0@DM6PR12MB4313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2jJokuLGfVLC63ym/kJMCMoafQF2d3jWV0epXlWVDaVvY8dTSkz/C35e0cD8F+/7q0PyrNzpqPC216LtpoFp/b7fMUuPJ+dyd0IVDOXJFES/IS0JmX56It6muaH7egfA6ihRT7nBKuSedTxHcZlEOq6CeUP9Dq8Ax5+V2f57gI++ZFXWqMIPaywLFoOrMCaHEnV1LK38RermmMX1xmrOCW7obJdmQb/nuxVyKkSvVOo7VIeZFkuo0/wcMPBowJON1UGRtKPyN2XF4Y8G09HW3cO2XxF7bk2/lPOYJuDzj9HBPKWcsX8ePDLQhVFdQPwV8QYW19VWL1rKvCT9/lLrxviHGtdrXsKREwlt9tqAk9tKjNJCl8hBKhN/iLhPIx1qaAKTc3S3EE9XuZkNytJKqUno9OzVGwMIso5yM0Htnk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 09:26:48.6974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180188f7-4532-46ca-900b-08d81cd7b71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When snd_pci_acp3x driver loads we see:

WARNING kernel:snd_pci_acp3x 0000:04:00.5: Unbalanced pm_runtime_enable!
at boot time.
same can be observed in /var/log/messages/.

Modifying pm runtime sequence for fixing unbalanced pm issue.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index f25ce50f1a90..ebf4388b6262 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -232,9 +232,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	}
 	pm_runtime_set_autosuspend_delay(&pci->dev, 2000);
 	pm_runtime_use_autosuspend(&pci->dev);
-	pm_runtime_set_active(&pci->dev);
 	pm_runtime_put_noidle(&pci->dev);
-	pm_runtime_enable(&pci->dev);
 	pm_runtime_allow(&pci->dev);
 	return 0;
 
@@ -303,7 +301,7 @@ static void snd_acp3x_remove(struct pci_dev *pci)
 	ret = acp3x_deinit(adata->acp3x_base);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
-	pm_runtime_disable(&pci->dev);
+	pm_runtime_forbid(&pci->dev);
 	pm_runtime_get_noresume(&pci->dev);
 	pci_disable_msi(pci);
 	pci_release_regions(pci);
-- 
2.17.1

