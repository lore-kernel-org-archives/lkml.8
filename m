Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02162C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41CE206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mIkv0rEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgGIIVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:21:00 -0400
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:61696
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgGIIU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:20:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNz844VH/ndsD4MDi7qGQyQrTgs7u7c4gEZTY3o6afpJlE4I1bW/5D1LlWKPoxc9uL1My1Y490D7cNgqHpGDfdcB7Sj53+mNirwCIjmwwQKfR0pFCCz+OAjAciNn7MlnTCoe5D3OXeMYqIMW9JSF2fX7JAdO1jRp3UC7Pw6sVWWvR2AXMTXwo0+OZFlXz9+TSRYuB/qTN63oSzsodsA9qGNwJukZaWbYxX/N55GV/kCekV323PY20m7dx3NIWCwGsTseZaH6yjEWjZSg1MFdHtOmzMMroN6rFYBxe+yx2GaDcxJLoKz2oh9ITm4XtY7U3TfyQRx9sIe534HpdX3FtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wutgvL54vvSXVkQA7OtsFbtzROIbfU0C+HK1KdfNn4M=;
 b=fOTuN6WvYXttt1Suqvi2lWDpZxRsgdiYWy9H67gapHc/gBBp98w0ebiwbj1fe5Hcc7leWp8/twusV55y+gNqGyFuEA3JpudFklYVY8mMNZx5fhktEih2QtkhlSjKr+79t0qwam9GmQnTBasomwe/FGNSwk9ua+oPmLgzuUPvbhGQJ/Ej8V2424RwS8eQOfANPBmqdYrkY6WQoEOhCo6EDS6SoFk68Uo4rE7J7nMooi5hleltrYqZWjd0Yr1LlJCIvGepUnLZctZR2GQrYTALXZtfY5Pb40AdBK1zAerWYpG1FuU9QpnjjTSpM5+4VUIyuqC48yvxAtQWO6Em+nI1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wutgvL54vvSXVkQA7OtsFbtzROIbfU0C+HK1KdfNn4M=;
 b=mIkv0rEsvfgW3pL2aAk5ywCTAeYmwaZI/l7m/FiV8uSF4OFIR3e6PqvBSmBAPshykHkqA2DO/rDG/wkzUcn+ZWaiuNWDW3m7ThWRnWxLhnapgVtmL7fACSFBNkXQmOv/c9LfbhzvUFQXy55Z5pTGg7aNWDgQyBxBNAM3QncjPhI=
Received: from OSBPR01MB4024.jpnprd01.prod.outlook.com (2603:1096:604:4b::15)
 by OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 08:20:52 +0000
Received: from OSBPR01MB4024.jpnprd01.prod.outlook.com
 ([fe80::2198:7e23:8f02:b240]) by OSBPR01MB4024.jpnprd01.prod.outlook.com
 ([fe80::2198:7e23:8f02:b240%5]) with mapi id 15.20.3153.029; Thu, 9 Jul 2020
 08:20:51 +0000
From:   Dien Pham <dien.pham.ry@renesas.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: RE: [PATCH 1/2] firmware: arm_scmi: Keep the discrete clock rates
 sorted
Thread-Topic: [PATCH 1/2] firmware: arm_scmi: Keep the discrete clock rates
 sorted
Thread-Index: AQHWVRf8HB43xR4TjUalzDhTy/IIAKj+40Vw
Date:   Thu, 9 Jul 2020 08:20:51 +0000
Message-ID: <OSBPR01MB4024648DB0F2C680892B442FD1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
References: <20200708110725.18017-1-sudeep.holla@arm.com>
In-Reply-To: <20200708110725.18017-1-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [210.245.28.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8621ba9d-0311-4252-751c-08d823e0fe1a
x-ms-traffictypediagnostic: OSAPR01MB2913:
x-microsoft-antispam-prvs: <OSAPR01MB29138D876AB13D09BFD64843D1640@OSAPR01MB2913.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CzqJGyE9tvO/lhG80vv3Hhpwlt8LodiVIZ54Fb2aVpMuke6Dy1c5y1TcCiX2Lz8KTnpz90o3vjAOOPEBaQOp/vc4sbkEdjOzglF7Ab4QVIy0LWgSjw1dam1EqizUnA5zLCTNmI8G41cFRFiBUH9qEx85IeXB/BsSQMxG0oUg5GAcWHimDECEESqc0yemMNU6biwGKHc6JIF/GwDP1jiaZbIkmCiJbP4fPITASJgArWtPqARKEEFoWppWNa43JXL71z0ei47cYMI7aorx3AJyKeEbMdm5S1uiBwkW/FC9D1aeleoitWqIfS1lDqft0+lUGhEgteehfJVWkimLt1skdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(186003)(478600001)(110136005)(9686003)(2906002)(55016002)(54906003)(8936002)(4326008)(7696005)(316002)(71200400001)(83380400001)(76116006)(6506007)(8676002)(33656002)(26005)(5660300002)(86362001)(52536014)(66556008)(64756008)(66446008)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1kpnUCAS9R1IKpcOm2GQk6ndE8H+rZRV45+CJnExMqBRWKnNEuFJeqrtSt7a0XW1ktdp1GPbvZ/jAi4pcPXPgsWt4a0BQ/XyAdMq9k+TBmvxBkoduhb9VBWl0ZHAO/++C13txsptdhgTPv/FZy5D3IAKWy6HkEQMt5/ky7I4dLTgTDPTlCSVYpGN5c+jD/EVLFlWCD71SBBr6xFRyW/Wg/cVRR23V/va1q17ZZ5rUZuwWp/QmDMa6mj5IEfmQ5EyC+yHd5X9TP0NWDK727Hhq8NsJc9QEoPkPrfLlRsnc/LCD5fZia0zeVWCOZXneoASAnGDwUVyJ6kV8EL0zPPQTg93dDHaGZr1uLBaQBmmvDrGOZWBUxyRl7XvhNTWAuSkufowdQVQsmbJ39WSzuxkUa3SqfJkXxDA2hFAA/4qiLuPwbQ7wVsY9DwIzpg2VjMFhIPQlANigIceuxdv1ycOI3/PRzlJhKCZNhaNp6Neu5g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8621ba9d-0311-4252-751c-08d823e0fe1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 08:20:51.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pqszhjybc07oomyrs4BhpJ55Hmt3PL2VVRYcym6N08NXJbMjPGC9lJ/EXnZwZc5SxOyTwjgMiYgGBUO7Lr6Tw7DEsEn/7IVAKK41LjqZNOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

I share my build warning and some in-line comment below:

  CC      drivers/firmware/arm_scmi/clock.o
drivers/firmware/arm_scmi/clock.c: In function 'rate_cmp_func':
drivers/firmware/arm_scmi/clock.c:127:12: warning: initialization discards =
'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  u64 *r1 =3D _r1, *r2 =3D _r2;
            ^~~
drivers/firmware/arm_scmi/clock.c:127:23: warning: initialization discards =
'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  u64 *r1 =3D _r1, *r2 =3D _r2;
                       ^~~
  CC      arch/arm64/kernel/vdso.o
drivers/firmware/arm_scmi/clock.c: In function 'scmi_clock_protocol_init':
drivers/firmware/arm_scmi/clock.c:197:3: warning: 'rate' may be used uninit=
ialized in this function [-Wmaybe-uninitialized]
   sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>-----Original Message-----
>From: Sudeep Holla <sudeep.holla@arm.com>=20
>Sent: Wednesday, July 8, 2020 6:07 PM
>To: linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org; Steph=
en Boyd <sboyd@kernel.org>
>Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-kernel@vger.kernel.org; Mic=
hael Turquette <mturquette@baylibre.com>; Dien Pham <dien.pham.ry@renesas.c=
om>
>Subject: [PATCH 1/2] firmware: arm_scmi: Keep the discrete clock rates sor=
ted
>
>Instead of relying on the firmware to keep the clock rates sorted, let us =
sort the list. This is not essential for clock layer but it helps to find t=
he min and max rates easily from the list.
>
>Fixes: 5f6c6430e904 ("firmware: arm_scmi: add initial support for clock pr=
otocol")
>Reported-by: Dien Pham <dien.pham.ry@renesas.com>
>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>---
> drivers/firmware/arm_scmi/clock.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
>Hi Dien-san,
>
>If you could review/test these patches, I can queue them ASAP.
>I am planning to send the PR for ARM SoC later this week, so I need your t=
ested-by.

I applied the patch,
Although there are some build warnings, but the patch effect is ok.

>
>Regards,
>Sudeep
>
>diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi=
/clock.c
>index 4c2227662b26..2dd119cdebf6 100644
>--- a/drivers/firmware/arm_scmi/clock.c
>+++ b/drivers/firmware/arm_scmi/clock.c
>@@ -5,6 +5,8 @@
>  * Copyright (C) 2018 ARM Ltd.
>  */
>
>+#include <linux/sort.h>
>+
> #include "common.h"
>
> enum scmi_clock_protocol_cmd {
>@@ -121,6 +123,13 @@ static int scmi_clock_attributes_get(const struct scm=
i_handle *handle,
> 	return ret;
> }
>
>+static int rate_cmp_func(const void *_r1, const void *_r2) {
>+	u64 *r1 =3D _r1, *r2 =3D _r2;

It is better to add 'const' as below to avoid warning.
const u64 *r1 =3D _r1, *r2 =3D _r2;

>+
>+	return r1 - r2;

r1 and r2 are u64, but returned value is 'int' type.
Do you think we should improve this ? e.g. return (int)r1 - r2;

>+}
>+
> static int
> scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_i=
d,
> 			      struct scmi_clock_info *clk)
>@@ -184,8 +193,10 @@ scmi_clock_describe_rates_get(const struct scmi_handl=
e *handle, u32 clk_id,
> 		 */
> 	} while (num_returned && num_remaining);
>
>-	if (rate_discrete)
>+	if (rate_discrete) {
> 		clk->list.num_rates =3D tot_rate_cnt;
>+		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);

About warning of above line, I think it relates to below snip of code:
                if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
                        dev_err(handle->dev, "No. of rates > MAX_NUM_RATES"=
);
                        break;
                }

I see that in this case is true, it is not proceeded as error case,
If so I think you can update 'rate' for value from 'tot_rate_cnt' to SCMI_M=
AX_NUM_RATES at here.
How do you think ?

>+	}
>
> 	clk->rate_discrete =3D rate_discrete;
>
>--
>2.17.1

Best regard.
DIEN Pham
