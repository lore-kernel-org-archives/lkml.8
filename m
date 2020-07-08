Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A163CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E76020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ri7tx29Z";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ff23hPqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgGHOT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:19:28 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:9168 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbgGHOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:19:27 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068EIF2Y006985;
        Wed, 8 Jul 2020 07:19:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=pEUqvho6ZrH3s4o8FLLvR+yKqZGvhHh382coDQzGEYc=;
 b=ri7tx29ZrJ3LTEezK6GsT9PQyjTMKydqXl+hGgnpvMctpSKiAcvF0lEC4jB/2X0IY68M
 T4hyhLQCISHJtoZVek0uHroYRJtTxZy1LZvSARj9LYx6PcfYCrq/DTI16ua/rwYs2gvP
 xJnMm2STMMuNXqiqG2Bw2J4/dxXj/opREMmR+4FuEhUJlpwvrlSCZBCzlROdZi2/5d+i
 KV8aG+JrVNIEWLgu00ePhvAv1XAXvlCnQaDoc3holPEJ/Ftbn2NBk4HqUfQo4NCLJyKQ
 4XHX/e/LZlIV4q+fsbjKjA/4VVyO3K122jNwRhMUsqWNP+rs3LwpKgSw3q6Ov7UdNdOr bg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 322pay837y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 07:19:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra34H6LDqjGqL51AExlfVD3Ym1B4BU6UFeeG2FWuKVemOFxnnQwy8oSwIM6L+Xt9Uu7DcO9me9pTUVoaOWl5UJGEw9YQuPIB820u3pD0zrRjhHMuQYvTBZt9bAJMja6Ui70oYLs/sRgAnAz07S0JZpNm/mr6TJLNCuFQshPuobdB7LKv9pYXV4E64hc4sjzkCjsUCaPpuSa1YzQo+UG9VFLkYuQFJ8x3hMf4ML+y87DOOOwPThVODuT/yu8zLbxZdKt4i6i9x6DW/DIzncR3kiJrF/h6r5TJtjHPSY31/TkIf5KmEHQBLTiFiGqYAGNYN0EYUyjiQXAt0FZwvYgodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEUqvho6ZrH3s4o8FLLvR+yKqZGvhHh382coDQzGEYc=;
 b=oafXvD9uImRPME29XLYjb8EzrZH7HOU9KK8c1r/JoPXJuxDTwY+ujoTajRRnkbvMcWBpt4R6KnLNYYW/Tq2D0b4250rMOyLxopwKTnwPhuWlG8b5/p2vCdyiIyGngEHB6rdcTFVf2VefztJQl/vPLwsH9tFFD5CbelruVoP/MxuNXmdAR2xoVuEzGJFPy1QOS9honuDZ5TzXcjpCMB5GmLl3Bw1xCL3hDMAuk8k7KgQ2bxza+b16j6canEssvw46PWJUYmJsstV8g9CWQki9icljAzBpm+SZSjDt1FRPSbhGjBOsgYIw4+u8qiQcZHVDMccMCLIpRkvHO2jyfl48Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEUqvho6ZrH3s4o8FLLvR+yKqZGvhHh382coDQzGEYc=;
 b=Ff23hPqPnAMJUBrzTRwxOLVtBfdyG9UGTkPJzYOefDi0hsuV3Mz5xx/la9oxsCbNJo+VoLe87a7VfUKrVoL7BpmLCil+HsHz7/Bh8p1IYU0faF+9wzgGOoZhIk9mvZe3Pra66SiycmJmtVC6nP2BMG8Q3o1e72YjnFiNBkqmrd0=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5675.namprd07.prod.outlook.com (2603:10b6:5:32::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Wed, 8 Jul 2020 14:18:56 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699%7]) with mapi id 15.20.3174.020; Wed, 8 Jul 2020
 14:18:56 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH 2/9] usb: cdns3: Improvement: removed not needed variables
 initialization
Thread-Topic: [PATCH 2/9] usb: cdns3: Improvement: removed not needed
 variables initialization
Thread-Index: AQHWT3AXbR9NJZf3Uk+pPHARL3MaNqj7r2UAgAIUBWA=
Date:   Wed, 8 Jul 2020 14:18:56 +0000
Message-ID: <DM6PR07MB552924C997407B3567A5C1E5DD670@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-3-pawell@cadence.com>
 <20200707062341.GC16073@b29397-desktop>
In-Reply-To: <20200707062341.GC16073@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjMwNzU2NWYtYzEyNS0xMWVhLTg3NjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGYzMDc1NjYwLWMxMjUtMTFlYS04NzY3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzg1MSIgdD0iMTMyMzg2OTE1MzM0NzYzMTUyIiBoPSJTY1AvWWZrWnQ4WU5HU1pYdHd1NG44NFFwbG89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b2246cd-582c-4776-b89e-08d82349d9ce
x-ms-traffictypediagnostic: DM6PR07MB5675:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB56755B305FE84B1D5F1DCF46DD670@DM6PR07MB5675.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwMzW6voRskvo9r39MifTsXx8UJF/jXxi3Vm6ONWNGiCvlsduLpF5MY3G4YGtXxdqcuGp4F2hvADb2HSpC2gY+m4tdxsNcv/d1tCEdPS7k0C8YeFZqOXime7bGLcyIkA0eXJVbLrlW0lcPCnnY4pzmSWgAlxv3/bz865wlanISRvzRBaE5dQi1yteK6BkSw0Omsjcjppfpu6/70mW7D3jX9j07Ge9psuRHcmq3G2Jx3wfGlimL9WxdhDXRK4wyvGidaAmDRFGNvfQPViLmFtXUjJ9mIKLbwk3jfdTB85BUkF/bUnmBKPY2l1tD5kcYOhAw0am5oNT4+bIdS9Vy7GIbRbs6YmrueLNRj1kjxc211Zc/6lOCPKfHhXC7cG1Db9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(36092001)(66476007)(7696005)(76116006)(83380400001)(7416002)(66946007)(107886003)(64756008)(66446008)(2906002)(5660300002)(66556008)(478600001)(4326008)(6506007)(33656002)(316002)(52536014)(9686003)(55016002)(8676002)(86362001)(71200400001)(26005)(186003)(6916009)(8936002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: d09wHP1QC5kTGJf4VoZhuspQpJZ3z5U0J2BCirI1N4Vg2FxGkmL2NRZX51QOrynoZ8vnPALeqYs3tVQ0H3+QxJSJQOVGJUZLZHNfl96TGcNTR5iJ2HEdSbtF9FrAHD1aPAL6jHOSHWZ92FD7Y22Q+dHNRVn41AOheO+LhPkDbniD2KvfeOVWs0acfrH8DLy04jL73qGqIQEvLbC9oOs78S3T7Baw3IIeDMHOhcAwBR3zBmdGSwQtJGz8//EwMwks3EOn6Xowt3y71Kaw2Ennvbcb8mTMgDIcJLa6dVh68DEAlzXNPdnhF46n0yBjwXZNeI+WsTx3gfdhbVcRGGT/i203y8MMf4bquGJAt2tf0kkqZOlnXOkfMe9iVKzq+yGu6RighzWPXYQAMM6BxtI8uXU9iGuTOX2ZvS/7JsQ6xjJBOiVmBAcMxmQOXxfV86Kj2WHqN2pfO2loL2WEZ5WfTlmv/jS6bG/PX0i1dKFGuoZwbbi9XICrEvc49CZfCuYB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2246cd-582c-4776-b89e-08d82349d9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 14:18:56.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkBvwZuMLm9A922nB0hr6q/1aRu2JsrIX7hzoHulaASlNapkqhaqnkoP+ESvkiLajnAXkZpD0C8HhUriMz9NgPOW/zNXeAqWiVR4ikpaorE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5675
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_13:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0 cotscore=-2147483648
 priorityscore=1501 mlxlogscore=753 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On 20-07-01 08:19:57, Pawel Laszczak wrote:
>> Patch remove some variables initialization from core.c and drd.c
>> file.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/core.c |  4 ++--
>>  drivers/usb/cdns3/drd.c  | 19 +++++++++----------
>>  2 files changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index eaafa6bd2a50..c3dac945f63d 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -86,7 +86,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>>  	struct device *dev =3D cdns->dev;
>>  	enum usb_dr_mode best_dr_mode;
>>  	enum usb_dr_mode dr_mode;
>> -	int ret =3D 0;
>> +	int ret;
>>
>>  	dr_mode =3D usb_get_dr_mode(dev);
>>  	cdns->role =3D USB_ROLE_NONE;
>> @@ -177,7 +177,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>>  		goto err;
>>  	}
>>
>> -	return ret;
>> +	return 0;
>>  err:
>>  	cdns3_exit_roles(cdns);
>>  	return ret;
>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>> index 58089841ed52..4939a568d8a2 100644
>> --- a/drivers/usb/cdns3/drd.c
>> +++ b/drivers/usb/cdns3/drd.c
>> @@ -29,7 +29,6 @@
>>   */
>>  int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
>>  {
>> -	int ret =3D 0;
>>  	u32 reg;
>>
>>  	switch (mode) {
>> @@ -61,7 +60,7 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mod=
e mode)
>>  		return -EINVAL;
>>  	}
>>
>> -	return ret;
>> +	return 0;
>>  }
>>
>>  int cdns3_get_id(struct cdns3 *cdns)
>> @@ -134,11 +133,11 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdn=
s)
>>  int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
>>  {
>>  	int ret, val;
>> -	u32 reg =3D OTGCMD_OTG_DIS;
>>
>>  	/* switch OTG core */
>>  	if (on) {
>> -		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
>> +		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
>> +		       &cdns->otg_regs->cmd);
>>
>>  		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
>>  		ret =3D readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
>> @@ -212,7 +211,7 @@ int cdns3_drd_switch_gadget(struct cdns3 *cdns, int =
on)
>>   */
>>  static int cdns3_init_otg_mode(struct cdns3 *cdns)
>>  {
>> -	int ret =3D 0;
>> +	int ret;
>>
>>  	cdns3_otg_disable_irq(cdns);
>>  	/* clear all interrupts */
>> @@ -223,7 +222,8 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
>>  		return ret;
>>
>>  	cdns3_otg_enable_irq(cdns);
>> -	return ret;
>> +
>> +	return 0;
>>  }
>>
>>  /**
>> @@ -234,7 +234,7 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
>>   */
>>  int cdns3_drd_update_mode(struct cdns3 *cdns)
>>  {
>> -	int ret =3D 0;
>> +	int ret;
>>
>>  	switch (cdns->dr_mode) {
>>  	case USB_DR_MODE_PERIPHERAL:
>> @@ -307,8 +307,8 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data=
)
>>  int cdns3_drd_init(struct cdns3 *cdns)
>>  {
>>  	void __iomem *regs;
>> -	int ret =3D 0;
>>  	u32 state;
>> +	int ret;
>>
>>  	regs =3D devm_ioremap_resource(cdns->dev, &cdns->otg_res);
>>  	if (IS_ERR(regs))
>> @@ -359,7 +359,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
>>  					cdns3_drd_thread_irq,
>>  					IRQF_SHARED,
>>  					dev_name(cdns->dev), cdns);
>> -
>>  	if (ret) {
>>  		dev_err(cdns->dev, "couldn't get otg_irq\n");
>>  		return ret;
>> @@ -371,7 +370,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
>>  		return -ENODEV;
>>  	}
>>
>> -	return ret;
>> +	return 0;
>
>Is this necessary?

It's not necessary, its only improvement suggested by Dan Carpenter
during reviewing the other CDNSP driver.
It improves readability of code because we don't need analyze what is=20
in ret variable.=20

--
Regards,
Pawel
