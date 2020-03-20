Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2032CC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53DF20776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dIyPK87Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCTGsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:48:07 -0400
Received: from mail-db8eur05on2052.outbound.protection.outlook.com ([40.107.20.52]:6256
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgCTGsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:48:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChU/l1ohSL0MDfvIPZ1QdgrsOslpD0PR37WkLL33cJWBEJu7RC/lYEvroXDYC2eEP2gnlZCK8nlNC4rytgDP/ShODh57gvu+AaJJYuWTDBW/bZOHn5azq2OHxmLIbtv20fIBrO/tiEAH9fX2nCdxYGoCzY91i1jHLURlNYtJJ+wPGvnAf1ki91SnYJj/pMUvWZuCrEwjK/Rld+++wbGvaZSe/L1r+oiKVI8lXDCu8Y3ghOvkpKSnUGQ9sk03WYTTo89wQjSf9GtYMRFzyK33LbY3rRZzjWjDEtu6dKa9wSdenbR8jzJehsaUwtr+C35uAEOg004GUF5WDY9BadpLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFZ156xlssog6pz3pkHfQmrcY2QS4g7qZ3yZxcQXozY=;
 b=dQKGcSDHe1+b6aR5O4L3dQDkR1ScO8prcANDJOaf/PMKKW7mG+IQ0bIUlQnn9zPv8fRuDM9XKCKltXWAKVYWVTE9sVqqk4u1r24Uv09lY3uuTKc2SAdkNqrFhKTpl66jFDhYVC9tx0DTRP19Zh3b/IukD/O7lcgxwkgoNQDyG9L4N6YHJO8YqGEE/UQNTlMlUunM1gw8ezKgO2TU5JLxajbX7/TNJ5M9K9RYT2cTR0uQ+A0jcUsY9nLJXT3fYHh8lpvtPbHLXdYG4ZmCsoXaLQ0vGutE6eyG0zaqJIEwBSvtdy6pEIdNluEIYPy/VfM6HHfO5AVa880U4ghpIharcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFZ156xlssog6pz3pkHfQmrcY2QS4g7qZ3yZxcQXozY=;
 b=dIyPK87Yp6HbjDmAJmaaYRC4BudokGopBwE4L6RkWalqhnqsraNL80mQjME7KsPizpUBj751a6yTZ2tOYH2ODIptGttEhoopm2XXgK35opRYTnlvT4uatfSmAXpdJ4X0Ecz4VlojGFtnKvxrxKiwMnZR7PUbdwQ/4Vi9S/a0WqA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5564.eurprd04.prod.outlook.com (20.178.106.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Fri, 20 Mar 2020 06:47:58 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::c491:36dc:a498:dd0a]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::c491:36dc:a498:dd0a%3]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 06:47:58 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     kajoljain <kjain@linux.ibm.com>,
        "acme@kernel.org" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: RE: [PATCH v4] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Thread-Topic: [PATCH v4] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Thread-Index: AQHV4WcV2Y0K+6EYb0mNmxH19eS7KageuXkAgAUq9oCAAAnqYIARApyAgBxNslA=
Date:   Fri, 20 Mar 2020 06:47:58 +0000
Message-ID: <DB7PR04MB4618D0696D39AC5D44FF5A51E6F50@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
 <DB7PR04MB46186AB5557F4D04FD5C4FEAE6160@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <be86ba99-ab5a-c845-46b6-8081edee00ca@linux.ibm.com>
 <DB7PR04MB461807389FDF9629ACA04533E6130@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <cb9b353b-c18a-0064-eb72-a6c91d5fdec9@linux.ibm.com>
In-Reply-To: <cb9b353b-c18a-0064-eb72-a6c91d5fdec9@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d39ccb6-0d5a-4e80-04c0-08d7cc9aa068
x-ms-traffictypediagnostic: DB7PR04MB5564:
x-microsoft-antispam-prvs: <DB7PR04MB55646FCE2B2D32C1403283FEE6F50@DB7PR04MB5564.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(71200400001)(9686003)(55016002)(64756008)(33656002)(66946007)(66446008)(66556008)(66476007)(6506007)(76116006)(7696005)(26005)(86362001)(81156014)(7416002)(110136005)(5660300002)(8676002)(52536014)(81166006)(8936002)(478600001)(316002)(4326008)(54906003)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5564;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYWjPuGqx8+vqheIMRxS0RsPRoK93dPwmvJQIkDI5DoQIMvaocJCuL61WCtFdbldFiTMgqbVL4gQi3MhM5Y+PvMUKM4htgwn2Afc6CNrOqzMA0fXOSrWdKOQcM1EarTot2ub7ZsAkB/roqp1SjNAz5bek8m79OI8CoUfpl6KRYpbMw7PnceUvSoUKfUAX2AO9ywykyyBdyjCYRvnOWv7VnvpDw6EGVJ9zRG86HAprguy8UU+XffEbQG0eylJ2wlP8sh7h7Nzb7XRZzMOjhge0F0U1UP2D6LG0pYACEQ7NlCW9yS+hPxcL5dvsIjJswWql9fBJK7leCuuSjFwNYROSjhWOG8Q4RomJ5TzZqoXZnpZzciqtIv4GKqIMNK5UP6Wjm3p1eb9rgNPFrzzKrTrA6ukZ7shhydrTAGNQgAzPkQgOjig+1DR5sd1PBuaud/k
x-ms-exchange-antispam-messagedata: VJVa1iWKhLh/4ToLn1l2RqF9fz7vIbK6JlMzgq36fZMEBx00Ca0dh64hYSyqRzXulCKjWjSt3IZ/gRPzlNCF3kYUTSZEj8AaRhFjeJo7dJKV9RBqKt2y0KIjPmjh2zezT/3IcXvdqu359qT1/suTXg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d39ccb6-0d5a-4e80-04c0-08d7cc9aa068
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 06:47:58.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOZkBqK/njXWQ6JHUJfOZSQFZXAYvXExFJpwzo+VadBxh8vcpncPDlg7aKYzZzua5crOlkxLaZmul4avToXFXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]
> >>> Hi Kajol,
> >>>
> >>> I am not sure if it is good to ask a question here :-)
> >>>
> >>> I encountered a perf metricgroup issue, the result is incorrect when
> >>> the
> >> metric includes more than 2 events.
> >>>
> >>> git log --oneline tools/perf/util/metricgroup.c
> >>> 3635b27cc058 perf metricgroup: Fix printing event names of metric
> >>> group with multiple events f01642e4912b perf metricgroup: Support
> >>> multiple events for metricgroup
> >>> 287f2649f791 perf metricgroup: Scale the metric result
> >>>
> >>> I did a simple test, below is the JSON file and result.
> >>> [
> >>>         {
> >>>              "PublicDescription": "Calculate DDR0 bus actual
> >>> utilization
> >> which vary from DDR0 controller clock frequency",
> >>>              "BriefDescription": "imx8qm: ddr0 bus actual utilization=
",
> >>>              "MetricName": "imx8qm-ddr0-bus-util",
> >>>              "MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ +
> >> imx8_ddr0\\/write\\-cycles\\/ )",
> >>>              "MetricGroup": "i.MX8QM_DDR0_BUS_UTIL"
> >>>         }
> >>> ]
> >>> ./perf stat -I 1000 -M imx8qm-ddr0-bus-util
> >>> #           time             counts unit events
> >>>      1.000104250              16720      imx8_ddr0/read-cycles/
> >> #  22921.0 imx8qm-ddr0-bus-util
> >>>      1.000104250               6201
> imx8_ddr0/write-cycles/
> >>>      2.000525625               8316      imx8_ddr0/read-cycles/
> >> #  12785.5 imx8qm-ddr0-bus-util
> >>>      2.000525625               2738
> imx8_ddr0/write-cycles/
> >>>      3.000819125               1056      imx8_ddr0/read-cycles/
> >> #   4136.7 imx8qm-ddr0-bus-util
> >>>      3.000819125                303
> imx8_ddr0/write-cycles/
> >>>      4.001103750               6260      imx8_ddr0/read-cycles/
> >> #   9149.8 imx8qm-ddr0-bus-util
> >>>      4.001103750               2317
> imx8_ddr0/write-cycles/
> >>>      5.001392750               2084      imx8_ddr0/read-cycles/
> >> #   4516.0 imx8qm-ddr0-bus-util
> >>>      5.001392750                601
> imx8_ddr0/write-cycles/
> >>>
> >>> You can see that only the first result is correct, could this be
> >>> reproduced at
> >> you side?
> >>
> >> Hi Joakim,
> >>         Will try to look into it from my side.
> >
>=20
> > Thanks Kajol for your help, I look into this issue, but don't know how =
to fix it.
> >
> > The results are always correct if signal event used in "MetricExpr" wit=
h "-I"
> parameters, but the results are incorrect when more than one events used =
in
> "MetricExpr".
> >
>=20
> Hi Joakim,
>     So, I try to look into this issue and understand the flow. From my
> understanding, whenever we do
>     calculation of metric expression we don't use exact count we are gett=
ing.
>     Basically we use mean value of each event in the calculation of metri=
c
> expression.
>=20
> So, I am taking same example you refer.
>=20
> Metric Event: imx8qm-ddr0-bus-util
> MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ + imx8_ddr0\\/write\\-cycles=
\\/ )"
>=20
> command#: ./perf stat -I 1000 -M imx8qm-ddr0-bus-util
>=20
> #           time             counts unit events
>      1.000104250              16720      imx8_ddr0/read-cycles/
> #  22921.0 imx8qm-ddr0-bus-util
>      1.000104250               6201      imx8_ddr0/write-cycles/
>      2.000525625               8316      imx8_ddr0/read-cycles/
> #  12785.5 imx8qm-ddr0-bus-util
>      2.000525625               2738      imx8_ddr0/write-cycles/
>      3.000819125               1056      imx8_ddr0/read-cycles/
> #   4136.7 imx8qm-ddr0-bus-util
>      3.000819125                303      imx8_ddr0/write-cycles/
>      4.001103750               6260      imx8_ddr0/read-cycles/
> #   9149.8 imx8qm-ddr0-bus-util
>      4.001103750               2317      imx8_ddr0/write-cycles/
>      5.001392750               2084      imx8_ddr0/read-cycles/
> #   4516.0 imx8qm-ddr0-bus-util
>      5.001392750                601      imx8_ddr0/write-cycles/
>=20
> If you see we have a function called 'update_stats' in file util/stat.c w=
here we
> do this calculation and updating stats->mean value. And this mean value i=
s
> what we are using actually in our metric expression calculation.
>=20
> We call this function in each iteration where we update stats->mean and
> stats->n for each event.
> But one weird issue is, for very first event, stat->n is always 1 that is=
 why we
> are getting mean same as count.
> So this is the reason for single event you get exact aggregate of metric
> expression.
> So doesn't matter how many events you have in your metric expression, eve=
ry
> time you take exact count for first one and normalized value for rest whi=
ch is
> weird.
>=20
> According to update_stats function:  We are updating mean as:
>=20
> stats->mean +=3D delta / stats->n where,  delta =3D val - stats->mean.
>=20
> If we take write-cycles here. Initially mean =3D 0 and n =3D 1.
>=20
> 1st iteration: n=3D1, write cycle : 6201 and mean =3D 6201  (Final agg va=
lue: 16720
> + 6201 =3D 22921) 2nd iteration: n=3D2, write cycles:  6201 + (2738 - 620=
1)/2 =3D
> 4469.5  (Final aggr value: 8316 + 4469.5 =3D 12785.5) 3rd iteration: n=3D=
3, write
> cycles: 4469.5 + (303 - 4469.5)/3 =3D 3080.6667 (Final aggr value: 1056 +
> 3080.6667 =3D 4136.7)
>=20
> Andi and Jiri, I am not sure if its expected behavior. I mean shouldn't w=
e either
> take mean value of each event or take n as 1 for each event. And one more
> question, Should we add an option to say whether user want exact aggregat=
e
> or this normalize aggregate to remove the confusion? I try to find it out=
 if we
> already have one but didn't get.
> Please let me know if my understanding is fine.

Hi Kajol,

Sorry, your reply was buried in a sea of emails, it comes into my eyes when=
 I searched any feedback from you. Much thanks for your great details!!!!!

I can quite understand what you explained. As a user, I think we always wan=
t to get the exact result according to the metric expression.

Can you take this case as an example then send out a formal email into mail=
ing list to reflect this weird issue, more people can participate and discu=
ss about it. Or you need me clear up and sent out the email?
This could attract maintainers' attention.

Best Regards,
Joakim Zhang

