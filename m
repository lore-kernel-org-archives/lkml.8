Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C3C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CA6222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XX1zK+AG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCJUza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:55:30 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:8512
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgCJUz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeS9P+dLf0VDFGmhU45GpK7iwjiUowk+FtDAbvea4mNx99t23KaVN0FoMam/UM2GjBSEGXZ6l3jGOTg9jpGZrMoZP7+6ak0OdWW3+8B/EY4slN7cjg28tf33vTAxEd4Fdjo3NQexTkH45b3MyGgwjTC/Pvq8rw70UqiUoctS7kzUT0XbKRGv1TmSbOZuYkQu09sXaIkNrmVtGHV/6ybwlfP+uUeVbB+RUlqXIlzBEj994yPBHtjxfn9vOFcEWm3FCV4dbs5TueaJuXa+JsrX1teyNEA9iG9PiWibH4HptCHNp5dupMEOhRMURnfN+IFbzNMQcArqZzIAoHT6/i8FUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mw9R9NS21yF85WDHGFMTVGpjccAZ/6N/A+mPJNK6SY=;
 b=FT3JAysxXyWGaMsZGSPmHWKid9EuU8E4oQh+nGLy2dhFYHlWUPtDxOFfnuu2e7kMXkE5QTHuWtn8yfLC/sDT77St2m0sBndTh8Qtz+4Bt27Nq0nFBYhXnwo7uRZQBSZblrSQJM8wWZvDt01HpJGZhxBpZYc+nWd76NboRFwszvRLA/DiOi8SHPhz8ILrErD+mCzdWNlgvVmZvIKUxR7RA73RmCvDYz/+cirUHvq9Ab0RBRS7syFhe7YN1zJI3hXXM7lhEdFDfk49qe8kKuKHKk5M9r3Rmuk1DeakijLtF0ElNKBPMFyQGRmwk5KKY16laTSiG81P3Or+vCaKNoZ4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mw9R9NS21yF85WDHGFMTVGpjccAZ/6N/A+mPJNK6SY=;
 b=XX1zK+AGrUZ1946Ewv7/eqqQM52y0ZdEpaq3c0NeJvfLLgGBEzTdBtngwvnh0Pv/FeCtHP/w6Up/IB6GWVcYX0FFCMISz/YQeaePewt9PbCjG0WkzrovC64wIb3lSDMEbuBQCe0t7VECwK2e3UAauc5lZTmr/1MxGObZI+QQ5L0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22)
 by MN2PR12MB2925.namprd12.prod.outlook.com (2603:10b6:208:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Tue, 10 Mar
 2020 20:55:26 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6%2]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:55:26 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
Date:   Tue, 10 Mar 2020 15:54:51 -0500
Message-Id: <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::24) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 20:55:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 313b36fb-fb47-4e15-a3aa-08d7c5355bfd
X-MS-TrafficTypeDiagnostic: MN2PR12MB2925:|MN2PR12MB2925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2925F6BC96FE919A8BFCB5E5E5FF0@MN2PR12MB2925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(2616005)(6666004)(956004)(6486002)(316002)(52116002)(7696005)(478600001)(8936002)(6636002)(36756003)(26005)(16526019)(8676002)(66946007)(4326008)(81156014)(186003)(2906002)(66556008)(5660300002)(66476007)(86362001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2925;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOVZjrWqVP9PCgwFOyOZv2kJVLAQ9fEN2xj+Zi1XXzpZOvGID4wlVZuBFGvaKKEloBTgAvFW1yaFbf2tnf3hDciPRnivyatQguwhtbjzZfMSZMlXR6MSbugGFptt1HovLvwIhLc/gTbFm591Kgd6dDAq9WO+w3TPPtRsvo4TriVElYEbetaa6uzOoM85/8qYIKq9Z34ATE36ISB3zgz09Q4CWg60vbFAfi7biRv7yPu1tvuN8R+84QiBxmuQlW350P7CjqZg6BzYxidWOl7Nr7VonZZAi2uBi2CoQuY2seqrHl/bx6v0LzvNSJnmhZdUDoommsFgUHhxnkM9OoinZHW1sc+HfGofE4uhzQtmBcdW3KxYv/AiB6GsEWAVbK304nnkzGVn7mRME1KoDHT/mrGT+ZgvHv0eNr7jCx0M69KRscr6UTcowb6/IBw7NX29
X-MS-Exchange-AntiSpam-MessageData: 5PI7rK8axL12YulGH3N8eP2IZLFS4tCl3b4F0pVy8VIIEMxAtx2E8pqxP0TAUwCyRqy6XHzn1tB/ujGzhBzwvkPjzDc4rv3eOYmtVrXFhB11bfRF0yrQ452nR6i5Qnm4ri0hpvPWgPRHCi6ayyq8hg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313b36fb-fb47-4e15-a3aa-08d7c5355bfd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:55:26.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X53QhGXGHer98y745KkZAGMBuia4nA+4ZiFDKAJhmwxJwm3H+4+KU4HxbezjYRxsjKnqclhAiGKtOrdijVyCbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arindam Nath <arindam.nath@amd.com>

perf_spad_cmd_send() and perf_msg_cmd_send() return
-EAGAIN after trying to send commands for a maximum
of MSG_TRIES re-tries. But currently there is no
handling for this error. These functions are invoked
from perf_service_work() through function pointers,
so rather than simply call these functions is not
enough. We need to make sure to invoke them again in
case of -EAGAIN. Since peer status bits were cleared
before calling these functions, we set the same status
bits before queueing the work again for later invocation.
This way we simply won't go ahead and initialize the
XLAT registers wrongfully in case sending the very first
command itself fails.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 6d16628..9068e42 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -625,14 +625,24 @@ static void perf_service_work(struct work_struct *work)
 {
 	struct perf_peer *peer = to_peer_service(work);
 
-	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts))
-		perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size);
+	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts)) {
+		if (perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size)
+		    == -EAGAIN) {
+			set_bit(PERF_CMD_SSIZE, &peer->sts);
+			(void)queue_work(system_highpri_wq, &peer->service);
+		}
+	}
 
 	if (test_and_clear_bit(PERF_CMD_RSIZE, &peer->sts))
 		perf_setup_inbuf(peer);
 
-	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts))
-		perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat);
+	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts)) {
+		if (perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat)
+		    == -EAGAIN) {
+			set_bit(PERF_CMD_SXLAT, &peer->sts);
+			(void)queue_work(system_highpri_wq, &peer->service);
+		}
+	}
 
 	if (test_and_clear_bit(PERF_CMD_RXLAT, &peer->sts))
 		perf_setup_outbuf(peer);
-- 
2.7.4

