Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6558C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B033E208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YtOmMmEP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tWtijVRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgFRRcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:32:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56936 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbgFRRcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592501528; x=1624037528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=50h5nqlSxkZYqPNcUkA7D84FRuiHVgmoztzin33Qr4s=;
  b=YtOmMmEPL5VtfyMtcMwvqGr2Abmomb8dBPb7rYKHZzbQ6jeZIVG9XZSX
   eeriDtgQcAdGx5+ud4f8vCYVj4Bo9dsyGBbw0rzLttDlIRFYXH3exBwbH
   vvu7L1WoyiB8UUtd8cqF93kdd+24tsML+xBIz5RqgMNarRu17Mdppcnf1
   4n2wBvOVOr34LyplSPQecModcWcRhGdum0+nHuamD9zB0DJ/wInmK3mla
   nzvzEfpI6bO1MH+TcglsKBwIBNzEszq3OoxTSHKt13Owjz6fW17L8wBGn
   qWL/Spm47nEb40+WFmn9ddJ8hWAOmzxO764XFToXrmHaJ4+CW4Iut4tGs
   g==;
IronPort-SDR: Qde5adOLqZGspqZQmofIG7rkrE8qADI9Pfj9SgR0OoHt2avy+4K7RJNjmNu+v8OPQXhLskYbLy
 fuhWlZ8Orlk+4co5Nzcz+1mCbyYYJH3cA1Nrh6LNRDVBwNvrmcm1BXGM4v2COTvmsTHAczjWrA
 XsMoWmpxIxcKOAf6dXpdnygKs9l8e5U73frdrDebuM0x7OiGNFNfbL6rrE0TRicC+NqYlAkMIq
 2SBy4oBNt5kQNhhRzbN7VkZeGfH/RcNGyGjOqzCJK7gF7VclyB7BZiWBinK7kV2C/9z4iKUNg1
 xMc=
X-IronPort-AV: E=Sophos;i="5.75,251,1589212800"; 
   d="scan'208";a="249522972"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 01:32:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8vYHDn3QzBEDYJZLe0slco5xO+VT8i2iX4tVk/9Techh32T5I2OpVbUkT7e/mksVPGLBaJmqTVvDyDlO2c0aW0vkTq/yGHAaowIs1AdZb5IvpaFSTqkcI7zWcmU5HsFZwyLM58jpVNLO3V0EfqBgr/k3inw9A2jAHVqyjTIQ5Jk93atnL5durlac/kKpxdQDj7hXgV3MIc3b4Rz7mRPMTPJXWraDykmIoxh3Gt+fJUSkwlCIP+C/okctubzib8c5Fh81Oy2NrR86dIDi+AFohDfMJWXWblOU/VQRb3OVNufLhaE4LHyInhmXZdJbfpPdJ+d+QYOoUl/RdIXwMn3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50h5nqlSxkZYqPNcUkA7D84FRuiHVgmoztzin33Qr4s=;
 b=ijxjZu9YLeFIqNbh/+O7p3dpdQb5q1A+NJaeSVIMGKQR1fuH0a5tCSr77jOZ0V12nkUyyzJ6v/uS6qGYfgg1SE9qgBXFWYnFTWorjTuwQI5QL/P2pVah3GIRiRn7oltFSMCOqgfVuTSHSie4fZhcZOXDc4usGetsZbPgSU9Ip8VChMwLfdWV3dNi7w6sSi1PlqRfiAS3on0DXG4WNNjBIz1k7CZ0vgvW3JG0Qb0zZEJOr+DmX0FpLDNOMFL692hadaNPtU19pHxXqgeDLANqjcwwqQCHSC9zXl9rKQeiOpn0N5BIa0jCSr6KSQ8aOyx+vxDrDofDb0TtqmCCBTbrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50h5nqlSxkZYqPNcUkA7D84FRuiHVgmoztzin33Qr4s=;
 b=tWtijVREYZW3DEXoNEvYH+G/hgKkVFcHDnFhPwZ0h50Qs90zpyNgoECIC9iEeQJqaMaUtvQB4gsfBWnZsfJYcPmeoZW5p2676ex6uz614d3HjoyvlEisCaHYtNQl/zXtenHN8WMgpe/WLCKMmASKDGtjAhELZdm3XSDA6OBOzVI=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB3831.namprd04.prod.outlook.com (2603:10b6:a02:ac::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 17:32:06 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 17:32:06 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvme: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Topic: [PATCH 1/2] nvme: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Index: AQHWRX1XXAlREGmmbEiRo2QL+5fiJqjenAIAgAAFx4A=
Date:   Thu, 18 Jun 2020 17:32:05 +0000
Message-ID: <20200618173205.GA1068826@localhost.localdomain>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
 <20200618171124.tfowb2ejv3bnvxr4@beryllium.lan>
In-Reply-To: <20200618171124.tfowb2ejv3bnvxr4@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3ded357-59f4-4795-9be1-08d813ad8558
x-ms-traffictypediagnostic: BYAPR04MB3831:
x-microsoft-antispam-prvs: <BYAPR04MB3831E9E2E55C00AC9BFFCB4FF29B0@BYAPR04MB3831.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZeT5dRTPDxENmqY0NwE/fYWkytPBAHkZ60r52325VFtllb7jJy1lsdpId9kKY1cpw4cU+Ff9+yZ7bQBGHkq/ymNBPdrSVzvb2/f+UZJ6tRXkVXaJOrNa2aQpM1qiHYzhSh/gTLcxUDHywHQby0fWCxLIaa7wP+jZ1dYX1k/pFddztqydEwaLeoyr2NdlvJgOtNVtHpssn2Wfbc6rL5n02R5GeLq3kHjJuICrJO2EY6SLfQuwyyuAuCkg7IzA8weTSBo+G4cEdR6Fcjv9nLjDnOSm4/Ug8UE2oFAWiu+cRUF9TM1U/rQWMlRqWgJ85ei
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5112.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(86362001)(6512007)(9686003)(4744005)(6486002)(1076003)(5660300002)(71200400001)(4326008)(478600001)(6916009)(33656002)(66556008)(64756008)(8936002)(76116006)(186003)(66946007)(91956017)(316002)(54906003)(26005)(2906002)(66476007)(66446008)(6506007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gr5dOy951T1e48k3qq15aap8+UZBAKUAeKib4AwRE9lQSQmsLLcVnkgjRxHqH1DoKWEEXPFkpeQgelmrvmb6OHJ0/VkK9/RA7HxoUgXbjADgT3qFu4Bhr8goUHAY+6JwFsvhbFl8XAu3E3MJqAyfThRBAQ3QeLt0LDFp06nsPEASS4lD7rcfBt+LCEmQ7OSgiZXU2wPpslZs7yAQusH101N8pWJxH+AOnCXMnLWSEQyehsyruFADMdYjzipawLPF4VKE0FCDl6I4BADt8Af2vXlLJcq4s8W6aK7sZn3aAJm+c1mDZf8yDP+qws7oCBHDqif8U7E/94j/r1Wrx4Uhe5LBGEVZUFV4BV5lj6S6EKkuv1ygc+Ts8ycIA5/Li2QkDiaFulMiSXpoAvlDq1QOTiwTCf30uQsOSCIYoL2JVXBkNyV8FD6c6xM41o1jBQC3KC6ZUzs7dF13b7p2MuRlezHGUAJ0GFPikrpXnInSsuuIYpegOsMZJ4GRryWvA12E
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7227DA71290B444AA8A88D901583F669@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ded357-59f4-4795-9be1-08d813ad8558
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 17:32:05.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNYi3/4jwBjaZ0Vkv/sA20VHrfgzQeXO8GWdmikCMe+rWI6sLVJrtI8ROnLwB4ftDYccqNdi3TEJy3xxCEIiKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:11:24PM +0200, Daniel Wagner wrote:
> On Thu, Jun 18, 2020 at 04:32:40PM +0200, Niklas Cassel wrote:
> > If, for some reason, we want to allow builds with gcc < 4.6.0
> > even though the minimum gcc version is now 4.8.0,
>=20
> Just one thing to watch out: the stable trees are still using
> older version of gcc. Note sure how relevant this is though.

While the AUTOSEL can be a bit annoying when autoselecting patches
to backport that you didn't intend, I think that it in most cases
backports fixes that has a Fixes-tag, which this doesn't.

Kind regards,
Niklas=
