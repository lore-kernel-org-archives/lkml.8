Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B68C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C92206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LRwRjfEM";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="h8iBHbrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgDHPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:06:58 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41232 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727847AbgDHPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:06:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038EnQtD010020;
        Wed, 8 Apr 2020 08:06:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=6FqK81lcdJrG8Q0+087s3mTedOrurTRbGSpKQZjSatc=;
 b=LRwRjfEMLCkLjAH4g4O3Lh4cQ1+uwBo+BMyTvRPN0CtA3ABJAoaZIRXxdUFe3TJ3IUPe
 LsPHI1sNm02m9tWtntAFid3+mzR/sc2+gdS8/XrzuRZBTusUd3Sh85xHHGpxixZxLpiq
 ysbyNOcWQunniSS+cAWtsR8GuyVciSC4F0j4LtOpx5BqsdSaHvI/Ea5o+8SYEfbY9Ctg
 vlfmcpH9A089XfMkqQ9vAZYcdsrQ8koQLFHqrVhXbwpY541xJIv9811IX+FKsKenhxLV
 NpgnMaEQ5jbucNcxM8+QWunwv2eOb5VTboyFsMM3ei9AHM9ET51WodCVNfVjKJMmPHZl xQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3091ny3ffv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 08:06:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA5sssOR+Jktc55znH7uQf4yMvpy2fcdCUPXHsYd6m+8GDc1Jdy9fNmyIqjt91BRCYGqi6ER7ydcukITeePGA1gnusRRiwCjt3S8AJdpTmc6TBHkJANZVGNhbHCNe200AliyQuPneUB0I/HjlvSdNK0ZqH2BSCxIjRDPs3Z9kykjyFZQc4MJkNMqqgzO+8+ElgiS+O5sXOKHS13bpqOVzVZP1lRTPFMfUEgZKceRbN5gEzUp0M8SYnp5UedbPTdjzqlUMEqckqCeDVf5k/Ygn8IccmqwBe4tQ0v5XOg5x4KLdaavFM8G/Q9BPIUd9/I0bY0wydKUEA9n5Dh0l2QHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FqK81lcdJrG8Q0+087s3mTedOrurTRbGSpKQZjSatc=;
 b=LnxbiphF8uhvhJvGiJ9eLudASnGMpx+BXk1zb7eeRM+vIesk7/1LJzw4JOyt3xosbmNtuTVkMkxBXaYCLYQhbecnwKs3KI9Cg07yxlRBGzxZEJbqaLXnf4D0wF0uvfhh8Axy3UszkDnTIXg5Yufl6gdodCxbAJHiIuxHlAu7rGYjfLukO68p398LVjVlTiG24Nf1UPqrS8Id5MW8n6Bq+W9R/CffR3ckA7u4+n+6o3dLc6rR0DdpGupQV42rsvn0crcbIv29AQ4JZ3CufZtLKiPDDtzxoy5hcP+a1JWnEiZLcE3CiXQhtkmqL1F2hJOokyKwLlp3xB7oAuNIJS8tKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FqK81lcdJrG8Q0+087s3mTedOrurTRbGSpKQZjSatc=;
 b=h8iBHbrWgurYQ4lbaaH0YNvOrfGfx6MLJBe8pzjA3aA/XoVO7KDIoe4OD2+oxWwcO3Gs3xaX9xyiQOUtByB/YIhiyPew/DNH9ff4QO5y4WobFUfJI0T34FK8NZRoG5mVx2PyZvnXnt3vGVWj/bL8ihh6IPI30Zge80R9M5lUjAA=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM5PR07MB4119.namprd07.prod.outlook.com (2603:10b6:4:b4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 15:06:23 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::34c3:e7f8:a178:a38c]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::34c3:e7f8:a178:a38c%12]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 15:06:23 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        Milind Parab <mparab@cadence.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 0/3] I3C mastership handover support
Thread-Topic: [PATCH v1 0/3] I3C mastership handover support
Thread-Index: AQHWDGGkJ2c7JAPQnkCuagmae7dgMKhvAV4AgABNf1A=
Date:   Wed, 8 Apr 2020 15:06:22 +0000
Message-ID: <DM5PR07MB31968BA9407E114EBE193C1BC1C00@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
 <20200408120418.0d5235a6@collabora.com>
In-Reply-To: <20200408120418.0d5235a6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03ZThiYTM5My03OWFhLTExZWEtODU2MS0wNGQzYjAyNzc0NGFcYW1lLXRlc3RcN2U4YmEzOTQtNzlhYS0xMWVhLTg1NjEtMDRkM2IwMjc3NDRhYm9keS50eHQiIHN6PSIyMjU2IiB0PSIxMzIzMDgzMTk3NzQwODM1ODYiIGg9IjRjWDl5SDZpZjRNMUE2RHhrQjFtaURFQzBnZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 349310e1-85da-48ee-75ae-08d7dbce66d6
x-ms-traffictypediagnostic: DM5PR07MB4119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB4119ADF0C1850ACE53E00A83C1C00@DM5PR07MB4119.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(36092001)(55016002)(26005)(8676002)(81156014)(4326008)(9686003)(8936002)(66556008)(86362001)(66946007)(66476007)(66446008)(6916009)(64756008)(81166007)(76116006)(2906002)(478600001)(186003)(54906003)(52536014)(7696005)(316002)(71200400001)(6506007)(33656002)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IsqfPf1TGqtPFkF25ebzMCntgG/iIrOPN879aBD4vmVgISFNwiUfyKB+R1xKi8sf3kDfIGtFaOaMFfu1Pzqt8vlX3Ug3NvjoX3qJm6K+b4ylfXCdM0ko8AcX99BPUkpT0C1DNWvKEzPLzprvqV4lKLcb0bWOTApPYiM4TUSUSXuXRs4buIDXcIHB1A0O6qPrzthwnshZnem524C4GO8ZtBIKKXml1UmHyIn/iDQbO0sgxiVNVeafG7r3beCfGyBcgM1X+/4PBCfY1ZA0qnPwpFrEy6m0b8KeeTwQsMtTbiDRzetQaY0yvqS2QdqaUDoGdBIAvgX0ZtAiVdMPt5Q93l6YFQX+XdbqDw15GElv4hOmsYIOSBZFkRWzVUliinG43VK70+AsatkqXM/wH1zKp0lzWD6T3o72RrTr/kSnaHiGPBp+QO0uD8R+IIVBaQvTmFSULA7EUsQe+16lexe66hmpniZ+4KF4Mfz0DfKSmCwmJOvq2VufF5hVfTOluVor
x-ms-exchange-antispam-messagedata: p5SyNpIWnhSG6TmmZUur5BXdaHZomy6VxLwiDIIIdfgHpJIJHWAnvE6+HZ6cPKZeh519AbwSha3nEKO1DTNcd5vcU9shiNyaumrq18CVo8rpZJtXpd0Tawyebr4i17HtqQuv4x3w3aoDR5uYfr/Mmw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349310e1-85da-48ee-75ae-08d7dbce66d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 15:06:22.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQ+IAdKA+Rr6CvB9EFBEPnO2ltUz9DBNtaHwE3n6WsBpntuMNMFu5iGUvX1t++1SzWXma+sKZSYO6GqwffOKEKuM+7IWu9R2WORJeWd0t4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4119
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=943 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

>It's definitely not the first version (as implied in the subject), and
>I'd like a proper changelog detailing what has changed since the last
>version (the one sent by Przemek).

Sure, I will resend patches with updated version and change log.

But just to summarize, main changes are
1. Secondary master deferring initialization i.e. registering devices
     representing other device as well as master itself, until bus
     ownership is achieved.
2. Moved bus request from slave and bus handover from current=20
    Master to separate state machines. This is to assist any further
    changes in mastership request/handover procedures. e.g. MIPI
    v1.1 specify additional features likes bus yield at the will of current
    master to sec master selected by current master, group address=20
    functionality, multi lane support etc which requires additional
    steps in handover procedure. This structure will help to extend=20
    the functionality further.
3. We don't really need secondary master to be aware other devices
    on the bus through mechanism like device tree, since main master
    broadcast this information through DEFSLVS. And receiving this
    information does not require sec. master driver to be loaded, at=20
    least in case of CDNS I3C controller .DEFSLVS information is stored
    by HW inside a table which is later accessed by controller driver,
    to be passed to I3C master subsystem. Sec master initialization=20
    state machine make sure it has active dynamic address (this may
    seems repetitive, but it is to handle case of RSTDAA CCC), and=20
    DEFSLVS is received at least once. And IMO we don't really need
    to process DEFSLVS for a sec master until it want to become current
    master.
4. Another important change is setting main master and sec master=20
    In pure bus mode during enumeration (DAA), this is to avoid need
    of sec. master having device information through device tree, and at =20
    the same time allowing enumeration to happened successfully.
    Both main master and sec master change bus mode once enumeration
    is done.

Regards,
Parshuram Thombare


