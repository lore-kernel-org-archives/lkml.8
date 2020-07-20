Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D386C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C2F2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="rJVzqsgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGTIov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:44:51 -0400
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:28513
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbgGTIou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:44:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3YE15auL8hoclSeMWUWOnhOxHYnOdZIXRZRE89Y1FlMrlVkOFXqZINia85XcogsZz7q7LCj0C9pWTDRYyo03ZGccyrddpWncvXxV3+FZCUiLLxeth8XvkJLpk+2wFmnbGsxs8LlS3/8Wv/Dv/PtkkmNp1+V95q6pNj4tmqWkytoRGoe7Y/q6OSgT84PpDvAaua7OYt9GjVaBK3rpoaNoNEqaTlrELK/ugBFgu5xKpf5zgp2/hpxIcq1EVVhYMy8AGTfVJEfO4lZ5ieSEoF9gZMZUvHecNfxOjVT2MjFj+27DuJmbqpPpl8jLGu9VprbHWjBfo6rthu69Ciq0Ra1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOdWTq+Sw4jpITq4OvkK4PggcSebbtA9DK5INe8RIoY=;
 b=OTQgKs0llodWWCbjbvXK0ID9ClRNZFa7hRBLjinpYPj8PfVrdxetlZEcyxOf9xWrBy90AXONZnLTEn+MvOzf8OYx6rMyrJUUEmMQdJCy1ykH8Hh3ZwIzDEaZnzGDPFUppqk/6ItBZukORVXx1SQLoiF3Yc5dCiu5+UIdjslV4ZmxlwxtS2z5aMh4TukzW7XwCBjTIIuatDMo2Z2108JC5G90VIfDos48Ihjge8jhJ28lJXRJLtBexcc+KzPdwh6GirdE5tAx+AW2n+4MtDbOw+Q24ufzDhQIQvn1EJP0bqVKx0ntQtiNb6lI1TjrivHfydLVkgZQC6JtDnK+x2/OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOdWTq+Sw4jpITq4OvkK4PggcSebbtA9DK5INe8RIoY=;
 b=rJVzqsgMBJBPhnHzanwgXl+6rz5JcfrjM1zkiS5zjwu2++nE824IleIKqSCV9pwRUBjXSuFvMGdDNsJbuU/8nLZUOi9EB+gogWKFrAYv/gox1wLQfyN3xUiHUxEOuRbUjHL1tc5SOOEgMLdw1s6oOkgxZr/tT0VgH9F3OocGZSs=
Received: from VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:31::26)
 by VI1PR10MB3216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 08:44:45 +0000
Received: from VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f97b:2363:7cfc:9150]) by VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f97b:2363:7cfc:9150%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:44:45 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: RE: [PATCH] MFD: da9055/pdata.h: drop a duplicated word
Thread-Topic: [PATCH] MFD: da9055/pdata.h: drop a duplicated word
Thread-Index: AQHWXWOqc5oFKSH7v0mQBoTjiTGJYqkQKPDA
Date:   Mon, 20 Jul 2020 08:44:45 +0000
Message-ID: <VI1PR10MB1662778E8A0A9E080275B067807B0@VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM>
References: <20200719002917.20521-1-rdunlap@infradead.org>
In-Reply-To: <20200719002917.20521-1-rdunlap@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0541d592-0426-4a83-40ce-08d82c892761
x-ms-traffictypediagnostic: VI1PR10MB3216:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB32161B6A3566DF2304DB7D29A77B0@VI1PR10MB3216.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nd6fLznm17Uc6EpjWC1rZD2zPOvitR9H22fPs9xKktYJGAKc5xWC3r0gt27BF19gXknStFyf2/9r3ymrsuyghvVEio3tguFU7tLoNtTX8aKNlEwd1i7HVy+/uoPYDGdgyJKpt5FO35BmFE3+YLjsyf0uRqUEnntCUZ75Rg7/CSkWFm4gSviqwfI/ZI+0QbDy4IrPwDKtE7f/fgUu7teoIjnCyknU4ZghE/XqMfncY7xGWtbYKOA7rTll6mwqVdO0Hmczew7zO9C97e2MlyQTDwZ3I75EQCCr/0kF+QgdpB5qXMULLO+Hn6EKOMEl0eyO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(39850400004)(396003)(6506007)(55236004)(53546011)(26005)(186003)(7696005)(110136005)(478600001)(4326008)(33656002)(54906003)(316002)(4744005)(2906002)(66446008)(66476007)(66946007)(64756008)(66556008)(55016002)(83380400001)(5660300002)(52536014)(86362001)(9686003)(71200400001)(8676002)(76116006)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ow8uCATZiWF0qSZnNaxdIcy2fmMIZmgL1F8qhQS6fEhsiauRu7aM/ZugSB938vlD9DG9gCjA5EJxWYXo7QPKZ9hOjNvJ08sLLIzN68GF+3oAYZ78cF/SDeBzXagQRaHJ22LtdK5LOhTWz65CsZslQdcjh2Zt9c9OIh0t83I2hvkQBZeYZb2t86DoDlHHwn/jAJcmymaKx4GkGTHRa8BrWW6lQuaZ8/Onu2HqkC87QDn9Epv5FRjMpn8ycUfU/WOLvc5o3hAUeYsQTUoaRlZ2v5MPg5eWKIQT6C94a1omynACnAlcBBUQcpiPVGoZoOlPfoZTtnkVavhUESeiggKgI6HjKk9l4sUVQ0p6mPcZ22u1tLwtJ4GD0cFmsKgQ/Uq5NwXxs2L2MTixWs1R8I02p89vkdUUP9F7vcNjnJADYejMMyG27zrtdZpekVKxpU2AYjk58+QJAFFc0uDf8K1P7N4VSTOu4svzOil1mSNfX/I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0541d592-0426-4a83-40ce-08d82c892761
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:44:45.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzeYiBAFbdi0IxO9FRngqkbcyABAggSz4OAP5SJWlybruH/IrubOgiNgH4nsmL89bOVUSLKw1y4ibICU8VZMUkiKm66+lNNtJEaQxWQmACk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 July 2020 01:29, Randy Dunlap wrote:

> Drop the repeated word "that" in a comment.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee.jones@linaro.org>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  include/linux/mfd/da9055/pdata.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-next-20200717.orig/include/linux/mfd/da9055/pdata.h
> +++ linux-next-20200717/include/linux/mfd/da9055/pdata.h
> @@ -35,7 +35,7 @@ struct da9055_pdata {
>  	int *gpio_rsel;
>  	/*
>  	 * Regulator mode control bits value (GPI offset) that
> -	 * that controls the regulator state, 0 if not available.
> +	 * controls the regulator state, 0 if not available.
>  	 */
>  	enum gpio_select *reg_ren;
>  	/*
