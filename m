Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B7BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAE12074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OtmCMtsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHXXey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:34:54 -0400
Received: from mail-eopbgr770053.outbound.protection.outlook.com ([40.107.77.53]:40350
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbgHXXew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:34:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+fpv6kc2uwcAYjUsQFkpGCN3XCK4ofrd7nukeSDZQRcYsNT/X+NwM+b3HEwepCOUDb9pmraT97My8Qh0cqBeVk2ViBGWWnb58xlKB9nagQgxyE/QcfPPpEi3RZ5t27NRqXSnAK3ggXu5GBM8uG8tXQRY9aTBwQuc4osjvOUA3PvsKr5hSsEk4OkLfS+LzkQmnTNpzS2oroGVAJyUdCVmfoxfQGtlz0R3xCGY+IkfYySCAfbyH6C13xuiHeEepeBFVramZfYqLMsc4NwkD45i4rMX4RTcBUQFoBpypQfnT0SPixNm1kMMddpgQDM//ntSzu+XcKuSlpzVp2FMrvqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsMK52Ym0e3GKgijTJD4Tv5rgoY+IekVfqVIKE5MVfY=;
 b=EQFV34EtjSFapGu6ifiN7QQEXa/tAYcqnJ4GLDk3gvqnDVNzOowMKtUXKDbB3KhfFN7s2cez9ZwEAhyvgolUp3IWblyDjxTbBbOfdlc0gE2yBpUp8vWWZyZkGCdzx56qATteQdli1j5rwkGFnnAbPT9JXjB2377Y+2uXEcDhvFRMkQHtgacgrHK9gMBYTE1gVf+ICjm519kd4ChVkiqZqMFByLBOtAyh/hOhHAFueUtQZtXZ/GpqUJnr8PjkftVIN9HTAS0RP+UmCKWkRIQU87TT6lzeT//OWckLZ2/Ds9ERnSnQi80YVFi9Fs5rWqd8vh+J83rEm700abtdSHLclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsMK52Ym0e3GKgijTJD4Tv5rgoY+IekVfqVIKE5MVfY=;
 b=OtmCMtsnRvH7/1qpCm15HiO88n/5skinBqu9LBN+YJtEVvG98Nhhj0ocZBiJta5QIHYkwQiFADPOM5prLjkKYTT63MGZZKGZD5q2LgElGjhhgEc14jDL+w9RbBhIsKw2prbSNbLkOFvwt+i8fVQ3kaIJh61RsCWwkU7mPg8dgCI=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BYAPR02MB5718.namprd02.prod.outlook.com (2603:10b6:a03:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 23:34:48 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 23:34:48 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Stefano Stabellini <stefanos@xilinx.com>
CC:     Michal Simek <michals@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Thread-Topic: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Thread-Index: AQHWb5AL1Cmns7xcFkizB0J8iqhSuak2g3KAgAdzeCCACgfykA==
Date:   Mon, 24 Aug 2020 23:34:47 +0000
Message-ID: <BYAPR02MB44074C112F383606E2292F4AB5560@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
 <20200811033213.20088-3-ben.levinsky@xilinx.com>
 <alpine.DEB.2.21.2008131103230.15669@sstabellini-ThinkPad-T480s>
 <BYAPR02MB44076F48364A94C05F636870B55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB44076F48364A94C05F636870B55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d02ce85-c332-4cd5-aa46-08d848864a36
x-ms-traffictypediagnostic: BYAPR02MB5718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5718436C549DC866F7416EC0B5560@BYAPR02MB5718.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6wccWlF7VozNiDzA1oVUs3846uVR+bYgbfsUHhbWKd5QxbyovbPDl/ajJsv+/8+RVklVKDFLOc47j+p6NzL+VU3ZPz3WEoAIUfQuhtzuvpViaYN3r4wyIe1z7BsNvPl6dUNtmnYyBEX6Qfqe4drKzpP7x4IUUlf6Lq6+jCHWFQK9OWL7AazlAijTA++e4WjTtkFMiyTcedhKuBedAgt4bqPxdc4oLS8NNAQuAQ4BnasP7BKz2myUJSuGwTFdDoqIiRznlSCDGT3vZ0Jg8qv5V6qVCLB6AAP8PThk4IOUuvbpKoZwsQfUl0ra25/IBCm8itaAKlEO+4XzqEhjsS+sjw8nbrA9Mmv5Ck1z7naEKgl5PM08uA2nb27GQIitUQ6P9svHnv0bbPA6XPz5kEPjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(346002)(376002)(5660300002)(83380400001)(66446008)(66556008)(64756008)(54906003)(4326008)(55016002)(33656002)(478600001)(966005)(66946007)(9686003)(7696005)(52536014)(86362001)(8936002)(76116006)(8676002)(6862004)(66476007)(6506007)(6636002)(53546011)(316002)(71200400001)(2906002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zRAJ2oUlZhpd7g7WSqJ+7W2WE/ecHfmOS3R+AQiyRI7bld1Ugd1S2bRDZHdLCDWXUq2JVqKTYcQYNfKDHwGF0SM5kZxsw88Zz3fDls3c4lF3Vv7uFWfbtiVDhQqXpb2K0nfSuXcB7rvEtcbaCHgdoGrfGvMFrgeudZj9Dufyxgnsi6uH58AIWmVuUTs/cpCXEazE/BYHwOgRJh6yF+F//HKXc8Fcpm2MHywTkmcdPBt7GOqDNxhcaD5i8XO7wokl8p83ZPu+SNoSY51qISkgWTCkJF6ibpDEjrdFGGh5HKxHoEhxWwmYM+Lil6ypccqGZz+SrmuF0aOuD8qThMq/CI2bZhX1oXXDg6Corg0rLdwnb1iSWKoxyzE1hLuu/PdamMf/Fhi1WC4wwMkgu5UY5Syek1L4wXz3UzQD/r+4sCwp9814xx5Euhsd2GIRFgtapGlExW/Y2eQYVbuxnjACsMTVYk/1LNtnb7vvW8Fq4XrntsLFfbm9tFEyjW2cz+n6SbQOR7VhhNOSD4Rp1OTx9V66R6Tm1gQ9XWOW8HWa7uhnSVzf6CfS2ej5bweBsNKpZwkvZtC0rTYQvKhXDXzSPpyY9aea6c2YjauIAi8zmZm9pTsAqtgKTZEH4i8mCExBFT1n0bwLe0LkdbeFU8TYvQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d02ce85-c332-4cd5-aa46-08d848864a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 23:34:47.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLPO0ifnFD5RUSP4hhGYOo+1bnD1jNosnamypL1QOVWC2ZdFGo9u36RR+irlZXzS6/YI1g449kYTt6Vxz5/xZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefano

> -----Original Message-----
> From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> owner@vger.kernel.org> On Behalf Of Ben Levinsky
> Sent: Tuesday, August 18, 2020 7:24 AM
> To: Stefano Stabellini <stefanos@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; devicetree@vger.kernel.org;
> mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
>=20
>=20
>=20
> > -----Original Message-----
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > Sent: Thursday, August 13, 2020 1:36 PM
> > To: Ben Levinsky <BLEVINSK@xilinx.com>
> > Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> > <michals@xilinx.com>; devicetree@vger.kernel.org;
> > mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
> >
> > On Mon, 10 Aug 2020, Ben Levinsky wrote:
> > > Add shutdown/wakeup a resource eemi operations to shutdown
> > > or bringup a resource.
> > >
> > > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > > ---
> > > v3:
> > > - add xilinx-related platform mgmt fn's instead of wrapping around
> > >   function pointer in xilinx eemi ops struct
> > > - fix formatting
> > > v4:
> > > - add default values for enumv3:
> > > - add xilinx-related platform mgmt fn's instead of wrapping around
> > >   function pointer in xilinx eemi ops struct
> > > - fix formatting
> > > v4:
> > > - add default values for enum
> > > ---
> > >  drivers/firmware/xilinx/zynqmp.c     | 35
> ++++++++++++++++++++++++++++
> > >  include/linux/firmware/xlnx-zynqmp.h | 22 +++++++++++++++++
> > >  2 files changed, 57 insertions(+)
> > >
> > > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > b/drivers/firmware/xilinx/zynqmp.c
> > > index 8d1ff2454e2e..f1a0bd35deeb 100644
> > > --- a/drivers/firmware/xilinx/zynqmp.c
> > > +++ b/drivers/firmware/xilinx/zynqmp.c
> > > @@ -846,6 +846,41 @@ int zynqmp_pm_release_node(const u32 node)
> > >  }
> > >  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
> > >
> > > +/**
> > > + * zynqmp_pm_force_powerdown - PM call to request for another PU or
> > subsystem to
> > > + *             be powered down forcefully
> > > + * @target:    Node ID of the targeted PU or subsystem
> > > + * @ack:   Flag to specify whether acknowledge is requested
> > > + *
> > > + * Return: status, either success or error+reason
> > > + */
> > > +int zynqmp_pm_force_powerdown(const u32 target,
> >
> > If the target is really the node id, why not calling it "node", the sam=
e
> > way as below?
> [Ben Levinsky] good point. Will change to "target" in v9
> >
> >
> > > +			      const enum zynqmp_pm_request_ack ack)
> > > +{
> > > +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack,
> > 0, 0, NULL);
> > > +}
> > > +EXPORT_SYMBOL_GPL(zynqmp_pm_force_powerdown);
> > > +
> > > +/**
> > > + * zynqmp_pm_request_wakeup - PM call to wake up selected master or
> > subsystem
> > > + * @node:  Node ID of the master or subsystem
> > > + * @set_addr:  Specifies whether the address argument is relevant
> > > + * @address:   Address from which to resume when woken up
> > > + * @ack:   Flag to specify whether acknowledge requested
> > > + *
> > > + * Return: status, either success or error+reason
> > > + */
> > > +int zynqmp_pm_request_wakeup(const u32 node,
> > > +			     const bool set_addr,
> > > +			     const u64 address,
> > > +			     const enum zynqmp_pm_request_ack ack)
> > > +{
> > > +	/* set_addr flag is encoded into 1st bit of address */
> > > +	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address
> > | set_addr,
> > > +				   address >> 32, ack, NULL);
> > > +}
> > > +EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
> > > +
> > >  /**
> > >   * zynqmp_pm_set_requirement() - PM call to set requirement for PM
> > slaves
> > >   * @node:		Node ID of the slave
> > > diff --git a/include/linux/firmware/xlnx-zynqmp.h
> > b/include/linux/firmware/xlnx-zynqmp.h
> > > index bb347dfe4ba4..4d83a7d69c4c 100644
> > > --- a/include/linux/firmware/xlnx-zynqmp.h
> > > +++ b/include/linux/firmware/xlnx-zynqmp.h
> > > @@ -64,6 +64,8 @@
> > >
> > >  enum pm_api_id {
> > >  	PM_GET_API_VERSION =3D 1,
> > > +	PM_FORCE_POWERDOWN =3D 8,
> > > +	PM_REQUEST_WAKEUP =3D 10,
> > >  	PM_SYSTEM_SHUTDOWN =3D 12,
> > >  	PM_REQUEST_NODE =3D 13,
> > >  	PM_RELEASE_NODE,
> > > @@ -376,6 +378,12 @@ int zynqmp_pm_write_pggs(u32 index, u32
> value);
> > >  int zynqmp_pm_read_pggs(u32 index, u32 *value);
> > >  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
> > >  int zynqmp_pm_set_boot_health_status(u32 value);
> > > +int zynqmp_pm_force_powerdown(const u32 target,
> > > +			      const enum zynqmp_pm_request_ack ack);
> > > +int zynqmp_pm_request_wakeup(const u32 node,
> > > +			     const bool set_addr,
> > > +			     const u64 address,
> > > +			     const enum zynqmp_pm_request_ack ack);
> > >  #else
> > >  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
> > >  {
> > > @@ -526,6 +534,20 @@ static inline int
> > zynqmp_pm_set_boot_health_status(u32 value)
> > >  {
> > >  	return -ENODEV;
> > >  }
> > > +
> > > +static inline int zynqmp_pm_force_powerdown(const u32 target,
> > > +				    const enum zynqmp_pm_request_ack ack)
> > > +{
> > > +	return -ENODEV;
> > > +}
> > > +
> > > +static inline int zynqmp_pm_request_wakeup(const u32 node,
> > > +					   const bool set_addr,
> > > +					   const u64 address,
> > > +				   const enum zynqmp_pm_request_ack ack)
> >
> > code style
[Ben Levinsky] for this, the argument goes over 80 chars if aligned like th=
e others. With that in mind for style, is it better to have the set_addr an=
d address args aligned with ack or to push ack to the right but have the >8=
0 chars style issue?

Thanks
Ben
> >
> [Ben Levinsky] will fix this in v9
> >
> > > +{
> > > +	return -ENODEV;
> > > +}
> > >  #endif
> > >
> > >  #endif /* __FIRMWARE_ZYNQMP_H__ */
> > > --
> > > 2.17.1
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > >
