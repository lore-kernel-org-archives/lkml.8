Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BD1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DF521919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gxZgtexX";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="RKRwV/ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIII6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:58:24 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:45446 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728617AbgIII6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:58:13 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0898tNbG025026;
        Wed, 9 Sep 2020 01:58:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=oDjxk/Pwx4lnXY6bw/qX5PO3ZgTzOr8+criizktwdAU=;
 b=gxZgtexXdps+leQXaGt9roZEr+k4Kclvu0drh1i1iE4d5DjPet4FFSvCN4FoRdB1VlfC
 tiQrIecTGW/++ham3CsTbOsepXlFdU65qgETzhQ8B/f8gIfXoKy21Jb3YahuK+R+mtTP
 8jsBo9e/wcmpz1jSYMATRoa2/08r8ZFtqEyCunp19Kafu+eEVwpieX+MgtCePusHgwV2
 l6geHHZb4rHhBV/VftENfQobzcTGUQUACkCh28YZ+ddzUn+U8ZHG2o+z6a8SXkCjyGVo
 oUDUlgpls47GvncpzyyeuMLvdDfaO+PQZYvEUqb5HF/zlh1JykBL/62NMZ16VYPvdNs1 /g== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 33c81py2n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 01:58:08 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 01:58:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 9 Sep 2020 01:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJNVvqHU6gyCpgSiJZBvBMkQyl3c8hAAaxYfw1waR/bwUGSHbW96aULs96PB6ILth57Y2JrSF3whgukhKIpPKqTP8grURp7idyUNfSzKylUBvEKqHdBTjJvKKBcyOQqxiASBDgUSGAiA7tfR+g9p2x+hjPHq03coz26lOJ3EgbDbBSJgc6fvwl0Slj8xWvtJz8mS+JTGt8WmlgIG9E0Chri2T6RuQTwEA5sc0rqqpc+ZGhiOJVL9RZNQLVTi1NcWPqxiTINu5idqBuol29UQPQfodny29Vi1Jx96T6QGpG6mH+7BOnoymXYUrrAQ26K6egY89fxlhCygfsjBg81OXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDjxk/Pwx4lnXY6bw/qX5PO3ZgTzOr8+criizktwdAU=;
 b=ijlJHiXDmj1UrHs9/peV+QlGB662Wrb7qhSruemExsYeFVPfHWP2STQlx7o3UrUwyAAUtTaZSe0pBYha4EHYt3y6qDfpIcmpzevUnLln6FvzrK/B45PJYq87HNqFQnTAKnt2obe6u1WKlmjE87Q/tGp6w5VmigegiPZ0Je9xwNgdx9XHk2i41pry1bxsKy8BN0FYhcGp5LGNKyp0uCjFi1Lo4toLAuCWVSWWvpPu5FFMtlUzCVWsJhhe1bpEJpElnrAku/jP3T+SemRNvf7J8zVEqNR5hpoJYfxxQ2G6TV14vDS04U4rO+xfPidDNh8zksZm212KSQ0MHBqrCzRCJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDjxk/Pwx4lnXY6bw/qX5PO3ZgTzOr8+criizktwdAU=;
 b=RKRwV/ksAhlsbkXv0MxOMjq5kh3uuXBUwM/6yV9gD0c8E5yMq7u4+fkYqKiT1gXBANxt4SyFUYaC4wxXCYAYwlQ64pAeT+8KavLMSP2u38YsMyc5yyjL1iRPduiJO9rfb59E6aVmAZ1cx8R0q8lVPEmFeLzrhZCLZvUYJvaB0Kg=
Received: from DM6PR18MB3052.namprd18.prod.outlook.com (2603:10b6:5:167::19)
 by DM5PR1801MB1867.namprd18.prod.outlook.com (2603:10b6:4:6c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Wed, 9 Sep
 2020 08:58:04 +0000
Received: from DM6PR18MB3052.namprd18.prod.outlook.com
 ([fe80::905a:ebb4:369c:ae1b]) by DM6PR18MB3052.namprd18.prod.outlook.com
 ([fe80::905a:ebb4:369c:ae1b%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 08:58:04 +0000
From:   Nilesh Javali <njavali@marvell.com>
To:     "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC:     Igor Russkikh <irusskikh@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] scsi/qla4xxx: Convert to SPDX license identifiers
Thread-Topic: Re: [PATCH 1/5] scsi/qla4xxx: Convert to SPDX license
 identifiers
Thread-Index: AdaGhtFqhP3YXnOVRQez8UtuoI+8VA==
Date:   Wed, 9 Sep 2020 08:58:04 +0000
Message-ID: <DM6PR18MB3052C2975B3E76FA6B575CE7AF260@DM6PR18MB3052.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [117.220.251.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e27349c4-797d-46ca-f12f-08d8549e76bd
x-ms-traffictypediagnostic: DM5PR1801MB1867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1801MB18673369BCADE0602DC35B11AF260@DM5PR1801MB1867.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsBqZYSDbiLcM6GRUE1u2/ZtpC16ZCUV97Ig4k4sTungJT3FBO9a4QM4z/O6ayQSGtaFUqlZgf8F463+tVZOExYQNMEP4MKEG7E+R0tXedMRsZN9ddTxX3jb1X1dMbn6c27g4IwsqbbP9Sl6302uxUi4lF8tYttE3Bhfb2rTFJm8Ko4hzNey/ncxPZ424ZA/uQetoyMG2GA7ghU6miP7hkqvjLJjRzm3Yk9myEx1yhTjRg2PDuvqLOd/718401ysxahFFFJlMPj9FkzHqCI1zSyZhq7MF4YqaBi87u+EQ2iTWFg1RSqnAXxaaWq1ZLw8nDNMedCYqBnXWKYn991TjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3052.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(9686003)(33656002)(8676002)(2906002)(19618925003)(316002)(6506007)(5660300002)(6916009)(71200400001)(8936002)(4270600006)(558084003)(54906003)(26005)(55016002)(478600001)(7696005)(4326008)(66946007)(76116006)(66476007)(66446008)(52536014)(186003)(66556008)(86362001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5jaSmZC6u/0xiqlgkR0BFqobUP6qcvh/pP6+48nUibFSQwON/fa2j4SOPUMNVvdCtv7Tuf+A8TSCTvna66n6p9ENdmh84CDiFP8jSf5ViUR5P4VZ3mGO6wPRMTNwaFw1ubRw9oTSBGgBvM7yY1jQH8LbS3fL61CWIC8fdmcnCxWe+ePdVNf5nkn/EhBWqcjGjHPU5/q1WgOLLqGPYu8uE3mn0HJYPCa+jUtyEq9DZN7G02B4BeMDoT+VBJAwxO38cUvv5MJgIphi2+j4NEgpOgWR78yWcyuQ9SA0Pf/H7KFwbfEj887JnEvxWMrUxUiWYoh+iJfML2W3zR9dkdrG1CFk4/YRP3cSSxeWYG4cCRE3IgX0GlaoQ9ZFrf8GRtnuyHFsTV7oJ1hfmp+JEquXPynzLjoDJC03bn57edG6R6rV+7dOianxYbkcSbKg08WikzSyNMoegFOiYQjWCzNI8asykXBVadHjb2ONQPrp4Xt/0Vp4/PyzDYeG5FLfE9m3amC6WeuY/R3Iu/WFxHV6kVcxZAyuhXqJxcVtOE5cfZx8fAP155Fw0sdDBzNtCyPPA73q+wb0TIEXBG0WQuSr4lZTOrTEC7pApa4gFV3XNwXzVv5XtNS8NcXP+wLBWJYF4jB/cnLMnuaCebovwmkXpA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3052.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27349c4-797d-46ca-f12f-08d8549e76bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 08:58:04.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgOY89d5JN4RJ24cX0vF0o3jrCO+8W0oJha9Ngl30qapZO6B/kqmwagkmLSyH474arxEQ0n57BvO3kcrZ4nQCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1801MB1867
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Nilesh Javali <njavali@marvell.com>

