Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7FEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5149C2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="PK9IdWac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGIIzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:55:18 -0400
Received: from mail-eopbgr1400128.outbound.protection.outlook.com ([40.107.140.128]:1357
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbgGIIzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:55:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeHxj/maVUYclvWUCDPGc4ymaEKv9JB2bd3LDdMrxc6OGZncHfjphQYhveYs9RKJ264DqdkzLjbAnrT1d12tQT8wvl/f8vKm5Vy0RcKIsoG5VPpcu/U5XObhjAcfcr2xcGY/jTydb72JiRtVgub/XWomupiAGVbp3fflu7CBnQIX6Ti/ClIanBK+7MjBYL/rQDJE+HE6A1oq2e70FpIdZruFMD/V7jPFCv78Za6o6nwM/Eg5TJZaaHSfSmmsUn/eniC/ta/lxuuQ3eIsi1Gcp0TU23woMWbM2DtOaPEq6SXiSq4nUluqN9K9elOw2d3j/jrYb3g+80z/R5KxRj67sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATRzOvBRSRcBp3xtC5lNtvw2YrsleU8nD9y8kTBj+cU=;
 b=R3YJY2BrWCZKAjkA1heXdfHSzyX1B413ZWR6D32Qb38XbsVH7+aIiw4zL21BMw249KEf2fd20bJdTj13nUOF3zZy2yjqx5YfAnsoPaQ/cA7Fxp/2Cw5tH+DO1U0nQwJgw92iwHhNDGESgRFM1ZTQ/u/tAZjgMyhzXrk6+8qfmLx2S8HfjGrtC+q0QCbRQSIGMaA7bfFeAIGp5NhWzw/YOdmLrD/40GFi76DRSrBA40MYILUIEV+5bvYmjNtPXNXisjozaoIgL37Pd+OCSWz977OyZ8EZaD1+46tfM7xCx8gV4HgDZr0nOD1UK9G93EguOEt4oK6efU9ZB14+z0YRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATRzOvBRSRcBp3xtC5lNtvw2YrsleU8nD9y8kTBj+cU=;
 b=PK9IdWach98Xkt/M1RHX1SneqYCNYxTRSlhKgUrrCmzRl8RrTUhUOx8zbNPv+0yVGMMsRmMd8iRshJPIAtYLql3k9a+4FYBz11BKa2GdaS/ieVYf3vasPs8pOr746iPiHtA8dASHLBjj7a7LGQaiKkr9Lbl2H1DfFct/I0aslL4=
Received: from OSBPR01MB4024.jpnprd01.prod.outlook.com (2603:1096:604:4b::15)
 by OSBPR01MB3080.jpnprd01.prod.outlook.com (2603:1096:604:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Thu, 9 Jul
 2020 08:55:12 +0000
Received: from OSBPR01MB4024.jpnprd01.prod.outlook.com
 ([fe80::2198:7e23:8f02:b240]) by OSBPR01MB4024.jpnprd01.prod.outlook.com
 ([fe80::2198:7e23:8f02:b240%5]) with mapi id 15.20.3153.029; Thu, 9 Jul 2020
 08:55:12 +0000
From:   Dien Pham <dien.pham.ry@renesas.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: RE: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering
 clocks with discrete rates
Thread-Topic: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering
 clocks with discrete rates
Thread-Index: AQHWVcldxf7eBbhrV0WytRuJ2WVzT6j+6QFggAAEUoCAAAQbcA==
Date:   Thu, 9 Jul 2020 08:55:12 +0000
Message-ID: <OSBPR01MB40243874BD95329871DE02A4D1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
References: <20200709081705.46084-1-sudeep.holla@arm.com>
 <20200709081705.46084-2-sudeep.holla@arm.com>
 <OSBPR01MB40249DA5EFECDA8C5AC9C619D1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
 <20200709083925.GC31544@bogus>
In-Reply-To: <20200709083925.GC31544@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [210.245.28.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a29fd2f-a866-4ae7-378e-08d823e5cabf
x-ms-traffictypediagnostic: OSBPR01MB3080:
x-microsoft-antispam-prvs: <OSBPR01MB3080045FD9EEE80DC17B478FD1640@OSBPR01MB3080.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04599F3534
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhT6w/j9TsJFwaLdv6SpHh2eUaDRihaLWsYIyLoSf8KEYe71srXQe18BQp+wiew4HTEZroB0v/jPI5HdaYrOfz4SYtF0a51Nl8S+95W3gXuZ41FdgIo+kZjDNBzfOHI9gtKIAAF/mnLTaQPe+IZb2oUZJt3l6jXqlYA7Ttg8cMgcXVKlyH+26lN3g6Ct6EMRlEZ2oX3EQVZjJHSwFal67qRlBDKB36IphrEfTkbLULKQyHF5dkpABglkPmKMGI/tWjL2XOMbIY8bP6TrucOcIigJs0hUDzuD06TG9ChmIW/BtWDpdY4zsLhhVe/FMqk4AMLnLp/O0XUMDu43Q5eBM6dZMHHnf/BY6Z1sONrulpzEZ5C4mrE65RSP9WwwHk09EzOct5LZU8L0l3SF6kPsSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(86362001)(5660300002)(6506007)(8676002)(8936002)(478600001)(55016002)(966005)(9686003)(2906002)(52536014)(316002)(7696005)(71200400001)(186003)(4326008)(54906003)(64756008)(66556008)(66476007)(6916009)(66446008)(66946007)(33656002)(76116006)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xDhL5UT96dRtYfSmDn/8Gjow2/bLZ9Ja6acAlyfR/QboVz9EPxxDP4K57g5NzmSUK2UQALqIyHY0RCs1a5vTNIETAwhKthd6Ao5dIGCAOmaGOjfb3CKLIPYhApNlU++eCh9rh2vYg4bZMysZayiRn62QbEvbxXoO1l+gTMoXfzMhAzgup1IH86IcKLReIfjojK3SaecDdQtRM+CowzSMKuShQuOnz4UIvUD0LevNspcNAA8wA0xnmXDRJYyu0m5SEirDMyR1TzTJCiY8BwNy5D+qmEuNOdmCprxC+m+aNm/dSEw/etnUjxw621QqNL0hLEP2OcxJSw7KoKgsCfWHg+dGG7Y2YjxnMbDBusiw4vxsfvZPvdjKLzi8OVU2q3ZuMolGGs5EjuYamJS7i4FSHut4plkhyhajxRxo8PcGtOP3h0W5xrIroRnWjuAGQkOY3XkA57xi73fks+nN1S+Fx0Q5HSEteOFFohYA8YF0BTQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a29fd2f-a866-4ae7-378e-08d823e5cabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 08:55:12.7208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Dq4VKNBTepdO6ocVUAgq7Mo9sFVFr9IRfaRldKwzhQDLUIq8IJykcbfBHZKO71puLpHCMHyuFrVyhHdWeMePIGuoKCfIlTNYeiqhXiJahQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sudeep-san,

>-----Original Message-----
>From: Sudeep Holla <sudeep.holla@arm.com>=20
>Sent: Thursday, July 9, 2020 3:39 PM
>To: Dien Pham <dien.pham.ry@renesas.com>
>Cc: linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org; Steph=
en Boyd <sboyd@kernel.org>; linux-kernel@vger.kernel.org; Michael Turquette=
 <mturquette@baylibre.com>; Sudeep Holla <sudeep.holla@arm.com>
>Subject: Re: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registeri=
ng clocks with discrete rates
>
>On Thu, Jul 09, 2020 at 08:26:54AM +0000, Dien Pham wrote:
>> Hi Sudeep,
>>
>> Thanks for your patch.
>>
>> >-----Original Message-----
>> >From: Sudeep Holla <sudeep.holla@arm.com>
>> >Sent: Thursday, July 9, 2020 3:17 PM
>> >To: linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org; St=
ephen Boyd <sboyd@kernel.org>
>> >Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-kernel@vger.kernel.org; =
Michael Turquette <mturquette@baylibre.com>; Dien Pham <dien.pham.ry@renesa=
s.com>
>> >Subject: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registerin=
g clocks with discrete rates
>> >
>> >Currently we are not initializing the scmi clock with discrete rates co=
rrectly. We fetch the min_rate and max_rate value only for clocks with rang=
es and ignore the ones with discrete rates. This will lead to wrong initial=
ization of rate range when clock supports discrete rate.
>> >
>> >Fix this by using the first and the last rate in the sorted list of the=
 discrete clock rates while registering the clock.
>> >
>> >Link: https://lore.kernel.org/r/20200708110725.18017-2-sudeep.holla@arm=
.com
>> >Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
>> >Reported-by: Dien Pham <dien.pham.ry@renesas.com>
>> >Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> >---
>> > drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
>> > 1 file changed, 19 insertions(+), 3 deletions(-)
>> >
>> >Hi Stephen,
>> >
>> >If you are fine, I can take this via ARM SoC along with the change in f=
irmware driver. However it is also fine if you want to merge this independe=
ntly as there is no strict dependency. Let me know either way.
>> >
>> >v1[1]->v2:
>> >	- Fixed the missing ; which was sent by mistake.
>>
>> I tested the patch,
>> I is ok and can fix my issue.
>>
>
>Thanks for testing. Can I add ?
>
>Tested-by: Dien Pham <dien.pham.ry@renesas.com>

It is ok.

Thanks,
Best regard,
DIEN Pham
