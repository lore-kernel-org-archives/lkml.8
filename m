Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 00:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36A22081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 00:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="GsmJaSzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgERAuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 20:50:03 -0400
Received: from mail-co1nam11on2133.outbound.protection.outlook.com ([40.107.220.133]:16451
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbgERAuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 20:50:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmTOEYtMHscxsSjIDsF3ZOzlUyoBMbHc35ZAnKdS00YPjDMVDdM8HblXzuY58dBp/0sLQMDGCJRNyeQDc70gYa4J461blQomQsr0qnUNlXQ0BCe0n+tCrH5p+tRP1D5PozytMX/RmPuetyJh8yrtbgoGEG49TSX2PxfM1rrqKqwuWISsrupf6PZYLeMzxX80lU/bV+/6PpbIZoAl/6cPyBmMZS2tdsiKguhmMOwk3T5bC3QJQT68Ky8OyoPARAk/sq7xiTRvdJWNEtZk9/cQcWauiNM14KLLYo0vj6rYPQAEKBcK+wA01TswMsGEMXHFS0PR4gcVJzVHIkl7goDM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7hX/J76tBtL7VRebaHJrw9xmZRzEx8WmpLsqjkC1B4=;
 b=jDtEw7gaOxBQaU4Fcyh8ppBTyiKNxpPkUVqxRzQiDdn0TIhlz73iSA18rMtEgxkzd1qMQWlrpEwhMzkR2f3xnGPfE15MzDsCB6BnjUrrnwMXxL78si4Sl/exyteaMWIVPazjvOnOFbSJFLJZo7jE6uVZDqLIjZpkJOHhfrEbUDP+/z9G+n+NKh58/wnIl0LCEALHfKJg1qWouuANL+KSQwjUmg1ex1DmjP/i/OqySud/6d2xjFBAslWCtsPvPXNSCAecBy0f0Rll7OBBU+f7Bs0kY1sNopik5pcoQfnb/kDBG16zj1HTafD7GrDJVI9PFsLFXK59KPZNtGR4ZDNhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7hX/J76tBtL7VRebaHJrw9xmZRzEx8WmpLsqjkC1B4=;
 b=GsmJaSzV1LzoLbs76nyiiWbMTl1iZvYhU4QQdNIv4gVdY9pMhefuLnzGXTHLlF0/lFqz1gb+YDeVJn42cbckFwJvMxz+/0n4X5QSgMfHAqYUFLpasywXHMzq4g5A6DcO6nYY5ci1Nu3A1kl3YPS2IINGUD/48fTMWKAcxXYEGqk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12)
 by MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 00:49:59 +0000
Received: from MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363]) by MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363%5]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 00:49:59 +0000
From:   Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee.maxim@gmail.com,
        Steve Lee <steves.lee@maximintegrated.com>
Subject: [RESEND][V5 PATCH 1/2] dt-bindings: Added device tree binding for max98390
Date:   Mon, 18 May 2020 09:49:30 +0900
Message-Id: <20200518004930.20973-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0024.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:18::34) To MWHPR11MB2047.namprd11.prod.outlook.com
 (2603:10b6:300:2a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2001:2d8:e88d:1f5a:d5fe:3ea6:5791:c8e8) by SL2P216CA0024.KORP216.PROD.OUTLOOK.COM (2603:1096:100:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Mon, 18 May 2020 00:49:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:2d8:e88d:1f5a:d5fe:3ea6:5791:c8e8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b911071-ebf0-43ce-eafd-08d7fac5643b
X-MS-TrafficTypeDiagnostic: MWHPR11MB1518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB151862D19404858831403F9B92B80@MWHPR11MB1518.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cgsxysXqCuPh7UdADl+RImBRtFFgfLga52gHtcwdLwps8lzmSaxmVQ2e5zltIo4+20Bq96WtxdGHDq+TFY6QQko95FFNDXTJ8bXAXQOroVCDY+aS98TYlccD7p6ltmZGyvrwMTnjmDDCajzt58dBNWUy4lxNUSi6wsh0j4wXGRq9VBLFI4Ew3b/jWAOP968Y98V+reXecoaD47Ke0DdKHLaRcWwRuvWEbahX8U7T5x5JmkuucOqe9tcIS6ioxUM2Zcnyx09Aq8RfEi5c1JMpHR1kfK05JBTdAxNgwmKLtCZ6XwE4vtRKJ/eBdy/V9AKeskJuIU7pcT5Bu6S6Jewwc3sDysLp3Ke1xhjeOwut+BGAigI9T4yw+nkfdF26LcMy4qViU2vNjEMm9frE8oFzU4GTuMTxoGHx9IjS6MoWYYYv2+Q9+uQ4C4c+wDBfg3Qzm+JdN6PK54uDs7Z0ktNT8yDV9pdCAUXuP0bj6lhqKAQ/NMOT3u8fIgteF16Gl/c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(16526019)(8676002)(66476007)(66946007)(66556008)(6486002)(2906002)(6512007)(478600001)(6666004)(52116002)(1076003)(36756003)(86362001)(107886003)(316002)(2616005)(6506007)(186003)(69590400007)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Wh8kQakzQ8afaRAtT0y+00FSzb7vrj4N1oxnH+Cb6pA53Y3vlds/4t0PM+3QGsn2AU6aRfcLF+REmfL5M2cYCEPBXa0KYsWh4OQvVv0hDQMtFsMPbPveC9m5D5tFJz+fImi7oB6svySS0z46LNzEGnZwlRDi/q4pKCTROnW5rl1yRGC6wzPbM5tFtDZFeiYEZx9hBiHT8IhyW79QVM/xWyhNjyg3olTG8AuZH6BkXt2JQgq8Dz78c1zknkXotzzsyNlhKXJq/mw3O22r7Gj81+D+YgQYlFcLTjkexNxBuEPkfuZp3FH+EA6bddePdqA6Z9958Ch9MbA1r5nDXzo6G/YxNwg5/q0a8eWjc3GoRZ6t3L/37KEbjHfTUfTPTzRHgxmPgOEosWWk/+2E3zTV1cj9JRYcNbzMirtrgG7SAhPmm94XDPppFpigALTKnnEnt0WxQrnQW1zbBW0f80j38nUgFGuD798R9ocnVn1SaAF4T8ZyLAaUe2OVVca5f4x9UQ6/7NZerP+kOAv0SLu7RjdBTB3CbBWGzmJAveoCVzs=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b911071-ebf0-43ce-eafd-08d7fac5643b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 00:49:59.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wm7AfAkiW/r2j6xxyeu4B7/BpxmSUK5po/qb/Tv+hp0n8jobCr0ICTFzPeYvW3MWRpNVizDM2sejtEHzVijVlW/fHdA4azv8lt5zxh2unUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for DT binding of max98390 amplifier driver.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---


Changed since V4:
	* No changes.
Changed since V3:
	* No changes.
Changed since V2:
	* No changes.
Changed since V1:
	* Modified sample text in example

 .../devicetree/bindings/sound/max98390.txt    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98390.txt

diff --git a/Documentation/devicetree/bindings/sound/max98390.txt b/Documentation/devicetree/bindings/sound/max98390.txt
new file mode 100644
index 000000000000..0ddd4c6ae55e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98390.txt
@@ -0,0 +1,26 @@
+Maxim Integrated MAX98390 Speaker Amplifier
+
+This device supports I2C.
+
+Required properties:
+
+ - compatible : "maxim,max98390"
+
+ - reg : the I2C address of the device.
+
+Optional properties:
+
+- maxim,temperature_calib
+  u32. The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12
+
+- maxim,r0_calib
+  u32. This is r0 calibration data which was measured in factory mode.
+
+Example:
+
+codec: max98390@38 {
+	compatible = "maxim,max98390";
+	reg = <0x38>;
+	maxim,temperature_calib = <1024>;
+	maxim,r0_calib = <100232>;
+};
-- 
2.17.1

