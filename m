Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AF1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1223F20737
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jjY/lDpC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tJwSmxcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGFCJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:09:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20009 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgGFCJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594001380; x=1625537380;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pkhBft5F+of+su3hZtaXXTaDnUM0MxH0NWhWvSHvoJY=;
  b=jjY/lDpCdSt/Q1tTxmcswpuus0eZuSKZ3MP4KPX2W2kicBJHYZIDtWQT
   tzMTHWh5dbjLQsiT1/q1ZO2MKxEGFe1FBCRXDn7aKfnTw4UCLDaMdcLHl
   Y0eA6T62V+OKiLM4CPZAN6aZW91yMKhBGCfAN9VMBE503FugnJM3du11L
   xkIWvhhEuHMqCjkcETXfl9MI6poJuhqgAcYalnYXmx6xQcu1HDVcJjr2r
   iBjBZMFXX8AkHnpBiQ4lgGs4FNjkffkgvA9gja5LUALf4f8aUw2mi7enP
   zk5JMErcYatMhvy3SL2iZ0yv3axHloevT5j26wxmouzdir/nRN/yAnEZ+
   g==;
IronPort-SDR: JucXAV0TkhWg34BiF8ArHXwhUSsv/Er3lKDE3NBOoGSl4ErsCzO1EDKQTH3V/VKg8eg6/kYXCf
 AbBaN2gsEefLLlkCmM2aMBnfo4ZgE+MKsGLCtS8c571uG0K7qVYJRl9d7mhqDN5RtS0p4ccZoq
 vvhgfnT+i0BQGEDeBVeZxYUDJoWkNJt02VdqTSlGMNfLqJ2moG+/XrX/NldDMnv7NjAORK7njp
 WUAb959udTxnwmRce134SjLSY9JL8PBqfY9CIJAgEdsJ4vgkVWwJqBj14x2+GgtdoijBji2Za1
 i0s=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; 
   d="scan'208";a="141879195"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 10:09:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggEvfQmOOk4xGaa32mg11PZ9QwmWVtX1h8Iu18kMnW4ixWFetLMq2K3a8vLbLfKXnkQhm7xhZurNHIa96MQq0eQSB8DlN9cDMjqrWXzQOzzOZ3uxyFfKUdT8LC4G4A2CIhygSdcp0afp6fN/S8G8D4sB2Ymj5hUHuuTIRHrYP6bQkub3SLf/Eh4bvMtZvvOvLfXYFQwnYP2wJz6vIb/hvq/tQjYxblv5AZuZapSDB90qlK8U9RAHMiPGkK9l+k6S3p04mF6lXCYEAeJIOcG1VBEoorjsb8FtVKUIB8AK/xIDgKZRxxlaa87mSFGjTWwXHDfPjo7mHJuYnzxtMblyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkhBft5F+of+su3hZtaXXTaDnUM0MxH0NWhWvSHvoJY=;
 b=YaHJw2KvSfCkJxphBRes5zUw2zRTJZxLimWs+Xl/vCHku4pAb0/taOLSEtiPjJTrkCqd5VLg7gil7mAt7UcD4yGV9V7Q5YtwLBNwJBR9ajNd2n46wsiQ3E2aIQLWl2wAklDKifEhlfI+obL+zW3I9/gkz5/rLRRNndOw/bfqTBWp10HsgkoBeFi6+fkp1CKPtKah51q14S2LKZOGvvnYQBZr6nMqWPFFkzQgzJ7Kbs73uNn6fAT1SkysbmZXkO+ydZrKPpoCC5z54kqOfu1hGeIvhhCiaPmawjHnylFUGYfC31Lkrg+txCasctRp3UgDxDpTcBnMloxszpkVu6CCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkhBft5F+of+su3hZtaXXTaDnUM0MxH0NWhWvSHvoJY=;
 b=tJwSmxcr8UKGrD43noqeZ66zy6VNAGeYzEujTz/G0NJ2uQtMvvJAthQ4oJXPybOkYAaTG/Wf7bayLv10L2XnvoNN7jERlo4k5On2qlapGxs0w+XQ8NM4IInRRUSSp5kQEnQpce52iORLM/XM/CzdDM8PTq6vVlgba2gFaPhOBqA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4664.namprd04.prod.outlook.com (2603:10b6:a03:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Mon, 6 Jul
 2020 02:09:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 02:09:38 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] nvme-pci: Add a blank line after declarations
Thread-Topic: [PATCH 2/5] nvme-pci: Add a blank line after declarations
Thread-Index: AQHWUOVJO1pSqtieZEKRrmw6qdDHLQ==
Date:   Mon, 6 Jul 2020 02:09:37 +0000
Message-ID: <BYAPR04MB496524E129709F978AA0DBE086690@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <dbb9c52aeb4030387a17342ca9e76fd09d84a0ed.1593743937.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 702c0d00-4b4c-4e71-adec-08d82151a2d0
x-ms-traffictypediagnostic: BYAPR04MB4664:
x-microsoft-antispam-prvs: <BYAPR04MB466417AFF40D4E22F591CBA086690@BYAPR04MB4664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mkTjuXjcLlPjlD2+oIIwqUUxWBYkqbvC26mZUmcPgAYgcwNM7UOLMrRq1e9jqbijZA+9qN22ntPIHHabqz6oG0r7Dkvqeg4tmkLQF8iaYLA9KYPpnfofzNgru0jFYt3Rfc3ZBi22BfMyJGg9CC6i/2lq5d8RCONDjBOozqzDi1nKrfqZxFqrHvwsUd/rvK5ki39X/zwCP2JQa1OzknUnbWI1HL/0o7+52e38LI1FE0PlvQH2GZC9qPxZejH8c137+2RLexrI7vZ+Oxf/kNvBvYuukG6rflP0EMt8n8g4b+uPGWLqK14Mz8oUQS95R4ldDZPT2/7tRse+/DZg35F4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(478600001)(8676002)(86362001)(6506007)(2906002)(53546011)(5660300002)(54906003)(9686003)(316002)(71200400001)(110136005)(55016002)(8936002)(52536014)(33656002)(76116006)(186003)(7696005)(66556008)(64756008)(66476007)(66946007)(558084003)(66446008)(4326008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pYKy9KswhvYt+iF3cFJOtz9dF7eUbRLFmitzCHx7+b16LO7Kv5xBNv0ecWQ+Q1Xf8HDdpv+wDHzyL1rtnbTUOCwefyVsFCTe5di5wk1D7O6Z2kHL6llax3XIEhveuMpZoIDEhS8mlIuzNEG87HW/H86L6EfoxlyWf8x87dNC/8TbRerNkS8gkp6lQHmdnFxzkzHZFP8xLwOU1TNcdIiXgIssheUzUicz5duCiJKo3s2D9tecPkyYIqUpRRUfieiEvECF2dBSFgvLiYPFByxFLG58Bs1KDWnozZIEwb0mUjnQ6TPpKXy81vB4LVgVKnXr/f8iO82OmWwEcS+HA2TTQJ92eHvDJ3OGVIDvtouNDZDaN3eT8ooflOngEofYrvKg6dQ/Zui9xpnD6J2TKM4baq3xt9XFHDILHomwGvpuLf5xofJgo85xJI4LCJnFQPn+lASUA2unUaa4xSpce8fiuNRBsvMWGlvH3bw5/nSq8fE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702c0d00-4b4c-4e71-adec-08d82151a2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 02:09:37.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3G2/RAwuXnLU3V9XShI6J0hg6Sm2seVkBl3YYieOvNe7txagA30iXrR0TZxyL1DtFxTfixv6qvXg9H8wXHauw91ARBIblc+3i/LL7mcnU1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 7:54 PM, Baolin Wang wrote:=0A=
> Add a blank line after declarations to make code more readable.=0A=
> =0A=
> Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>=0A=
> ---=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
