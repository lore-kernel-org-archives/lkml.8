Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86905C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1BB206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="mTVEjxbb";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="n2WS1auK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbgEMJnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:43:52 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:34250 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbgEMJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:43:51 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D9g2tf016643;
        Wed, 13 May 2020 05:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=gk/qzrxIPed0uqXZ9FLGGl0xzD/N4ZrS2W7RgtOQ6k4=;
 b=mTVEjxbbcnFiiLnuehv2Q6zztVJu7sR4v0c1UUYkjqj1F+OhKTwQjywWnzbMVmW8WJqo
 uQe4gA8w2pXM4BnG9XS76eOleE3Zji5vkSFpQGXrmq6uTz3WRFWLwMzS6SPnGA0I//LZ
 hkwmG702Ttot+lAtn3Kv9ay4C8FdPnWdLQmSwpykJkf7xHOmDkBDQ1QdpcV3XGT71Qwy
 jzHrIQHu2JkgQAbWbxSJAnzyXFs/jMQ6VPPZ0EXRoBIq9QHUjYp/AqJLdFQHJgwuEt7w
 GddFNMDDn47ldDPQiAmXl3PLfAA5p7FtTQhW3zsoncSPfd4A9pxqgZNLy+Uc6eXjFV+y JQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31011b9vqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 05:43:48 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D9hEcW108504;
        Wed, 13 May 2020 05:43:47 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0b-00154901.pphosted.com with ESMTP id 310de4gr2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 05:43:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENS+SRnDHOfwmX+RPMBgBpZP9xB2a9XHA5l3C5XC62k2mdN7nuInPdYBNga21JRQuNOmUnVuMq7tG0CK32LUc1LXT/UY5mAioH2nPmaGJiHG3dAcMv8HLzCoaeZGAc/CsdLvx/eHcJvp5GXjBs2+48U+hJdiJDIYbz0QlFSx8RVs0xLGMGFjR4XrR2OiSE0AKaVLOtrLdOCdroRg5uKv4Uz4hoGgsoVom9j6ceSFBFb/7tmMka5QD1MMVKur7fVZNh9DCC+3n2L02nr2Bfp/MYicDXkxtzd/Ls4jWdT+5M+Wjwm8FuqVETdu2rksdPxHifvFTAxEs3vO0pwvqK3Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk/qzrxIPed0uqXZ9FLGGl0xzD/N4ZrS2W7RgtOQ6k4=;
 b=MwvVIkMiZ8CeT4+oQAo6nm357Xd01NO4nh9PxR8KdFQp0APqgZGQDpP7oUssspUwqps8Mv7mw6Qh0bOUiEKh7OCPDPIZHX7jj2iiPSy9eXOH1mAxdjpxEz3t9UvIz75/E7jReQW36xeyon4zlrxBYO3yxtpTna2G85r67Vfy69KEeTaut8+EVOvJQBhyN3udUMmRDiLLgkLFG26t9SuJabAO5xdJkyfc2AJfIkjz1qsimcN54gbonl1RsoCBHY9FLxbTyj1L6gTZmrS54VwVcUGAhoS7JFjbVaig0ib0pJFrOhJnpnt57cIrIY73QP/8+MgpQgRCdGZmLC26NkGt6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk/qzrxIPed0uqXZ9FLGGl0xzD/N4ZrS2W7RgtOQ6k4=;
 b=n2WS1auKaAwTWi69BbcJQcwgYux+kto6AVmd4/xRHnscaiNnTM7t8iVyKI5XPzDMubzQv5ABlAp2EgMH4/stPZAbS0jlhWM5G56wgrE3fSdkgsRL1duU0x7AOFNyNhsZ856EyXwEuYHlC6Ra3A0rXXG1ImYblDF0p+nKZzS1BiM=
Received: from DM6PR19MB2682.namprd19.prod.outlook.com (2603:10b6:5:139::14)
 by DM6PR19MB2716.namprd19.prod.outlook.com (2603:10b6:5:145::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 09:43:45 +0000
Received: from DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::a586:af72:89c5:a6a5]) by DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::a586:af72:89c5:a6a5%5]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 09:43:45 +0000
From:   "Ravich, Leonid" <Leonid.Ravich@dell.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Idgar, Or" <Or.Idgar@Dell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: CMA enhancement - non-default areas in x86
Thread-Topic: CMA enhancement - non-default areas in x86
Thread-Index: AdYoj3CyDXSuH7upSp+PFUP6/DQ3LwAYv2CAAABMfIAAAJ6ogAACYu7QAABj24AAAdj7oA==
Date:   Wed, 13 May 2020 09:43:45 +0000
Message-ID: <DM6PR19MB268231FBFEA47D7C4CEAF29098BF0@DM6PR19MB2682.namprd19.prod.outlook.com>
References: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513064755.GA763968@kroah.com>
 <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513071413.GB766804@kroah.com>
 <DM6PR19MB26827EFC4DDC6CB9DD5C52D098BF0@DM6PR19MB2682.namprd19.prod.outlook.com>
 <20200513083343.GA772573@kroah.com>
In-Reply-To: <20200513083343.GA772573@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Leonid.Ravich@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-13T09:43:41.9653487Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=a919e076-f121-4293-a925-bad5d71dac60;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=dell.com;
x-originating-ip: [93.173.128.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba5c681e-3755-4697-357a-08d7f7222164
x-ms-traffictypediagnostic: DM6PR19MB2716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB271670256486C913C12C75FA98BF0@DM6PR19MB2716.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mj3Ky4so6qHDcb86q+rU4Quee+JH2cHwHHmM3sPi3ahIHe5qk+mFWq24VuqblJoFWoHuAbijubvlgRDTHMejkaaR3qvkrstlfvuWskQ0Bi0s75y1hiH+FrOkmN/qbwyByA2e1jC3g9lQrTHAc+BVGBjClhrXbQI6NpxlhbXhlA4aFCike+7MUWDrbj6KhBUJTcRqELKZs+scVd+s54+frlFL0tK2TQNTrhJmqEVbbN45kPNk8tD+dSCKp6paxj5PdpbvTj9klDIfQ5C+PjBJMjViL5xOW+YOwqfGdxIfIVkuHNSmLxWe/UmJzv1okB6bIpMpnXbF9rYdKgCZz6v7lyzzjIqCUryvFo4gfJRmiT5xiEfLrJLUspzpH7MvMBpUa4OAzOty9crr9VPr9ejBNHGCpU7H6xJMIOvaDf8iKdAytvhLAquJRaSDXq6hxeKRDTKneURUOmNm9ISIVNNdCo27f0XF/+j+mr+3/2bLrAt9iYDip2oH2JmCmquc+aqCcKL3V1ZZ9Y8DQX0fwFUXRXQIKsrZn8JECw9FYxq/OsQzRC0jxHtOEhWpaoqRvOX4W3FZD0BTKYlg8XirqEpn9rJWD+tdBaIo/8iQDUEpZAxCfO9cm8fnyTVdrfN23tPI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2682.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(33430700001)(9686003)(186003)(8936002)(55016002)(7696005)(52536014)(26005)(33656002)(33440700001)(6506007)(6916009)(498600001)(8676002)(19625735003)(71200400001)(86362001)(66476007)(64756008)(66556008)(4326008)(5660300002)(66446008)(54906003)(966005)(76116006)(66946007)(2906002)(490044003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nqCqh/Y84IBACbXziJSjy7A0jsI4oEVmATjh3vUaF3GNf6sNH+BTII0PXkyRvueyS7Tbaofw6QmMyAJLtUhZw2OZgKMXAj03k+lNIpjveX7RkdjWZI+of5rxotLwtNdY3JFV6T2Esz2UPv83Ot2UHpvGtna0vg/w3uGsvl2LifkAnIEoPe7qy4GxXRGJdwOnU3++2KyhWGyAlD3AA5Mprr+JCLi+jvhQ2gKsLj0vPW35FDftSgHbxRI0cMch4OJkVdg+3nbO79WLcv2PBKeaaEfhhj0qsg+ylWQSAfqm/uwyXv9rUclmQPNlceYyJ660HNWkV9wXD9IGH3T64+1tKXl0MzIEazMG1GwA3Dg6OgXMQGnxTYW66/5uxSao40vEPeLzbIW3eG6t/cy0VfMVDhHTemoshQJ7IhORIvnz1QKYot/iUtaQfq0X8gYyQrifFjq6/KLhrXUfVULQmhtB4B0o3qybm2l1lR6zPpAJU87gdmF8cd3eW6emZ3YPiWRa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5c681e-3755-4697-357a-08d7f7222164
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 09:43:45.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xh+cA+RKb7HRk0HjAtSyzhweZvOBNUcV1Ze0gSkk5rUAVNwzE/+lvMBfxCkUg4qQjITzM2aI36WfI9QE7+HL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2716
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_03:2020-05-11,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 cotscore=-2147483648
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxlogscore=970 phishscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130088
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 mlxscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>=20
> A: No.
> Q: Should I include quotations after my reply?
>=20
> http://daringfireball.net/2007/07/on_top

Sorry , bad habit .
=20
> On Wed, May 13, 2020 at 08:29:16AM +0000, Ravich, Leonid wrote:
> > PCIe NTB
> > Documentation/driver-api/ntb.rst
>=20
> > 1) Basically PCI bridge between to root complex / PCI switches
> > 2) using out of OS memory is one solution but then this memory is
> > Limited for usage by other stack, ex: get_user_pages on this memory
> > will fail, Therefore attempting to use it for block layer with (o_direc=
t) will
> fail.
> >
> > Acutely any generic stack which attempts to "pin" this memory will fail=
.
>=20
> So why isn't the BIOS/UEFI properly reserving this from the general opera=
ting
> system's pages so that the driver knows to use them instead?
>=20
> Is UEFI wrong here about these being valid memory ranges for general use?
> If so, why not fix that?  If not, how in the world is the OS supposed to =
know
> these memory ranges are _not_ for general use?  I feel like there is
> something missing here...
>
Maybe I am miss understanding something here , but if BIOS/UEFI will reserv=
e this pages=20
They will be "out of kernel" which will work for propriety driver but this =
memory will not=20
be useable for generic driver which will attempt to pin this memory with ge=
t_user_pages() .
so we can go and try to fix that  (not sure this is the right way) .

another option here is to use some kernel infrastructure  which  from one s=
ide reserve the memory from general use
on the other hand kernel will be aware of this pages so get_user_pages()  w=
ill work on this memory .

from what we saw CMA infrastructure can support  such requirements.
Please let me know if you think I missing here something .

Thanks , and sorry for format mess .
> thanks,
>=20
> greg k-h
