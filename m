Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B78C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBA624673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCBPlt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:41:49 -0500
Received: from mail-oln040092254039.outbound.protection.outlook.com ([40.92.254.39]:60921
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbgCBPlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:41:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X21eirYb0isH2CHeHJ7VYaEiUHDy73YYDgnOax0CgcaOwM0vx2GBrOvl/oeqt7JVzWQV+aUH5dbjFnH+c4MFB9DegDs5XFXpQHqJh2Vd6sdTWSj8+8vkdOTQ01FXifEMQtBznV/Yhjip9/IgMEbaCXL5k0E1fxzFp7SEBFaqGa0wyO9pXBUixisJZKdIIzIJmFC45JyUZYW81oDQAbyR0bdB+N/oinccFQqsER7Lhp0Xi327o9VvX/eYuMHGpecmB8PpXJYt6bkucO0gtPiDoe1CggGhvoqc2SRmyh9WXqnYPgl6a1OLafUJSBl/Qb+R+Ntf5JUH6Cv3YncVLcVGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zVfrUrcXcwyGgOjZZAeCaf5gh9diZ7bVkNRpOcOR1A=;
 b=ZkjzJMApksjo4nefeYplYPV65CNpxoF/8ABMxn55bMDDrXRKFtVZhHEQsFVlb0I6ZteCzDj+kOix2F2KBJCjBqCh5E3LHHsnboFW1L2+QHVY0Vgl3VK2NXDxYJdrRASQZqUxJn1wdu5wSUjflDjtE811dFTnNSsYw7MX6oX47ReUsvvsn6xv98+HMD5yuz9yNRCew1idn11LUQinvkHyWwppEodU3/Lrq7PmWfCJglor3tNWhPs9wAwgF4v1VwLcJ6XuC6NUYWYLmmVdGJNAfmYTVZRjPkQGDFhXSfg0TVQaQjjnv0a3ANtCcu3EWEs+FG/sXfUzTtVvoprZ0J8PbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::36) by
 PU1APC01HT060.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::368)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 15:41:43 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 15:41:43 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 15:41:42 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:44cc:a624:8145:fa79) by ME2PR01CA0067.ausprd01.prod.outlook.com (2603:10c6:201:2b::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 15:41:41 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 0/3] nvmem: Add support for write-only instances, and
 clean-up
Thread-Topic: [PATCH v2 0/3] nvmem: Add support for write-only instances, and
 clean-up
Thread-Index: AQHV8KkSr37jFfq2CUymVfNYz6th0g==
Date:   Mon, 2 Mar 2020 15:41:42 +0000
Message-ID: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::31) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:B976264080D6D5856615D2E0ED59CFB4B0B5C93639779B73F3D0F72B7FF0CFF4;UpperCasedChecksum:9F4A85BBDB4DF0E022AAD0FEB3E1258F9F2C8E332D1DB6067066CBAF88E050A2;SizeAsReceived:7717;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Vfn0h7sZCa+i+0r00iVOqYgpMneFgAqo/zpgzSTQfrdcwpSRjYI+b+D+G1+Vy7V2]
x-microsoft-original-message-id: <20200302154135.GA480811@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6248d60d-b0bc-41bd-a116-08d7bec034cc
x-ms-exchange-slblob-mailprops: wjVjg9/kRd0kSRHgcfi6IkPwPzcQchPL4tt84KJHRq6Mc9Pzy0Ewtn3QAJiM/mTScZhLMWRHSLHfYuEQpeXQu/i4cAPz8Qv83gfyth5QFuYK4lv1A6NYMkUjlJ76ipOc9T52HgPdtQS8rUT8i5KIe35VbKXJo6Mbr2FqtcXd4LN61KfdzpmhWSu5lzKu5qmnGLpctTJ3Epvoo59QlhwsyWWw9I1tjyTiGOWrvPkyAS/sgMor6HMyhURBYbuLddcwRrVoMwos6gETMVXNplLGeQAvSPFaL10piLlcVs3R0qIOLG43FAldFVKHp/8vQBql/qByjB2Shhq+b05A1YLN/XCI4FE22wC5BNvPUGDiS03n73I8tD4jn4JjjRRiHu9pWbLyz6+jatHoK6A4+Pd4BAnJ99Q0+A11jNitqZS/NcjmtfZ2xL7MayEOJPj9R0fB0EE8A0rFl0Y8tnkC839t6g4dqUProsAGyIrAOd6pvluZKnyDzVSbX23NJEPpX4B0PPMJszzawrCCyudhLEZaxkGUalNMaLyYyqPOqa0Rqz76yAXAk0+zhnpwIDTO29bH/6hjw4LuIdKf6Ab6BUhkhQyEidTkt+fhzpmfmic0DND6FfymbRQfvjbMXDtodXs5aYsyTvx8C0GlqwEeg0x82TculqlJ5h66UpYxPAp+aaVNlaXyf/23B7tBoh5VrFaZKCE2dm+8H9Pyo3+zpVM/nEPgRic4+6AhSyzQP0ANuCq9Fl9JgcHJ6+kyO0z5EpmtnFcni0vFXeSlwrklR40JFTGt5CqWAE4O3424j96Hk9L1rj9Qkz+onIUUtyGAeBWcgna9hTqeSMSPCAWCkmj7gxOSX0QYHIoJjp5G93EeCUZGw9Z2J+EekyI8YE7iy2D/MnXnrM3UbsdKz5ez7MYiAXas2dmmFAqdLqyEThrGAZUSoEChSOPqpA==
x-ms-traffictypediagnostic: PU1APC01HT060:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODCoboPDXKDlSNTE/taEqQPn0flXXxuEmLRd1449NfigrjX2qFi/PW8dV6JTW6kZ7hlUmJpZy87DBrnLgkmW3N2DgYbNomv0UyuTQmt/M/QpRQWjKK+P7ftbAo7MxOzuiD5dyMQEDFnzOMVaLLVHz/utMY1JQcSloybWAPBSBU84ke9odvYkh4zkEccsmMAmMYclBs/3P58khAupQXxAoDhj6viH4BAbUyQqyVveiZw=
x-ms-exchange-antispam-messagedata: DS6f7pmhfQwmiMR07QuJsDIhPFWCoSQyhNoC0gZ5VEAJnukZawUI/paAomzc7wuMtRY63zNtcVAPeByPeLhSChzptqIoNoZCOvWtaoEXHodghgtzz2CfNz5F/Zv6LrZO6eRbGdwNew1QU+P16CZYtXyX3u7n8JBf9jkwLx599fsrvSbwp0DW9McbLb9ZSCbdRIYncRXO//aD76lQBPHfOw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A16AAC7BCA7D8B4C8B22D076442622BD@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6248d60d-b0bc-41bd-a116-08d7bec034cc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 15:41:42.8746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Previous version: https://lkml.org/lkml/2020/2/24/973

Changed since previous version:

- No longer looking to drop read_only flag in this series because of 
  reasons given by Srinivas. Fixed some areas where I was ignoring the 
  read_only flag and relying solely on presence of reg_read to determine 
  if read only.

- Changed nvmem_register() to return failure if group is NULL from 
  nvmem_sysfs_get_groups().

- Added commit to check for NULL reg_read and reg_write before 
  dereferencing

- No longer using WARN_ON() because now we can return NULL from 
  nvmem_sysfs_get_groups() if the inputs are unacceptable. Much nicer.

- No longer providing global writable entry - my bad.

Not changed since previous version despite discussion:

- Not changing read_only flag to world_writable and inverting logic - it 
  would mean that all of the drivers that do not set the flag now need 
  to set it and vice-versa. Too much verification for now. I might come 
  back to these things later, but for now, I realised my eyes should be 
  on the main goal.

- Not documented kernel-doc of struct nvmem_config. Unclear if this was 
  required because of WARN_ON() - if so, this no longer applies, as
  WARN_ON() was removed. If this is still an issue, please clarify whether 
  this means Documentation/driver-api/nvmem.rst or just the blurb in 
  include/linux/nvmem-provider.h, and what specific change needs 
  documenting.

Nicholas Johnson (3):
  nvmem: Add support for write-only instances
  nvmem: check for NULL reg_read and reg_write before dereferencing
  Revert "thunderbolt: Prevent crash if non-active NVMem file is read"

 drivers/nvmem/core.c         |  2 ++
 drivers/nvmem/nvmem-sysfs.c  | 59 +++++++++++++++++++++++++++++++-----
 drivers/thunderbolt/switch.c |  7 -----
 3 files changed, 54 insertions(+), 14 deletions(-)

-- 
2.25.1

