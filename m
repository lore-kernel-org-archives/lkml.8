Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C16C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6C020C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WHHE83eC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YG2ulwZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390042AbgFXWkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:40:25 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54234 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389143AbgFXWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593038422; x=1624574422;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5euSSVb1mYmYe+gpDOG9ErBSVRQxh074Zs/+PDR0fps=;
  b=WHHE83eCV3Ca/gL1v2e2HjRHREoa+KdSPNh+LEqA7mgqGUG4UOQBcMOY
   q9e9TuaAouyyWQXolj3zkFn9o2i/xlTF6g874xuGDapd/mE2++yDmSgTJ
   0PVHXNoMBY8YVUEfM0hnxuWpElsYLju99BPtavw21QtE1suVsYKcvjh/t
   aJmko8iMnfyYgixG0z2lXMCW96mNlOedY01u5rwOJEois+SyJI00QYP5S
   +9a5j9+xiLbIPeZWAbNgCvQQbkAN4K8P7x112qyXqnTc2haRcqZNeRdX0
   PewpaE1vYE7AWjNkKSC5s5n60buDMMUptXJ8m3SmrmYotVGSVVDIEEdIs
   A==;
IronPort-SDR: PlH3to+mgPMB90mU68GfXX9DSoH//O5JsuW1V2muoWcGChxlj31tfc6HkQg3oXhIJWG5eeBEGT
 rpo/lBPLsTxd37Hhw1fxm7jdr2BxLgBMTkLJSr4GeTWIMnoIoSGDTOtaRbt5PxDU2p/Ox5LBRt
 biSJ635ahtsYcPkay411pl/0i5vcTLnB0tWeRSn6oVrlpZ/dVlw/Aq20DcZbpYvo9VWV9tZxb2
 ctBaJgcDJ0KSyC9PQg5l33TaNTbS4s2KAbiAXCGDFOlPAcbWScIL2eaYFBvrrZuvc0SxzpSVPM
 TYg=
X-IronPort-AV: E=Sophos;i="5.75,276,1589212800"; 
   d="scan'208";a="250058055"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 06:40:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N96VLPK9oszIpIMbKo1O4jyhC7OTGcldyzOUUChI5xV4Yw+49NGViJDBtOAGXMapyngzLkcw9gjJ88YsMgK1c46WFxwcrwDwN0LL9dNX2TFqG/2jyvA2/JsizBHJH3fI8zBDLxcCLP2CTSrKUq9ItZw3NFsvkk7ehRH7w5uPl8oB62Y45MxNC9zbzad4a7hGAFomnIyT3LPSFqeds6rSUvJfHV52tjOVuxGk9q6HmrObO8mfsVAqRpa7NoOMTdNbFjcnO0PWmla+XzPNptk+6KHeyaW2jX2LC6XRfqXoHbSIZS2VLUcOTC0/rmJVh6bp5pJPOnYTKuGfPg3tBhUODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR9cU4ON1j/uGGIdtSJImB1uBtXvEm/p7e9YwnhH1Mg=;
 b=ifUwIJvoJhx/VT3s3WpzZzbwoWl3lEvRPqpxUV9fMVCvorlajyB3kUiyDy8ZTttyXb35qgvsEmlPdn4TxBZ4CfYRipHukpq7Kg7qqAIpTca4Vk8fFqiR2/fcCc3dzaLGEmA6Br+G09j0gp0k7G0HRlzYIlomHRAp95Pw1XOPG3x7Kb9AhDDbp9KdGP+3iTLs3IROwda3zBbJt+4VzEBR8zmM44tNKAyU68lIjWZu0v3FNXDhwTuOn8bh+deB+XvtNEcgZ/ZVaZ97z1r7KEYFTnpCkpdMlBFok0HtW3nZhr87lXJTdIJn+O41Vvm2ltf9SDqidrbTLbJWpsgbu250RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR9cU4ON1j/uGGIdtSJImB1uBtXvEm/p7e9YwnhH1Mg=;
 b=YG2ulwZ/hxY04liKUwVAEdHKMUiGKEyGWsAlyi9AXuJp9t68FOrVCIgOLtSH69L+QFelrsliWN9xtjD4xZuWkc7nqm97RA9KySZhT7cgwB6YzJoxooaxWSmYxxszB8wPFCO3b52YM/3qWi+vulDjsDoSqGjP252xP8vVnnlTgWE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4664.namprd04.prod.outlook.com (2603:10b6:a03:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 22:40:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 22:40:21 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Topic: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Index: AQHWRats4KkNpfsaUkiEB9dxdlImtA==
Date:   Wed, 24 Jun 2020 22:40:21 +0000
Message-ID: <BYAPR04MB49655BD99E428B66EBB831E486950@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
 <20200624164441.GA24816@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cb668ee-b530-46ac-617a-08d8188f93ce
x-ms-traffictypediagnostic: BYAPR04MB4664:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4664C4D8C06024838653B87486950@BYAPR04MB4664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 517OF7IjKHQHwPpX3092bqykpnsn1S+C7u2TUvJwaw6sIku/8nTJB9QKIkwi58W4uXzdhs3BfQ4BcfA48agf+ulAlFWicpeQXWz7HHX3wf3IXqPn/+txvyNivuWWMyPdmko+gwD39jcz60Ve4ZJzIggO0AszvEEIN7muTI2ucGWsG5dIVOJ2Pjqbne9dMVl5vFUuvM9ADUuF0B5dVgu1XXxfh+39Cat9zI8nhIyekCqkL2CuuGTf6Su5RxE3NOglBgCnWZVyHAWjQvvVi3oqeoRICj4PqZd1wnoOpqWY01YV9LKZBdiDQx7mJCIwjIF6xYmlkg7/0pP/qecYu/fuGxxbdz5qcZb+FpYeDIy8JEK7EP1vaqG5xdSHtqidnGc5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(8676002)(71200400001)(478600001)(33656002)(76116006)(55016002)(8936002)(66946007)(9686003)(86362001)(110136005)(66476007)(2906002)(64756008)(66446008)(4326008)(66556008)(186003)(5660300002)(83380400001)(54906003)(316002)(53546011)(52536014)(7696005)(6506007)(26005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eJIFVcZ1vvskxMQhLTs9yjWPzujziVMskVRtCe96Qy5RB03XE7kTzWW8nl/6a3kufKrsic45xPusfjDXre0UCBxfr1ilXPekLf8yEY6FHrK5sEXTlQ8nV8+HygU5QabkW3Uea/MxmwkbuHIAGCvwouo/jj4t38UU/M+ONxMvYQFP9mKtK/G5gz5cbhK1RtPrejBxbWs0mUS1xFxjtS0lJQHgWufgVJqnFmOxYRjWxE7M5VN9NZzK2MrUjp2O3BcLr4TpcZdLHEwA4pbl+9qBeKJFbCgmgY5W5ejDKArjbQiNC/Sx+fWpdandAhRu3hXqk4gtJJwgLNqvBLz66MAM5vcmhS/xNv+T/98+Yv8g1/Ugkes9nN/mr0j/Fy6VvhRHwe/28CqGcXObzkaODf3ZwfqhzPLYgQ/x7xD6qsAr6XmrId2WY8Rs+CvJ/3aZrI898qGhlJ3t0XWIxUXzhUEMBB9zzJOQRi6sGRoRQ24Z1pk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb668ee-b530-46ac-617a-08d8188f93ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 22:40:21.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpiZ9a+jmfs5U121em5eTRILP6ciEQde6pgPPtkvzfzzOC6mVZY9D38xROC+dgTVsx+2n2dbdVjY77UaWDBTp3OjTA99K0vPaduV9ZzRrcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph, Sagi and Keith,=0A=
=0A=
On 6/24/20 9:44 AM, Christoph Hellwig wrote:=0A=
> This looks good to me, but I'd rather wait a few releases to=0A=
> avoid too mush backporting pain.=0A=
> =0A=
=0A=
Here is a summary, for longer explanation please have a look at the=0A=
end [1] :-=0A=
=0A=
Pros:=0A=
1. Code looks uniform and follows strict policy.=0A=
=0A=
Cons:=0A=
1. Adds a tab + more char [1] which can lead to line breaks and that can=0A=
    be avoided without following declare-init pattern, less bugs and=0A=
    no pressure to fit the initializer in ~72 char given that we do have=0A=
    some long names and who knows what is in the future.=0A=
2. Issue with older version can lead to adding additional braces which=0A=
    does not look good.=0A=
3. Writing a new code becomes inflexible and pressure to fit initializer=0A=
    will not allow users to use meaningful names in the nested structures=
=0A=
    and anon unions.=0A=
4. Future patches will be needed for backward compatibility.=0A=
=0A=
Also code is perfectly readable as it is so why change ?=0A=
=0A=
If everyone is okay with above cons I'm fine adding this.=0A=
=0A=
Regards,=0A=
Chaitanya=0A=
=0A=
[1] Explanation :-=0A=
=0A=
I'm not against unifying the code. This will enforce struct =0A=
initialization to be done at the time of declaration and is inflexible =0A=
given that we have different transports and meaningful structure names.=0A=
Also, no one knows how many new structures will be coming since protocol =
=0A=
still has a room for improvement.=0A=
=0A=
Consider following :-=0A=
=0A=
e.g. 1=0A=
=0A=
static void nvme_xxx_func()=0A=
{=0A=
	struct nvme_XXX_YYY_ZZZ abcde {=0A=
		.member1  =3D line of the initializer calculation =3D X,=0A=
		.member2  =3D AAAAAAAAAAAAA + BBBBBBBBB + CCCCCC + DDDD +=0A=
			    EEEEE,=0A=
		.member3  =3D AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa,=0A=
	}=0A=
}=0A=
=0A=
e.g. 2=0A=
=0A=
 From code :-=0A=
+	struct rdma_conn_param  param =3D {=0A=
+		.rnr_retry_count =3D 7,=0A=
+		.flow_control =3D 1,=0A=
+		.initiator_depth =3D min_t(u8, p->initiator_depth,=0A=
+	here ->>>queue->dev->device->attrs.max_qp_init_rd_atom),=0A=
+		.private_data =3D &priv,=0A=
+		.private_data_len =3D sizeof(priv),=0A=
+	};=0A=
=0A=
In above case (e.g.1, e.g.2) we loose 8 character =3D 1 tab for every =0A=
declaration-initialization, now if we have a member to be initialized =0A=
with complex calculations then it comes down to the next line and again =0A=
we loose 8 char of tab + (number of characters =3D name) of the member =0A=
(member2 in nvme_xx_func()) and whole things looks ugly, in contrast if =0A=
we do it outside of the declaration we still get 8 more characters =0A=
before we reach line limit. With 80 char limit we should avoid line =0A=
breaks and tabs as and when possible, this policy goes against it.=0A=
=0A=
=0A=
