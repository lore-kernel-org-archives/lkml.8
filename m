Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43ABC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8773823750
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Hl56BCMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHEQNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:13:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:53380 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgHEPsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 11:48:38 -0400
IronPort-SDR: glV1k55yjq2c/65KHs8xLzoPUszamL+EUCoBQehG/3r/iBWL06/5qdF6z9xy+9dDsp+dclzo95
 c3MU98dRNQFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="140455198"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="140455198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 08:09:01 -0700
IronPort-SDR: vTkOPFiwv4Lxvjq7GVPXOrUG6J6A5lXZUQqseUCTEhSFrwD054rJe2Wnq41Q+Cjitx6HXa6ieU
 NHEws8bjN2mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="330951232"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2020 08:09:01 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 08:07:55 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 08:07:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 5 Aug 2020 08:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx5Yg2qCEOSGF8RKNyZvA4/AJ034eOPS5KvyRxoIYRmdQ/0NjgfO+SiuSmo7D09Eq0h+nWfyS/OGEYBdGGRGLirUpnog2CaO92k8CIHbShyOJ+PQR+23A7rcPfE78KM5Cw3uX9ZW6Yd0jbadhA2VVecOnv3j6o8rCVPxboTD+28zHJnrpRYr/ME4wkwKw4jStSHbs7DZl2hP5hHaJyBEbktCfXDPxQHY1PxfvjcJb6VIevaG3vPdvBzn3n+KeEgbLq40MptpU+4yeCsJXSyzddOP4cA6+TzU4snWaJQzPMQpSwpWryz7QZ3kf7rk+yKKvEZ65zK9AXtEGvo3k75MlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRssAUnNZ955tKEeuGL65p69qiJms2y8wA2DUGRJ59U=;
 b=isJxCPochul5JF0rBL4qi4ukPcJLv6G4AsDSQQdshFd6CPZwWDgo2hTA5KjDsbi7KOGtvg1uTHweE2qOaBlgtBtuh8FgwhzAOwLIJ5hnxHQqjKjdyHlyy8rj+Gaekj8Ufh3NPsnIFe7/jgpYs2Rvh9kEn7VVpjanPKd9FVKWpvxowLzi9nbGtrXrmNY4cNm/VzH8z/FjkvLH41lr3VEyk+hUY2ibydhTMmzOMf7itNodHS1ktoHmg03JB41HXHGjsjaxKY1pwfJvqG7SFuDDeN6MLUHzKqDaDzmMnyrMunPY2BgU/3ukLzYbPlgZ9NrNNgw2sA/XYrzo8FKXDUVGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRssAUnNZ955tKEeuGL65p69qiJms2y8wA2DUGRJ59U=;
 b=Hl56BCMtQB/XZNcDsqkAbTemBfxj19IH2y860M2V4NBJ6KFsG8zACOUCSZwE9pgPj61Itskm0An42l08CR/EltdDiMB1fuf756QfZhv8qXGZxXzvJwaaIedOZSYoxvVfwV849/32wSza6+5b+YeFeaENPvFAuUaAmAxCBtxSIxc=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 5 Aug
 2020 15:07:50 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd%7]) with mapi id 15.20.3261.015; Wed, 5 Aug 2020
 15:07:50 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     gregkh <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Topic: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Index: AQHWWGERiGLMQx7oL0apZ2u4U144JKkooA3AgACXcwCAAIoQsA==
Date:   Wed, 5 Aug 2020 15:07:50 +0000
Message-ID: <SN6PR11MB2574EE40D3120F92F1BFEEAAF64B0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
 <SN6PR11MB2574422442C26A41FBC89DA1F64A0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200805064622.GA608152@kroah.com>
In-Reply-To: <20200805064622.GA608152@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e3b999c-9dd0-49ae-31e4-08d83951522e
x-ms-traffictypediagnostic: SA0PR11MB4655:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB46552556CE7CEC070407EFD5F64B0@SA0PR11MB4655.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZIyRMBdcIX+MMS38sprBJRrj/1nDy/mpi3sWPl1rSP2qBX/5Vy8SVd2zWfgucXHRzZtR64JN7MzyJTGzF26LyXT2htyp9JtO/aqv9JiWwS9q3PnwtMoZpDzAFrLCtEyPVBEFMbSFPNNUnjjNkOahWvkT5L+JVh0rhjbPyQaLQroF/PkrMP9qlD7uT/LZjCes4muslbTNFDbRglt9qjjwXME57JSJHY9yfRYJiKsZz/3Pj4LcLhcKeLVe7pF0byONlJ8FH15d+bLQrSlzzr68CXOoYPOeeuT04eHjW2pCmOz2NRpY8uxLVy76alqZvkTixswWWMLUGRNtDBxjtwUQhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(66476007)(76116006)(66946007)(66556008)(66446008)(52536014)(316002)(6916009)(83380400001)(64756008)(7696005)(86362001)(54906003)(2906002)(53546011)(9686003)(478600001)(8936002)(55016002)(5660300002)(186003)(26005)(6506007)(33656002)(107886003)(4326008)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nASnck39ZZ7+9Ykfor6P5B8WRDqi2x5LUVVjgRjFyE3/NiliuJGQ4FKEe1+omfINMqpygrq5LHTKPlchBwc6Sp8p0zFPnWpWJXXHjNdnT3NrOt/7oP68ntbfzrS5uFq6qyHAb1+DAv39vKM6MgKyBxDzSzRYAqLvC6zc999Hhk4T2Sm/Az/O1kFr7Je1CcX6jO52Y1Dz9cCsG3fktYpvtJ1VUwRzPMvaR/1CvuEn91V0wt1C49QHr6QEQ8aFufcOYXVJFWsFbPDvosQvEZ28goTLrBz9BjP4JttmxKKYUIUeTm8xWWnyEjAev2Zfposm4yobfc2Mx2s18GDU1WV3ynUkcWWzPqG4UVLwd31agaJNwDBlmjFiAoDVT6Eg57h8yvhayKHUFKHedoCOmh1YAkWp5SAPY5LzyjhOf8SpNGyd26B7xgWXyM34dlCgorGGY9bAbcDDcb99J5Y5XWjdA2zfrqxrreZ6b861GvrkJFQCX4vLQzELDJSNySYH7Ii0Lm2/QYE0UJMLcmNJS03Y2tU/8YRIxJCHvRblB8MrE9ek0weFbycuFU04IaaBuTYFgnP/fVlQ1cb9NTA5li6jl9YFxcDTTwZCVQHCIKaaAzWXYTbxQEym/AdslXaLwUmdeaLsecQJkoAhAoGlsxyUGw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3b999c-9dd0-49ae-31e4-08d83951522e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 15:07:50.5559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muqf7n3jqL276pKZgeahL85vgbJ086Rv8VonXtkj6q2PvSLn6o9Ra5KvlSoUtL3WSza4u4WNwJa085wRjVDU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: gregkh <gregkh@linuxfoundation.org>
> Sent: Wednesday, August 5, 2020 1:46 AM
> To: Eads, Gage <gage.eads@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel@vger.kernel.org;
> Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>
> Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctl=
s
>=20
> On Tue, Aug 04, 2020 at 10:20:47PM +0000, Eads, Gage wrote:
> > > > +/* [7:0]: device revision, [15:8]: device version */
> > > > +#define DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> > > > +
> > > > +static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
> > > > +                                        unsigned long user_arg,
> > > > +                                        u16 size)
> > > > +{
> > > > +       struct dlb2_get_device_version_args arg;
> > > > +       struct dlb2_cmd_response response;
> > > > +       int ret;
> > > > +
> > > > +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
> > > > +
> > > > +       response.status =3D 0;
> > > > +       response.id =3D DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0);
> > > > +
> > > > +       ret =3D dlb2_copy_from_user(dev, user_arg, size, &arg,
> sizeof(arg));
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       ret =3D dlb2_copy_resp_to_user(dev, arg.response, &response=
);
> > >
> > > Better avoid any indirect pointers. As you always return a constant
> > > here, I think the entire ioctl command can be removed until you
> > > actually need it. If you have an ioctl command that needs both
> > > input and output, use _IOWR() to define it and put all arguments
> > > into the same structure.
> >
> > I should've caught this in my earlier response, sorry. The device versi=
on
> > command is intentionally the first in the user interface enum. My
> > goal is for all device versions (e.g. DLB 1.0 in the future) to be acce=
ssible
> > through a /dev/dlb%d node. To allow this, all drivers would support the
> same
> > device-version command as command 0, then the subsequent commands
> can be
> > tailored to that particular device. User-space would query the version =
first
> > to determine which set of ioctl commands it needs to use.
> >
> > So even though the response is constant (for now), it must occupy
> command 0 for
> > this design to work.
>=20
> "versions" for ioctls just do not work, please don't go down that path,
> they should not be needed.  See the many different discussions about
> this topic on lkml for other subsystem submissions if you are curious.
>=20

This approach is based on VFIO's modular ioctl design, which has a differen=
t
API for Type1 vs. SPAPR IOMMUs. Similarly a DLB driver could have a differe=
nt
API for each device version (but each API would be fixed, not versioned). I
didn't see any concerns on lkml over VFIO when it was originally submitted =
-- though
that was 8 years ago, perhaps the community's feelings have changed since t=
hen.

Thanks,
Gage
