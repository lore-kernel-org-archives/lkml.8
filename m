Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45924C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41CF2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="D4ygxYiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgDWLzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:55:03 -0400
Received: from mail-vi1eur05on2117.outbound.protection.outlook.com ([40.107.21.117]:18810
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbgDWLzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:55:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNC825hJeBt+D1gkw/SDSS2tQjzS+V4f0sKjvNy9TKlXFVXGWbodWDwcMYPawppjvRvtQrYGeFVW74WP6I2gAcVhDVcPS0UfLjJR/iTX43einNCX6pQVzGaepPEFOxsBWlJHvYVqn6IIsCpVp0qbKatvWG3Mbe9c17OQgBNMWOUMA8FXhkcIKaDM9+kXDbfM4hiYFoVx8KzXJAwz07e5nIh+opuXVZ9N/AhjtO1i8GaHpKtug05tqWp5zX+U79ofXy266QlJOrfjizG3JCKjDHHkD2ZkJJcWTkKCTwemnNrYmmKctjaZHu06J4dgoXB3uLAuIOGhwNMiprqjfrz7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jTp1noxU5OBZUuPIMqsQfN1WSkRkwmrhS26QaiU3iM=;
 b=bTbHT/VcdNiCG5EVJB1jP+81Yk+XcvdCavohbhViOZCpb7IPch0b33oZbL9Jy33+F60ROHx8UA3xskZzmZyJMiVAwdnC6X8RsMSGN2tn/My2fc+eVlhO/nkkQ7tHIWLbn0qCS64v0Y88M6sE72GeuFBJiWlQW/58c+BcMgwwa1lUUCGUQkKg6a0rFHPyDRjE53LPM1e2ynMOLVqedmy54V2/eWZJtQb5ucxukgmIc3wq8xzDp9Wb0eRfim0uPmdNdbc2xsD4MGim4aG8oZEt/DE4NG8/8E3pKSeRlHBIqAHN6QuhDJf5/J4rO9PQvTpgKEPfon5VD2tiynGMli5Zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jTp1noxU5OBZUuPIMqsQfN1WSkRkwmrhS26QaiU3iM=;
 b=D4ygxYiYqZ1kzGtM5kkG/GLsXvacRWpTRysWhArtGTsf1+0PE2yueWMLlHvrbnIx9vXvcT44Vy9Z47JQIXa3Q+LWWnTLWEomLhHLqaRPBppFnO7umSeHq1jmvryRrE4ReqSHISo3D2rVq84C8yajnwso4g1eZGHDm/fHzJRDayc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com (2603:10a6:3:4b::11)
 by HE1PR0701MB2844.eurprd07.prod.outlook.com (2603:10a6:3:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Thu, 23 Apr
 2020 11:54:59 +0000
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece]) by HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece%10]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 11:54:59 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf test session topology: Fix data path
Date:   Thu, 23 Apr 2020 14:53:40 +0300
Message-Id: <20200423115341.562782-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.25.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0285.eurprd05.prod.outlook.com
 (2603:10a6:7:93::16) To HE1PR0701MB2938.eurprd07.prod.outlook.com
 (2603:10a6:3:4b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.15) by HE1PR05CA0285.eurprd05.prod.outlook.com (2603:10a6:7:93::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 11:54:58 +0000
X-Mailer: git-send-email 2.25.3
X-Originating-IP: [131.228.2.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0f2f889-cf99-443c-5002-08d7e77d2613
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB28448AEECCF4C9AB0095B081B4D30@HE1PR0701MB2844.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0701MB2938.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(66556008)(7416002)(103116003)(478600001)(2906002)(6506007)(86362001)(8676002)(81156014)(6512007)(36756003)(8936002)(6666004)(110136005)(54906003)(66946007)(6486002)(5660300002)(4326008)(52116002)(16526019)(26005)(316002)(956004)(2616005)(66476007)(1076003)(186003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVMedP5gbBRSS9yS68OrbmWigL/PrwOxcnPvdNn/08GsgaJQTFLdhW8RMJ3v7/xPyuODs0IOno0ToXMXk09+SBl+WKtYYPwt/YyS8JTpOxfJbj0nXkk0f9j8Rf5K0mq9K5FWXxrSMfWCH7tRy+m/hbTkfuYwtsoTPuGwagNv4mHA0UK2IXt7XYc8QLsa6SMe7fUT9SHIc6QTmluTQiIPdGZ5tyxU3qnuLW95ozOgThyrLSb0lPXsii7ZIBsFXVSFgD2wmV8ECFztaOoCbsVymmn/fGF9TzQgS7x6p/BQ1ZxRGqmBQg09EeU3loOJJ1kPpEv26iUFq+7/a71aY9nIas5hJakhUumObXtnWJpJq+jbbn5jePtW8h0gf3N74fO2UXuFWzARJfTNJhiH0SEJSUvIYv4mRxx2P6uceHBx99J5cUXaPXfIrXabIoE9WTRr
X-MS-Exchange-AntiSpam-MessageData: cu649+IPZ3bxoV2iBiBF+UXwtlYJ+Nu/rCBXTIUVeAm5aJgzIR5rneR/AkT+ePhCZ9GOl1b0v5M1nTPiwNIAx4f54oYg3OOl5fBgmLMEc+vLfg3wKzJn69HNHOZ9w64hbVAkAmf3KBgcMYVuekz+WfsoXWLFwF0QueBX1IU5+OaJ6XRla+uHgplegH+mlPx81uEfJD2p7TSRn8SVPRqXm1L+S3Fc/1HraWN1d2xs1sepGVrp8M+dO1Ecx/Ck2XSHSVUkc4itjeBfXadvh2vdZ5PanRUe4eiPO+3wwlvSaAyxeZme/K7jOkVLk6JWI2o6GqPgyKAfh/r1OEDEO5WEwyaV4C8YVSlSCwt6U+Opdyq04sTCxdYxaFjU+rNMmBvEaGRa0TYQOTDd8Y7m0jEx5UKl2NENj/i1iUc1copGqc1HkOXsboF6CY73O9ytTe52qd1cFOFkeOlI8JM4eR8uQVr2pPjZafgMTuB4WV6Hl2kmOq7cz9scpg/WZNpH6pMwmZgzRBToLR36o0tfLCBUY79RHRCWDpBjcxw7fxaPhLzukpFZ+ee4be65emousKHYQNk++OZFbFJRNjptC2QpDWzj97zvGvUbisEi7LReZTlZXb2L111aM/3O+4DLcpS1uEQlovn90R4tMbRMj6cBri6CTcLBgglviKtFYofNPfyB4YfhG7IN4n6dXHzD283DWEdq3qW1VzDl+jO83zVr/mopjGQOey/wC7zg2BvGgPx5BXK3GuvsRtTDY8qOnxTrJEvB+It/lpzx6DC0Prw6RhxEFEJYxE0NRcJCnHMo/R4=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f2f889-cf99-443c-5002-08d7e77d2613
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 11:54:59.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hw8yXHqFrBHnK5HRicSabw40PdBud1nmmHt+bXV5be1hcJAOIYOAoNE04+7rf0c6HPEmSyBYTK5n6ww5u10/7fW3r4e0DXi0jbtnatNqXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2844
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2d4f27999b88 ("perf data: Add global path holder") missed path
conversion in tests/topology.c, causing the "Session topology" testcase
to "hang" (waits forever for input from stdin) when doing "ssh $VM perf
test".

Can be reproduced by running "cat | perf test topo", and crashed by
replacing cat with true:

  $ true | perf test -v topo
  40: Session topology                                      :
  --- start ---
  test child forked, pid 3638
  templ file: /tmp/perf-test-QPvAch
  incompatible file format
  incompatible file format (rerun with -v to learn more)
  free(): invalid pointer
  test child interrupted
  ---- end ----
  Session topology: FAILED!

Fixes: 2d4f27999b88 ("perf data: Add global path holder")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/tests/topology.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 4a800499d7c3..22daf2bdf5fa 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -33,10 +33,8 @@ static int session_write_header(char *path)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = path,
-		},
-		.mode      = PERF_DATA_MODE_WRITE,
+		.path = path,
+		.mode = PERF_DATA_MODE_WRITE,
 	};
 
 	session = perf_session__new(&data, false, NULL);
@@ -63,10 +61,8 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = path,
-		},
-		.mode      = PERF_DATA_MODE_READ,
+		.path = path,
+		.mode = PERF_DATA_MODE_READ,
 	};
 	int i;
 
-- 
2.25.3

