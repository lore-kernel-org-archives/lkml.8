Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77619C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B3D2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rpqAfGQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgC3Snu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:43:50 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:45248
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726385AbgC3Snt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:43:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT25rIAyQja8aLDMo+NCxwp7Mq4F0HaVZcMIeGOceByHZ/XFLt/xhD6cqqhAc8fAjETWcI44smnxgULtFupxRFVu6EFQ7q0U6hAEfX8Bsu+tkbZstMc79pO4w1J/ScxkCrBsXK4T2koDr9NST3DufaJg21wsqxCYDbNRyBhx/SwtgOpoof6EU9GRJxale/wMRN0Kiyx5GwW2HBLqDC6bns2ZM9MBGe5s+r/9vrruBXts/4ZjbKeIAfz9dGKfk4XdanbmAxhuci9/Swno8d4JktvUN8FBRxIBoUhX+pVOy+aoq7vvx9P0sjiDW0KkZoUip3se2tPDWHDhnf2MLTLSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BgE4IcbRa1PRyaOEVLj4RRZFvWSZtDKqEoOmq8n2vI=;
 b=lsPIZrKUgWtgNGsOwV+wxXzfkL+8mQBT89bgxbL4UT4F3Vuo435bqiJIIY+ZR02iTwnOibrGumpt5MtQdzSD4xRpo/IUj75m+sv/2TMr1mww21fCzJOC+RB1wyf8eFBtQIF8035/OzcFcT6pzvRkdvfIR3DZowwswd5aKFwlsDEeaDhy8CIzgOedE3yVQT5aRTTGxM+kXbexVg5eQ6uqwQ9YCNMj3EszDyyQj9m6qNpGCcUrbt0saDso+wD4SyCraGpsJBSPF5Rn2knfVlC/cwKoQ0gsB2x4lFFJu+FIpGEEj0V0Yf6lZbfkShvfcjle/otCguhV7tLC6AeNfFmZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BgE4IcbRa1PRyaOEVLj4RRZFvWSZtDKqEoOmq8n2vI=;
 b=rpqAfGQO+VQTV4eL0JKEyfY2/Zci2I9z9pyShXSe7RLSn6mmVe+P5LaNNmvO16JCYG0RIHVTb+n+OaraqCU1l59Uv8w3nBH3GQbeAg3uQqEAbs2bZ6UB3hLdkKSz4zKIWo5KRD0MU2waE8BeJNWkeznLTvKNZy2qtOoU+E4jXwA=
Received: from MN2PR12MB3232.namprd12.prod.outlook.com (2603:10b6:208:ab::29)
 by MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 18:43:46 +0000
Received: from MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::e194:eea:a96e:a732]) by MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::e194:eea:a96e:a732%6]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 18:43:46 +0000
From:   "Nath, Arindam" <Arindam.Nath@amd.com>
To:     Jon Mason <jdmason@kudzu.us>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
CC:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/15] AMD ntb driver fixes and improvements
Thread-Topic: [PATCH 00/15] AMD ntb driver fixes and improvements
Thread-Index: AQHV3DqlnIDS1qJCGEGljI9iZT5gmqgPkraAgDZQnICAG+nw8A==
Date:   Mon, 30 Mar 2020 18:43:46 +0000
Message-ID: <MN2PR12MB3232D38E30341A7D7408BED79CCB0@MN2PR12MB3232.namprd12.prod.outlook.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
 <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
 <20200313002524.GB13046@kudzu.us>
In-Reply-To: <20200313002524.GB13046@kudzu.us>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2020-03-30T18:41:47Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=e7384e19-9425-4246-8732-0000e9c41582;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_enabled: true
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_setdate: 2020-03-30T18:43:42Z
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_method: Privileged
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_name: Non-Business
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_actionid: c199e236-1bc7-4c31-830a-0000cba8f745
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Arindam.Nath@amd.com; 
x-originating-ip: [122.179.41.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdd8422f-17f0-414e-ac4d-08d7d4da4762
x-ms-traffictypediagnostic: MN2PR12MB3407:|MN2PR12MB3407:|MN2PR12MB3407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB34070719369F2BC26B9112DC9CCB0@MN2PR12MB3407.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3232.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(53546011)(478600001)(86362001)(6636002)(55016002)(5660300002)(33656002)(6506007)(110136005)(9686003)(2906002)(52536014)(186003)(8936002)(8676002)(71200400001)(81166006)(316002)(81156014)(7696005)(26005)(64756008)(66556008)(66446008)(66946007)(66476007)(4326008)(54906003)(76116006);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXpowUyCguu6j7TfsTXjogkbcUtSXaLMk/ZSl5DIravW8zd2RkwPcqWWysET3qt+NpJvoZZrTQrcbPV2ho+1OuFKCiBX/xpGs50bMHhfpqrC3RTSv/JwffwpCKgH/e65DG9beFeU0YIkEhJHOL7syftQXscx18DPHX6yKp9r4kKCvuKnlw0zfk3nwAEiLq0FotMUmjmNEHAwT3VzxnCKLkp1eoDvYNAOqj79PEbwHKePEeBHWYTEAz1AvFQp84KaPtlcmqdA2+TrTUuWAFFzR/lvgzvJ8X9et6iC/xUMvvRA4j0QuRWklEWi/8/V8w6XZB89yQkETJ3hMt2VB/7Hd1GT0gU5wmmnlIzjSFiWwPdT6s9qhPARQGSWJu7ZtYoTo6CRD02wk9LjGpcn3p1g2BsG6KNu/RyT5+Riiv4SWFIk2dB3GYpzOdI0dj8Ike/B
x-ms-exchange-antispam-messagedata: ksujEKmIxTLBXi25NEsugDngZOu/+3FhDYWyAQng4ObtXaiukPKogDQaX/s9M2W+acgxjfBkO6lXcn6mtwObXNgXiv3EjaEIamOZPZKi7TwHlchd3NevnYTxNJsb7OYVp80B5bnJDwZPSDwent7mAg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd8422f-17f0-414e-ac4d-08d7d4da4762
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 18:43:46.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTzeRIEqc0sJ/KmD35Jw24HcHjdnKaO15dd32gt3jMs781mxmaPP140GPBQl6OXa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jon Mason <jdmason@kudzu.us>
> Sent: Friday, March 13, 2020 05:55
> To: Mehta, Sanju <Sanju.Mehta@amd.com>
> Cc: Nath, Arindam <Arindam.Nath@amd.com>; S-k, Shyam-sundar <Shyam-
> sundar.S-k@amd.com>; Dave Jiang <dave.jiang@intel.com>; Allen Hubbe
> <allenbh@gmail.com>; Jiasen Lin <linjiasen@hygon.cn>; Mehta, Sanju
> <Sanju.Mehta@amd.com>; linux-ntb@googlegroups.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
>=20
> On Fri, Feb 07, 2020 at 04:28:53PM +0530, Sanjay R Mehta wrote:
> >
> >
> > On 2/5/2020 9:24 PM, Arindam Nath wrote:
> > > [CAUTION: External Email]
> > >
> > > This patch series fixes some bugs in the existing
> > > AMD NTB driver, cleans-up code, and modifies the
> > > code to handle NTB link-up/down events. The series
> > > is based on Linus' tree,
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >
> > > Arindam Nath (15):
> > >   NTB: Fix access to link status and control register
> > >   NTB: clear interrupt status register
> > >   NTB: Enable link up and down event notification
> > >   NTB: define a new function to get link status
> > >   NTB: return the side info status from amd_poll_link
> > >   NTB: set peer_sta within event handler itself
> > >   NTB: remove handling of peer_sta from amd_link_is_up
> > >   NTB: handle link down event correctly
> > >   NTB: handle link up, D0 and D3 events correctly
> > >   NTB: move ntb_ctrl handling to init and deinit
> > >   NTB: add helper functions to set and clear sideinfo
> > >   NTB: return link up status correctly for PRI and SEC
> > >   NTB: remove redundant setting of DB valid mask
> > >   NTB: send DB event when driver is loaded or un-loaded
> > >   NTB: add pci shutdown handler for AMD NTB
> >
> > The patch series looks good to me. Thanks for the changes.
> >
> > For all the ntb_hw_amd changes:
> >
> > Reviewed-by: Sanjay R Mehta <sanju.mehta@amd.com>
>=20
> I had to rework the first patch, since Jiasen's patch was already in
> my tree for a couple months.  The rest applied fine and will be in my
> git trees on github in a couple of hours (sanity build pending).
>=20

Hi Jon,

Just wanted to know whether the changes are in your tree now?

Thanks,
Arindam

> Thanks,
> Jon
>=20
> >
> >
> > >
> > >  drivers/ntb/hw/amd/ntb_hw_amd.c | 290
> ++++++++++++++++++++++++++------
> > >  drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
> > >  2 files changed, 247 insertions(+), 51 deletions(-)
> > >
> > > --
> > > 2.17.1
> > >
