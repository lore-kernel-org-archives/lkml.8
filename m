Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E328C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FD820724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="StLJhlc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCRCoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:44:39 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:18646
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbgCRCoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:44:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OETy3igWMFQw7J4RqrtOKRQ/vPT5ACUerCPOUxF1RrfHXt/WNh/R9b3EzfQajGde93V4FiexCtZpzT0Z7M8RyC5i80G3pXEAmB8iL7w0f5jgRKDvXdUQbm4nBKcE5buJBzEXjNxlM++DLTHNqGn51pdSr8kbMp4LT89CK32FI2b1b9TNNUFO33FI38fnAN+n+X3Q9iNfNyoYy+ME58skPm5wsd4Kw8O4wY/VR7Lii9z5wNUdiIexK6+04PuqKAGd4oo6amoigsMvrLoCC0A59mTK0fQm7SXSh941YilhIBwXzkGVEHB62ElvW2QVsYGduNGehfsFtPztP3M56Nf1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr0u8xTUHeAA0G2piQ0Hr3ewjhnv4M+y82w+ZkXgKWE=;
 b=n0+Wo7CgThCawoDcFEyyg0Ve+aY6SSN/FxXhdUoRl5RnFRROHjY1rQGpIRPjfDCHgr43Eeo1X2V241SO3WA7fjjlPd2awdDq0Xqln879gOwn2RkT2I4Nrvucmv5RaQpgG8P63eFsfQ1C/c68TmIEWsmjXWfYYKHb2GwjQYH1DzcFOTJ5eZn3nL1zzATzvkOfKmb+oA+8yZEeqVGIYBPJWwygw/PhbhWsqJwga54pa6FnKPwch+dQPwVxXWLglWpMXcu1epyzuBvSlBkVcvlD7lyuoFYWxZeadwnsRaJUGwqAqxeBU6dJlYg57ZvzyhpYAOwJvCT6sxq90qE/17N4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr0u8xTUHeAA0G2piQ0Hr3ewjhnv4M+y82w+ZkXgKWE=;
 b=StLJhlc9dzsvgwcA2mXs8ysWY11e4D3skGaPiUOJ0WAjfZKUPqqfeyj49iLzt2kIy4EZEH0FZbujr+nYonXy7xFj98G2QtuVsglXHZMSW0gCk+vczWSpJQ7NEBkFRtEIFzVVG1B/wdfhP4ZglVkTlnivD/3l0w913/3SuavkTe4=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB4447.eurprd04.prod.outlook.com (20.177.57.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Wed, 18 Mar 2020 02:44:33 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 02:44:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Topic: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Index: AQHV8emRabKKTJAuM0OK7xtU5vZU9A==
Date:   Wed, 18 Mar 2020 02:44:32 +0000
Message-ID: <VI1PR04MB694108DF36F465324BA45E05EEF70@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023455D0FE9766FFBE1EE5EEEFD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <AM0PR04MB448123609B2FE8F5ECAF1F4388FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB4481D74E3C38B047562F419988FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10ae6edb-df68-4914-4b60-08d7cae6499b
x-ms-traffictypediagnostic: VI1PR04MB4447:|VI1PR04MB4447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB44476673D4C7587B1E966A7CEEF70@VI1PR04MB4447.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(199004)(5660300002)(33656002)(44832011)(54906003)(316002)(186003)(26005)(52536014)(86362001)(15650500001)(110136005)(9686003)(6506007)(53546011)(76116006)(8936002)(55016002)(91956017)(8676002)(66446008)(64756008)(2906002)(66556008)(66946007)(478600001)(66476007)(81166006)(81156014)(4326008)(71200400001)(7696005)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4447;H:VI1PR04MB6941.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +78itZQZ3Zk3LFDWuBQjcipNpQ/yl20tGRLevxtM2I5uDLQ2Tsay3VP1jeucBiVtQDbINKqi3MFOWEhMIJRP/xseWKxuro6cc8qS1xCgKhoOg6+4PcIsXKXDMR41lzBCC8pSX6UnsPNLK8XtPGL5kt8ZYkVbyUxSjW80/Ze1Ra6zq4apId1yRbbnpt0zYU507IxWpCUhEDbX1Cna+IVbUZPVBlXiffB8hQ0tPafcRwYQzLsuUCuraSSBieioUoAOJQkAiFJYMrIa2Vt8r6AndGKF/NqEz1+RxtUFnR0x3lXvemcvpQlRM7BBhOA2iaIxm45sP30is4XVGhXdXJBjlOMsIBSkQQnCyPBkGM8qzShY9bnbBwBu7qHYccaQA4Oj2AUtbG+UN0yiKlryLdm9A4tH/RjMIWk67oBevl0flGgrdDyPfiUBOk8Ryw1kfLvBkpkKBSUaIGZraOzMdr4KcDuHFh3WyeyeeAqgZOtwU4oVIW8RMrgQgwAkfayL3PS9HK9Lm4UjNPClnAng+QBYnQ==
x-ms-exchange-antispam-messagedata: sK7nPOPORkyHnMxz14j+eV6P4dvsnOVLUjnllEOYsmKeGuJud769ohv6gPQIfhtFfpJoXH+x2U74BVHp+GKp9Nyqv8Aq2DcYyKXVsBcux60s36L7EShHXA+ZwdToYYsw5Vxp59pSfwBYZWEDDRqfgQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae6edb-df68-4914-4b60-08d7cae6499b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 02:44:32.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E90VmxLc2pXfyYKWXdcVnTDYpz7eg2iTpg8WKYNsZ9rIL7s5BtNIOwgbYEzotsY2ou+jbiLoJSXP0GAc5ZpPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-13 9:38 AM, Peng Fan wrote:=0A=
>> Subject: RE: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel=
=0A=
>> type=0A=
>>=0A=
>> Hi Leonard,=0A=
>>=0A=
>>> Subject: Re: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel=
=0A=
>>> type=0A=
>>>=0A=
>>> On 2020-03-04 7:55 AM, Peng Fan wrote:=0A=
>>>> From: Peng Fan <peng.fan@nxp.com>=0A=
>>>>=0A=
>>>> V6:=0A=
>>>>    Add Oleksij's R-b tag=0A=
>>>>    Patch 3/4, per=0A=
>>> https://www.kernel.org/doc/Documentation/printk-formats.txt=0A=
>>>>    should use %zu for printk sizeof=0A=
>>>>=0A=
>>>> V5:=0A=
>>>>    Move imx_mu_dcfg below imx_mu_priv=0A=
>>>>    Add init hooks to imx_mu_dcfg=0A=
>>>>    drop __packed __aligned=0A=
>>>>    Add more debug msg=0A=
>>>>    code style cleanup=0A=
>>>>=0A=
>>>> V4:=0A=
>>>>    Drop IMX_MU_TYPE_[GENERIC, SCU]=0A=
>>>>    Pack MU chans init to separate function=0A=
>>>>    Add separate function for SCU chans init and xlate=0A=
>>>>    Add santity check to msg hdr.size=0A=
>>>>    Limit SCU MU chans to 6, TX0/RX0/RXDB[0-3]=0A=
>>>>=0A=
>>>> V3:=0A=
>>>>    Rebase to Shawn's for-next=0A=
>>>>    Include fsl,imx8-mu-scu compatible=0A=
>>>>    Per Oleksij's comments, introduce generic tx/rx and added scu mu ty=
pe=0A=
>>>>    Check fsl,imx8-mu-scu in firmware driver for fast_ipc=0A=
>>>>=0A=
>>>> V2:=0A=
>>>>    Drop patch 1/3 which added fsl,scu property=0A=
>>>>    Force to use scu channel type when machine has node compatible=0A=
>>> "fsl,imx-scu"=0A=
>>>>    Force imx-scu to use fast_ipc=0A=
>>>>=0A=
>>>>    I not found a generic method to make SCFW message generic enough,=
=0A=
>>> SCFW=0A=
>>>>    message is not fixed length including TX and RX. And it use TR0/RR0=
=0A=
>>>>    interrupt.=0A=
>>>>=0A=
>>>> V1:=0A=
>>>> Sorry to bind the mailbox/firmware patch together. This is make it=0A=
>>>> to understand what changed to support using 1 TX and 1 RX channel=0A=
>>>> for SCFW message.=0A=
>>>>=0A=
>>>> Per i.MX8QXP Reference mannual, there are several message using=0A=
>>>> examples. One of them is:=0A=
>>>> Passing short messages: Transmit register(s) can be used to pass=0A=
>>>> short messages from one to four words in length. For example, when a=
=0A=
>>>> four-word message is desired, only one of the registers needs to=0A=
>>>> have its corresponding interrupt enable bit set at the receiver side.=
=0A=
>>>>=0A=
>>>> This patchset is to using this for SCFW message to replace four TX=0A=
>>>> and four RX method.=0A=
>>>=0A=
>>> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>=0A=
>>=0A=
>> Thanks for the test.=0A=
>>=0A=
>>> My stress tests pass on imx8qxp with this patcheset, however=0A=
>>> performance is not greatly improved. My guess is that this happens=0A=
>>> because of too many interrupts.=0A=
>>=0A=
>> Might be. Could you share your testcase?=0A=
=0A=
https://github.com/cdleonard/imx-scu-test=0A=
=0A=
>>> Is there really a reason to enable TIE? Spinning on TE bits without=0A=
>>> any interrupts should be just plain faster.=0A=
>>=0A=
>> I could try to disable TIE and give a try. If performance improves lot, =
I could=0A=
>> change to non TX interrupt.=0A=
> =0A=
> After rethinking about this, we need TX interrupt, otherwise we have to=
=0A=
> use TX_POLL which is slower or let the client kick the TX state machine.=
=0A=
> =0A=
> Compared with original method, this already reduces to use 1 TX and 1 RX=
=0A=
> interrupt. This already good for system.=0A=
=0A=
Sorry, I missed that fact that your patches don't include the required =0A=
DTS changes. Indeed that is only one TX and one RX irq per call now.=0A=
=0A=
Running my test now results in RX timeout :(=0A=
=0A=
-----=0A=
=0A=
On an unrelated note: are you sure it is appropriate to change the =0A=
compat string here? Another way to implement direct SCU communication =0A=
would be as another channel type, IMX_MU_TYPE_SCUTX.=0A=
=0A=
It also strange that you're adding a bool fast_ipc in imx-scu, do we =0A=
really want to support the old path?=0A=
=0A=
If SCU protocol was implemented as a channel type then maybe we could =0A=
sidestep mbox_request_channel_by_name, parse mboxes manually and always =0A=
request MU_TYPE_SCUTX.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
