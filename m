Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAFAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5916620CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="pf3SJRWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgCaS3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:29:48 -0400
Received: from mail-eopbgr80139.outbound.protection.outlook.com ([40.107.8.139]:40838
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbgCaS3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:29:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrY08AnklTU2zAWcPfhh7QZC1YNKOvL6Mp9Ed0+2cpMSogXFfIWcNjDaJdoQZbH4S07e9N0hyhEBl6jYYxVVUHpMunIeUABanO2SECX1xVTRXPinbUpCPRyVYbrUFM2I/nbvIs2WRXpoXcsecH+jsc8V35UpyX8h6xrBceDRftL8itP+6NapnH6HxdaDbHX9TUuC3mKjSSTuSMIBDkhwjxboch1v8AZD0PxcB+dJlEOopEbkbEkn2I4ejXtYKGCaRn9T8M1MwZhhgk8SxM7+Vgo+M4Xj/QpigwImng7YWV7Ts/vfxVJogRErkTvu30xNmeN81K6nbd77kIgWmXOuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owuDtAxkXj8WXwlapdfAbp6iQ7OeoxoMbw3GjoxF2Jk=;
 b=U6JZR8L2d6Cu8IkKi+WwFWunetCZrAtud9N0lc6TbHPc4aVXHimN/77tt8drEQYRfWvjRZ8qaGYgxl9Z2eBv7FmG15z66gW4lql1Fplc/ypDCfeVV8T8EJseXeE5KD89JlpUncSLc7+tJvK/IZjxrNfAhRO3uojwfFwCoJ1ES60OwkfvzuK7rMjDKDpHGe18G+buxqxl0pfDE7T7+JgAw+iYVEjKpM9ieBPjmhSEmrlroxLdwk3xbm+0uaZxJlszjwKO3E3YLSuK4RgKQvjeAYRdJ+V1AYklOMu2UHIi6BlHdiUGMbxPfiYUCV4p9I4blNX5K2taY+H5MgFG91sIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owuDtAxkXj8WXwlapdfAbp6iQ7OeoxoMbw3GjoxF2Jk=;
 b=pf3SJRWoHVDwr+K63nQD2HP68NVVIb/7f+dYru6JN/hN3FiIf2TTd1313D+RU/hZnSbXiTrsIPbxSTD/br8KvExyRB98WfNO/Kse2BZb0cO88xeY2eD/4+3XOTVc2Ls5Bz/CVnSOQ1zZDV8CZfPJnwDQ5iQ6KmP7x1QzJ2SYX28=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (10.255.19.214) by
 DB8PR02MB5931.eurprd02.prod.outlook.com (52.133.242.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Tue, 31 Mar 2020 18:29:45 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::2989:ba7f:c6b3:c93d]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::2989:ba7f:c6b3:c93d%6]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 18:29:45 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] habanalabs: retrieve DMA mask indication from
 firmware
Thread-Topic: [PATCH 1/2] habanalabs: retrieve DMA mask indication from
 firmware
Thread-Index: AQHWB2yBNblG9Z5dlUiw7tiTC6vGx6hjBOHw
Date:   Tue, 31 Mar 2020 18:29:45 +0000
Message-ID: <DB8PR02MB5468D095C88EBFE48C6206EBD2C80@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200331145600.768-1-oded.gabbay@gmail.com>
In-Reply-To: <20200331145600.768-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [89.138.173.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58ce05bb-49d8-448b-1e23-08d7d5a17c91
x-ms-traffictypediagnostic: DB8PR02MB5931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB5931B1C00857974031576EF7D2C80@DB8PR02MB5931.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(376002)(346002)(39850400004)(396003)(136003)(76116006)(66476007)(9686003)(186003)(4744005)(55016002)(316002)(478600001)(110136005)(4326008)(66946007)(8936002)(7696005)(81166006)(66446008)(8676002)(52536014)(26005)(6506007)(53546011)(86362001)(6636002)(5660300002)(33656002)(2906002)(71200400001)(66556008)(64756008)(81156014);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TrzghK/2Pru/OsuwAOxlng6XmC80hq1nm8yaCzA/Pdlmw18apWBF/KuZ/XXmXiAcTKbMmbsrzfdh2a9eA51ctoHRyYzcdSCo9D8lUWdZmMVDAwH+qb0nhLnihWTmPCwsrp+XG0L8fTAugu4dHE0e8b5Lf0LZ7MEClA1aMMabENsm/EsBeDdMBq9OspSFKGzAxWBzReQgYVDfXdsuILoKtFHj5gNmA5Mrr3OiHx786Nfbj6cFAX99KVOM+3e/Uo2a1dC6iPsJbTuxaKVraunFvM0Uf164XdddN5VAjGc2skzJN4XMHnTncpOf5K80qxsSbjr45sqTNV9VbsCpzmoa5Th6fbDfpeAz77nNbOVgO4Au4Cuyd/4k+yZZggxCeAXcPFVhdzwqOPHjKLTKv3K7sqSZ4nvN54Rg00kV2ciFvNFn8G/ykskGA9vP4sNDZpYO
x-ms-exchange-antispam-messagedata: +xKHNuEkK70Pek7vLiBhduIT16agKnSTFRSQH9IDDVxLR6vs5QJxG8zPoyrfkF19MR99UWTmJOz0v2TVV8T9EChT972J4n9Uk43wLRogsDDApvStNe+k7Wj3Djb45N4/VP38s8wOz6bBGUk+M7DEmA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ce05bb-49d8-448b-1e23-08d7d5a17c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 18:29:45.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkK7B+yGHoXXJdGxQV+6HsBYuZLyJ5T6A/GVSWyRyETlJkygQPk5AIe9TcbofEDlxnt4+t4Ovz5x1+Uold7kyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2020 at 17:56, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Retrieve from the firmware the DMA mask value we need to set according to
> the device's PCI controller configuration. This is needed when working on
> POWER9 machines, as the device's PCI controller is configured in a
> different way in those machines.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
