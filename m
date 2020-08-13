Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC426C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537F920716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XQCQv3MF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zZsxkc71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgHMHDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:03:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41510 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgHMHDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597302247; x=1628838247;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PLPlzkNL5jlX6qsOhPR87sW5KDku7VksUlBN3TM6EGA=;
  b=XQCQv3MFaL6EhZTOaPopo+nTgv1kmJna40H1uqRWM379bPicNyyik2Jj
   yltzIQUSTYSFDY8qiNcncg7CMCRphuZxxX+XR1spzn51h6ZoadoV7DtIg
   Ii+pmmIYIHRAqtOd159wKPmursuSuCI4B0KfrE2KjgvoBSBq0TzyZguiu
   4NmMtYTGIOhiJ/k7wLTwSE+53WuOVSzyBcjA+UC0GuToSVuNGDnd3iE/t
   EuD/hQoQIBnYCO2xilL2zsdSrWFwNa6upgp7GC/IzQ0x7lFORAHueGBOJ
   /6GQLQYmVjz0zKHY1zyIP56sOi7FXVVlv0AhSNNWBLkeNUQkm278rOSRL
   A==;
IronPort-SDR: lKcCcyDmM302puTiAZuzUqlFHnDNBSaV94EYHVXhksIT1GywpjqVpraYdjc9Y8IyANMVThcDmu
 gPa63BeALuh6vhpnK/Ro10wxCzNn478zBjyZDdW00/rUDrsgHSgKxk+fIiflz9aTOQjMX3OLbH
 d9/OrGOOAskeieMuwRNLQxblKKoT9URfN5IbvdXEy197RDzpAxJSYhG1BWLHd0J+Z/aXLSu3F7
 NJUAhrpbV/KcsBdq/bB2SBW5tBKXycTrY6HHe47NdojRmSc0MhWBRTSAo8D25ZMfZkr9IZDE6F
 aI8=
X-IronPort-AV: E=Sophos;i="5.76,307,1592841600"; 
   d="scan'208";a="247996527"
Received: from mail-cys01nam02lp2059.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.59])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 15:04:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M22u8hSvZ8PqJdv1qbAre9MEnRt5gZw0jJEdrrOKcQlSd9Eo0pzHItmLNlzAZn3aecZXcAu1GarIPa4k0a/pDCxJNvHxT30NbHGOC1jAE1Gs1qVDB4HcgRbwdldqg6r45ZK65OiicYZKteOHXgFHREq7hLg4OY6xTfZe938Iy7Am/lw07xgwgb3R3/6q20+x3PhgqMTjpUGvJQq3106qVJx3NtD1u4nZtIhgnHb/o/dm11p+yqq8gcgn0qqtz2zzMInL9YbKX3k5HQq2eeTegs0sKRsh4lw+SuHxJfMLGUSIIJMDQeQ4Qkz4AvEj01obPK0jIo58sj+9mRtm4A3/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLPlzkNL5jlX6qsOhPR87sW5KDku7VksUlBN3TM6EGA=;
 b=XLN6s9cf8hlXPoS+6ISDYzM2KdWYurWBrZMjJD24mbKBnPIie2uvpGkX2nbdplEOm6PTrNvIDixiNqgMXWgXjTGYgtkQTORyj9V2TTWTtWFaPeWK+NpImF0N6vKPUUSHCE01TwrOAJgl0hfKMrEZYAkQAjbJE9Ig7hg2v+HFugXbxq5+KbD2Inq/QXKxePVDEe7YybyEbCXSlzSk4TJzTCfl6C/jJw6elaPNbWLZUB2Z8g9zSMcZAGoy9f0umWQL/kZtUyiAIb5bjroaY0vKbEAd7cpCqQieFKd0oNXGnZcp3+7RBQ/nG+rA74e63rWLl6/Orb2DermH2YiiDjPNsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLPlzkNL5jlX6qsOhPR87sW5KDku7VksUlBN3TM6EGA=;
 b=zZsxkc71H6C/VBe8CehLVlPaZ9QdY1+8SeZpZupn2s03MGKORbw0BBHJbGA8rlXyreLLaMYfUc4JijTty2XNJyDNxJfSGXyM+npIkvdcfmWEpAdLBma8CbB6j0iU6MBQrH/mSjfNUfwf6gVwzoqUk38C6i+EHeWdpBXm7aTRqlg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 13 Aug
 2020 07:03:32 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3283.016; Thu, 13 Aug
 2020 07:03:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Atish Patra <atishp@atishpatra.org>
CC:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: Setup exception vector for nommu platform
Thread-Topic: [PATCH v2] riscv: Setup exception vector for nommu platform
Thread-Index: AQHWcSODcO8pwfBnAUaNkuIfFTKGFA==
Date:   Thu, 13 Aug 2020 07:03:32 +0000
Message-ID: <CY4PR04MB375169F5D9CE1EB09B592CB5E7430@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200813033807.19556-1-qiuwenbo@phytium.com.cn>
 <CY4PR04MB3751ECCFBE6B590E9D0850B0E7430@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAOnJCUJTR_FEmjvs+L1KV6UJNbsZKrrVr7noWHUi8gG6qoWHxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: atishpatra.org; dkim=none (message not signed)
 header.d=none;atishpatra.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8019:b5ea:f0ff:8b24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92e665e6-3524-4303-cf9b-08d83f56fd65
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB072728783164CC04D4341BDBE7430@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNH3YesmmX9zTP2Rbt+lV0JVcTfCYfuf6yk9YwVTcN3LpY5+DvskRjFEsUKmsl/DJUcvyMShfRjDNC/ILpdAO/8PJjrjMxTRQu9hRqbCqVJqT6MZdu0thun7W/ogdr+PofdOrlVRfGs9YP91pDHTOma4hjxBk4Skl1TyCJmWXFNMtNSm0UYurwldeQpv7AEDqQa1vLvrWT3mjiLuGBRXCQnJtu2z2Qtp263y/zsz9rhBxSmkg+F0hHzFUWiqeq0geMKtVrX5lyovlsTTOus4cgQisAwSEC+A/JPVqF5XWFPz8vUqNu8ni0f4c/Agkp4MZEqehc+JY5kBZgk+aqWqJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(54906003)(71200400001)(186003)(478600001)(8676002)(66946007)(7696005)(316002)(66476007)(66556008)(64756008)(66446008)(52536014)(86362001)(33656002)(9686003)(8936002)(4326008)(4744005)(5660300002)(53546011)(76116006)(6506007)(2906002)(55016002)(91956017)(83380400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: e/YaNsF3c44KfewCsQIVqsXsw+HX3K3mByQUTLVVUNaCWtZcYAJycujlBuD/PctAt6wxPf8wk4xCz6aPRvUFGK4UzmMdchZ7morKnzMdAtcZP6xt/lu8TiQ/l8MMsvIvMl8vSgbT/toZkXnjN8CS3MNBw5C7ZZTn9eoChYcvMIgALDIqbaMDcP/Id9aMc0isufD0o+/hdbVetEcM64CexD8AOxt0sU4Yyhal9dgiNh+ZJO+1GZt2Le06uf4jUwTD2RPmUMwt3JzXoOCDWUUFD9Yfx0DiXVVBNXMCmUxjoc87ZwVyuiaGKhkRfLwbEoM5g+FWfEAU1qHXvTd0+5O2q7m6cL8Ss+Nqf1LBs3GaVB6CHOgbAQfxJoxZOkrlIzUhAtQ8jnyFxQGjqu5rwNZBXFvs9RqsmemxEg8Dhu/+9S/WMN9NeW8UHaUgcPLLBjEMRXh4OJfH+EuPaIflcq5KZqsWliH4Cayx5vjx689f2KofRIaf1y9RLOKBVOLhCCdkJApPGtONgfxFh8SRlj6YiULkGKCwmUUP7wxZ0jdPvXoc4Hh0yjEb03nTGKscNkuUFTlTP1oAO2dBCakTiqYBUn6LJfT/7HTYyyMQ3UQ1XyrF6Wlz0lf1pBEBRay+PgsxTvItTz8doflCXxN7vEn1iqzCQghMqv+QLrgxH8SZLsGzHOydQksmBGjjhZJi+1qfWgqFQUz+bGSKakCu7djF4A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e665e6-3524-4303-cf9b-08d83f56fd65
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 07:03:32.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsWWrP7hzMnBOwa4soDNqBQm80A8RxbhsmvhB+NlSEvkMzMN7fX0ONzsqL+BhTo69KrpzqMBgUpuTS7ZjneTOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/13 15:45, Atish Patra wrote:=0A=
> On Wed, Aug 12, 2020 at 10:44 PM Damien Le Moal <Damien.LeMoal@wdc.com> w=
rote:=0A=
>>=0A=
>> On 2020/08/13 12:40, Qiu Wenbo wrote:=0A=
>>> Exception vector is missing on nommu platform and that is an issue.=0A=
>>> This patch is tested in Sipeed Maix Bit Dev Board.=0A=
>>>=0A=
>>> Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")=0A=
>>> Suggested-by: Anup Patel <anup@brainfault.org>=0A=
>>> Suggested-by: Atish Patra <atishp@atishpatra.org>=0A=
>>> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>=0A=
>>=0A=
>> Please add a cc stable #5.8 tag. Kendryte support is in 5.8 stable.=0A=
>>=0A=
> =0A=
> That won't be necessary as the patch that broke nommu (79b1feba5455) was=
=0A=
> part of the 1st PR sent towards 5.9-rc1.=0A=
=0A=
Oops. Yes indeed. Thanks !=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
