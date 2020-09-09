Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1692AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C649B218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ePDBdc0t";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="hgm6HUo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgIII70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:59:26 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:4050 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgIII7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:59:24 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0898tdOd025151;
        Wed, 9 Sep 2020 01:59:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=oDjxk/Pwx4lnXY6bw/qX5PO3ZgTzOr8+criizktwdAU=;
 b=ePDBdc0tdbGLyfADDIkkwbiyaRY4H2c6VodBtRYN8phNDgztYtvnFCvTQv/rNVbwzJ+O
 9Z0jwqzQmi6NHRwE+5/07VryTO+Ven82oePoEj+stsIVn0Hw7QLH8WsUBaY4EupvXtmX
 f2oAtfAGSjHGi8nVS8TjgX+vBp+q+M1UapBFRcy1v/ebruheBTMWJ2wk++UZiQ9RMkTT
 URKJDEFKXEoqxe7CnHZXfAgtNzjlSDBGnd4VVf8Dt3+I1PZth/q6hoW6AG+2RdhGRZf5
 njUvSHZGZsOQ1ozUqomWKjLCgGVLEIJQI//DxkBrt5xmk2KK3HuDSQqrQIFPbGf0xShg kA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 33c81py2rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 01:59:20 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 01:59:19 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 01:59:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 9 Sep 2020 01:59:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bs3iKW8M0bCwsP545GmbBGtxRuCgblfH9wHY4AnQaXzlb0k7CH2svCt/ch9TwlZENyczKrl47nHcC0x4wOIupnapZb+ahxDtFN3iGT+MvTueEW2Gc1iDk7J/YbobJUc2k3nMDApSduQ4Olt4sZ6qRd2Qh1lxrOOmOVqGnai1RTSf0VzUj1l2zeHweV3eacukx7HrT4vzVQ89wPFkVIupEz6hTqIFDvmQMvfbrCyBGn9MFVyECp2Vx4eJnFWB5z4K/7Og3d8bI5xoRk/bK965VMKQCWy0rMOv8Tk00qQRz3Bx2DTZ9L9PWtwbJ2i2cFMrQ8mQuOf5+yFLwDLQ/FtdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDjxk/Pwx4lnXY6bw/qX5PO3ZgTzOr8+criizktwdAU=;
 b=O9wbtUzq01JhHjpPaO+9X/ZkGAyIXEFJ8peWT84bPosCq2rPvK1CzqLz8Shai86vlWGv4tIE+or9Zavi6jLNNZTiB61fekxi+7fzL7gKNIZZcNPFosGBiGZ2kNLf7GpZyq0OIy/8QvggvEcS7869V0F/yeFjepgqBdtUsScOnN3kxnVI/dNawt6mlxHZTreaVaY3ZikmgLQEN8KSEgcp7W+W8Ccc54nHWCuF9o+XevjdalRfeiK1H+BY1W9V0Mfdi3eZ1EXBPCCWCfc82ciFJ225y4TKLPsx4gTCedUB750Io8G0zVGndS5SBK3b7mPahR+qjBCLtip/xBdPTwAa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDjxk/Pwx4lnXY6bw/qX5PO3ZgTzOr8+criizktwdAU=;
 b=hgm6HUo0/nOfJX0YRtr2Xc/kDoUzQabCLz9F0pqz1ALalwDrDPksC7fCmpr9kPwoQ+QLu/fP6QQEiNjukfF5FcTHScwj4IZeI54Cjo4wcQSX1PN/fHXXTqGI56U7sea2/v0p5fB38Q5TIctLz27GOGHwW4agt5Z01maKu9/safE=
Received: from DM6PR18MB3052.namprd18.prod.outlook.com (2603:10b6:5:167::19)
 by DM5PR1801MB1867.namprd18.prod.outlook.com (2603:10b6:4:6c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Wed, 9 Sep
 2020 08:59:16 +0000
Received: from DM6PR18MB3052.namprd18.prod.outlook.com
 ([fe80::905a:ebb4:369c:ae1b]) by DM6PR18MB3052.namprd18.prod.outlook.com
 ([fe80::905a:ebb4:369c:ae1b%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 08:59:16 +0000
From:   Nilesh Javali <njavali@marvell.com>
To:     "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC:     Igor Russkikh <irusskikh@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 2/5] scsi/qla2xxx: Convert to SPDX license identifiers
Thread-Topic: Re: [PATCH 2/5] scsi/qla2xxx: Convert to SPDX license
 identifiers
Thread-Index: AdaGh2WnpUkcu3KzTrqS1rJzTlIjxA==
Date:   Wed, 9 Sep 2020 08:59:15 +0000
Message-ID: <DM6PR18MB30522D4485EA11646B387235AF260@DM6PR18MB3052.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [117.220.251.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2ed6b7f-33a4-401d-4dbf-08d8549ea14d
x-ms-traffictypediagnostic: DM5PR1801MB1867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1801MB1867438934498E3AB20F03AFAF260@DM5PR1801MB1867.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nIeBrmaVC1I0h5LCPBekvED2eQBaUepAhs+rHanTDELGPGs8Q+uLdEc2iBG5cBBlMwAOlep7JsUwrDTON+5gSoBsu2vxD/2l7trHCi6RClNjkhd9P9vB+ttQmbXxoxj0elhA8ZO98C5iJbGq5ZBEiTPFZG3FzSeh/RKyygU+E5atRca6mk3E8dmpikbd6TLvOpB+Og3Ui9xCVpAC3MnmpAtCFYWG+Z8iXLUam4qiqaSy5lspB7BMTK3nD3NtMdFWrdq23IQtCZVPJn/wYr3Wejh9fBVZx5r0a7MxuqAAXW7uQvIPzKVfjXW4vbdds7u1RdjTCyp45zBqaC0boxC+Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3052.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(9686003)(33656002)(8676002)(2906002)(19618925003)(316002)(6506007)(5660300002)(6916009)(71200400001)(8936002)(4270600006)(558084003)(54906003)(26005)(55016002)(478600001)(7696005)(4326008)(66946007)(76116006)(66476007)(66446008)(52536014)(186003)(66556008)(86362001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 66irXwGhvr6YXY5p2cMIkiEtGDxT7cKpzVgwdeXfc3X8dvAEi5C2r5gD8qk/7K5C7o0AK3fUvhzlvYuWLjPAKvjPnF2D7pUaZVQMODQTtfMZ6Mb864P3kFJN35bV4lkYZFrbPGNUnRChwi/mdJhOqIN98poqlZRwWBGpJ3EPWPAMv1SkpJaieP6/ISJEMfbUPa3VTmxQGMOhdvzlustPskfvYJtCRuq4zi9x8Vpp4qgmB+Kz37ubFXQEEoe9vlgso3WjZNmVVp99CdOBCnIX2IIravnYVczMCUucMUQwNIqE9ljpMQJXGT7awWx7r6hazqMa+F10ISHdqD8SuocIZN2JL5E/cHL0GoTEWCMxeD+3GtRlsEj8j7tlbvJC2IBsH6dl17ScASZY9VXyzlsG+x5xZ6TP1vZmKjfbjvOmRUmGnQdRPr/ZOo9tTojHFQRpH3NLilmhWzUEeWK3sbHe9Lw/yOxEzweNiFbpcKlNXgkTxXO+r6bmnD+Uvb+mtotPxq7MIvqc227BWr8J4VZA5kslyXbBbC1VkCjFdQgMX3rcJ9vcdc/EbehRqNEEXBwszSsDmsItl7IzO6c8ytiQbN38f03c8hvoEtCb3lJ0tbeGMSGLK7uHWZe26PEMnosrwwuP5DkLDJGifXFp4hWdIw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3052.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ed6b7f-33a4-401d-4dbf-08d8549ea14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 08:59:16.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8RpYED+/KwMRlv75/3Hegbm570/hwhxheWu7dCNTbw33kW9NbKN7qEtfU7mwL2haf1J4YYUB2AhJsAn/+sDnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1801MB1867
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Nilesh Javali <njavali@marvell.com>
