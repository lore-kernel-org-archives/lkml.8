Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C396206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hkEVRz4G";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="BHEn6NGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCLJ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:58:47 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30730 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgCLJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:58:46 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02C9pUEa012646;
        Thu, 12 Mar 2020 02:58:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=GVrQ9SIguLoxpq5X6PnIyHKK1Ov0gxAS14op5Sq8Y5M=;
 b=hkEVRz4GnDWTlVghbaH0NFNXj1aTJvFQaeXfrAbd5qQftGyjWcZ84lx7ZtVwaGeddFU4
 fdem2/Yd7ZEMhKwOtPLffyWvtYK+D6VcLTMtPq1XvQRYJO+gDwDIcUUU727IR49MX1Bq
 0MWzKVJk+NTdMc+HpfuQP/m6Q4wcObr8BI2m6Vn0aexczcy/OcdQRyF3jIV03QlMS+dW
 Pg/YD6vJnq4muXr41PxXCNqor9EH1rVIZDWZMfDqpjSR868Jdcy4itj6AC7OHGgRLkPL
 eGtHnS0+6pGXyNesIr9eGpC5A2D8fNknJE5XCsIKS2Ecm2ZdlyPGaoKroxrKg4G1nIsA Dg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yqfggrwk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 02:58:43 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Mar
 2020 02:58:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 12 Mar 2020 02:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktPZeV6vBH/xhNo28REq0wLn1ELIJRhhSjNH7cOG8FcyrrqwfLZLkWoZGwHkvvX/VWaijM31v6RQz/zxHBHfoYzE0C2u9g0I7SZEyc9Vs6MG72L60y8oRkLjgYDKH5qP5gr2A8Zt3L1/6UX45NVn77BMC/ELIrhZLyD7fcJXQnicPPwFLZCD8Y+FBTtlm+Uofuasr6zIZtdjoQFb/3I4yajEHSllU2M/y+/twAo6U7AKsoltyg0Q7XPAPQt8BamHX81VsZ21uYK3vhI3Yh7jvIP3Txgs63iJCjZKg7s9/Lnh15HwVmQcSCdKpQbqygTE2kyZR85EBdGyhx6CGGob+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVrQ9SIguLoxpq5X6PnIyHKK1Ov0gxAS14op5Sq8Y5M=;
 b=VVafcwyOmcCF4J8wLEA3DkVnyCNbb8ExIyDL+GI+C31u2yjP3B9jo7/7sViO44vFwdMnz3h5qo9Y92GsCYUS5j1aHxI6cdhYKS/E0mG+2HHJoj36P3hoztAW1zeRomDAjN0Xr6E4fKNrRSXRFqeoqY7gPajnrbticckQRPDXofVE7CjE9hCQWtWMFDl7vb5EGXvJ2gyWT3YJRiVUPyDjmeUlrlaW7c1lIMS4Ps7sl14RjKTsxN+2tyCEKJXGii1Kr6VR4S78+HC+u2TGAmoCdOnvmERw3xAiGbuh8QCPWlIlAY/8ZOXcey0/T7v4piX3e+P6dr5YeskJFGmhf+OYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVrQ9SIguLoxpq5X6PnIyHKK1Ov0gxAS14op5Sq8Y5M=;
 b=BHEn6NGFgjBCCDzpdSJIabSl6HSpq0ydK/EiGL2FzaskTYBX3MSeVWqqhEOkG1lKPJ1POKoz5DzySTD2QthuC8NQxFGtDmDbUxlT+wBZcgnqBc+Y/jv9RwjjkBBHAH/vZrGHZa8FQogKCZPky3otwKpHnTTaICSZOV4ZTB8DZQ4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB3344.namprd18.prod.outlook.com (2603:10b6:208:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Thu, 12 Mar
 2020 09:58:40 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:58:40 +0000
Date:   Thu, 12 Mar 2020 10:58:32 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Tim Harvey <tharvey@gateworks.com>
CC:     Marc Zyngier <maz@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: Re: CN80xx (octeontx/thunderx) breakage from f2d8340
Message-ID: <20200312095832.yjjhxfxs7ay2iq6j@rric.localdomain>
References: <CAJ+vNU0qVnCkWpG_NKNQTdYf5LJpRrgOeWX0xH=GgavKJ1QNwg@mail.gmail.com>
 <0c3c16c770d21e5ad2276c83feb27ce4@kernel.org>
 <20200312094322.bohnhgnyb7nogpq5@rric.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312094322.bohnhgnyb7nogpq5@rric.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0902CA0047.eurprd09.prod.outlook.com
 (2603:10a6:7:15::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0047.eurprd09.prod.outlook.com (2603:10a6:7:15::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Thu, 12 Mar 2020 09:58:38 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6361f95-80ae-4e9a-99ca-08d7c66bf0ac
X-MS-TrafficTypeDiagnostic: MN2PR18MB3344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB3344E4FF30E9B953DB2689FAD9FD0@MN2PR18MB3344.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(956004)(107886003)(16526019)(4744005)(81166006)(186003)(66556008)(4326008)(2906002)(5660300002)(66476007)(66946007)(8676002)(81156014)(1076003)(86362001)(316002)(7696005)(52116002)(9686003)(6666004)(55016002)(478600001)(8936002)(6506007)(26005)(54906003)(53546011)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3344;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1zyIwvO1VYthB21aH3hFS184U2jSa0ngfBanwbTgcDquv5ZM7XAtLr+TGM1n2zBA3yhVnyvHVI9ivrZz/RmSNJEXDb0RuJG5UTUyCWfPy8UjOQhlxWpd5/CV7NqYuPBNJGkphRkOWb0EEGQ6Z7Z2xrQ0kUqWXFJ86Z7xt6nj5yoV0CNiL37Hiwo20fyBwHU1zNLr/vHbj2iBMZKS15+nOTRD/eJ9p8V9vdG6T42yyFsaXIrqXgMxe4l3F6W21euDktLKgunkTZOJq5rYXBQ5xc37/X6HK0uLGgHvVIXG2BfCwm21fbv7FrRiDdgts7aMh9fDhTIEu6/odZF1Les1juOVbiBrhrqdhJf/kk8WHoHBYO82W9Up6Ex3zxA7VDwUaZIyV7MzhdK/F32R7WEm3cncrbnYVQdLTICGF4qV3quVAAyS4wteWNkyQ0AsYlD
X-MS-Exchange-AntiSpam-MessageData: mUN+T1lxEpOPrBhsSxGE9FmE0GGkU9WyJdj26rSo1xQ25sSN58ogzWh6PtsoMghBJfo8qPoqTNFs1fhK7JaY+uN26NDw1/SMG02doBnVjThfpzN5OK1zfVcXsvrvV5mmG+qPndbA6qsoH8c57ye8Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a6361f95-80ae-4e9a-99ca-08d7c66bf0ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:58:40.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiLqbSvDirM3pKiQ43tXbQeCTczOMBcAz5mLCWzjaQp7fGiBE0HDmeK6g4LBtmoyGntWZIKbUMNOS2m8uM1zQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3344
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_01:2020-03-11,2020-03-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

> > On 2020-03-11 20:17, Tim Harvey wrote:

> > > Im seeing a failure to boot on an octeontx CN80xx (thunderx) due to
> > > f2d8340 ("irqchip/gic-v3: Add GICv4.1 VPEID size discovery"). I'm not
> > > sure if something is hanging, I just get no console output from the
> > > kernel.

if you are booting with serial console, you could try to use earlycon
boot parameter to get more output. Though, I do not have the
parameters for that system at hand. You could try 'earlycon' without
parameters or perhaps 'earlycon=pl011,0x87e024000000' or similar (not
sure if that works, maybe check devicetree).

-Robert
