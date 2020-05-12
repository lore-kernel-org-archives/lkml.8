Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ABC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BE720746
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lS2cftiu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="v/v7vvJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgELGYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:24:21 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:4582 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgELGYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:24:20 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04C6KNoq000707;
        Mon, 11 May 2020 23:24:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ZXfoa1TMioeD+fp5YhTXeiQwQGGaMIa+yy9h/S4MGpY=;
 b=lS2cftiuRd1J0ZbmfGjDGgsO8Px7iCZxTSesvbLXenvBE+c552eMzgqMj5XjuVnLrBkb
 KpH9oiPC2J4IhwiDYrzKd0t1oaUtJBNfJeXsvrf5aDIGtwWE0W3pRlcFO5aIe4vsmqcH
 0MscJbgVGU4T8NgTLGKPkqbJ2SfmJqNmgXfXD0uizwTFFnsRb1li0o09SdLY1iQeHRz6
 feNCTKnpsLmdzUdXiJm2WJXPvtZCS8tIctn2AIN9+DrXH0/+4RA83/GAECfNi34cMpDW
 +SBD83J+tYx0XHu+3+Tl7vpAhIxAfLq7JYKXvznkH3GJgl7RUjzIycARKA2ta3yIozae pQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30wr3xhr1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 23:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIteM6yJY+A2OIuegWG4f872cJFC0wX3kOxrilhxUEY27P2uJWPvZ3venkFRrDQPWUAbjZY5wHGskkgmII2QObOGNEV72RA6GSDmMn4PBbIquNsb2HwHyZCCX8zHfImmhHzXdnCShwrQ8PhTVBT0qLei2yz65CskkEXN23/ascDJ8MLXFxmQpBIazy+83aeymyA0oy6wCQO2ftE3M7dOZKVcgyGAdApWT4RJumJaPwRmvFufIPbOi/7trh/GwcsNnaUUeeZb12RusCe4klaxe+8cwS81Hkq+hSUfDMeXfMNBDD5C0QLzsRkkU6UtDw6Ll6Kjcq7/Ettx1Ktk+Esu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXfoa1TMioeD+fp5YhTXeiQwQGGaMIa+yy9h/S4MGpY=;
 b=K+nM7+Ij2hxKvMpOCmRMfbCy03gPB/eJKOldrJg/2wM97ZjLBMf5KY+V0qc3YfuvS5taa/T3vro06miakyoNRmAxgK+LaSRmmHF+xpyxMHciHGjRF0NBkjiTaxMQl9cf3B4RwcVXToTUTmNFccj1p+eES/0Qz/GjdXSgAoR7gAE5O1ZI2D0ua69XYnSQ+SXRd/bxr1uMDMEFosV5z8Ial2TVwfPrSywSbnPDVvGva0NGTEvByofQRavuHLIw4AYC0x4MkfLXk0HTTJvQ0nnc9ASahoteOCrIvhE6049ZSUys7D4Sq6Ttzl691Ruu+2uSmCML3AEeF2yYGVyqpkepvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXfoa1TMioeD+fp5YhTXeiQwQGGaMIa+yy9h/S4MGpY=;
 b=v/v7vvJq3+AiDJPmb8/yY5QthMu+QTUzbpAQGIxwpJuDC45vmLaF1KFd0NNKiC4PjOqaUmmlPrrfMIw4dg9Mq8a43ODmMdPIhue2tgeP8I81yJDAX6uuYUXH3lgZoMCT+Tgre/PHhPQGPMity4ZpdrHmkPDdjk14oLa2NNDzDYs=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM5PR07MB4103.namprd07.prod.outlook.com (2603:10b6:4:b0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.30; Tue, 12 May 2020 06:24:06 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::19d0:3872:2f5e:220b]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::19d0:3872:2f5e:220b%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 06:24:06 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v7 4/7] i3c: master: add mastership handover support
Thread-Topic: [PATCH v7 4/7] i3c: master: add mastership handover support
Thread-Index: AQHWJ5Yr8A8LtuvkDkeeRNJfxsE4YKijFfcAgADYeeA=
Date:   Tue, 12 May 2020 06:24:06 +0000
Message-ID: <DM5PR07MB31963DACC77DCB2634010B27C1BE0@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
        <1589202889-9186-1-git-send-email-pthombar@cadence.com>
 <20200511183816.54e95659@collabora.com>
In-Reply-To: <20200511183816.54e95659@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0yYmZiMjUxOS05NDE5LTExZWEtODU4NC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcMmJmYjI1MWEtOTQxOS0xMWVhLTg1ODQtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIzODE3IiB0PSIxMzIzMzczODI0MzE0ODM4NTEiIGg9IkVseE9sUEdab2ZMcnlQRnJJWldMTXZGbzZHMD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea83519f-4ff9-42b8-a6d0-08d7f63d12ca
x-ms-traffictypediagnostic: DM5PR07MB4103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB4103D83D1E6A9CC212247BCAC1BE0@DM5PR07MB4103.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L0UxaIYUgvU/EoDdReTzq1bJOM6a7pDr5UnH3ab+rulofH4i7xXD4Wb5HJYkNULkSJLJ3fkwZOh7fyGaGprOrvMWnDia3XUpe+36rqXQ+5O+1ibpoEBupFmQawjvPvAKjPQ9moNVx3/b0wjiwl0BPDA821PoiIVfBXiRTBU95HkvlLRGMtl4A9DemVQmpPfRlEwNHDvBDch0E736eHQtNZ0uECFstyf/7lurAXOKaVmhycY+FRia365NKuBfeGaM1EhSyEjDdrhx39MP1zPeGY5bVCtrfmqnM2Uf9wHWhPnABdoMftbI7OKdcxDcVIEE9Cdfb9Beo/m0+KppO9FbqJXpY/D846nFU0midZzcvU/wQFyAeM9vn8dSpmfNXCieszhR6jkCCUCKI7/DNj11T2TOaNWTOqqPr7gcWtCSqxGSEozPXZT3Pq6NWYxSvoI0RJdJHdGtLO6b40buTkR1rXYe4zXUw5uhRxeajUVj1p8IvbO8thF4PA9I8Hu+rNhczQumVdn9EtcznjAtza2JxVWoxa3emZQSiKc51dBJcdZCMtOnjZMLIGh89CnsF/NA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(36092001)(33430700001)(71200400001)(33656002)(66556008)(6506007)(478600001)(6636002)(66446008)(66476007)(64756008)(26005)(66946007)(9686003)(5660300002)(4326008)(186003)(8936002)(55016002)(8676002)(316002)(33440700001)(110136005)(7696005)(2906002)(86362001)(52536014)(76116006)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hJxqCHnrLlbETolUdnw5Z9RyZIbMg21tr5/0mNFWCNt3ejS6FMMRj/kq4teuEwNee0B6hnkzXNdMzkzYDb0hRlQfKlP8nDio4oWHRoy5bEvkKt6O+qW9LCvpW1lJjM5olVdihvgsYytt/uNizXUBZvKSQoKQyWJlVrITYv95smfN66MYFkFUlFWdaKagVPlXV0u9/zdL2bsTTz+F6U4HP4BpK7AiR1t7dGy7spH+ZULE00kz5ECpK2VNzB8icho/kdwhAMAhqRdmQEABVJP+wLmWF7viIlDoKwomiVkr2EpH8FnTnTgXKeUfCy9RiRUtwBMzLA770QlamUjAaYO+ZTwgM/03bL/MiMSmZKS9eutL+aJ8ShypQp/Wm/JbrrIpmmqAVlvMIjhhPrsrrBd/oQPDzDJCBoTKoizhtexiESN7eeu5cT+/bEEztB0KRGRXi7aTHBLCdMMFC/MA8WYlOBXHkgG+HI+JomOppm2qXAA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea83519f-4ff9-42b8-a6d0-08d7f63d12ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 06:24:06.3184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVIsxFq4b3TLi+m2/g8+JQW+J0SG1xcTUPCOIsdSpoT/dJXe29Nsj0RozA1YaDn4HdLIkURkRj823Z0JiXmob7cnY+iI+jR9iwFzNT/Lrlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4103
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_01:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Those waits should be done in the master driver. Pass a timeout to
>->request_master() or make it a property of the i3c_master_controller
>if you like, but don't poll the status from the core.

Ok, I will move these pollings, check master has DA and MR done to=20
master driver method request_mastership. Then we will not need
check_events method in master driver. Every master driver can
handle mastership request process in request_mastership method.

>> +	if (!ret)
>> +		m->bus.cur_master =3D m->this;
>> +
>> +mr_req_done:
>> +	i3c_bus_maintenance_unlock(&m->bus);
>> +	i3c_bus_normaluse_lock(&m->bus);
>
>You should downgrade the lock instead of releasing it. I really need to
>get my head around this locking scheme because I'm pretty sure we had
>good reasons for the locking/unlocking dance Przemek had in his series.

That locking/unlocking dance was apparently because caller of
acquire_bus holds read lock to avoid device on which it is=20
operating does not disappear or get modified due to=20
maintenance activities happening inside maintenance (write) lock.
Hence, here first we unlock normaluse lock and then gets
maintenance lock.

Przemek: Was there any other reason behind that ?

Yes, I agree it is safer to combine maintenance (write) unlock and then=20
normaluse (read) lock, into downgrading maintenance lock to normaluse
lock in single step using downgrade_lock. I will make that change.

>> +
>> +	if (!master->secondary)
>> +		master->bus.cur_master =3D master->this;
>
>This change doesn't seem related to this patch. Looks like this should
>instead go to patch 3.

This is to initialize cur_master pointer in master object pointing to=20
I3C object for current master on the bus. Only main master is by default=20
current master at the beginning, so cur_master is initialized only
for the main master. And since set_info happens in bus_init during
master initialization this change is included in this patch.

>> +	/*
>> +	 * Maintenance lock and master check above is used to
>> +	 * avoid race amongst devices sending MR requests
>> +	 * at the same time, as soon as ENEC MST is sent by the current
>> +	 * master. It ensure that only one MR request is processed,
>> +	 * rest MR requests on losing devices will timeout in wait MR
>> +	 * DONE state. And next MR requests are blocked due to DISEC MST
>> +	 * sent by current master in yield operation.
>> +	 * New master should send ENEC MST once it's work is done.
>> +	 * maintainanace lock is also needed for i3c_master_get_accmst_locked.
>> +	 */
>> +
>> +	ret =3D i3c_master_disec_locked(m, I3C_BROADCAST_ADDR,
>> +				      I3C_CCC_EVENT_MR |
>> +				      I3C_CCC_EVENT_HJ);
>
>Isn't it taken care of at the controller level? I'm fine sending it
>here, but I suspect some controllers might actually auto-disable MRs
>once they receive one.

I think auto disable MR on receiving one, handles the case of multiple
devices sending MR requests at a same time. That is handled above using
maintenance lock and current master check.
DISEC MR, HJ is to avoid new master getting interrupted by MR or HJ
before it's use of bus is done. Once it's work is done ENEC MR, HJ is
sent using i3c_master_enable_mr_events(), may be we can
rename it to i3c_master_release_bus. It is not actual hand over of bus
but just allowing other master to acquire it.=20
I am not disabling MR and HJ at the hardware level. But I can add that
in acquire_bus as one more level of safety, if DISEC is disregarded for
some reason by any device.

>	if (WARN_ON(m->this =3D=3D m->bus.cur_master)) {
>
>And you should probably check that before send DISEC.

Sure, I will do that.

Regards,
Parshuram Thombare

