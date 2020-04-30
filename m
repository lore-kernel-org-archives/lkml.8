Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A040C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB67B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Zx5IuvG7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fNF0EEf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgD3GTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:19:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726337AbgD3GTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:19:42 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03U69uY8008203;
        Wed, 29 Apr 2020 23:19:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/XmngWCDDQ7yTPEIuqpcQSMJWLVrYb+8cMDOpxm8CVU=;
 b=Zx5IuvG7t9/7RfXNvyAUFC+0nMOndGe1bm9DZynAYR/K5mafdglH1S1sU6h4A5lkPaHw
 FIgf8kYO3S+jCORSuLsATLMQKQMDpMMUSgdkfl+iGP50f3wRnyAmNKKAV+XXGC7Llx6a
 FCa/KFKOYqEqANMsC1nG7j54GATy3aoOQ6o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 30qjh01v0v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Apr 2020 23:19:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 29 Apr 2020 23:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0YatdEgofILMhPmzhCqNkR9cw/5icguE2D7gRLVwk0ylID8T0HPr4kmyqVGVvV1bEhqIdmbF6Jbcyua/unRBwehCvlJCTm+rtrg/9iuXBsSC7ZpH+k2zy1yysNiP9/HU1ZDpbDfbeVAilFowqgqr6d/xR3fukD1yYTxQjvW/Lk9QZacfYxQgeA+13dgLoM4BWlt8Z0gPfaJNx7pVFmZnF4vCnU96+kfc5yCLxM1sYdG+oVXMTsfujdfEilgNNR91bP1Ii6MDWX2/lRubHHnZbndyIs5NZ1HR5E5GKIkkkAew0l36pcq90iuhz5BpNbUjoL5CXMpo4CuKqn9eKHqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XmngWCDDQ7yTPEIuqpcQSMJWLVrYb+8cMDOpxm8CVU=;
 b=MJmSoeh/k+139zgjFylSofaYSU+Gkl2oSCUyZLcVKb0TxvlOB82sFKCvUisMuRuiSuqPhdRyn8z7hqc9/AGk9+IWV/8AUkMKyN4yrQaW+mWNmAljZHODVo3DLTReXS66igR7PY2dH5+bhk66ROPHzR2bQMJM6QK3Gm4626xOuVuPrrjOrEyzu4ye6ffx0PkHaZ7sxrklt1az080eVAwunXifvKchQMXx21n/KT+C06HfjpigS0t0/kbB5dvS+o8bUR0Z7NmKjXHf+SyvaUeas1xLFBAYbKzQrVT3puOu1MoQIDkks4/ZW5tBUxkQBColx38uIxe4cz3UYoUF2Y58Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XmngWCDDQ7yTPEIuqpcQSMJWLVrYb+8cMDOpxm8CVU=;
 b=fNF0EEf6v8ccHHv/xrUnw5QC8BxiCemtQ1YHnOb3zV5fwaUoafOD4wJM4PNsysFSioke+iif38HUxErUo1eY+TGluoaq2PbLDDOTdEndZAWyBySao6QaiFUKV57OrUPkkNAfA4DHdkL99Bq3QA4duTg3lJKaVz7e94I8/pXtsck=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2215.namprd15.prod.outlook.com (2603:10b6:a02:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 06:19:26 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 06:19:26 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jason Baron <jbaron@akamai.com>
CC:     Coly Li <colyli@suse.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] md/raid0: add config parameters to specify zone layout
Thread-Topic: [PATCH] md/raid0: add config parameters to specify zone layout
Thread-Index: AQHWA4Oi1lNMKhCVRE6s4F46gf8lKKiJbd6AgAQ7nYCAA74WAA==
Date:   Thu, 30 Apr 2020 06:19:26 +0000
Message-ID: <E3616A45-C6D0-4B3B-8112-688B03126F00@fb.com>
References: <1585236500-12015-1-git-send-email-jbaron@akamai.com>
 <0b7aad8b-f0b7-24c6-ad19-99c6202a3036@suse.de>
 <8feb2018-7f99-6e02-c704-9d7fed40bba2@akamai.com>
In-Reply-To: <8feb2018-7f99-6e02-c704-9d7fed40bba2@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: akamai.com; dkim=none (message not signed)
 header.d=none;akamai.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:67b7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d24309c7-81c9-4093-d834-08d7ecce6f1f
x-ms-traffictypediagnostic: BYAPR15MB2215:
x-microsoft-antispam-prvs: <BYAPR15MB2215008ACEA37969FC968CCAB3AA0@BYAPR15MB2215.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(136003)(376002)(396003)(186003)(4326008)(2906002)(6506007)(53546011)(6512007)(6486002)(54906003)(316002)(2616005)(66946007)(91956017)(76116006)(86362001)(36756003)(66476007)(66556008)(64756008)(66446008)(33656002)(478600001)(8676002)(71200400001)(6916009)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AnxEYt09ocoig4Rdq1iQCEhCqAVcoSBHkqgQqK/zbrJ8OHi6vbTD4TmV/aO4ajbccefo8EX/CVsdR9lGVTPn9W+2TNO7bavUT/vnmgwEj3LXHvYPGU9H9QcvMXfsG74FtOCYEB1//XVSgxhSmAvlzBoDHWABMpu+FnOG5XFWvXaadzN4sVOGstfthBRi/UYBCoEpMNaVaF06Waor+XBxKQP+qNt21O8mHu+JW9zuf2J6PlMUva02NhEG9Mh1NT+DA4ydDm/oMeILQ6+Ji/UAY8sCaABaw6eFzk5rCSpL10jizMJIqfk8XbbuFUIiRnh5IUtFVZ8S49wjXWg9sxCFo5Gg5Si0yGA8U/mCI4T4hpf6m1HY82ZTaHFkmINeCIClsXVdjemtCfi7hNk1D7+6UlzXBdI2L5LI1qche/nbooOsR3/BKgFN2uLQKlEYZZH
x-ms-exchange-antispam-messagedata: fS/Y2FHDBgjIh2MjYhj+TzcaJGwOpzOaw2Rd/WV0DQohS4Jqdb97uLeDLh7z5YXH72AAQSK9Ejftn45q5hzgWvMh21SdY7sSkgl0DiLFLxTN0VW58tg8TGfVRnidCGuvFtogt/ONQDMxPXxIJw/97NbjrCPzcdmt0JXPejbm6TWWxLHs5LrLa7vwAj756pSWsrK042aytwDfxeau/QkgvEyg/S5HS5KvtcdS/HUBgKTe6AlnLFQowAkXJdYzojhW3rQyVFffDQCKvgsHeQXVgPRWXx5cmvMvqetGtFEJlERxyYqWPtq3GfEEMo8qdsMWhYjptSaMMDJileiNR8QQYcaUoKOhZEvcTHI6TKGNvXQp4aLXOIy0OXeL9w5uBPvekbvl4mwNuOH3P/C4qtOclqFk0XZN2LNhkRjRpSd87JLfoXTZicz41NYAXM7YWT0p/4Luu2oY9EEzaoy8+vhTpEOA1DwwekHVmtbfsfFw3r9vv/ZEqYgwUVUa53YPggGY/lcHk9SJE53Th+ilL6YRf8Yxph7MDaty3rASA9czzon2KjCQRlvIS9sTe2M0tdJZMrqIWbt+AEWDlk6gyxYjdf7KKJJdYlQH1S8lmgXyQjB32eAK8tA7wn0pReaK8chKNzonw5hjd44HxiS+29dhplpqVDTk6BQBS2wUbvrkx8J4qPqm8XFL9GU1DIND55URkTEjBK853+lASSHyuyJlhZCj2GLqfVSrnxXLgYO6ew9QO8S7QU7EiOxyZmFOLc6i2RNTvXs8ro5lH6QLUKM7SvNBSXcu/haMS0d7bhF1tGDk96ywzHI8mRNcRr4vS9nMP3YYfkbwqHgZHm3BqNV5rA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D838AE0962CBCF47995E7AC2D4866D5E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d24309c7-81c9-4093-d834-08d7ecce6f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 06:19:26.6621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3hXG1pf8verFKZ6+aNCk54uh5oL0GQzyk4tBUHpIkCMvEsgWAP6j4LalU4ZA835kbRYCfWUx7QkLevZsV4sUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2215
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_01:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300050
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> On Apr 27, 2020, at 2:10 PM, Jason Baron <jbaron@akamai.com> wrote:
>=20
>=20
>=20
> On 4/25/20 12:31 AM, Coly Li wrote:
>> On 2020/3/26 23:28, Jason Baron wrote:
>>> Let's add some CONFIG_* options to directly configure the raid0 layout
>>> if you know in advance how your raid0 array was created. This can be
>>> simpler than having to manage module or kernel command-line parameters.
>>>=20
>>=20
>> Hi Jason,
>>=20
>> If the people who compiling the kernel is not the end users, the
>> communication gap has potential risk to make users to use a different
>> layout for existing raid0 array after a kernel upgrade.
>>=20
>> If this patch goes into upstream, it is very probably such risky
>> situation may happen.
>>=20
>> The purpose of adding default_layout is to let *end user* to be aware of
>> they layout when they use difference sizes component disks to assemble
>> the raid0 array, and make decision which layout algorithm should be
>> used. Such situation cannot be decided in kernel compiling time.
>=20
> I agree that in general it may not be known at compile time. Thus,
> I've left the default as RAID0_LAYOUT_NONE. However, there are
> use-cases where it is known at compile-time which layout is needed.
> In our use-case, we knew that we didn't have any pre-3.14 raid0
> arrays. Thus, we can safely set RAID0_ALT_MULTIZONE_LAYOUT. So
> this is a simpler configuration for us than setting module or command
> line parameters.

I would echo Coly's concern that CONFIG_ option could make it risky.=20
If the overhead of maintaining extra command line parameter, I would
recommend you carry a private patch for this change. For upstream, it
is better NOT to carry the default in CONFIG_.

Thanks,
Song
