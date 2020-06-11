Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C796206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IfsbTDhZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QXv77kfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFKTQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:16:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7512 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKTQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591903017; x=1623439017;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Odm5JQ1qiXYUIgWtvDKK5lnYUTERJRlGVy2CEenyhSk=;
  b=IfsbTDhZTdcwox2Z12clyJwr2woj2/NKvczNVx5ohajbu/Lha9Q+6EVR
   QrblqjV0ItlPq4es1h6cSyIhnbFNk0Lq2EPqHQg1NlosPd8iYXNiIbJ+t
   2y05p27S+FpgSINVcEKpWnFfxL24/aYljGXaJCLpjp2HoWHwOHIKuhocb
   GfDZ3gBHsSTKJs8BXD/DocmzLq8tlQXMXuzB8+B47ERJFjXVbUY/5RsTF
   oOjxZqzdnv9RQ15QCxTMpBaOwsT/tMKOnh7vOL0ogU1gfVoEUsM1W/wen
   1qaQi58Xg4Ap7rkMrjHKRc7gQ6L/1UvmCNXFcxpsne0buq8WHHY2VVmGx
   g==;
IronPort-SDR: PsbZ79/vWtTOXbbjBo61mRiPmZUMnqXNuM/Qc+w4P8Gu8myqKohjee6SNkWJi05SUwsWfPP2In
 nlEwdmGcf6O3epFZas+dnW5Dce8TIDy6uJ/KoHGWF7yhF6lxdSXkfo5iM81SLalq0U6e852stl
 2S0KacSxORAgcK+04R1QxnjhBoRuSq7WxVypBZKUJTvEcb3rqgo0Mig/SstsodapVvii8rxz/T
 gc1bN0mWuEHIhc7llVljsDpRvOdltsaRncXvnHzCnoNt3AbH6tTAXeT9dhZR9+8/L+BS4xQdk2
 1eg=
X-IronPort-AV: E=Sophos;i="5.73,500,1583164800"; 
   d="scan'208";a="139762664"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 03:16:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJkSXXFyjd0GV4ceJD9llC4beZS+4pNz3Sf731s917itEmgTEGIHAdHIFD8w6UMDC6MrPkStLabgufOAWVR1MO1IarJMa354mvh2PtxqOf45oVSs0otix1Gq9tYqRLhzJlZQNVrkCNl2AS0IoXk42T3QW6j2AVO7WJ9RWtnEslAy7sbo1nyMEWCvSvS1hDf9llkp1puy6V5gX2rmPCF4NASX/o9o5ZR7VoPYt88+eCVc2hrJESI9pz9EZdz8EavHsfIXLvgoIrNLTx/UfGDyaePo2zVnO3dxeaCu6NT7TMMyaSvTt1SwZU9Nt7vmCKvub9n+vMSuApggCRM91cE6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF5m86lqJidWkx6lwKGLassGs9bB/NswwePJmGYVNUM=;
 b=oRpPgV4Vo/VFZAW3JdOXnYKQi5y/Lv3VWuOtSEXhRUh4r8OHQ760yo94fO+E7E8zu2oJXRuzkGWuRdVah+63W2yYzmiIK7h6NrXAhDInxuN/MUNkmSHM45lv5mvIc0Y4mJfwD9/pqmx7YR+5kgTn+XoISnsBQwKhv4q8YOPoO4/TjaWOzTcN9C3K2EsTcEapkK+ajNXcS9SU7K0+l/diosNiRb1FTnGFYK2NPfFErxs2YPCRIMNXCZJt18V9oW7z0Xuobx/X/EC5rdDelo+7of7b32MWMq9xaEkSTpMz4HBt+cpl/2dU+QKPcA7k3UJXlLxvs3vCjLHb05qF1Ou7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF5m86lqJidWkx6lwKGLassGs9bB/NswwePJmGYVNUM=;
 b=QXv77kfWcXgt98AVjJDpBaElL5boaWcRCSgGbdhRn3kDGX01lUYQDtngyXO+PeYbPmLHarzWKihxN+s7wq/pwjmha2WIYPdeQ9U3ofQefQixi/NTaanyVIpPY1x2fd2x1uT71Z/2w8cET8oKJYK7kHOmbQTurrg/FFuCde53oig=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3861.namprd04.prod.outlook.com (2603:10b6:a02:ac::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 19:16:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 19:16:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v13 0/9] nvmet: add target passthru commands support
Thread-Topic: [PATCH v13 0/9] nvmet: add target passthru commands support
Thread-Index: AQHWKhRsU0RUeVdtwkqjNhBWhX0tSw==
Date:   Thu, 11 Jun 2020 19:16:53 +0000
Message-ID: <BYAPR04MB4965CEDB8E3AE4B7F4C527AF86800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58e1a248-9d32-4f93-168b-08d80e3c0063
x-ms-traffictypediagnostic: BYAPR04MB3861:
x-microsoft-antispam-prvs: <BYAPR04MB38619E0D316404A2ADF3578786800@BYAPR04MB3861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5m7AuniIZ/mF9GOkfy/gzamnFvwwzba8RsX0Lm/5bH2VFrV3kTFrH+0VI/9bqYc2qwFVDq2++6gJmn2golUFC1GoOEph/JT2NBIo1KbHQnYWroqJpoi+T2UAYqXBkmkDGLnAPu4bEMVIAKlPiRH86YFTlwZP+AJQxoPk9SMRXYmMY1NfLbU2nN1bfIAoySyFZwwCNqkMct1JVhJAy0Q4s4H5xHGFSfbuzsnsG0eMyAQgYxYfH+Jw7qsPxAKWlmKH5KdwCmA/RlKJPp1q6IGutVNRs1Hgze7fP3vgsWSPdEHyAm6s85pru2iDD2rvTw/M9HFeRv3QN1VpfXYi8y2sLJ7Vka5hO+dph9zH7G1OkK/SkVmjxI0h+FUtzs04sNGcQ4PvBTkHlJtyJw8Cv5XgMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(66556008)(8676002)(55016002)(71200400001)(52536014)(86362001)(33656002)(76116006)(8936002)(5660300002)(2906002)(478600001)(4326008)(83380400001)(6506007)(966005)(64756008)(66476007)(7696005)(6916009)(316002)(186003)(66946007)(26005)(53546011)(9686003)(66446008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ib+3cmmfwTL8FFHzu660nWvNZ+YuiYp3tgWdx6n1cbjpq9F4WgSebEdoc5+rqtt15RuAU5SZ+j5DaI+6v8OIaGts5xymz+BLQ4tLd5ja+NZscEJ8NXD7C+Yml5s9vWnGJdJ/VBQFFS9xz+N7KWXRwDhoKmTjJGofr4tL53iRksQ5FEh7vvZgrbFYfeI5s8NO8m86xTq+ohk4lG/eZnqrsKI77OmmAwdMf7TpKPo45o3pKfp7n4TuD1edfescMms65gyJubHIEWp84LqdpfYIMbYWocq3PJOn+AezKPJSl4Hl1iG7Sbgl2Glu8ZZfvAnYBlDnaS4/ftJPp/T6BFK+8uZKHf9xP16VceF1cY80MoTsudbkA9NVm38cP7wm3GUH7sPT8WgEujRmijjOO+i0PojDF+h9V8PN6Iys8kafchch4a2IF29xJpkaebTNYD9soSvZSiIFnqJ2rdp6S9uaP3AwH7M6VhX5qMhgoT9ufS4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e1a248-9d32-4f93-168b-08d80e3c0063
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 19:16:53.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4hjPUjTqkG9UXwUwcwL0C9mUN8x6JBW0ZXwwa1hCmEZttQQUjypkpGOIBp0p4ia4AJQhepPMi/Jg9CRv3Gattnm3GidJZ9J/lKiNhjYezg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:=0A=
> This is v13 of the passthru patchset which is mostly a resend of v12=0A=
> with Sagi's reviewed-by tags collected.=0A=
> =0A=
> Below, I'll reiterrate some points I made previously that haven't been=0A=
> responded to:=0A=
> =0A=
> I don't think cloning the ctrl_id or the subsysnqn is a good idea.=0A=
> I sent an email trying to explain why here[1] but there was no response.=
=0A=
> In short, I think cloning the ctrl_id will break multipathing over=0A=
> fabrics and copying the subsysnqn only has the effect of breaking=0A=
> loopback; the user can always copy the underlying subsysnqn if it=0A=
> makes sense for their overall system.=0A=
> =0A=
> I maintain overriding the CMIC bit in the ctrl id is necessary to=0A=
> allow multipath over fabrics even if the underlying device did=0A=
> not support multipath.=0A=
> =0A=
> I also think the black list for admin commands is appropriate, and I=0A=
> added it based on Sagi's feedback[2]. There are plenty of commands that=
=0A=
> may be dangerous like firmware update and format NVM commands, and NS=0A=
> attach commands won't work out of the box because we don't copy the=0A=
> ctrl_id. It seems like there's more commands to be careful of than ones=
=0A=
> that are that are obviously acceptable. So, I think the prudent course=0A=
> is blacklisting by default until someone has a usecase and can show=0A=
> the command is safe seems and makes sense. For our present use cases,=0A=
> the identify, log page and vendor specific commands are all that we=0A=
> care about.=0A=
> =0A=
> A git branch is available here and is based on v5.7-rc5:=0A=
> =0A=
> https://github.com/sbates130272/linux-p2pmem  nvmet_passthru_v13=0A=
> =0A=
> [1]https://lore.kernel.org/linux-block/247eca47-c3bc-6452-fb19-f7aa27b05a=
60@deltatee.com/=0A=
> [2]https://lore.kernel.org/linux-block/e4430207-7def-8776-0289-0d58689dc0=
cd@grimberg.me/=0A=
> =0A=
> --=0A=
> =0A=
> v13 Changes:=0A=
>    1. Rebased onto v5.7-rc5=0A=
>    2. Collected Sagi's Reviewed-by tags=0A=
=0A=
Are you planning to send V14 based on nvme-5.9 branch ?=0A=
