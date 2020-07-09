Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63275C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D0E2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="dWKIyZJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgGIMbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:31:18 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:6194
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgGIMbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:31:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVu/0Gu+Oew/B9wmW/+Wq1I/WBgJ1BPWMRjCwI3hur4QcQZg0VDt71L49qrgUUAMaNIXrJ6db6b1mP7oWxgWyAkFLU7yqtEvtmlImHeED+jyhNNPjid9Vqq0ISOQTf6YwE/9499fq3GVi2nnYNR9KegIfkaLalzuhleGaWKvDg5qwUNnpI4HZDULOlQO+8NPI1gmYrNMXBXhq0he18vDGUuCLP2SQKcpblWFExkssz70qPgJHMD4aLC4h8xf23ikCR4SHB++/hWXYJK/kTVyyhZ6efH/VW3tF9YDP0dTDMt36W34ObtgFnWB3FQKY3y5yAw9D1nrBUM52cDdoaCnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b61P6t+y6VwKasAxG7gassuo5ahARk8mLcFRioDruxo=;
 b=FSHbX2DxLk34Zk5r+hYEEgXHVLlSVrCqpokjwFGmuBga88hi454muVWNnRAzOxBx1W+zBVPW5xtT9bhy17GpPjVgcfMxd7X6bgfU10KqgvHd9g7puOQdFhh2ycSNGhgbTrmpdzDSSswA44Ip+dW769s50bfMpZQoZlWZV4bzmzvw4UP7M1ZV8TLEaeWAkgip5mKFJHPHCuX+dW67TqVosqlpX5RqbLi1LDZksNC8FKYxmJd3+RsEfpvtkn4t8LEn9d8Mh6SNN4IVTZwlnZ+apt8aPPe4y/gH4gnxtXk3/MT90uR/g1k1Gs17aVR+KJSzfDoI9yAIWQsBOuJu72Ntaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b61P6t+y6VwKasAxG7gassuo5ahARk8mLcFRioDruxo=;
 b=dWKIyZJdkv0wHjvZa4TcPMQICP+13+ggrlIdDEzX07M3yrvcp1ppKHfLdtshD29C0i3AUUIgaskWlVmyrTkDz+YBkaRIwO6CvQzfJ/rkNUxUiYQNe83lOndECzZeTcx1YOAN79pY3SGdOiDBUW40yQXWj5m6omCNwXb4WGov2lE=
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 (2603:10b6:301:2e::20) by MWHPR1001MB2272.namprd10.prod.outlook.com
 (2603:10b6:301:2c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 12:31:14 +0000
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1]) by MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 12:31:14 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: printk of non NULL terminated strings ?
Thread-Topic: printk of non NULL terminated strings ?
Thread-Index: AQHWVezV9c8qp7AVfk6iUQJ/gxZBLQ==
Date:   Thu, 9 Jul 2020 12:31:14 +0000
Message-ID: <4436dd281299b46f431ad1707c5de42af45ea4f7.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.37.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8b32485-b836-4cac-2853-08d82403f88a
x-ms-traffictypediagnostic: MWHPR1001MB2272:
x-microsoft-antispam-prvs: <MWHPR1001MB22726F4E16D5D8039362B055F4640@MWHPR1001MB2272.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: am3zanJHU4qPsYMWX05LcqEgjpAXbYIRzEJbQpjhdr8TraLHZvzyblqoEhdNWtpUgEvTuf+qiANBqG2eXsrjY9m7JUrF1NKLlw2XA1a7EghCUDlf1qrg7V7dVFFtrwWrJv6nOMmuNgyvBAy5UWZSANWYSr14hC8OUPugehjpBho4wf9dpHy17h4OtjL+9DN1nvJv5h3GUP8iSzXO5t+0RISoiQJLW2G0WrnWTu7/bPezsri+6JRdbO30O9CWKt2mgSvqNw2NNmfj010tL+yPd0+rrr86xE1BC+5XbdP28eH7rDDlkB9tGg/bYiYxav89KChzODr+tBAFUx5znOvppA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2190.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(5660300002)(36756003)(71200400001)(2616005)(8676002)(2906002)(186003)(8936002)(6916009)(86362001)(6486002)(316002)(558084003)(6512007)(66556008)(6506007)(66946007)(66476007)(76116006)(91956017)(64756008)(66446008)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JqIKjsjM7E+Fqf1RPI4XCU+WD1jjFtnO8RjWLjG0mlMqwDcalreOtNQxwAEv020C4dHoevSbJRNCzRoFe+coU9dcv4mujrIHHj2Ij4vYspBr9wBL85f0u2sNev12jdKJr07mYzwN4+kuJZ/Uut2fUl905g0O8c34PuABWqI+ARIwA0iAVgDcuuoUXy6/T4R9S/sA+Q4mLJNHKtscHGxcRTYAIEwUpDueZSKqfgVsy7EbrFKVobhGsXHAuP/qzjcDZoaOQCwsN5abKTfnAPXOsPaFacDUHe5D71BVDoyaPaiibPDQMLkitG3sY0XxjCtFGPV9ralkqfo6VawKSNyv2tnVh5Ti0ymfb0IcO+uMlWUVKSI9sgSyP30h4MkiFmGrZpuDO5S7O0LAK9xwQ2sCGDZwBW4yflmuZtTMSBzL5WQLcSin2/meP+UUI7hhhow7kt0T7UaJypGxySPHcovXoAV6j9MC/OlxoduGzUvMHFA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <85190205696C89409ADCCE63AEA4D764@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2190.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b32485-b836-4cac-2853-08d82403f88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 12:31:14.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlJvBHZ0Jfz0U5sCt5OrXnOeMrdPiLsnZQNcf87hlMj/9HldNnDdIpJE7t9VVHagRJUusluf26tx7QsdqIPsDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXMgdGhlcmUgYSBmb3JtYXQgKG9yIG90aGVyIGZ1bmN0aW9uKSB0aGF0IGxldHMgbWUNCnByaW50
IHN0cmluZ3Mgd2l0aG91dCBhbiBcMCB0ZXJtaW5hdG9yIHVzaW5nIGFuIGV4cGxpY2l0IGxlbmd0
aCBhcmcgaW5zdGVhZD8NCg0KU29tZXRoaW5nIGxpa2U6DQogIHByaW50aygiJXMuLi4iLCBzdHIs
IHN0cl9sZW4pOyAvKiByZXBsYWNlIC4uLiAqLw0Kb3Igc29tZSBvdGhlciBmdW5rdGlvbiBwZXJo
YXBzID8NCg0KIEpvY2tlDQo=
