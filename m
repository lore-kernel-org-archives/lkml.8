Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96017C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721EF2065C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 11:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="LHE38TiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFGLUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 07:20:33 -0400
Received: from mail-db8eur05on2103.outbound.protection.outlook.com ([40.107.20.103]:39745
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgFGLU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 07:20:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXOHb+SFjOGVFzK52K4cM4h8sZNCTBkVLDD+W2RS6qv6DHpBq+N8w4gDPjcoH1wHF8XzDawc+pCdU6sj7C20Dectm8QUNIy50n/fBK4CkKLq+j0mt5DXqpVCsR3a9yAhwBNncfTFFS0WYQDJ9XQHTKVgNdK7pXt2unIVc1QS+SSU4XZgES9nL8X3kH6Zy7dQvWTMnXHiEkma/MEJT95NuKQRjBNx2rxt6kfj4TP7pHVNBETRWQ7LRj12KlH7Jm+2B/SRcg0bty7gaFAf9G51PVUeYyRWIFlpX6u1DuHDCr7ylk08aNSJT7xXCwaWKqKB9aH0fLEWqVfERHAoWV5U1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFrDBCUlTrW8skbNZpmuvd0jVSipIP3WrvaOEKYl2Uo=;
 b=hiun1VO+Euw4cWC/oAAhRC2Rv3/AN5tE791jiiqXS/nSly5tpeYYf+ibqnszELTpK5S5pgB38eT0uDUkqGIMm+7aGRIiofImgUHzfA83XCDiN6seiDf6Wok7noqOxbLwZjyjMbC0xYlYOJ+lsBX1bl2pz/ueAGAgChhNttBIcfCo/EW5c43KyWPAzqbbLzb4sCtpMIkitzDy/X4wrr4MBHWTx8f8ErHPRVV2LfrJ1ibn2EXbgNWdVLRu25kShqeCyVp1ioqbSnx0dRGq3CyTbU8qqUUGZ9vaYNf8GK95GFIl8W7sX5mDQEFRE5Da4hlwfRnhlYuQmrixjmCJJGEocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFrDBCUlTrW8skbNZpmuvd0jVSipIP3WrvaOEKYl2Uo=;
 b=LHE38TiFGj+xr6QDyLri4rRZbimtTvH+3DPrT8fQrsI5XwSmIl2QNHRJddNCs+h6ToE6s3RNH1Iwr0LntAS8OMaWblRqvkDDYaHVfzG7Is08yxX9Ak9Lu/qxmnwkpuo4gG77CeyE4HeZs4nlabGfiqUd6e0zhkWq+q8/oQxHLAY=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5723.eurprd02.prod.outlook.com (2603:10a6:10:e5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Sun, 7 Jun
 2020 11:20:24 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713%6]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 11:20:23 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: rename mmu_write() to mmu_asid_va_write()
Thread-Topic: [PATCH] habanalabs: rename mmu_write() to mmu_asid_va_write()
Thread-Index: AQHWPIzW4ZonhZ9LYUmeOYhCXg7iyajNAbXA
Date:   Sun, 7 Jun 2020 11:20:23 +0000
Message-ID: <DB8PR02MB546847632974CE63042C6C75D2840@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200607053100.13596-1-oded.gabbay@gmail.com>
In-Reply-To: <20200607053100.13596-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [217.132.152.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 077fee7e-6a4c-4b75-9a8d-08d80ad4c5ae
x-ms-traffictypediagnostic: DB8PR02MB5723:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB5723C329693906B5211C5702D2840@DB8PR02MB5723.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 04270EF89C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NyXet+sPp/b6Gq4Qf6oU7iduPwzMHhEwgVAocx2oV+a0wEHL8RumlINJj/Q4tK2ZspZY4gLm5eWwoPgc/4izSzrkBnyRdRaGvyWt5EaslPJvohCGCVlUEHzqwfJwFWXry9yMifY8dzApnbQXvJhKwh8z8DkU1esZgWiflOGf5tjA8zeVnlKPAj/Nn4Usbbo36b4dqO6GItH3M98vkMKhI8aypd79Ze4j1i7vTKP5NF9fH9vZWHqNE2pFhVfk3lmHmB//OursKjzoBdKZDnEzp7zpYdemsYGHW/Zs7HACee6Pslb/awrxA5f4SrFoUZdnRFN9sJNjJKtXSW74Yr+sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(4326008)(6636002)(52536014)(5660300002)(558084003)(186003)(9686003)(26005)(498600001)(8936002)(55016002)(8676002)(86362001)(7696005)(66476007)(66446008)(33656002)(64756008)(6506007)(53546011)(71200400001)(110136005)(66556008)(66946007)(76116006)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vbIwAL4UPlxfQghCmEDrChxhQa4/GyWy3CjhJGydWomh2l6/iKlbfpdvYKKvFMrDaZRBDmzKGEZVaUmsQ2PzctFw1ZB+pc5LSEVJdnVOv6BMMIxNKKIISu/MM8zPkfmFhVg7Ait8p7cy4ONg6CdlyEUHobAsuEbQtLT3KUsCjx77wI48V6K/uIh/4YCvjcrERgyA9Z3o47AFdjRIiKOrguRSo239x18led/Ei4x5Iowvn4WETQGtmqm+btPcUl84d40HAxP738M7C35iYVQaK0n6juE39lReYIDTSH7EovZwbC5bGp0Hm9llGF4tzxVPEjvGMGnKH3yxz3KJ7KQ+c/DOsCJR20C8pdp4O7bWBgNsLGGIEggCRDiPiRlQwxW9un08Q9CdoPIuP93+quWZU69AwYpmFrKn6zgnEMEaZWD+klAQB5v+A8ulom+rdLRHuWCpAOoWcvkBqK04IMIabe+ghZQ6wWtsh+Lu8ClR3FKIYHDAbzndp/Y69ZqMFXah
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 077fee7e-6a4c-4b75-9a8d-08d80ad4c5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2020 11:20:23.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUXytGrubDcbzh3ed677VJymVfjEPCZ6j3Hk/SY8CwK2u5vfsjDDydc/3NuzjLTKcgy68kA1Paht0ytyPGE0AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 8:31 AM, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> The function name conflicts with a static inline function in
> arch/m68k/include/asm/mcfmmu.h
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
