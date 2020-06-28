Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33976C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004E1205CB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nLXA2SWI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KAc+iT8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgF1VzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 17:55:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64454 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgF1VzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 17:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593381315; x=1624917315;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hyqev4xeZGFG6SRLYQ4adpuy4D99pOQY0WgV5DS1W70=;
  b=nLXA2SWIa3N9TcYdLjlqjFi3+GCdS+/UtCHMjwefahzq7zlgQ2E6rPEf
   5QWLXIYQu6HwZUxKPnKvg/N6a1G1BGrq25m4IX5Ot0kHBDMf3pabtAEu1
   uJ4r++w0Yoi741D5bsOQAXHEIMiK//UUlM1PL38Or8rwpTV3C4yY5wu0f
   5rvYe5SWxwurdpZYD4Wbrk8UcgIa6QUN9GfzSfc4di1c70Pr4Cp8FXOM4
   gG4v7FaMrPHLwroLyIcVGKi2HvEDNDEoM16kyqnvhHoG4vqrvPzwfzGH3
   lliMRtjRyl8UnA+mzyzRRQgzjpEoTk6HVSbgKciqX31YzFUO61SlckMPy
   g==;
IronPort-SDR: aRCuM3WAcldmphb34afsD0RGsD+gVT/oG3w45ILqUAw05dZkFMF5CvTOimFf23g4fVda6vpVEt
 uI/6jSz1W3l3jRGce91n8poQ0yGNWTc2VAi+24teyu5adCcwE/I4mWrt1e2yCoKS42mJtP0WHn
 YsGDXh9LG7T8xiP1W8cZMY9W+3nGz+qOshPXfg8ZNtWc6dzlVB+EnWBWdkjnvAg/5dHG4FtCqH
 acpRtz5AsGx/FRQw1leCs3juB0ZhPnb3YG/k8Wx/nCiOmnq3SofrbtttC7ba2tFjlFSLiPhiF4
 Thc=
X-IronPort-AV: E=Sophos;i="5.75,293,1589212800"; 
   d="scan'208";a="250360080"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 05:55:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1GmsnIuKL9pQWVHHsTudMfD3/jqn96yNcC5+Io7pcfiDBpHh4SLp8msRJq/iPpxKeonvTrNkKXbiNx+MEZHsdUuCyVwQYm2/PPMLula4/5D4qTp22VRxJV8fj70FpMLBTLXRzREsTExioJop0++2LbSjsLKkvDZuebBBjF7by6q1GJyqUMgFkarXrJFYQ7xv73Tk6empBpZ7zT3hD59P/FcnLCCo0HN/c8005LsgManULrWkdQG1PLHuaylfMvsJT+l+7gPECMxZ/wVjoJNNf62o1kubN9Oh4J2ptM3ITskSyXQLOzKKUdIthc2wI2WjY0oJxF+EZTlsAgaHMm5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyqev4xeZGFG6SRLYQ4adpuy4D99pOQY0WgV5DS1W70=;
 b=LCIlxmPBfCOcsBBnJOrO0uFgDpFiug6//TwdOznN+I8LjSFGiuqRYWBM3qAGBL8SfGZ1IsZUeFmaybxOU/mquqYdhC6gbhVgK2aRSi/pcvkZxFuU0oDSTFeUM4wqdYX0/r9AS65UsPkrQUE+XDqvrbgSWL9O5D5iOTsTA9Jee4EqAMyti716mjgPxs3gvbwaacgN3h/d0cT+zgpuvZm4167zAcTSnf65pxI/0t58IYlPlnm7QMlZHOopf4T3IeGFvT4OIL2nQRLfS1isMNGfJMtmGDkOHJfVK0CPo8y8IvJFMWKkt9P/sfw9BHeMo7CdQRLVfQEzrmSCPmpO7Q9TfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyqev4xeZGFG6SRLYQ4adpuy4D99pOQY0WgV5DS1W70=;
 b=KAc+iT8NA8KInw0wyA1skA5f5NgtNDcyvPleBktSPUmWU55AH/6vUDjM+ueKhX7GMfrddrLG7ZvelnkTFu8wfAyqWzRFWbHvxPvkNchAJnEH+8mVvTQ85gBh/yc9u9wtiBFxQ8X+QeCkHKpGUlJ9UjXaPkUTaimRXyk0RsIwLWE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5335.namprd04.prod.outlook.com (2603:10b6:a03:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Sun, 28 Jun
 2020 21:55:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 21:55:12 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] nvme-pci: Move the sg table allocation/free into
 init/exit_request
Thread-Topic: [RFC PATCH] nvme-pci: Move the sg table allocation/free into
 init/exit_request
Thread-Index: AQHWTTkNjOAY+qipjkO2V+mbMsikEA==
Date:   Sun, 28 Jun 2020 21:55:12 +0000
Message-ID: <BYAPR04MB4965FD429BA4203694CB37DA86910@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7bd1936-282e-40f0-3c6c-08d81badeec7
x-ms-traffictypediagnostic: BYAPR04MB5335:
x-microsoft-antispam-prvs: <BYAPR04MB5335749214109A495341C91286910@BYAPR04MB5335.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0448A97BF2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwK/At2rAlxih3+TIuWordd9P3aWcvL8rLjDhvhkLziL+jUUKh92BQeb7K59OTRY37WpoO9bKCEHJO63/a+Q5n9hs1+44qyAzmRIyx+EyBEbG1HW3U7dWQC4SxC9vtNROPlMRTKbBmsUszDOP1ubJUT8yIYQZnCN6KZrshSPi/5b8znX9srwIkhRt2Ic2T7aAcxgFDmOCPS381mVbLWkf5cFcEOHIUiRXHDC673kvzEc1psvsJlwpC6SFPAqVUJAj73I0RNrEwNE5VuWTTwMsja5xRVRC3QBwvvIt3MhSK+ZCzy2cHWDSN7F3T564AO2bnEwYe7tXwkUFBLaR6fhPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(53546011)(6506007)(110136005)(86362001)(54906003)(478600001)(52536014)(66476007)(33656002)(66446008)(71200400001)(5660300002)(66556008)(64756008)(8676002)(4744005)(66946007)(2906002)(9686003)(26005)(7696005)(83380400001)(55016002)(4326008)(186003)(76116006)(8936002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jJuPR1wdRirMnFLWy531sOjaixYg+iewTfaARUDUgdeteXe12IWm2Gocrmx/x1Gm+PQY2wOJFtTS0+e3Sy/l9ug5K2JjhRIiErhqySwo7aAY5XQ78cF7DKgssN8D9GPO1CeQIM6YiNEuyeipxgvA2p6g6gDxIjLBxHmcSD3ycgzyhODqGawggAh3TvtkSvJPS8J9WFkkqPQqUT3BC082fgi4cD8zb5Juqq3VC7/fQSwYNX1iaaotgbjoTyNRMbD0ZbYnL1aFT/6aTsH63b5eCj/1lmnQEI47hK2sEiEATdvEMP3xdkTqrSF0YRvUuSrUoxrbHFIEiyy0QZPCoFd7055s3vlHtVwao/yNlstJHXkwmMFzOjR1itV1XhPRBf0nINWaxJqh3j5RrbDnHO/A/OL66y9Xsgst+zw8V0ty+fN3mjbMbXg20z41qMqNXAArc3YzgTl06q0SsgHQLQ83Ubcm/OQvZ+/LK2KDCGVr3tM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bd1936-282e-40f0-3c6c-08d81badeec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2020 21:55:12.0193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: do2vAaSRCHrTS5ydBM9jnP/xNMcuWxj2oHnjFQHRsfOBrwNwZlhto3uKDVXUz02UlVp+pqm3K3yrTwHE+6tKnGUuoCsrLoaba95l/+H1WnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/20 3:44 AM, Baolin Wang wrote:=0A=
> Move the sg table allocation and free into the init_request() and=0A=
> exit_request(), instead of allocating sg table when queuing requests,=0A=
> which can benefit the IO performance.=0A=
> =0A=
> Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>=0A=
=0A=
The call to sg_init_table() uses blk_rq_nr_phys_segments in =0A=
nvme_map_data() with this patch we are blindly allocating SG table with=0A=
NVME_MAX_SEGS, without any performance numbers it is hard to measure the =
=0A=
impact.=0A=
=0A=
Can you share performance numbers ?=0A=
=0A=
I'm particularly interested in for IOPS/BW/CPU/USAGE/Submission latency =0A=
and completion latency and perf numbers for the respective function in =0A=
to determine the overall impact.=0A=
=0A=
=0A=
