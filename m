Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B0BC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E1021927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="G6l98F+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgCJUqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:46:00 -0400
Received: from mail-eopbgr1400094.outbound.protection.outlook.com ([40.107.140.94]:60844
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbgCJUp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZpBG0+to/4OaUic3ora7y3MSupj9pIb2Dz0Z6cdhukLNLIicXA2NBlGxQ2mw0R74FmeAXqZK+aWCEcDcbe8u1eFCNUlL3em/4kooGS/qs6NgXliT59ySk2AvbFkEYsR9O45mELvpVpu4NNidzCfkxnavsVNzV81viIBq7GmLBQkS3jR20icuLjlJgsnAocCgzEoxZbsRcYfPyZ4TSFtDtX1sBm0bR0TpmGRyrs+nxWqA4b/jhPxSKX/lrMze7uUW1Q1iNtzirCnvkUDnOcJHEGVY1fF2Kvka0QhYCc8yLfTdU++nquelzNPUYC71L+OXPEbwpmL8gkyGunU+vW/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqHbHuaWGCr5w3IM18M6srB9hkn5UhStJTD+DZ1UE8A=;
 b=TR7P3UIrkM5tsIE8KxaoKPpEdqiugi+YHIQx2E97pb2M0DuNXr9eXeOFeNhzk1tHgPM2T1o8WL6PHmIrYJ/WYK3FcjJb8+F8tELy+2RiJlN1Qe5QxMdMreuPCKjj4aPBuEUWIUt8dmKfI6kwwVUjtgvfESNUCX2WYVhfFgCdbrNbGzH9k+bVwFHr4fstJjLKIr1sDum2Pe0Yzh2CS9DRROiMdcfZIRopleToPgoAZxBxRwGvVcSNSJJDVUo/Szk+EBMI1vKm7CFN0qDi7UeZTf4n6V2fDGB8w+FWxjEHWww/lbolATASeFzrr64uPIhSSa9m9VnkfotD9biPImrlaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqHbHuaWGCr5w3IM18M6srB9hkn5UhStJTD+DZ1UE8A=;
 b=G6l98F+XoKCGRJNrfFG91xMbTy3oAwF+NFOG/MJJMqyzByqiCF7FxCRNbu8ibRoaq1WVfyGEJ8sLf8pNF++LQVsT8ZySJU2AOdQRuj6azPmperAH9i2dbPvUfizGA71QZ5I7AEMpJMRZTyAhEW628PCT0+LdLJkaPcZLkhniwkU=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB4822.jpnprd01.prod.outlook.com (20.179.182.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 20:45:52 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::6df0:eb47:a259:b94b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::6df0:eb47:a259:b94b%7]) with mapi id 15.20.2793.018; Tue, 10 Mar 2020
 20:45:52 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH v8] dt-bindings: display: Add idk-2121wr binding
Thread-Topic: [PATCH v8] dt-bindings: display: Add idk-2121wr binding
Thread-Index: AQHV9xOlCc8Y9xnvg0ugmqANfj2zpqhCPT+AgAANyaA=
Date:   Tue, 10 Mar 2020 20:45:51 +0000
Message-ID: <OSBPR01MB359023719B67A166C3502798AAFF0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1583869169-1006-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200310195425.GA23440@ravnborg.org>
In-Reply-To: <20200310195425.GA23440@ravnborg.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30e5e66a-74e0-4866-4ad1-08d7c53405a8
x-ms-traffictypediagnostic: OSBPR01MB4822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4822D3E13B9887D3ED0BEACCAAFF0@OSBPR01MB4822.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(189003)(66946007)(8936002)(66476007)(6506007)(66446008)(53546011)(966005)(2906002)(498600001)(107886003)(9686003)(66556008)(5660300002)(64756008)(33656002)(54906003)(4326008)(81156014)(6916009)(186003)(55016002)(8676002)(81166006)(7696005)(76116006)(26005)(86362001)(52536014)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB4822;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5uKsHf/0/8Rq363vXRjOmQ1zIjm9yirjno3HfnlUo0/jvWj3j1LUPTJcHJeRiYhEHBCOsmN7ErL9xQ/c+fEe4kivto5hod6ulyxrw7A11IYdMGF++TNbLZs/Z0y+LfkREqA65HxV47xMEmPm6REGiZ1gbvAWamlzt5KriIEBYXnJKiTcsFdzQGSUqwQM5NcaDZ18V7EgYOI5CqS9RLRVjgKFq9zFib66htx2NNg8+4ovwgoxQH25QWjQisQGQIWMqOh3XaRwXidWGKm0Rkquet8u6Jl9cVDhaDeb5nXDD6hXg3MeRtZ85m/ecESyLcv6iG676gbEKIZexdTzrBGwnVVoidV5ldxlerTzWqZJbULWUbPYdI6d4iCJBVsGpcr81uImYo8z2JOKod9vNU3E69wOQ+HwZzi7t5xKCSZzuMpaZp5QlVHrIb1m5aJiGwEK9p/raGm2PDN2Kr8+GyhbAgw8BqCa76+Ay9apfMhD/EPUzUaqmtSY1fqsf4FFmbIFkCKf7oLPy6eLGbLRf/EkGA==
x-ms-exchange-antispam-messagedata: 9PQTMixdNYeUvlFclYgur9lNOStSLUqjE7HetoZsEBiDyNdM/XvCph27edv8/mqe2aiZkEL53UX7JH3EEbx+hSsszrN4O2a0IxpAqbaqrwk5NEpd2JEVqluyUz4XzytXwT9YLLIC8T9hW/6pphPhFg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e5e66a-74e0-4866-4ad1-08d7c53405a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 20:45:51.6293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DAtfyii9n5onfCfofYcu0rETk1JMgAQGUSHC16cX/0QsO0s/tC2R8X20Ciq4qK3AbSRITfaf6pS6ZrdqHpwVhMEloqqG1GKXPu6Jk+hIPV/+prBOqL+TsYN4x+YP4bp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

> -----Original Message-----
> From: Sam Ravnborg <sam@ravnborg.org>
> Sent: 10 March 2020 19:54
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>; David Airlie
> <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; dri-
> devel@lists.freedesktop.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH v8] dt-bindings: display: Add idk-2121wr binding
>
> Hi Prabhakar
>
> On Tue, Mar 10, 2020 at 07:39:29PM +0000, Lad Prabhakar wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Add binding for the idk-2121wr LVDS panel from Advantech.
> >
> > Some panel-specific documentation can be found here:
> > https://buy.advantech.eu/Displays/Embedded-LCD-Kits-High-
> Brightness/mo
> > del-IDK-2121WR-K2FHA2E.htm
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> > ---
> >
> > Hi All,
> > This patch is part of series [1] ("Add dual-LVDS panel support to
> > EK874), all the patches have been accepted from it except this one. I
> > have fixed Rob's comments in this version of the patch.
> >
> > [1] https://patchwork.kernel.org/cover/11297589/
> >
> > V7->8
> >  * Dropped ref to lvds.yaml, since the panel a dual channel LVDS, as a
> >    result the root port is called as ports instead of port and the chil=
d
> >    node port@0 and port@1 are used for even and odd pixels, hence
> binding
> >    has required property as ports instead of port.
>
> Looks good, thanks for your persistence..
> Applied and pushed to drm-misc-next.
>
Thank you for the review and acceptance.

Cheers,
--Prabhakar

> Sam


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
