Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE77C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84C62068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="eUlkWDuP";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="Qkx8dETf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFBQgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:36:40 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:35906 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1966; q=dns/txt; s=iport;
  t=1591115799; x=1592325399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3Jy4jB5DKVN0a1d+emMQLWwHFLERK1rx+dV/bJHbdWU=;
  b=eUlkWDuPehlbvY0CSpDNnxsLpXT68nR6rec9Uy/PGYws0SUkSZuam9he
   bTDjnsNPJT29uOe4c47W+DNErvsjoXYJZkuBMGYukz9iV26xfATcN3hzS
   RGJiGMnwy935sbtsDAhriSBCMjlkOho4oucUGAkT6WgXWTJic80WNj+d4
   M=;
IronPort-PHdr: =?us-ascii?q?9a23=3A2DkVchITehqg8PB+zdmcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeGvKk/h17SVoKd4PVB2KLasKHlDGoH55vJ8HUPa4dFWB?=
 =?us-ascii?q?JNj8IK1xchD8iIBQyeTrbqYiU2Ed4EWApj+He2YkNUA835IVbVpy764TsbAB?=
 =?us-ascii?q?6qMw1zK6z8EZLTiMLi0ee09tXTbgxEiSD7b6l1KUC9rB7asY8dho4xJw=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B+AABTf9Ze/5RdJa1dCBkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQESAQEBAQEBAQEBAQEBQIFKgVJSB4FHLxcVCodhA41Fj0G?=
 =?us-ascii?q?JDIFCgRADVQsBAQEMAQEtAgQBAYREAoIbAiQ4EwIDAQELAQEFAQEBAgEGBG2?=
 =?us-ascii?q?FWQyFcwEBAQMSFRMGAQE3AQ8CAQgYHhAUHicEDgUihVADLgGkWQKBOYhhdIE?=
 =?us-ascii?q?BM4MBAQEFhTcYgg4JFIEkAYJjiWMagUE/hCE+hBkBDQUBCBmFdJE7ohsKgli?=
 =?us-ascii?q?YYiwPgleJCIUPjR2uWgIEAgQFAg4BAQWBaiJmcHAVgyRQFwINkECDcopWdDc?=
 =?us-ascii?q?CBggBAQMJfIsvAYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.73,465,1583193600"; 
   d="scan'208";a="767075513"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 02 Jun 2020 16:36:37 +0000
Received: from XCH-RCD-003.cisco.com (xch-rcd-003.cisco.com [173.37.102.13])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 052GabPK015919
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 2 Jun 2020 16:36:37 GMT
Received: from xhs-aln-003.cisco.com (173.37.135.120) by XCH-RCD-003.cisco.com
 (173.37.102.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Jun
 2020 11:36:37 -0500
Received: from xhs-aln-003.cisco.com (173.37.135.120) by xhs-aln-003.cisco.com
 (173.37.135.120) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Jun
 2020 11:36:35 -0500
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-003.cisco.com (173.37.135.120) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Jun 2020 11:36:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaCILnNClzt2RS2VNf3+E4q9S6ibHXvG/ocVc9W14PnJBSgpfvGcvDm3R401RNqF/tEUo/g+HC6IaHtxXvAwa2xY3lfiDYqVdupeEfr9yS8NXKHERnAez/tCA9QpXhJ0hA1AItlybhIuzbMMVX4Q4inflOpkrOhsaEK3DNAlKgaejx4gIcppJ/DOtb4gx+oSApHA347grD1OUD5anK+ymEaJJp+ZigMaKBYHSUwyuWDK7YuLscyUWqI8eQMLe4bA7XBdbilW5hWsz/VmW5uQrSXmJTvHXQHyC2Sk9dulF9psPHBjjEfo+H5cdtGRJvHcFp3blCEo551W+XmUCjfajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAhwOKGFM9d9l8+2MiQwWzk6nnQDkHNWa6Q4bpTuUec=;
 b=d84o7Q7bnVdbaKVMXQoGoD3SD7FWM/qhRpzJTzmVPc93cG4FhmN7aVxvrYr+dTR1E7MVcS2gxxwEwPZ5+y8cCK5uaqLykA1ibIr06nPXNnNQSLjcyImmjpmoillJHjt6R9tD9owNp9VID+4v3Gjgf7G8z1cpURauwHJUfG+IwwMMB7nc3ALir4X6PZLED5wvhBTxtHPCTzipm/f9toWNOFrA5m3bwPDT/s9WfAIj/5wBBB3z4yJ7iNB8wJvciXi7viIKz+fV+KH+xYSrBC/ElMXs6qLWgI0LQeK4uyWTNKA7nfyLtqXafhGbV9bp0NBdZv4MlVTe3zdmzUYLnAmzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAhwOKGFM9d9l8+2MiQwWzk6nnQDkHNWa6Q4bpTuUec=;
 b=Qkx8dETfIg9zPeKFzU6yj+Or7TVROql4Rpe2+snTggDFmTD0dpikZJW/j9bDxx/Wu6P/RM3dR6Vfge2VSZW1qoIVwem2NX6uVzSvBldYaZ+rOkdYGy/5DLLNOi/5kDU+gFDIP24Zu8Cz5giXWbTsVLzCmqchBXGXNwthdPPwEbI=
Received: from BYAPR11MB3205.namprd11.prod.outlook.com (2603:10b6:a03:1e::32)
 by BYAPR11MB2952.namprd11.prod.outlook.com (2603:10b6:a03:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 16:36:32 +0000
Received: from BYAPR11MB3205.namprd11.prod.outlook.com
 ([fe80::589:9135:2039:62a1]) by BYAPR11MB3205.namprd11.prod.outlook.com
 ([fe80::589:9135:2039:62a1%4]) with mapi id 15.20.3045.018; Tue, 2 Jun 2020
 16:36:32 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     "Jinhua Wu (jinhwu)" <jinhwu@cisco.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: intel-spi: fix forced writable option
Thread-Topic: [PATCH 2/2] mtd: spi-nor: intel-spi: fix forced writable option
Thread-Index: AQHWOPv5MjW7nhJ9bE2jDffSfrKqDA==
Date:   Tue, 2 Jun 2020 16:36:31 +0000
Message-ID: <20200602163631.GH23028@zorba>
References: <20200518175930.10948-2-danielwa@cisco.com>
 <73a475fa-3c26-89ab-aac6-54f9b5b15936@ti.com>
 <190F24BF-EE4C-4C40-9101-C0AE6C9CEF53@cisco.com>
In-Reply-To: <190F24BF-EE4C-4C40-9101-C0AE6C9CEF53@cisco.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: cisco.com; dkim=none (message not signed)
 header.d=none;cisco.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [128.107.241.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96fb87e8-7d45-43fb-5460-08d807131b93
x-ms-traffictypediagnostic: BYAPR11MB2952:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB29526BDCC3B1BCB3EC520465DD8B0@BYAPR11MB2952.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3fzTPMF6pmKuGtlrdQpye5/NyMOaaztoqfgAA3XeQrqBozydqTrHsgzzDdjcM0ySoTTa3CBLmK0v18H9CoRdDIaSaKSEZccaAKYi3dN2ngf20NwVq6IC3PqmjXmwxSi0oPWCl33X0ClD5C0w4z+8c+8clnVn9OovAAec2etQYDYhMDmdW0nmE721wrXG6v5RSYG7fDhilUDD00SDzwyNHmSMjgCLaJfF9aFvQfg2dO3ozyuUDtNRk4edMYpQ4Oulnw6GR/A01g8MQUefgty8wW84MrEtTHOOWqgU8hcI4qOu9C5ZSDFOcE8OmL6RoP3kTu1Q+CvitUr06dUHWYv1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(396003)(136003)(39860400002)(366004)(376002)(346002)(83380400001)(54906003)(186003)(2906002)(66556008)(66946007)(64756008)(66476007)(71200400001)(66446008)(6636002)(316002)(4326008)(53546011)(33716001)(478600001)(1076003)(8676002)(33656002)(8936002)(9686003)(76116006)(86362001)(5660300002)(26005)(6506007)(6862004)(6512007)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: s+6tCNyOJ1N1K2ZT1qV7CrTsgaPB3BPZJEyz069gEzhaNUG4inFAMA0vQ7cZhyIugciOTzIb/gt7TpDSAj53f4Y4bvwmWTUAuNOykZWDCM2+R0Yiz3zNETJMtu/GfxQFm1jaBjVPebFomgpemJ2SBEpoKRgpNFfNaj0xXHrGH/UhmkcrJmDcb7XpQVL9lkHUB89Ll5CEzuwI+8QQKB9qynNV1BOAI6Fam5oycm/5uAVBsFumfFlA63PG3gJZ9HoAYgnh/bUdPRG8edWFcx74dhpQgKawU7esXjOInXCae5HDovIWFD1M4sHUsyuWha2Flp2ejY8a608uOwP/i3PdwAuCIMMbVDAxjuiVBLZ5f4FiE+X+8n/cXSaR7R1GbAcavQtOMLjGvsV61+kSXZJT+cee4WwXQz8zbeun9cmNJFgd6P8RL40C1rUu0qwqU+OLqyuuYF1d7LAS3GWbbZq8I9LJZjNJbr3NDUCOnoacIufZePm5J+KCxlhejifpxYh4
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C8955D25A42EC4C8A30AF927EDA8A10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fb87e8-7d45-43fb-5460-08d807131b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 16:36:32.0059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZSwPHuSziwUFtyDzLrEOMWA8KOSe7Cht0jXggzvi2Vo2nfT2NWZmh7kYLyGD7zAE5xjUpmF6RfWgEAGs4MHTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2952
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.13, xch-rcd-003.cisco.com
X-Outbound-Node: rcdn-core-12.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 03:55:21PM +0000, Jinhua Wu (jinhwu) wrote:
> On 2020/5/28, 11:48 PM, "Jinhua Wu" <jinhwu@cisco.com> wrote:
> Hi Vignesh,
> BIOS just locked down parts of flash (such as, code region), others are s=
till=20
> writeable. Once the SPI locked down,it can't be override unless platfrom =
reset=20
> and set WPD (write protect disable) will fail, so ispi->writeable will al=
ways
> be 0, then the driver will always make the whole flash read only, even if=
 we
> have set the parameter writable =3D 1.=20
> Now the flash is totally not writeable, just part of it is read only. Why=
 not  making
> 'writeable' working when explicitly enabled?
>=20
> >On 2020/5/28, 7:02 PM, "Vignesh Raghavendra" <vigneshr@ti.com> wrote:
> >    On 18/05/20 11:29 pm, Daniel Walker wrote:
> >    > This option currently doesn't work as expected. If the BIOS has th=
is
> >    > flash as read-only there is no way to change this thru the driver.
> >    > There is a parameter which allows the flash to become writable wit=
h the
> >    > "writable" option to the module, but it does nothing if the BIOS h=
as it
> >    > set to read-only.
> >    >=20
> >    > I would expect this option would make the flash writable regardles=
s of
> >    > the BIOS settings. This patch changes this option so the BIOS sett=
ing
> >    > doesn't stop the writable option from enabling read write on the f=
lash.
> >    >=20
> >
> >    I am confused you say "If the BIOS has this flash as read-only there=
 is
> >    no way to change this thru the driver", so is it possible to overrid=
e
> >    BIOS setting? If yes, where is the code in the driver?
> >
> >    What happens if BIOS is set to allow writes but writeable is set to =
0?
> >
> >    Also please send patch series as thread (2/2 in reply to 1/2). You c=
an
> >    use tool like git send-email
> >



Vignesh, do you still have concerns about this change ?


Daniel=
