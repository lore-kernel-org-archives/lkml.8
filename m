Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5FAC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A8B2072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="auNc/mW/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y8v1zbBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD2GUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:20:03 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:60848 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbgD2GUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:20:02 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 718A64066E;
        Wed, 29 Apr 2020 06:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588141202; bh=rTGzQD0DtCdGWQshK24nEVitEQdDkJ+cP3mFGR9gIoM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=auNc/mW/J2OEM2QJgLa+xfjSlZBSMmSUq3IbNvRsQ403ve2rU30H889WuYGukA2RU
         7Z9AP4Nlj/FZNWod6dzhNs+Z+zEwkZPfDO28IoG73/CVYDXTeb6KwzaeFU/FtTlZBg
         cSPXKqjCzbiRUj0r0uYvyJLandvEFmLqBwpHH1yVV+PZQ6whTEfANTzzcypHTPycYs
         /v8BPlN2CXw2nSDLf5bxzVg8Mr2/QB7XJr8Rn+2hYXTMi0rTLDzYZGneM7eOaOpv4h
         mwOqGD7lAj/2Mhkw7yQD7bdHsqAah9Rfsj/5T7oSTUkbDcJSBtN3nztTNyUH4ylJiZ
         uC+M3l95Z+svg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F2E51A00E3;
        Wed, 29 Apr 2020 06:19:57 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Apr 2020 23:19:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 28 Apr 2020 23:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A727wPG0DAJG7GUkP9nNThte6RxyAL2JKEidmawaTIzLXL42vIeqh7kXXKblKjASavKICn1xs3oc4xBPzSrQKcsrUlz4EF5WIhJAZ/6H+H5BwA0uEBrtgilteLTTdLREVrYwEBE0/5nKTnf3vAyYrpLTxRa33PxK15UHYyFQK13JlUSqRGGmAS5SvAfxfkunJWOSS3Vsa0B+o93Awu5SuLH09LfbvmQdVaF8oUEpEwzsWOzgoRyn+1pf8XkAvJR1bFB3vkw5fTrbV9ZF85cs7zrBYBTZoHfvD64dV0+p3zmtj/6edFI4AaTo4Ipz8BRp6jr37Vk2J5npnavDtDwOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTGzQD0DtCdGWQshK24nEVitEQdDkJ+cP3mFGR9gIoM=;
 b=lYyLL8FXe4NSra0jecwDdKPjNvpymrFrhcOlAg2HmfLjNe867+o5iNBvfwP7y/gxpdZ0eNoDx2/Tm6gAkBdFiJQ0WJOg2jelS7c4/RYJwBbcApgLfNBvxiVIxnx5ZeT4BpWx79h2SP7eesbcZuSz+S5OM5Pp6GxJNCNOHaWYzAOVnUbh65Rj6D1EO3e32XsSuiitOxSgOt4HBXexXdys68zfOhBYaJSMRz3FfLS6zXh9SsOH4vMVVq2PAI4c5rdK9Z3kKB60JpxE0A6Hq333+UDleFtycnVqRkRX1zjfllRdwygKxdzXdEk4eLmlVNg3Ltm2cGsu58wTYQViE3bzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTGzQD0DtCdGWQshK24nEVitEQdDkJ+cP3mFGR9gIoM=;
 b=Y8v1zbBfgOJUVieTb4yfFpw3Njm+jd2A3Wk3YtkNqHVigeSstIXQe2adBof2V+zYsbtTtWFwdrUaLyatHsC8SRmhhR8JBQPI3sFMV2sUa9hDQd/71FD61gyoLTlszq0AtNB0MV+jqarK6QiQ6aQSB9DQQg/MRomSFflIU4xW/fg=
Received: from BN8PR12MB3266.namprd12.prod.outlook.com (2603:10b6:408:6e::17)
 by BN8PR12MB3107.namprd12.prod.outlook.com (2603:10b6:408:46::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 06:19:55 +0000
Received: from BN8PR12MB3266.namprd12.prod.outlook.com
 ([fe80::651e:afe5:d0fb:def4]) by BN8PR12MB3266.namprd12.prod.outlook.com
 ([fe80::651e:afe5:d0fb:def4%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 06:19:55 +0000
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Subject: RE: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Topic: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Index: AQHWHY4gqPzpvJC7j0qx04E/xf4m+KiPoJXQ
Date:   Wed, 29 Apr 2020 06:19:55 +0000
Message-ID: <BN8PR12MB3266393BD37EAABBF45D8AEFD3AD0@BN8PR12MB3266.namprd12.prod.outlook.com>
References: <20200428185024.5168-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200428185024.5168-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d55e411d-d32e-4b2c-d445-08d7ec0555c3
x-ms-traffictypediagnostic: BN8PR12MB3107:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB31074C809AFE048F8B966FF2D3AD0@BN8PR12MB3107.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3266.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39830400003)(366004)(376002)(346002)(136003)(66476007)(66556008)(110136005)(107886003)(9686003)(478600001)(26005)(54906003)(6636002)(186003)(66946007)(316002)(55016002)(64756008)(2906002)(66446008)(76116006)(33656002)(8936002)(7696005)(4744005)(52536014)(8676002)(86362001)(5660300002)(6506007)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sLZC8kjyXlHPjatdvPgXaxMUUkHW90+oA+77hfeFI3QcUxlzYzpOO98BagZvvXhGLyZgJ2UYbI7KxLK3Q4loOhsN3UqRzDCix0yaH/cTtXzCLueRmpyAqcxQlJCEjw4vhB9P3nhgbWlwKdyAkFmoRB8phCipALSyRpv/dKI1w9FqK9BuEoccPdA2DHq/q/q21mLbJMGn+P7Crq+9RKabODrJFB4Jx5SG80GotiTPmU12o+Oa7T1UeBdi4+kqwF6ePA/NE4Dvx68j0mezcAo1zbUPHhlTUNFs2vpYNtoyZvS1Px55nFHdYBR97uzs6A4kA8aCqc0pHoRFZHPmzR4XvOfee9lsEdyJ/IHaYRI+CeQuLwKcAEVifNiWe205PbzZslbzUQlXWbLzSCaIlYV7+zS4TF001fSog3ilRox5UU1WByAHPJ2YQ7rnNZQnIwXO
x-ms-exchange-antispam-messagedata: gMdJn8q9MSC4uF2eEW63lhAqVAMe9T7f+1CBNK48anIt1dzIphe6ry13NIU54+rpExcG7HcuVK2unQozwkLW22sBA98k64PmaS+bEcc8j8vHUJkcn/L9o/QEsspkw+6nPGW6Hb6wV+xpcMyUCXD2+D103iK36mfCMxlJJ9fEMTtVSWnkUtQQWjmxhdnGwtzfv37jKdbhSizaLtgJwyeY0rnW1eaLQTc1Y6OPLVZwWqbYw4F7W53L3gjM5uEImvm+gvg1VE7rB242jIApZ7Xwbd9csIGhlRzwmU4TZYIOQLh2qltiyCWubM3Iqp8Z2SE24AS3hCVZq+sXsIWqb1r2iAMcnPfjHZnxI7G2uF/q4l25H4G+8EtoSrGYaGqW2mjD2Vv90qAUgXXF32BglYavuoTDsGIznIpovIn10oGs3SZBGLy8htgC2Sm22saYKBFcnJQrm+3K8NgXSv1D7XYP7JTtc+YpEovE/oI6ircFnpWXRrgVdjeeYVJOD34o10yS1NQCalhZka6xs1hzHEp5I44mhnsls1AnImKalHHt7OjTa1rreiB4AiteBzWw41EwVJBqjJh3rjU5zR1SgwV36uOLF1hLnooIsuTroFe8cIaXwdDm1xP3wBLlQxWNINhV3uZXjnF6e4JJ77RJ1X1/eij9UChWBDH45gznffQSbgJboTcbdYEFHIzym9xjcsP1wZchowUCzi232EM1HEuIpP01XtuBY08O4Lsfz7Huhr/5igfw9xk//81qfouSmonfr1CkUueE+EhGYspueVyFG9IjmzZYM+E5FTx4T4lsLSQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d55e411d-d32e-4b2c-d445-08d7ec0555c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 06:19:55.2894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7Yv/+HxMtH5hQubzkON69KHKnUe3HLWEH2PD3ex6lIHkbrBLxznTI6cuk/X1hcTqEATOgJbcXvPbmaJJc0vgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3107
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date: Apr/28/2020, 19:50:24 (UTC+00:00)

> As of today we guard early DSP init code with
> ARC_AUX_DSP_BUILD (0x7A) BCR check to verify that we have
> CPU with DSP configured. However that's not enough as in
> ARCv1 CPU the same BCR (0x7A) is used for checking MUL/MAC
> instructions presence.
>=20
> So, let's guard DSP early init against non ARCv2.
>=20
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Reported-by: Angelo Ribeiro=20
<angelor@synopsys.com>

---
Thanks,
Jose Miguel Abreu
