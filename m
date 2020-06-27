Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E77C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9602A20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="iJzXaN2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgF0MyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 08:54:18 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:8459
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726581AbgF0MyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:54:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYeqhgmaEK3c7zov848SefAOrEK8UrFAEgaTRYnLMkKXYhZ7zh7yucDUh0O5IywWF+7CMbvPCTaNCWt7obHf4JBEG+mTBLIAML/cBhAFVWGuMq6wyG/SAywxr1OjXoF9ZAqq0FmOJEhYVJr2abo0XaWjAX0J2LT+thA9iTQ8ugObosxWeFRftvVdwnzwtQRkoyGeYduRbiZIWFDnnBl1NRQW1fxq+8HaR91c3JLDeCVh49nGhPgGDMVtJaDoqs+CxB1Pf1x5TUjONieHrVaaK2J9xDgzVoeLRvvk6KfDknnHoZsd1QZKNrkLi4g/Qabj9B89Y0TMCdSYlCtDib6y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvb888lPufvBjnXd1dKyR5YYnRb3W8cLir63ZDgVNik=;
 b=jDN4gym5FaugoYOflTk8eHifq1fewse/F9wjoDEZ8QRuW6IzS5Y5xCtF/i5S4DYYe/6IS20N4d6zfSRyQ2PbaA0Wk4tOSi0PvPfvBgvS7FnSciZlD5R+DAu24Z5UBYERPFfjf/UZoMnjSczlmaTKLdbDcDjsLOZkC2x6SLFAqKBrbVzxkBcdyAneNBoRl33hMTKAsh6xNp0lCS8vGeVsVi3mzlcfalLYuEi/kJSFJ2/fHBlGMjFGKYgS6bdeO42yOpFbmIg8TiqPhZx5FP7H8KaIX1xtrItxrFvJWRtuF4ayRXT2/Oj7ZTnS0eWO8EoezmZV3DBf0fhapHjY5geg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvb888lPufvBjnXd1dKyR5YYnRb3W8cLir63ZDgVNik=;
 b=iJzXaN2+3zOsfzwGUgozdceStgnkSiDbUNs1kEui2b3LqpJo0NGxPm/7UuhiEQvkiQ8NeqokDKqVznBDnvtVfdRze9zS1aiFeFteiwksd5eqlcgklxkRUADFKNLU1H0DvxzD8t1UW5mH4dfpXmr2squF+AlMrOlvHuuwuBt7iqM=
Received: from SN6PR11MB3392.namprd11.prod.outlook.com (2603:10b6:805:c5::26)
 by SN6PR11MB2623.namprd11.prod.outlook.com (2603:10b6:805:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Sat, 27 Jun
 2020 12:54:14 +0000
Received: from SN6PR11MB3392.namprd11.prod.outlook.com
 ([fe80::a42e:1202:130f:db92]) by SN6PR11MB3392.namprd11.prod.outlook.com
 ([fe80::a42e:1202:130f:db92%7]) with mapi id 15.20.3131.026; Sat, 27 Jun 2020
 12:54:14 +0000
From:   "Meng, Bin" <Bin.Meng@windriver.com>
To:     Bin Meng <bmeng.cn@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm: Drop CONFIG_MTD_M25P80 in various defconfig files
Thread-Topic: [PATCH v2] arm: Drop CONFIG_MTD_M25P80 in various defconfig
 files
Thread-Index: AQHWIG7ht9muB4xY+U6WlPxfBFESE6jswqNQ
Date:   Sat, 27 Jun 2020 12:54:14 +0000
Message-ID: <SN6PR11MB3392B3F7A5EBF24B7FB75E3491900@SN6PR11MB3392.namprd11.prod.outlook.com>
References: <1588416347-30217-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588416347-30217-1-git-send-email-bmeng.cn@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da2a019e-0c55-41f6-24a5-08d81a993244
x-ms-traffictypediagnostic: SN6PR11MB2623:
x-microsoft-antispam-prvs: <SN6PR11MB262377B2154CC01CC774ECE891900@SN6PR11MB2623.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:230;
x-forefront-prvs: 0447DB1C71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/seN78h2CcQDg3oOdfYsk4SA+Re1iyw4XV1FtyM0gh7DzprPCOUEMknGTK60tqmyBeW0i8DoLdcJYV70sZBFpvhTZ3xM6GGyyO3YFZEcpWKnSlOLBWMDLsZ16K/v8CVXNGhvIE7A4zn9JKzPgrPB5sSSd8/8fQ2/jumOEc4D5cH8jKQbRMncuXhJs6Q/RsK56Hg/KonozOupVwsDrzUtH47Uwjg/kgpdjiUXmXltvpG9ZiYOcIAIIxMflhLuYKX0i00jP7Fb5IEdV2xKpA334vgdAvMJgVwp5CR/Z1+zwZCmpXeeid2yINO43Nx6H2cZ0elu6OHn/sB0zZK9cDe7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(39850400004)(396003)(136003)(83380400001)(33656002)(478600001)(76116006)(5660300002)(71200400001)(316002)(2906002)(66476007)(66946007)(110136005)(9686003)(7696005)(66556008)(86362001)(6506007)(8676002)(53546011)(26005)(8936002)(52536014)(66446008)(55016002)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2ihpLi7CUTzqUoq9wKxrRzK7VKZbO7LHCTt4SNO1Rv14xCGfegfHcKOC5L7SjVYv71jaMHmeQ7h0bTZ2jmBZydeI20KkMFKcuso1n/QX8KFwf3hS7SPc2fNJ6vu06eAFcZoAmE5c1GW4TPV8MxsJIxd6PpxAUeiuq1KyR6/D5DLXQRvO6I/R+kcZPBLdpydsTNy17mxgKy026LJtNH5RltqgYpq2YxtwiGBO6JVhIzF0hfx3nhGUOPCvyGHaQNmZJzWroAA2lVZEuqmzbQ4fP5N+NsB7oB11BFzSQeBreZngMoThTu8uu4rFOfTo4idR43Hb4Tr/rxJiCUgUNN35TfMM2UpmDgaNEb3V3ff3Qzfxw5azZEqyU2/UZ5kzk1I7qLZZDbrg5ZlrNbn0x+HbdYkQ7mumyqY3TcFi2ZnMKLEzVTHd8QXx0ICnUauL7lrNJOMVyi0NzizAJYE0sIa6LWpSY8QfWNq0REo9c6c5HNw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a019e-0c55-41f6-24a5-08d81a993244
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2020 12:54:14.6331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvq+BQPUmHnJdq1kHSpX012iTP////FsfVgirnlgbwPX6weSJncfm2lMw4RWxzJvfaXstcb+nkpOWYmDGiwUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
> From: Bin Meng <bmeng.cn@gmail.com>=20
> Sent: Saturday, May 2, 2020 6:46 PM
> To: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Meng, Bin <Bin.Meng@windriver.com>
> Subject: [PATCH v2] arm: Drop CONFIG_MTD_M25P80 in various defconfig file=
s
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Drop CONFIG_MTD_M25P80 that was removed in commit b35b9a10362d ("mtd: spi=
-nor: Move m25p80 code in spi-nor.c")
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> ---
>
> Changes in v2:
> - add CONFIG_MTD_SPI_NOR=3Dy in axm55xx_defconfig
>
>  arch/arm/configs/axm55xx_defconfig     | 2 +-
>  arch/arm/configs/davinci_all_defconfig | 1 -
>  arch/arm/configs/dove_defconfig        | 1 -
>  arch/arm/configs/imx_v6_v7_defconfig   | 1 -
>  arch/arm/configs/keystone_defconfig    | 1 -
>  arch/arm/configs/mvebu_v5_defconfig    | 1 -
>  arch/arm/configs/mvebu_v7_defconfig    | 1 -
>  arch/arm/configs/mxs_defconfig         | 1 -
>  arch/arm/configs/pxa_defconfig         | 1 -
>  arch/arm/configs/qcom_defconfig        | 1 -
>  arch/arm/configs/sama5_defconfig       | 1 -
>  arch/arm/configs/socfpga_defconfig     | 1 -
>  arch/arm/configs/tegra_defconfig       | 1 -
>  13 files changed, 1 insertion(+), 13 deletions(-)

It seems this patch isn't applied anywhere. Ping?
