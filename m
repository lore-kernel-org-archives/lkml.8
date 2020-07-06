Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D82C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF74A20737
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ord/4yla";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zOF/4irP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgGFCLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:11:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4661 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgGFCK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594001459; x=1625537459;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6wgbhNY74mGvqtpX9PetJavvFQUONN1sLZGgA1ROKnU=;
  b=ord/4ylam+pSeeGL1XKHdxqwAOR0J0soHDmv3BG/RzP2Zt8Ib3mtd3Pw
   wyZ1TOCZJjLga7Y24C6Bqp8ccmNOlnEiXWV1eLF7SCWZsgxHSf1fr+tOM
   Q6fgpms6nWhwMXJc+ABYGpJz/DPcZZDENE+AnDI+omQxXulyvVXsXJ+v6
   PpawQWd8gyiBCs8Vu4tRXA4DtO15kozlEWrEfmJYoN0VZgj5KEtDyeWVU
   M4I+DeUhTri47CWcgvvCKDJ+Lf5vqMeJrmVWWjpKj/CG/rforMj2kewDb
   y1Atgs4WVAjhPvy+VqnOMUE5niaG4ncM0hgrvOlRnpn+gVwUFVj8BcbTV
   g==;
IronPort-SDR: OTDhGTsUpS+p0j53JeQgvoD/xvECL5wwybajU9Fv5DuT1ABtxZ9/GVsmErTQ9Glwr2dSkRQrbU
 lBxbZmJtnWTf4eINmrv4lpPyev6nKPL8F/zmaWi1vjmnTG/fYGrUBQA5mAhBeMyy+jNzdnHjyI
 I4T3qTnP9W9UHWG9sGZq8oHBVQ0BStHto5F0qsI/iAJ1OqlVk2wvTtiUPj5pDltm/7Oxfj3gE8
 6m1Kd8c8f9gMIIUKaVGedTmBA3/9m6IByFMvlMuFSGH6f7FIeU/7mvdhKwNArs1dhW04xFoRVB
 /rQ=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; 
   d="scan'208";a="146021443"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 10:10:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR4roDR0/gFwW8X8XcFeyUalfivkLN2s7+TvGJSh6rWPU9kUw+3CX0azH+cAzK2CtnO5ro2fK6fNbeTvpgsPw9u6rBNOE1LLp0S9OO6c0BnGkcx1mXorgJrJg6RpvB5UQDrFSZIf+dbmAXB3kL6HeH65BmvvFyBZHCeZPU1bJY9EXDXR77rL0uomXyaKGf9wS3UXb34C0JcVEAUOvJxApsrc6LMdXc5b7nMX0JtMNjEaj9H/TL67WOdnafCOnycXnymjmdwIorVHEyUBYRSXklDX7Rw4wyXXon4ltR83PR4rdMNwTX6sdF1H2pf9/p4SYGjMW6pPuPsJ1h1cVN+qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wgbhNY74mGvqtpX9PetJavvFQUONN1sLZGgA1ROKnU=;
 b=LERBtCqrLOLG3Cg4FRROYR53khd8mNbWooacIBS9gCNcusQX8IZW4vtFcVJLmFMTEAZaDm3LBAzvHhP7GHbCfDBzgWJ5fk39uNS2V/miAxOJdRo2TVNdZjdrhdHC4V9B6ebebDqbg9YHbLjK+jBSesaX8DgubNPEbhIKAEKJz3Bclzd5luCgQf8Qac4a+t3EuZq8Q4EzN3x82W/tBHze16GHkSkMrS69vKNxj3DP3WUsA5xnHrhN5xCpY9kZcAPimbgd0+ufFztVeUM9wMp1hufQZFqlI38MmYV/H7OL9Jb7M4J/l47eXo+r/7DDanPZFzKr2b9bi+Kddj/pSy/XCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wgbhNY74mGvqtpX9PetJavvFQUONN1sLZGgA1ROKnU=;
 b=zOF/4irPdcDscbL8VHwBEbDdbuyY+Lpnsqg5+IKkILL/fr65LtyuYS4NtnRxDGVLlfAKjHyLCuQkPiwnpF/0FOg9DYpgc4wg/fC4gGNJjfVTMrbOlHWPt5HM+2OeCiA0xNdhwWfpu/xplA+laveLFM+zS2olRVHKH9qQy008pDU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5527.namprd04.prod.outlook.com (2603:10b6:a03:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 02:10:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 02:10:56 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] nvme-pci: Fix some comments issues
Thread-Topic: [PATCH 1/5] nvme-pci: Fix some comments issues
Thread-Index: AQHWUOVPtXqqYQo8rESYKdvM7jJiyg==
Date:   Mon, 6 Jul 2020 02:10:56 +0000
Message-ID: <BYAPR04MB4965FA356D5F3A74F17D6D9286690@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <3820a0fc3c74f9a70a8856172d499de4dee3c2b7.1593743937.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 361d20e0-f8cf-4f49-e197-08d82151d1b0
x-ms-traffictypediagnostic: BYAPR04MB5527:
x-microsoft-antispam-prvs: <BYAPR04MB552747A9840A6FD010AE027A86690@BYAPR04MB5527.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21eWghvJ/j51CfA0Z7OM4a9oTCGnHzvMjYTRluBZkG/hpz8lBuH8I9Q2qYVBPTCordrKK7nLzuSFHfULUcxlbL1RkoKsWoJ8OYXc39xfn6P+wrPYMW5k77VEnKph9c1Ng2/Aa2z1WgfZ9XsDL9ZnPg3Avsfc7OZAOAKf0l4F6gBkFTcwTF4dlCwCDmktBf2u9LBuuO8PtLcaJ7TNMFpl/QS3tmj51jAF0NcedWSNDL/wBXFgcgT9DVHF1CxyfkEZJs+JqPx/RRFUXi3PaWHyRQTJPy/lUam4qetIEOc0zh3mHQPwtiAhR5XmYF0e3M9P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(26005)(8676002)(33656002)(64756008)(53546011)(66446008)(66556008)(66476007)(558084003)(7696005)(4326008)(110136005)(478600001)(76116006)(66946007)(8936002)(86362001)(6506007)(316002)(186003)(2906002)(5660300002)(54906003)(9686003)(71200400001)(52536014)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T71faRM9b72CCBZESLHncSX3MeKmiS1PgUSOFP2VNo2MA5+PaXqG76YKOSPkJp8IIM9nZPtWJHSnJ4BHnKKRatodFLKpohdPw35ziMDSu4i+3gcM+12xhYqzn+tfwNWnJs5FwJx3U6jY36x5h92t29XnxOXw/u7K/zcNYX8yLJ0b2Q8zGMg9FYCNMqJ7XGnEsGDb95AOkbIIT3MpKQg0nJkUbkjnIpGmlB4cKnfSYmavA12ztUh4+H2EVfaQIvCgXDVc2YLpg4FrMjhHG9EnMighVcRIaPgBY2Gi3/+3OxPbf8t52NaasGQcROcIRcX5q0xWqtzevesMOmAjzevruOcyhHxOPQarW/DJHx4E4JowCz+IKNLjxOBrZfTKz0wE/eyAP1xvW8+XoCeAJt+3ltszmK8XjDFE8gOzBnmW4OhiAFLfG2RKmH7voSqDFQzfY/GYgZxDFiut26ZXGva5MQhdazgrB3+MECwmRmb8KuE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361d20e0-f8cf-4f49-e197-08d82151d1b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 02:10:56.5583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGNoodva0ph6+vr48oaGer+Tl4A25WZmgPhb25aYN+19m3Z/TI/WFgJY+b47Pi6agIXfuwErW/2oCh/ICzhgUi1ZE1oOvm5G8OHE75gfbnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 7:54 PM, Baolin Wang wrote:=0A=
> Fix comments' typo and remove whitespaces before tabs to cleanup=0A=
> checkpatch errors.=0A=
> =0A=
> Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
