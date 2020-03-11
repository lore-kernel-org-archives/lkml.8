Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B13C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ABF20737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="NORdWQqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgCKRwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:52:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:32298 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730487AbgCKRwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:52:03 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2020 13:52:02 EDT
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BHdsKC009693;
        Wed, 11 Mar 2020 10:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=a5tyHGiOZ7VodHQW/R2x1iDgVGvIAFdY6LrUp+fRzx8=;
 b=NORdWQqON4537YhTSCI9HfdR5xqfWx//9sThXUvVzemaZO7JcUoc9/TMyGkBNZJId3e4
 l7unWhlSxGLUSMlzy7Hler8cCP6lIZeOS0VK6EfPXw3kOfvHt1cMUjZhORHEllxa7O7y
 DeV7tPREcHn2K/qp09bWEXNgHaxf4uj1ZR1CfrxSxprJVGzi3ZRC6lKabvJIbTD8wtXk
 sYQRwkonZrDL8fIPydFcsx/5TYzp2AdP6ULnyQzwx9Rh2SQmw5vLHY7NXwUycXpwIm4l
 LGg98/vPYjo9JB74IK2MECEN+MB5sPhlLjxwsdGWb5tUxDbmiQi5AgF2N2FE5RGoZoCq PQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2ymbjq97mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 10:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO9mtbydoYoggIuv2+7Tu3S/7+kWQ7O3p8S/2SRqb+ORGZTTxZo8GFYeoZeEVzI7TtSKGVR+3IgQNEpcgG3ZzP7omc+K2WqfpbdV/ost/NhDMPovlZO2ddWq2f3ycRWUW2+Ov7CRArblcI3fQsDRmcgtgyr3uldtEbg6/+YW6g3vcSb2BFhOyVnzUHVhy2Pesi7iA7NmUKFejdklJMOUrnzQZ4GMhTD4PJDdutSSlwk+lvA1kE37Wt1yV5yDveTkZ1sm51wOfKmTRmcfaVyhhG/feaLoLKg37EAf2Ps38hlUYMFQ1fbxVCljHfOP42xtqdcHqxoL159ExbZsYnL9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5tyHGiOZ7VodHQW/R2x1iDgVGvIAFdY6LrUp+fRzx8=;
 b=a4krwQyd6Nz9BMTCRAM1W1thY8OMDd/rgLb0uL0WVcNCub6/PB84f6Ph3ewNr1k26/purmIqPf1R2MKyctPKyzH7+hwgfgbwJSzFPrmKxfX+TqLpWoXIh4/VRThT2iSkfPnkgPmVOlfrVZt6iJly+G3KRb/SdzJa5pSbpaYK+L3w0I/+bY4pq5f+TdCl5UjNm4va8zVryoeNkg1n6XZfxz73gTlAIyUC7KpINjg7Vb8ilzSrwuD8sMEAww7SILCDP+0USksqT+KLmnaoJfrhGyr+F4ZvGxeW2QY9sMAznKXYEnPNNWUUV8pGZiIswBPcYjUjLe61qctU7nh6/0mTbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB5601.namprd02.prod.outlook.com (2603:10b6:208:88::10)
 by BL0PR02MB4610.namprd02.prod.outlook.com (2603:10b6:208:4b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 17:45:58 +0000
Received: from BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c]) by BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c%6]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 17:45:58 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Subject: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Topic: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Index: AdX3zHNqbuFpQvKERxyPueA21j6FDg==
Date:   Wed, 11 Mar 2020 17:45:58 +0000
Message-ID: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a175d3c5-408f-41b9-dd49-08d7c5e40ec0
x-ms-traffictypediagnostic: BL0PR02MB4610:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR02MB46109C4830A5FB6344FDB510E9FC0@BL0PR02MB4610.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(86362001)(52536014)(26005)(9686003)(71200400001)(5660300002)(6506007)(478600001)(55016002)(44832011)(4326008)(33656002)(186003)(81156014)(54906003)(109986005)(7416002)(8936002)(8676002)(66946007)(66446008)(66476007)(66556008)(316002)(76116006)(2906002)(107886003)(81166006)(7696005)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB4610;H:BL0PR02MB5601.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsfA2LQD4iHOqQCB8NaPXN36et9TIx6svVq/uRi1UkEhh8N5Jo4TVh0OFJDzdwyAp2JHqanKREyDp9nZO21jDijwGhRU+LOgcyhcn7KFBaZBblrDtRuQoKNIEQ/7mbLQNmpaWI2jyqq/Ijx3Xu8iIJ25k45rJb70ITA0W+Dcj71A0zLZj6Vy5+2cy/fwIlzodt5sdc/YgfLjquxGiw03NqbCbHSgL3Nw+C3X8BcQZJLp+QgdOwCQXcTcFqlkpxk4YLmKa8GTkXx5cVz2jeTiFgBqwpb2yPDbCV6IZtAGwhxaKstkZk9Vgp1x4hUz3Q+/4kYFH742mBYQdJ6LvzZlcOSYI+lNQ7VBDGezIshBAhSw1w2Tg9TwCBFnPcWm7seP5od1XDLEQXhwqk/jHU8vVNNtC+fs8PT0l7wUnTrJMk423IoLsceIwMFryI3k0z1R
x-ms-exchange-antispam-messagedata: MxVWwqS+UikoQGxP2Z4b68PrYuL83cf3S9wfGTxQIVwn7muEzUBRNoEgp3Y+fkN6rGXXLZtQKoWHE0Xm6OwuX2MOprKEO9Jt3UX13QFfHoNajOdLRxjt/frS2nR9yRz5Vw+BrtaN0489G7M/BoLJTA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a175d3c5-408f-41b9-dd49-08d7c5e40ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 17:45:58.5551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZP+5xltUGXBirbgVYOH7rvFy6hApq2hQUnVGd3OlR+ZyTaoVFhxvmA4edyOsTqeK85c+PWNwnaWzEvAvnLZE0D3t8teFyqT15LuWHnbA+OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4610
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_07:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Reason: safe
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a couple of knobs:

- The configuration option (CONFIG_VM_SWAPPINESS).
- The command line parameter (vm_swappiness).

The default value is preserved, but now defined by CONFIG_VM_SWAPPINESS.

Historically, the default swappiness is set to the well-known value 60,
and this works well for the majority of cases. The vm_swappiness is also
exposed as the kernel parameter that can be changed at runtime too, e.g.
with sysctl.

This approach might not suit well some configurations, e.g. systemd-based
distros, where systemd is put in charge of the cgroup controllers,
including the memory one. In such cases, the default swappiness 60
is copied across the cgroup subtrees early at startup, when systemd
is arranging the slices for its services, before the sysctl.conf
or tmpfiles.d/*.conf changes are applied.

One could run a script to traverse the cgroup trees later and set the
desired memory.swappiness individually in each occurrence when the runtime
is set up, but this would require some amount of work to implement
properly. Instead, why not set the default swappiness as early as possible?

Signed-off-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++++
 mm/Kconfig                                    | 10 ++++++++
 mm/vmscan.c                                   | 24 ++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index c07815d230bc..5d54a4303522 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5317,6 +5317,10 @@
 			  P	Enable page structure init time poisoning
 			  -	Disable all of the above options
=20
+	vm_swappiness=3D	[KNL]
+			Sets the default vm_swappiness.
+			Ranges from 0 to 100, the default value is 60.
+
 	vmalloc=3Dnn[KMG]	[KNL,BOOT] Forces the vmalloc area to have an exact
 			size of <nn>. This can be used to increase the
 			minimum size (128MB on x86). It can also be used to diff --git a/mm/Kco=
nfig b/mm/Kconfig index ab80933be65f..ec59c19e578e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -739,4 +739,14 @@ config ARCH_HAS_HUGEPD  config MAPPING_DIRTY_HELPERS
         bool
=20
+config VM_SWAPPINESS
+	int "Default memory swappiness"
+	default 60
+	range 0 100
+	help
+	  Sets the default vm_swappiness, that could be changed later
+	  in the runtime, e.g. kernel command line, sysctl, etc.
+
+	  Higher value means more swappy. Historically, defaults to 60.
+
 endmenu
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 876370565455..7d2d3550f698 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -163,7 +163,29 @@ struct scan_control {
 /*
  * From 0 .. 100.  Higher means more swappy.
  */
-int vm_swappiness =3D 60;
+int vm_swappiness =3D CONFIG_VM_SWAPPINESS;
+
+static int __init swappiness_cmdline(char *str) {
+	int val, err;
+
+	if (!str)
+		return -EINVAL;
+
+	err =3D kstrtoint(str, 10, &val);
+	if (err)
+		return -EINVAL;
+
+	if (val < 0 || val > 100)
+		return -EINVAL;
+
+	vm_swappiness =3D val;
+
+	return 0;
+}
+
+early_param("vm_swappiness", swappiness_cmdline);
+
 /*
  * The total number of pages which are beyond the high watermark within al=
l
  * zones.
--
2.25.0

