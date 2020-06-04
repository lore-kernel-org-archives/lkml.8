Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5950FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C96E206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S+0ZZeEF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YPqMINu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgFDGyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:54:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9536 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgFDGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591253659; x=1622789659;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7VwoXqyWdPrk1BZq7hleWaNmZXYoXElAIpudK5dOl9w=;
  b=S+0ZZeEFNsy9AmwrMPAlPdTvepsXQUPlOoh/C5dNDb8CVkb4BpAVmqLn
   y1xi7+OJf51N07WgqaC/Gj/TYAPUUXRIYwyGiuteptWXz4kFjlhuwgv1k
   MpZnkcUCa+BvQIA4NfbbqGoP0W8q4yQINT/RbRyx5GoJKzatCKUnbJvSj
   SBQPhuKWI67I5+Xn6xJHP14Igupn9PM420qEu36EiPK6ZFdsBulV1cyiR
   3eZJLjSZufK4MvR6oEETQvNgEPFJATO4pE7ltN80kBL9DZ5haHyqCDM2X
   3in1tpdzMFLS+bbrWa3eLKFJjn0waxvWT4MtMHVzorzONg+pBVGYd4D79
   w==;
IronPort-SDR: i7DgDgNievU0AX3bTaBZfH7X3R0E29bKykT571zLDAmWZ2wXiZ1V3AKWBbBBNh259WCkRNcQUe
 bwPvRX/XPuHPA2HnGnzJRKsWo4MMZcBY4EGqw/Uv1t+qSl47Xujr3Jk52DcETphll3Z6UfBGdj
 TV6xQihKU4xt38XIWiV9ptHHnoSNuqgIHG707JH6IoZnd8iOppHj/hRn8T+Z0F1wx2IHVqwQkI
 Qtm9v9gURfD09g8AefUk8U/0oqXSrey3mYA8pTYnbX+Sk00GRkbEM+sQ/mVwdNy/HgrFkgAj3c
 Lrs=
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800"; 
   d="scan'208";a="242046900"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 14:54:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAsM0fc1umClmmimqe5phTLCVZrEDHu4x2NjL+6SRFuhHXVpDsS4yHsSA76pRW12+3krneWG7UKmm6sjB7KPZGSSP0YMs8velS+OJlS++u2ku+GdUWlM+nqos7YWvhmToBnGh+u88gqylHDeSEtyaKf57xn4tgdqPsUSrtSL7BtLGchlJcxsR0WeZi31s+I18hQngJYVqMkW1+O4sL5R+/x+jPHPXpddZIqLzJ1LXtRnYE9WcOW+BxWUdgEm12cTLKIEFgHh2NEm+AZ8vHemGp2IHWf2ny4LJhRFtZv5siaMlKITukkNfWe2VjLNxnOALkEbClC9IXjuNf4m7SeWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VwoXqyWdPrk1BZq7hleWaNmZXYoXElAIpudK5dOl9w=;
 b=FpBA38bwhua+9oiovFKSSXKLAraBdXEv01V1HqykQ6ip5GyQCSYpqsO9phoZINmNBeftzwCIKKyxMcl80xK1zMn5zQjldCq9lRPiRxXJ1Xv/cHHL3nkOLONZ+R4kGJtJW+EMeYEMRRrFkxFI7ZqTF6qN5JkVRN472J67uecMMmuOYM2BVnHEkfc1Kecn+0WETtmOwhg+T6vs8wRxtHyqdjh47YZUbma6iKb3ZjdKwJtMrPJaoK+Uom4RfjBtL9oJiiu2fNP9/uZHyqFkfvlMKj500HxuNPzWsO+e7xSRxnmg+jZt4P1QDTeaTkBWrwBRIyEf8y45ih8ILefGt3Agow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VwoXqyWdPrk1BZq7hleWaNmZXYoXElAIpudK5dOl9w=;
 b=YPqMINu6NW9KXaIp+O52U1sr0+r2l3w9aj2zoJULT+lnl3tYoDUIQ9PckKvRbu+/mSNoygxFoWgR2mdbMn8VIWMDw/hiSkyj0jmNiJ05WXLTIgTbjogHp35R8RFSRbEUbqxeFKEGtQntZ3avXvEWbR5xpQDy+IBclMcvPlUOVeE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5911.namprd04.prod.outlook.com (2603:10b6:a03:10c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 06:54:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 06:54:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
Thread-Topic: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
Thread-Index: AQHWMxYvcSawy1rsD0W643/8Q572ww==
Date:   Thu, 4 Jun 2020 06:54:10 +0000
Message-ID: <BYAPR04MB49650D649A53B89DBFE1461286890@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
 <38a2cfb9-df2a-c5cb-6797-2b96ef049c7c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67381f92-666e-48b2-e59c-08d8085415b4
x-ms-traffictypediagnostic: BYAPR04MB5911:
x-microsoft-antispam-prvs: <BYAPR04MB591184522F1DFD42EFCB496786890@BYAPR04MB5911.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GV1lCU5ZPyjR8ZCEMpkC8Olu4QunlLr1sLj1U8TQBMJiuQ/tq3hRZhTNAVasH4da/FxNzZzHdvY0mCF6qR/2sfVc+M62MF9XDOrReueSrczsTL1Mlym5JTQwIz+8u4gleL5z59RMWlYcXSxPuXrULiMBXafHYi/fpWkzaAoTIMRfY5eRmOq7c5+igvk/XU3wll7IzPvFowfZiuKx1OndOAETjLXAc3acFDF6f2D0qBtFNvJTOOZMHK6QcSgSgDdSJqYd/YsWcrKoFdq4OrB2WkG7jJZPJexL7aougfDwdGhmbxuUQjBQlGGtq0LMM1gZ8PVkRFnUm07eaKR0wTIl7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(6506007)(26005)(186003)(2906002)(8676002)(55016002)(9686003)(4326008)(8936002)(7696005)(86362001)(316002)(54906003)(4744005)(110136005)(53546011)(478600001)(52536014)(66446008)(5660300002)(33656002)(76116006)(64756008)(66476007)(66556008)(71200400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Vc8TDzgMYP6dhAMgymmK0PMc3+4DYTXWWz1U+SQpC8SEik2RC0ynFqyjkZ/L2fYLDMF7WWB+69fLwiwtfXshwso/0n7ETgatW55Y2JTECPYDLPNEhiaLgxGclieLIzEo0Qca5IyMmk1RO7Q4LhzkZOYhruf9gpx5UgN+eV6l4+J+WzPDU3UNwpdrQ2r+LW9vxCNmlIKNfWfzJ43Fg5qGQonsDxdfGkAaEdvjrEg5gSfWxmMGVhAVCfYsHOzPFHCdqOZD8HSA7E48Okr0RaD6e9WSepcYAs99DZhlAADp4UuehyfnWxdlFD7YvQw+xXPzewPCPggAAfL08B8kKb9NnEN/BnvyEpMrpa17czJtX/YzCLLIPOvjkSkOLkU3Brm7oOdRAN8f2Nrxlio/KIXIOphG11nKbiwYqK+JsNYQqJl+m6HhJlbiegBSWfQYIaHe8LOeQ+D4R373QdbWj51Vd2nezSGoiZLQfTOWjgCezUE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67381f92-666e-48b2-e59c-08d8085415b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 06:54:10.5648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpnAyOx9yPQCva99EUNUBpF3uk+kBq9RD45I5MhAsdh1xXtdn2LURtFWrGKAXsAIYW7o2c1yy6dlW3o1Wm1X5lAsWa3gY2jFUN7wEBkNlCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 11:46 PM, Dongli Zhang wrote:=0A=
> May I get feedback for this?=0A=
> =0A=
> For the first time I use fcloop, I set:=0A=
> =0A=
> # echo "wwnn=3D0x3,wwpn=3D0x1" > /sys/class/fcloop/ctl/add_target_port=0A=
> =0A=
> However, I would not be able to move forward if I use "0x3" or "0x1" for =
nvme-fc=0A=
> target or host further. Instead, the address and port should be=0A=
> 0x0000000000000003 and 0x0000000000000001.=0A=
> =0A=
> This patch would sync the requirements of input format for nvme-fc and=0A=
> nvme-fcloop, unless this would break existing test suite (e.g., blktest).=
=0A=
If I remember correctly I don't think we have fc-loop testcases (correct =
=0A=
me if I'm wrong).=0A=
=0A=
Not an fc expert, but having uniform format for the input make sense to =0A=
me (unless there is an explicit reason). I'll let James have a final say.=
=0A=
