Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86487C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCCE206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Uir3iOPb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="H2iULZ75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHCE1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:27:46 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51134 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725908AbgHCE1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:27:45 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0734Outp010543;
        Sun, 2 Aug 2020 21:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=8f8HKQ3lkaLpS8NPhK8wiKbn3kUBkIzujT5yJncN7LU=;
 b=Uir3iOPbBGJ+qy/NLOJjclPY38E7mjVUgY8HhBinkW3iL1HrF9dp+PTIlJnBBvReFmrt
 ANlr6WVwBaT7JBGJ6zKrvtRYIkIpAGqhZ3ZwT+tuZllSfRyrBGl8grQMiFFYpJS7cftQ
 anma+y9Ee0dUhLMVnjjpJCDANxmlS5E6zmQ7sZ8HBVu3QKbZp+xyog1rgrMCrEyiRX+g
 zSTRtoQY3gLhlBW6wNJVw9diRnEUh1Dv5nzMldjPTutzoVDg0rgzrgRZRtj4HtS7S8Cr
 3qCP1/mvTTWrJwu8BkfW3yumHwrXIXFhncOlsfBYan/vFSNTmy1fUMSEvxjeDABpHU52 Bw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-0014ca01.pphosted.com with ESMTP id 32n8gxm691-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Aug 2020 21:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHo4wwjMPA80hQL5lkFFunLL/b6Bjtc96gXCgHliFiJsseZ6s6f/CVNwvZLgC7+Najod50gjhMtJc4l7jJNN+CvynTBz1htMKq7ZLvxvmB5Do0cYd9+XLSLCnRlOWDvQR7E/o+eV/wGlXR0ZHWVYOnyJaykDXQFlQUCJw9pluurWlYUFob6ogd61FjwH6KGIMMi3H6lTGKh2eqqEMjEHUy5tWDXKPsONw2lkEgznbaZTXNMusz/8zvVwX+FY0J0bAT0hbrYivkcNxjouQApAWQXq/d0okDEROSSbFWezye/8w7719rFQ8yvRWNIdggBo4X3EMS0zXwvmhC97Dq/aEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f8HKQ3lkaLpS8NPhK8wiKbn3kUBkIzujT5yJncN7LU=;
 b=V+hVM16J9amynhW5ryo9DrU4WAU7Ys5yVnV6nUAwRuNHUvay2VWB5CG+7en4cVpqOZnchW4iTs4L9xUdx1R2LW7xBrodhgtHjYsZtHDLw0ccoZgYqlx4WPb5jCcjgexUsU+G8crjmk0EzXe9s+axj0Nb71QWmBRi+8/fxrE2PEwgHpmPFXFGBhhTk77MqesmDIsm0Nf+VgybE/gc7udf3zVaxD/Ii1YuvrfLH8oZY4+onHGBAvQMqwXsG+I6bUcXNPZDN24RYKv5xaSXTNyv6ISSHrreBoeUyH5pzUGr+CAVi8+MTXTApC/c5q9y6ThLx6DJwSbrU/AieBveVhN6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f8HKQ3lkaLpS8NPhK8wiKbn3kUBkIzujT5yJncN7LU=;
 b=H2iULZ759Afzus/SMTxRaikHIvz4/1HFxfFhlRxs008KZyFlUn8TjIcAzCL8kVL7oxeuZC6FuNW8rvptPLE3x/97SGBV0Z4leaKd+HwyFqh/9sfYmdo0XtM1wJAxgJ8HWE4mGcpt1gzbxF3Eg7rr0CNgP8IX7+X2ORjk+2GW9EY=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB4460.namprd07.prod.outlook.com (2603:10b6:5:c6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.19; Mon, 3 Aug 2020 04:27:17 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::35cf:ffb3:3776:8362]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::35cf:ffb3:3776:8362%4]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 04:27:17 +0000
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
Subject: RE: [PATCH v2 7/9] usb: cdns3: core: removed 'goto not_otg'
Thread-Topic: [PATCH v2 7/9] usb: cdns3: core: removed 'goto not_otg'
Thread-Index: AQHWWP1JVS+n3WQDxkyDvzwFhNzdrqkS8ReAgBL3eFA=
Date:   Mon, 3 Aug 2020 04:27:17 +0000
Message-ID: <DM6PR07MB55299BC37F8BD76E2551759BDD4D0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200713100554.28530-1-pawell@cadence.com>
 <20200713100554.28530-8-pawell@cadence.com>
 <20200722024051.GF5807@b29397-desktop>
In-Reply-To: <20200722024051.GF5807@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOWFkMDA1NjItZDU0MS0xMWVhLTg3NjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDlhZDAwNTYzLWQ1NDEtMTFlYS04NzY3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjE1NiIgdD0iMTMyNDA5MDI0MzQ1Njg5MTkyIiBoPSJmS0dxdENFOVlpcXZNQVBLemJTdm5KNnMrRGc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6add4d17-399a-4d47-cb0e-08d837658163
x-ms-traffictypediagnostic: DM6PR07MB4460:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB44602E993FA9768366B906E5DD4D0@DM6PR07MB4460.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEel84c/DjIbhM+bHAmO/BkuI44oqHmtaG6z090Yr14BrpnHZkKWI2ubKnZqA7XX8RDGqmIZG5OZBbg1O43232SyYuFpuaRLYcMXzCLVKXR1gsgyNsSKyQFmx6ttXHSWbZiU+xG27cLNuowRH/pzlU4W2ZOaK3JyCB7WO62i6DnTmIwybXxea8PJMK/r+Ah8WktYiwCFkSEMaBtr6mr6sfLrawHQR9ILy0TvhhYX2SLQ8/nhzzsr/nFvwi+27YtLnVcXk09LLi5KVx6tMNTgDivVusOc77s3BvOYYmiWihPCOfRu4u3z6dz7qmfTqsGcuqb9sSRI7o9jaaNyhzZvsdj7zoKtQoYf/0KzaGRNoTh7JB4Xa0dYY2rUiAaAkuHH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(36092001)(76116006)(66556008)(66946007)(66446008)(107886003)(66476007)(64756008)(6916009)(83380400001)(9686003)(4326008)(71200400001)(8676002)(186003)(7416002)(478600001)(5660300002)(7696005)(52536014)(316002)(54906003)(2906002)(86362001)(55016002)(8936002)(26005)(33656002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8gWf9xQqytr/9gqWSQw4Btc2dvfdLlsrX7iUkMJoiMlSEIRZJPJTYW/6JaiEc7sjrvolPA7oAJhOHSfYNwhIkOsf2zfmptQhctA/vWldwEuUeECuiFjefluMX6tT22DUWKOV+QOyT/KY1zbhmIQxYZCLRlpLUjlLAgXiSCngnV3ysST+rrnZUpc0pXcKwKr8hnH+u2vhAGNhZ94pdXW8NF7VrVe8kaFVX5h1psVPu7Pf1ZmlipcdmXs5DpdkgJoJbebt3cyOWuB/Iwhfev9nyySGGLn6GkOlijdCyyXjEVZicWuRJWmmpzMLygvnIICzCwIl5yxqV7OXSVu8QCwgKnjZ5bX8wWC+oS0bK/0ykcfSsIFSrt2YJ94mjwNBukDXVzNswZNEP4wGWR3Ck7YYgpwvbvjK1JlstA0UG+IVd3tV73zfwkHdo/D0VHawlkX+338/2R/sOA4Cf4Kz/yDVSPXyx8YTpxgASM7P5xYljNMGyvRAwenMnexfB+zJagbZtFey5/cqoRtuTOy/g4GcIyrMO+zkQK6BAj2cxT/Qon2rKZdB/J4OoB2CiAltmTdO6J2D4RNvRcNGVxhIte+bPoaX4Y3hubZrnCY95MXwFXiLi6U0Oy/lyyCndJzVfx3IhaNG6pSvf7ZF6mw0nDSk7Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6add4d17-399a-4d47-cb0e-08d837658163
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 04:27:17.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCyPcnfMOEjeiZspwTBF6IE20utXzl0QpBuk7xcw/v/J2lTUQ4dhPMdogrAdnrDeRVI6ySxAShaBAHadA1b/PnzmfNxN3tHnlbmBPmsKfQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4460
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_01:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 mlxlogscore=943 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008030031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 20-07-13 12:05:52, Pawel Laszczak wrote:
>> Patch removes 'goto not_otg' instruction from
>> cdns3_hw_role_state_machine function.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/core.c | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index c498b585eb13..8e3996f211a8 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -191,11 +191,17 @@ static int cdns3_core_init_role(struct cdns3 *cdns=
)
>>   */
>>  static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
>>  {
>> -	enum usb_role role;
>> +	enum usb_role role =3D USB_ROLE_NONE;
>>  	int id, vbus;
>>
>> -	if (cdns->dr_mode !=3D USB_DR_MODE_OTG)
>> -		goto not_otg;
>> +	if (cdns->dr_mode !=3D USB_DR_MODE_OTG) {
>> +		if (cdns3_is_host(cdns))
>> +			role =3D USB_ROLE_HOST;
>> +		if (cdns3_is_device(cdns))
>> +			role =3D USB_ROLE_DEVICE;
>> +
>> +		return role;
>> +	}
>
>Would you please improve it a bit like below:
>
>	if (cdns->dr_mode !=3D USB_DR_MODE_OTG) {
>		if (cdns3_is_host(cdns))
>			role =3D USB_ROLE_HOST;
>		else if (cdns3_is_device(cdns))
>			role =3D USB_ROLE_DEVICE;
>		else
>			role =3D USB_ROLE_NONE;
>
>		return role;
>	}
>

Sorry for delay, I had holiday.=20
Currently this patch was added by Greg to his usb-next branch, so=20
I don't want to change anything.  Next time I will add such changes.=20

>Peter
>>
>>  	id =3D cdns3_get_id(cdns);
>>  	vbus =3D cdns3_get_vbus(cdns);
>> @@ -232,14 +238,6 @@ static enum usb_role cdns3_hw_role_state_machine(st=
ruct cdns3 *cdns)
>>  	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
>>
>>  	return role;
>> -
>> -not_otg:
>> -	if (cdns3_is_host(cdns))
>> -		role =3D USB_ROLE_HOST;
>> -	if (cdns3_is_device(cdns))
>> -		role =3D USB_ROLE_DEVICE;
>> -
>> -	return role;
>>  }
>>
>>  static int cdns3_idle_role_start(struct cdns3 *cdns)
>> --
>> 2.17.1
>>
>
>--
>
>Thanks,
>Peter Chen

Thanks,
Pawel
