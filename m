Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E36C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1900922CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tXYotZjj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="IUam/VSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHTJXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:23:45 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:16866 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgHTJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:23:44 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07K99IYQ028279;
        Thu, 20 Aug 2020 02:23:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=udtXPjC5MZeyPEKRKJuF7jkPuSM6fA5ZJKe0RPGr3vk=;
 b=tXYotZjj2VzWX+EGrwXDdjZeZFXIUZfA69Fm821zN3g4CX53LiMP5ExSIPZVvBZaVZRS
 svLMGMJUo/yx2saXvwHL6o+zLpflb32o1w2YxU5YuHgl2A5Li0kC9gAScT/USb6xyinX
 HmFx1RumoDnQhTvzQG2SG+EqjcS+ifSReL/3UpIzyiHnqpoLp+y/fz2igmqUIVzplxjr
 kGFNYOz1iCkw6IEyBRqsrAALMSMFurr8ws4dxw43T76FQnmW5I5WlwFsmfHwfairWQDg
 4LpEM+LsnEYQNfCFqIOuIGxJ8ZCEHFdMn4DgAVE4Cfj+Cie2z3GOiQ7idkotN1N72NpW Cg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3306jnsmcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 02:23:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3x375OkZzFXFVKD5XXEFMJyhUCyYM+JAT/phJZ0N2OZFykpuKybnc/kF5i1AuO9bVvy9kruvV5ozSMgJPIwJBys6wssiFaKvmM4JzzrN/3S0vMK0Ns62v9AAC2yfnDySm+bGK3+9ofb51mcR6VQa+w+U8m3f7r3vOni2J50hHvgcDynZWBu/pSD/y/ok444A3tfnERXXhyIa9ZzWUMirhohkKfqWwuFQYvZd1CWMlBthelhPcxgCisSRr2vChkndpQ5FqXMRrfQf8FmL4QxtsnCWnEyxwrDV3WlJ5dv8Mq1thkbO8pvenhigZbyEVyTzSse3ecVZRNhdvHa8nhFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udtXPjC5MZeyPEKRKJuF7jkPuSM6fA5ZJKe0RPGr3vk=;
 b=h4vYlEEKGa63u1oHiXkWI0KYLELLfI3AOvpy9slXqTeyZijGihW2WPpRS4/vs6wQ9dLtsBxf857EsU+ybMXl29CM6j7d7ggK0arOyFE2gDI5NJFS7VbuoPlr53YogNmlLImHD8I1Hp3yZtGa6/tqFXRCIXO8A2z7rGkcusgfKW7OcuWkIE24tQXHRjL7AeroAmumcatlxyB62aYPWHNrD1hRY9y8ngF9ZcBq3L2Iok2lKgZMwtZCOVrlOLVCRtDod4mUaVp0GsFdznBRtXJ6XR5JYfs+kRs0qV5xwjXKwobdafQWE4ibrhwLNt27U4f1qk1BiX4ChPEFrKsC+/wS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udtXPjC5MZeyPEKRKJuF7jkPuSM6fA5ZJKe0RPGr3vk=;
 b=IUam/VShJRTh4cN/4hPPTWnUeRm8IrGi1Nc/mJ9dUUAEfN3UxGZ0S7bZEYgU8oKa5cK4pg2V15vHEkC7BcX0rRtTXPPOh2wfXQNsu14y5vSs+F8+5hWkxvGGgP/s7LN+VleVmSa9C5uHwDux9/RPFfKl23OJIEyU3aYjle8jmr0=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM5PR07MB3877.namprd07.prod.outlook.com (2603:10b6:4:b6::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 09:23:26 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::fcc9:65c7:8aed:f107]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::fcc9:65c7:8aed:f107%12]) with mapi id 15.20.3305.024; Thu, 20 Aug
 2020 09:23:25 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: RE: [PATCH v2 2/2] i3c: master: fix for SETDASA and DAA process
Thread-Topic: [PATCH v2 2/2] i3c: master: fix for SETDASA and DAA process
Thread-Index: AQHWL1LbKgAavLYOLUSFNKBnioxWdKk/olsAgAFk1TA=
Date:   Thu, 20 Aug 2020 09:23:25 +0000
Message-ID: <DM5PR07MB31965D54B61E191E3C1325FEC15A0@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1590053467-32079-1-git-send-email-pthombar@cadence.com>
        <1590053581-803-1-git-send-email-pthombar@cadence.com>
 <20200819101238.760d4e90@collabora.com>
In-Reply-To: <20200819101238.760d4e90@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jYTA3ZGQwNS1lMmM2LTExZWEtODYwMS0wMDUwNTZjMDAwMDhcYW1lLXRlc3RcY2EwN2RkMDYtZTJjNi0xMWVhLTg2MDEtMDA1MDU2YzAwMDA4Ym9keS50eHQiIHN6PSIzNzk3IiB0PSIxMzI0MjM4OTAwMjAwMzM1NDciIGg9IjJ5ZFVET0hOc2ZsMlN0SU84NG8vU2F6eFk1cz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aa9b8de-5cd4-44cf-2ba8-08d844eab145
x-ms-traffictypediagnostic: DM5PR07MB3877:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB38771B449A7FEBDA9FB73F9CC15A0@DM5PR07MB3877.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Cv/e045b3rs/rUBWKE7Bd/Uq1OBrxjNeaqhQXu6phflpXw/AF3wrV2R+haU6xp7qZ6xokjo6IvZwnOeLuuYWWpDiB24wM65jtzTzsWD59W9aXdiMXDXf0XYTrmo9TCDr0/kkEMQOZZH5mG3wMjcA+N9QUDXXN39p3YCufyDPm2nJ6sIOi51T0ABQJyS1IFXehk4dCKiZj6oGxGtoqM6gCRvQyvO9VkRaU9QvjNnMmHSp2S+cDcTcId2ZrbZzjHWjxaKFWi7Jq4vi0RMiGonKYtaYsnnpAc6vaiqaw4+Wt55XmWanNCnD+FBysMbcByMEpXUgih4pQlTViiAfR8q236q0S6QGDWIMyWC9sCiVroEJVycjTxgfHBzCBraZirH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(36092001)(8936002)(54906003)(9686003)(2906002)(6916009)(55016002)(6506007)(4326008)(7696005)(186003)(52536014)(86362001)(26005)(55236004)(478600001)(66946007)(64756008)(76116006)(66446008)(5660300002)(8676002)(316002)(33656002)(66476007)(71200400001)(83380400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: eKvVO/hXgp67T2KApNHY69a4XOuJN5NcPEGuuUF9yGJV0/l50gWv0vABx2g+0qBy80rIG4IxVL9buTvgUtfzuN1pKVY1ST4yCgPQ7D97SXi5bMpmpFIOMXZHhjzIgq2EqnW/0zowPtRAoh2OIz66f6ENtb3p31IvtDs3iLcrd1oRIHVIyFVqMENnQHy54uxsRyrXzzQmWRrg12zhVJXMoua4cPS4ycEEUsEm1fcs6/3EOT+r7Vsb75x0b1ljr3z/MpfEXS2dbSSNUAD6SI/x97zi36FLS5sOvK7rQ3V2GTBMVjYSj6X9Pveg4PwTR0j41Q4J+ynzTQW9ixtqdpJRclAzJa6r8UVTds9siPNbsh5R1eWOZkN7hCyahrX0vmrPkZ0c8V+2FTeY5KR7vL+uIDDejPJcc9TIvCHhFb6LH2S07W724Z35vf4gh/+qgBK7IOeFf4XSvocpVCLathmNVl3+Xvi0zomqTvnO1PzamMT855FqtsreZ9YpvE4aTIw31NNZ+FPkeJd9qLJnBhC4EnkJp7hHqwT8/V0unzgnPiVRtdnbfVRNHQBBIDt5YT/15f9hOqLWoQtAvcHXci1OA1m/LW6JlDGNjG+p5VP6g+GNsA8WUxDZiUzxXYKkUdXb0Un14emeQJ6pCR1fnDW+eA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3196.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa9b8de-5cd4-44cf-2ba8-08d844eab145
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 09:23:25.7342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Caj2NNpb0y24AIv+jupvqT8RYn78IoMYa9K4J3TML8ZBI78L2Noauvb4AO/r4jbM1c+fmCPPBXSWud/Rp/rBoizmJj97icWVXs3HMxt/Yzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3877
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_02:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thanks for your comments.

>> +	 * We anyway don't attach devices which are not addressable
>
>You can drop the anyway.
Sure, I will make above mentioned change in the comment.

>> +	 * (no static_addr and dyn_addr) and devices with static_addr
>> +	 * but no init_dyn_addr will participate in DAA.
>> +	 */
>> +	if (!boardinfo->static_addr || !boardinfo->init_dyn_addr)
>> +		return -EINVAL;
>
>If we consider this as an error, we should probably check that before
>calling i3c_master_pre_assign_dyn_addr() in i3c_master_bus_init().
Ok, I will move this check to i3c_master_bus_init(), before calling
i3c_master_pre_assign_dyn_addr. It will probably add extra if condition,
but will save one function call.

>>   * 5. Pre-assign dynamic addresses requested by the FW with SETDASA for=
 I3C
>> - *    devices that have a static address
>> + *    devices that have a static address and attach corresponding stati=
cally
>> + *    defined I3C devices to the master.
>
>					     and attach them to the
>					     master if
>	  the dynamic address assignment succeeds
Sure, I will append above mentioned change to the comment.

>> +		/*
>> +		 * Free reserved init_dyn_addr so that attach can
>> +		 * get it before trying setnewda.
>> +		 */
>> +		if (i3cboardinfo->init_dyn_addr)
>> +			i3c_bus_set_addr_slot_status(&master->bus,
>> +						     init_dyn_addr,
>> +						     I3C_ADDR_SLOT_FREE);
>
>Hm, it's a bit more complicated. I don't think we can unconditionally
>release the init_dyn_addr here. Say you have a device that's been
>assigned its init_dyn_addr, and userspace decided to re-assign a new
>one (the feature is not available yet, but I thought about letting
>userspace write to the dyn_addr sysfs entry and wire that to a SETDA).
>The init_dyn_addr can now be re-assigned to a different device. After
>some time the device ends up resetting and thus lose its DA. A new DAA
>is issued to re-discover it, but you want this device to be assigned its
>last known address not the init address. And when
>i3c_master_attach_boardinfo() is called on this new device, you release
>a slot that's no longer yours.
>
>That was the rational behind the "address slots are attached to i3cdevs
>not boardinfo". Maybe we should have another list where we keep i3c
>devs that have not been discovered yet but have boardinfo attached to
>them. This way we can reserve dynamic addresses without blocking a
>slot in the master device table.

I think the sequence of events you are discussing here is
1. User assign address to device A with init_dyn_addr in boardinfo.
2. That particular init_dyn_addr is assigned to device B, which may be hotp=
lugged ?
    and don't have boardinfo or init_dyn_addr in boardinfo ?=20
3. Device A resets and trigger DAA due to hot plug ?
   A. Here now init_dyn_addr is already assigned to device B so device A sh=
ouldn't be freeing it.
   B. Now preferable dyn_addr is the one received from user in step 1.

If we are to prefer init_dyn_addr always, that will rule out possibility of=
 making init_dyn_addr=20
available to any other device when original device is assigned with user or=
 master
provided address owing to SETDATA or SETNEWDA failures. And we can be sure =
of not freeing
init_dyn_addr inadvertently while it is being used by any other device.

Else if we want to prefer user provided address even across resets, since w=
e don't need init_dyn_addr
anymore, it can be used to store user provided address. This will serve bot=
h the purposes A and B stated above.
=20
And in my opinion this can be handled when we add code to allow user to cha=
nge the device address.

Regards,
Parshuram Thombare
