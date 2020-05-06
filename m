Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED9BC4725C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EEE206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l52dYC5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgEFEWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:22:47 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:9609
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgEFEWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHHTLzkdyLHkCPhQ+vyk5OQlGWlM/mKmBg7ARlzPgT7HiZ89+6YYbOTQk46lCr6/WX89WiAOc40gbYWX4WsHmKMdB6oCCwcMgJpOnj6klelQxMWoY0blYkUMKr5hEStgHeuKVhEi7faJOwf5UAn6x1tQpgSbGH1tTjGzXLDisdC+vMO1XLWUfO7MxezA89hRdYIkEV6LY16WAA3N97pNNtesmIAq/yAkvsHiZXFnLCassZQOfVJjq5u225JwsOQGChsuPaScCOIum3ySt0TcQ7Nzfv53j2Kh+cGHSXTlhBbyNy6HNX49WcqbLSVcbkJJCCuk6KlclHepQyF9qwyt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJTcAg2Rx20NV/3eV+nC7FBwuzQCxZ4bTl7EOG16GUQ=;
 b=klO+wzPB8i4gdpgTk5ec9eXe3418+dw+EdWVJL0OT4BR4F+dlzHPuYV+rknApNYQ2a5bfpW4BsT5kw9V84rdUJ38hGcqwL7Ikg+53FS71mK3LtzvbpeciNnoM4DhG8vGEx877LEiPVw/fASml4EjTPC/Z7GLZYjIzYiIbu2l9g0JIpGmSMBHJFYEaboO31Un47QMGlQFcIms/4pFLOiAem4aHHX9HZNKscmEEYTFKl4S+We8PSKPZplkQQ24xitJDFf6BhIeYfn+OFfDlOFLfcUSv3lcr2MUOTt++9XOczcgSVRm7LbKzFLBU26aJuTeBjzp6OrFyt8v69GeLk3zcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJTcAg2Rx20NV/3eV+nC7FBwuzQCxZ4bTl7EOG16GUQ=;
 b=l52dYC5U5V5VlSg6kAoHNXL3HVksPSOUkdIGjvVc0A4Mfi/gGwNI7dY1E8klSGbnKu4hUHyAR3KgB5lUITlX4iTBQ1OXimRQmKOSwFB3+1yhxCeE/nrC1Q186EcKiQ4XIkR+T39nRHw4wN9OGJHtWGeh/bUg7CyRVF+DbbJEzDI=
Authentication-Results: kudzu.us; dkim=none (message not signed)
 header.d=none;kudzu.us; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28; Wed, 6 May 2020 04:22:44 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 04:22:44 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 4/5] ntb_perf: increase sleep time from one milli sec to one sec
Date:   Tue,  5 May 2020 23:21:51 -0500
Message-Id: <1588738912-24827-5-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 04:22:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8bbc46c1-02bb-4fd1-f76e-08d7f1751f59
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:|DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40922EBF5D56C3D40C3AF7CEE5A40@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oGL3XVXNMXcZrRopTG3pFNerw18DviCj+0lagy89nVbOWIORJg8/xoh8s0nFmAxpO9MwN1KQZt9GLb/wIUoEn7vcVPpLo/kLiUiy9oTSkrU7AXOY3uqtXvNgM/DbzjyQe62XkAEYiq10Jkej0SfyBuQm33ZkMTfMAxUi2nwLh8PGPQv/pvzHdC92EV4QC3erHcG5FqmKaaGXVVD3K0drDaKcJHkb1Spjbpqo6Lpp9XsZdtABW5/7yxK33dY3glGpziaRLZK0CE0Mop9abc0PeYgiBaa3Ohss3ln/yNqI1IpkFu3rwPRqASbl9LGxZmQeTS48PzZmGaFrADmKD2ExtcTIlydgNm9kUHgkFiqF0AY8/Ne1WsqM5ONgMgI22aKn/nuqmB62o355JQkT17yAqLt3X1vsQ83KyTRdAM5C1sGmSmYwyIuQC4JilzKTeVu96yKWd7hQso3MPr8FXOARfnHWL9amY8cLzbELu3I2Ph5UUxvxBfra1assvHHrlLuFi65KNKnVn87oOIRFiKqaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(33430700001)(4326008)(4744005)(33440700001)(956004)(2616005)(478600001)(5660300002)(2906002)(8936002)(36756003)(316002)(6636002)(66556008)(66476007)(6486002)(7696005)(66946007)(52116002)(26005)(8676002)(86362001)(6666004)(16526019)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Po/RQ9wgbUpMupKSf4rVZ3Yvz0K3UycJTj25ws9c00PE6PgB+Lrk+l4pHVqvmxm1oxh/cD+osoFZKrVJ8JziT5MV9j8Rvsijv4MJxGTR0jLHdb1xl7DB5YgVVHFAPVnvnTT82lsrftoK/B5/FBkpHoSx0MVT0t7lEXrR8Xm7BsmW+XYuUzhTvPWMeY4zKU8TwKp5Ot6yLOFY997VG3Ym8M9aA4jgQwwkaM7zUjTE91B5QCP6TFevaOBKnMsM4oG7Q4WcslVoMuW14A6MRWuF9lAWwjnluVbXtG1jMEcwmcJxVVNA1cZ97IuhpSPZ+dHvIJWSoDFiIlYUgnTelJS/86/OEufwNFDAg7Owbtg7RmZ/7Cq/ou+Hj+3kjh1CGC/LI+l9eK+NZdnFM6yEAjG34uLgcxIDRfKKh2eB1/e3MlijDnIHYQN+I+xhNrB0Z2VG2hFQVr51y9PLaP45qRd7moN1KVRLQmJ3Y5XPVfwUWpL3J/4L4Pr1ocaSOxak4lstwVWap3kZ9+OljCefP/PczJ6mrDeTZ2psjr1j2GYy5JUxCzOFBdqEhZmedP6yzXhIGUGVmnzYm4eM9D9KKESMOMzZdmbcQg600LGcY/N9zXxgYfu/7taTaCrr/wcXGwXnCYK2Lti/C0F6f9KCrjDc1mpkIaPxrkcEL/3KdL1apvdEjne+flp0mxaaTjp1o2PoqZ3rqBZiHEuSxKqIvGEyzpUtIMDMjARxQvkHpA4thAJVY7/v9pDPwBJJeu4OgCW3AZN0bBCf6LBmzwYO8Jnep7VKZ56R7C/RL0KqN2oPVOzt6Ibp6742OVqJqe8IhtgH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbc46c1-02bb-4fd1-f76e-08d7f1751f59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 04:22:43.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liwEhD1vJ6+Tvlb2WeEqyd8LZEkz32J4pa1pJIFrX+GjEkhuYEuM5NTh+JAv19vOPurG0CxM9BYXNE4nRzhbPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After trying to send commands for a maximum of MSG_TRIES
re-tries, link-up fails due to short sleep time(1ms) between
re-tries. Hence increasing the sleep time to one second providing
sufficient time for perf link-up.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 1c93b9f..dbcfdaa 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -101,8 +101,8 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
 #define DMA_MDELAY		10
 
 #define MSG_TRIES		1000
-#define MSG_UDELAY_LOW		1000
-#define MSG_UDELAY_HIGH		2000
+#define MSG_UDELAY_LOW		1000000
+#define MSG_UDELAY_HIGH		2000000
 
 #define PERF_BUF_LEN 1024
 
-- 
2.7.4

