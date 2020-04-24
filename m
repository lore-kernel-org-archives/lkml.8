Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74552C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C171214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BiwawVOS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AhJ24TfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDXXWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:22:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5418 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgDXXWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:22:39 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ONK46u012090;
        Fri, 24 Apr 2020 16:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5kkSRJSPMKpGUtMVYijyXvVEFOk1EI/NpWlE/Gd0/88=;
 b=BiwawVOSv1V6d++DP6ZtxgOgD7iZU9n+JdpvN1jzERe1WstrkxFACyDAdm7HNSoE8mqC
 n+rdylempHFSJUbWx1YoC1GbWeotbhVTzCZvBmgz9Y0B4V3gwz87/ZfdTK5exai5bw0t
 lgv1+Dw+ewZozr8nIt5Naz9cZJSjqPGctjo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30kc0rk0rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Apr 2020 16:22:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 24 Apr 2020 16:22:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH07vRddBw8KcXmHfhpFXSzBEw9TafnEaTkpqxKsdgYvBlegOCIuG3nHi60LlLCGIWCfKchpE3N7KJeHMmsLrC2YsQe3mBPGuUnbkW412e2ru9X7AND7a9lGl5E7SXKF/6ewUl7092AzN+/Zsw4N5m3/mFCkPECi0+gMAYD77WSXWDETSvj1Kro+ih+gss3+TU/WeEeObn3aaKU9EU9+s6U60FkO705OXOwrKKZV1aAa3CIW0SnNQw1Cznhu+wcZueYPMZjdU1tvxJqWA9YQ1DBnsjzjQ421BG5feyd30rrOJ++Jlu5Q64zOJr8yhWlITrMKr32qbbCK8J1WBPoKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kkSRJSPMKpGUtMVYijyXvVEFOk1EI/NpWlE/Gd0/88=;
 b=FrbRP6vV8Dq+KeXee9BDqjFajnFJ09EZmoyvMRp112UGaxtEYBIVt/exXR1ooYMP/gqMNUgb63d5SZCOizkKtkD6q3KjbXwTAbp1HjTWo6JJvRzadg+B5fNPopceXFGvSH/5VH+hpiofgCz7xecpru1CFQz6UNuV4MaSCY9RjitukRxUrb9EzMmDfjYIj9ZKz0jyWAOj/WarRK3rCCAi0Wy1E/H3te73R1oGYyChz/yWaV8mn9c3Z2sqdxlVTvG+iC3oQQa8IgkRp0iPjuKkMYK0Kjn1l5YRBK5bXQtnjQ7jcxUHaF4P446V4Je4lH4DHFbuUUKc4SnznG/7AFqgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kkSRJSPMKpGUtMVYijyXvVEFOk1EI/NpWlE/Gd0/88=;
 b=AhJ24TfXKLP/yVi2Xlw2nLRbJpDoPtqU2Y4ZNYL4ioMhG1jjb8rIymppRm8Rve9jz23DdOscjpM11GJJV5UHlEu/XY9BYnJVKTOW9QdP5ngfq5Mc/VZm5sjPkrZgyUbOLoiEN4nZ04xUs9iRF/VKZh4ax4X6cdrSyQTCXT8wLx8=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2439.namprd15.prod.outlook.com (2603:10b6:a02:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 23:22:23 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 23:22:23 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jason Baron <jbaron@akamai.com>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "guoqing.jiang@cloud.ionos.com" <guoqing.jiang@cloud.ionos.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] md/raid0: add config parameters to specify zone layout
Thread-Topic: [PATCH v2] md/raid0: add config parameters to specify zone
 layout
Thread-Index: AQHWBqzd7F+KEJEx+ke3wR1vMYGq26iJERCA
Date:   Fri, 24 Apr 2020 23:22:23 +0000
Message-ID: <81A991E8-B87E-4518-9643-45037A104981@fb.com>
References: <1585584045-11263-1-git-send-email-jbaron@akamai.com>
In-Reply-To: <1585584045-11263-1-git-send-email-jbaron@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:292a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3aaa9740-32c6-4887-d44a-08d7e8a657f5
x-ms-traffictypediagnostic: BYAPR15MB2439:
x-microsoft-antispam-prvs: <BYAPR15MB2439C945753B65177DDA04EBB3D00@BYAPR15MB2439.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(53546011)(8676002)(316002)(86362001)(54906003)(6506007)(36756003)(71200400001)(81156014)(4744005)(2906002)(5660300002)(8936002)(91956017)(2616005)(4326008)(6916009)(33656002)(6512007)(76116006)(6486002)(478600001)(66476007)(186003)(64756008)(66556008)(66946007)(66446008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZuNBeFnu7UL3yJBTIl+UQKWQvOTiEB812wjrN4JxD4xesFf5AK60w8fAeQ1ihB/wcsO1GrWNNd0Y+0jzdOTPWXqx4OAvjo+wF3Oj5naJDHOgEitaRTwRlgV1xPK205MvmdLHxrO4NLsIsJzJjW61x0JlZlpR9rJouARaHjrvJN5gWUEBlKZhXwC8KhglAnlHa0ykHYlYFaiTHvSHYiK+zPOfEQA67iGkoUiSQWy1CWGnBnop2ZRCWYIb2azxqIwY9ZA7Q8U1cdhBop/18r+wmv0Z0CCg6mt3OiYxPCFoe2TiR50xsPEGgAvVRyzOQqzhUDI9U/EIrnHSHcVI0UVF9AKXjF2YCHFhDIywR9V1JaUjY0AWkdbCrIkOty3Sj6/MTOXyJ45BH37oU58tDeTGi8EMLzpW0duZu/CCQJ89m4E9Aj5TmpryuYCORmExmdm
x-ms-exchange-antispam-messagedata: F1SAtPQ3AiL0nY6gCLC/XUOxmGwgl3a4elXK9P1+24enDFW5Z3YMKtz2YsMScdSdf9iWwXGlZcX4vLNYtyGMjSjfBx24cwTlPbrL/XUpqGTTgWrY575OVxZBSgA7x0h1jZ3KS9LOR8FOLMlF3SjrXX7J/P5wP2F7lEuzWZMziSRZkrmpwdLQYni4aNboVHPnSLT76sfyx3rfrQGtPvehaxh23RsMgK7fqNOsFg12ulBk4cYJ7PqqLGVM+VWuj2kfe0fPbetTnsNQrwg2jpIjG0tOC/ODxhcuUHt1QSVyYWOJW0uc3ExC5oHObOmAaEjlZAoEAwfUT4CgvwB7ik049Otblh2KQGJG8yLOW1lmJqK4tDckycA1V29zvY7ZkjwQnBF3/jy8rLW9S6wqw6VUPBwZ0RIKGztHAU3BYI1Kf8B9NrUZPjQQmyhxAJ8xEPbhakhnv4PY3PcpN1UvaKp/nYhBv8DdX0vyrTqlgMILuS1vRXlNmlhn58UF3ksLB//LA1KDQRVAbfejomLGL26AEKVq+E4hN1qXFcg08Ntm/HH9G4xYrdzAolJ/zcu7III5nm0l1SEPRnCQ0TXllm/fs1nOiiO29vg8eMW89utnp9ktG8pkOYKcvcnbSW8FKlK60XvZ9O8BlP2Be9q9ka2oc4WkvYIvPuIm3PB5hus/P5Sw/RzmQBwH+io495YzkCkfRv5uSBAQBpDg8FqI8G8HfY0KVrABtATrDhT2ggFBC5IgyrujoxXkG3Pu9/KWJzRRzXG9bI5+DFrPluTgf/AKH32xlg601s/BEOKSoI7RAKo2ZxUidgkkiGhRXR1WKIHiLM7cEe3Ga7pctlxLGuVgeA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14A498177D9406408AB7D323A41B5F7D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaa9740-32c6-4887-d44a-08d7e8a657f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 23:22:23.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBJHwyunPyqSi1pisTsquPG2W60tl6irSVI8vlkhTQ0voA5rHwUvhsRpOTHL/sUIBu5jSzuN2fuEMV04LZk49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_13:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240177
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 30, 2020, at 9:00 AM, Jason Baron <jbaron@akamai.com> wrote:
>=20
> Let's add some CONFIG_* options to directly configure the raid0 layout
> if you know in advance how your raid0 array was created. This can be
> simpler than having to manage module or kernel command-line parameters.
>=20
> If the raid0 array was created by a pre-3.14 kernel, use
> RAID0_ORIG_LAYOUT. If the raid0 array was created by a 3.14 or newer
> kernel then select RAID0_ALT_MULTIZONE_LAYOUT. Otherwise, the default
> setting is RAID0_LAYOUT_NONE, in which case the current behavior of
> needing to specify a module parameter raid0.default_layout=3D1|2 is
> preserved.
>=20
> Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jason Baron <jbaron@akamai.com>

This patch looks good. However, I am not sure whether the user will=20
recompile the kernel for a different default value. Do you have real
world use case for this?

Thanks,
Song
