Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B930C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E3D208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Ht+Ll19/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCEIhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:37:48 -0500
Received: from mail-eopbgr80109.outbound.protection.outlook.com ([40.107.8.109]:50715
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgCEIhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:37:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKa56jDogLIzoSsc1XHQmYCrglzmwlInXEh80D79BCpSgMU28letRT5rVa2iH/vzswQ1p1Eu4XWz0bspKVOHXXP7fbth2HJPRxWnqNlsU/i/YMdUiatvfNLUZTAI0EUVItYhe9kCkS8W49Osg43jUKGjO/aFFCadhx0EMwBLi9Av0cTzQphxTI0sKQlg4qDJ5cgLw+LvilxYh3tCCV0IhdB0UlMI6uaqlQtWJQMPTm4r0U6E2OzMf7SQzB90Y3IMs06RvsAmtaK3EwlhKoyQC70QlTPxaKIu65b5qK5bSQBattl72X5ZLGpQHoOEaRHIPUwnqASOjrQ8/vKAm1nhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWpKOljTGEYWzDf1ED2XivvVnI15xm6eO+ypnxYLLQM=;
 b=KkGvvGV3Z152p73AZcLm9m4b1qmuFcuTQSl2RPgFoGuTAhrAt7Ah0oUjg1FsRlx66deIQVdupHWtM+J4e9pamx4Sfz8+mjZdfxcZElP0rKceX3YoOBFGTg6zGuLTHsIRXeJclcMge24eK2pqCA1cGu3MZmk1+N23G9r4Wl6lU+ip8c4kD1wIG1HhsbZhA/UwJQIFv+Tz+w4ecAnc7/5t8ohA9hrwGLacNYu0zsvZezWA45a8uX6fMCOyKCO7I+jPjO8l/Oxemia59F4H7Ino5yZS1LfrETw5bReC9rjgAetb8iUaw8zRK4xHB93EIs2Wu6fJjdf1hTqa2wPGuqNUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWpKOljTGEYWzDf1ED2XivvVnI15xm6eO+ypnxYLLQM=;
 b=Ht+Ll19/2uxB9W+1xoWY0WDGqDujvywfBvUSec5vWd6IFf9X42QX/3n8MnBXBLrh/3SIruIZymvW9FYrMQ+Z3sukAEw/StJp0UP0WV4JAC5b8b3Wk98eb0x9TqJAgVb7Hcz7d3dL/2gU6pIFq593BiUN4IJnt1Y8dGphiuTIPFk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (10.167.127.12) by
 HE1PR0702MB3804.eurprd07.prod.outlook.com (52.133.7.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Thu, 5 Mar 2020 08:37:41 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87%5]) with mapi id 15.20.2793.011; Thu, 5 Mar 2020
 08:37:41 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf top: Fix stdio interface input handling with glibc 2.28+
Date:   Thu,  5 Mar 2020 10:37:12 +0200
Message-Id: <20200305083714.9381-2-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
References: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0048.eurprd09.prod.outlook.com
 (2603:10a6:7:15::37) To HE1PR0702MB3675.eurprd07.prod.outlook.com
 (2603:10a6:7:85::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.19) by HE1PR0902CA0048.eurprd09.prod.outlook.com (2603:10a6:7:15::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Thu, 5 Mar 2020 08:37:41 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [131.228.2.19]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbf330d5-3588-4a3b-c347-08d7c0e077e1
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0702MB3804E0D1B05D43D7A1D75989B4E20@HE1PR0702MB3804.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(66946007)(66556008)(66476007)(8936002)(110136005)(54906003)(316002)(5660300002)(956004)(86362001)(6506007)(2616005)(52116002)(26005)(103116003)(186003)(4326008)(6666004)(2906002)(16526019)(1076003)(81166006)(81156014)(36756003)(6486002)(6512007)(8676002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3804;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgtpKOYZ0Qq5c0/N3uzGvxFCUkgVQ+ei1lewSnM1elkxIWkWOQLdDFeH5bBRkhVUWj+YcK3/IO+heg0jipE4UVp3Hhghgz020FgVN1UFzgWYUFyk638ehKRL/cTo3KhXUEsFbZ2ptj1yFJe11uJ/gDiTcHvfr6j6aJtQ+yc1BEwyfrlJLMDmDpUvv6CwM5kYalMIJ0an2E0fqcjLCKSRxWTkz4/QOpxnsN/7wB0s2/BgZmJ4JpgKdk72G0GK9FJr3b4Uu34TjiVUqeZOaQSWNcPWyynG2/0B+Kbn1T7fDxIclJgUCndoOLt1xThzIjE/rz7KmXEUQGP/c+v9s6Hcnpbrt45vmCP1TCwAVlwWc26zOKkRqsT491czIWtHqFUR1OO2awZjbGgwOy1NiH+Yr2S0dhl7GK3FS2v5yek8JjT9HHbHfdLeb9Xst4dIgiNVQ06Rh3fdJHPNvYul+Z3+58xkXSo1MsA8+lYFfM9dFRZ+VEOSNLxoeML77B29xT/ob0QYHdyW7PNB88KfkFfGAw==
X-MS-Exchange-AntiSpam-MessageData: 793WGLfxeKDMYlD1mBlEKaltFr5UQoIt8HVCkUwqkG5SzJXmeVQnO4+Mi5yvZ+nkdNJYsu3HZJdDrDvXCLPkqMiDyhdWKo/CzYISIqgEfzOEgRXx8IMEcKytPQITQwwkdyGDrwPAklGF8wQ1orGE9w==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf330d5-3588-4a3b-c347-08d7c0e077e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 08:37:41.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPbzy9uKSLqlDEAst3NLsjHi7jWiO9Cw4YVcbWvb8eJjHENgnqwpKWzpwp4+GNHY0zIwOxyTU/jXjhG/moESa+zrH5zT+5ryEJsoqXPTUus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since glibc 2.28 when running 'perf top --stdio', input handling no
longer works, but hitting any key always just prints the "Mapped keys"
help text.

To fix it, call clearerr() in the display_thread() loop to clear any EOF
sticky errors, as instructed in the glibc NEWS file
(https://sourceware.org/git/?p=glibc.git;a=blob;f=NEWS):

 * All stdio functions now treat end-of-file as a sticky condition.  If you
   read from a file until EOF, and then the file is enlarged by another
   process, you must call clearerr or another function with the same effect
   (e.g. fseek, rewind) before you can read the additional data.  This
   corrects a longstanding C99 conformance bug.  It is most likely to affect
   programs that use stdio to read interactive input from a terminal.
   (Bug #1190.)

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/builtin-top.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f6dd1a63f159e..d2539b793f9d4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -684,7 +684,9 @@ static void *display_thread(void *arg)
 	delay_msecs = top->delay_secs * MSEC_PER_SEC;
 	set_term_quiet_input(&save);
 	/* trash return*/
-	getc(stdin);
+	clearerr(stdin);
+	if (poll(&stdin_poll, 1, 0) > 0)
+		getc(stdin);
 
 	while (!done) {
 		perf_top__print_sym_table(top);
-- 
2.21.1

