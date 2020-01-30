Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2152C33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79953206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hnYhxkI4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="E9hGfVAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgA3Col (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:44:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbgA3Col (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:44:41 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00U2aTla018337;
        Wed, 29 Jan 2020 18:44:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b1Hn0pjX63EqTIxmNAIDsOXXmbOjh9dL7nwTY6Cmuy0=;
 b=hnYhxkI4cqYjdspnCnPx7ZJSdKXjhq4CqnZQytK2irQqgXU5YB5Zp2GycoGYppB8626F
 O7esnZAYcBHQmbbK+72daqGU8OCzdzako431f5B7lCtoBOhkt5C0rJO5FZZCIvrjzvmG
 W9lbbdv656q16pcaA5MlLqZ3TP08Gaqdrmc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2xue5qaf7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Jan 2020 18:44:33 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 29 Jan 2020 18:44:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgcvmZj/GBjnYUOkw5BnP5ODSKtzAxx6jP+LSbtVBXay3Wf1nBTS9xnO6C/vCBZyM6wVS0POUvvCq/6NSZbYs30GYTa6bnrCC2X0EjKOok8cKigUgrAPwqP1/6KyKyxPSVko3GHD6f26Qr6NYtB9jLiyGaoH12m9YBgV6Z1cabeGd7YEMQy9PR7LBTnLhjVk5NfX+4TSQzYPsl2eulOdxnV1u/q2yOtYv0vPiYTJ85c0ieIotql658gQG2VZpcB+FBgEKKH5x45VLtNmF1XCRuV9Guglrg/7zxVKZE5JCGg9eZ3UFOy1y3GIl1Aqi0JVyEbuqU4VTSOT0TpF1s/E3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Hn0pjX63EqTIxmNAIDsOXXmbOjh9dL7nwTY6Cmuy0=;
 b=CcbGkWQB+cXAIF/aHxgc/SoUK1CBsvhl9ZF6skC9cUxzq0BUSuIACIF7b/hIL7eL29IVR+0viRfzAMI20Q8i9U1sHSrph/RM6UE/8BVTOw3U0dIEZRZa6smDE8lfYCv/b6nc3Si9i6wLbqG7dDWx7nvRLv7daLcqhPw6tNQmKoexs6gCFbGg8KmyBXS38F/SBVyhMc2UGkh1eIvdrQvo5d5ulTAiuEaLSYSHiF4i+wii5KGKN3JHqLDXfEjuKzK33bIfKaAokIVgvvMFOdsGPNx0YqD3dBC/ssacB8IEB0KViHnUHCRd83v9cc1XGRd/rqo1n0or6DzGKfA87QEM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Hn0pjX63EqTIxmNAIDsOXXmbOjh9dL7nwTY6Cmuy0=;
 b=E9hGfVAWgNKtVTMKBgMu1k4fCXzP6t0m06f9tjRTCZdXylx6MJe+05ehF+aAvnCcqFiwmreBmWN49+XS7EXH2o1aMmoO3NvOGVSKrObgH6LRuI8MzCGo3ss4TidMBBWzASFOwgzMvcr+HX3MsOefXa7y+cqdNWMp/PYNcauRvX4=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2854.namprd15.prod.outlook.com (20.178.206.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Thu, 30 Jan 2020 02:44:31 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 02:44:31 +0000
Received: from xps.DHCP.thefacebook.com (2620:10d:c090:180::482e) by MWHPR22CA0059.namprd22.prod.outlook.com (2603:10b6:300:12a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend Transport; Thu, 30 Jan 2020 02:44:30 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Vladimir Davydov" <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 27/28] tools/cgroup: make slabinfo.py compatible with
 new slab controller
Thread-Topic: [PATCH v2 27/28] tools/cgroup: make slabinfo.py compatible with
 new slab controller
Thread-Index: AQHV1xN2UrFWuOxJRUuTpgcWmaVcKqgCgDeA
Date:   Thu, 30 Jan 2020 02:44:31 +0000
Message-ID: <20200130024425.GB14994@xps.DHCP.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-28-guro@fb.com> <20200130021729.GB21973@in.ibm.com>
In-Reply-To: <20200130021729.GB21973@in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0059.namprd22.prod.outlook.com
 (2603:10b6:300:12a::21) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::482e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3644b671-7e59-414a-47c0-08d7a52e5527
x-ms-traffictypediagnostic: BYAPR15MB2854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2854195DCF65F5A14A74E55CBE040@BYAPR15MB2854.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(1076003)(54906003)(71200400001)(52116002)(478600001)(7696005)(316002)(6506007)(5660300002)(8936002)(186003)(55016002)(33656002)(16526019)(9686003)(4326008)(2906002)(81156014)(8676002)(66556008)(66476007)(66946007)(81166006)(6916009)(66446008)(86362001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2854;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7nksLFk2kubQy1V4HdqDIFyKrDdkpnPPVnZQi1At1I8xUvLXDmdeCJisuB5mM1J2YINBvZ31b0RaudMVumFqfe2wONKWZ4TsSmn8ynh3vi24+dvDszPhbMV1I3hVd1otDTAOdkaeqROl2Mri4+W34m45HZRQwKEkrOwWfPxYuDzf4qa3ipyO4uMjQdldozG8sDNUFi9C54Cw9SxW9oLbLfwAyFDoq2C4Q2YsUJ0flpH5SCsRKzqlqRqzKvi6nNKOx1I7+WPaKBemsVANRP+WESH17R3eLyanhrViRdrehfR71070DeIO4rasjlJsFlkU1BkykUAsB6yGPPC7oRZc3yXRS5tvG1QioSK/BaX4spiZFw3Nr2I6ey3DCyDDjxg6C6NSUBNq2VsaP4wa2AiqsCyv8cylaCtucPvNMCpXk+GGNqJXIglBsDtECJcttbM
x-ms-exchange-antispam-messagedata: sKw1eXc2JUttYkWNI4S63lbhAwdh/AlhFPiUE4ArkLl10gLWvRIjeGEDZWA8Q9oYW9P1PFDauLIJCtQ1JMEoY4yUcnd4b68bAwOzlcjvDxsswZN9V3jxuCJZ9v19eMkKMBKYGDkiXjWzSSO1pwXAB30OBmDDQX7TiWvgtwf3+BA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6AA988FDCBE324791C7B065604AAB2F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3644b671-7e59-414a-47c0-08d7a52e5527
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 02:44:31.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68ETANoydQnEy6y1Tm6IgIjfv+WYcYevPcYy4bXdNX33/vFj+6Y+LqHwS/Qzvg6z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_08:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300014
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:47:29AM +0530, Bharata B Rao wrote:
> On Mon, Jan 27, 2020 at 09:34:52AM -0800, Roman Gushchin wrote:
> > Make slabinfo.py compatible with the new slab controller.
> =20
> Tried using slabinfo.py, but run into some errors. (I am using your
> new_slab.2 branch)
>=20
>  ./tools/cgroup/slabinfo.py /sys/fs/cgroup/memory/1
> Traceback (most recent call last):
>   File "/usr/local/bin/drgn", line 11, in <module>
>     sys.exit(main())
>   File "/usr/local/lib/python3.6/dist-packages/drgn/internal/cli.py", lin=
e 127, in main
>     runpy.run_path(args.script[0], init_globals=3Dinit_globals, run_name=
=3D"__main__")
>   File "/usr/lib/python3.6/runpy.py", line 263, in run_path
>     pkg_name=3Dpkg_name, script_name=3Dfname)
>   File "/usr/lib/python3.6/runpy.py", line 96, in _run_module_code
>     mod_name, mod_spec, pkg_name, script_name)
>   File "/usr/lib/python3.6/runpy.py", line 85, in _run_code
>     exec(code, run_globals)
>   File "./tools/cgroup/slabinfo.py", line 220, in <module>
>     main()
>   File "./tools/cgroup/slabinfo.py", line 165, in main
>     find_memcg_ids()
>   File "./tools/cgroup/slabinfo.py", line 43, in find_memcg_ids
>     MEMCGS[css.cgroup.kn.id.ino.value_()] =3D memcg
> AttributeError: '_drgn.Object' object has no attribute 'ino'
>=20
> I did make this change...
>=20
> # git diff
> diff --git a/tools/cgroup/slabinfo.py b/tools/cgroup/slabinfo.py
> index b779a4863beb..571fd95224d6 100755
> --- a/tools/cgroup/slabinfo.py
> +++ b/tools/cgroup/slabinfo.py
> @@ -40,7 +40,7 @@ def find_memcg_ids(css=3Dprog['root_mem_cgroup'].css, p=
refix=3D''):
>                                         'sibling'):
>              name =3D prefix + '/' + css.cgroup.kn.name.string_().decode(=
'utf-8')
>              memcg =3D container_of(css, 'struct mem_cgroup', 'css')
> -            MEMCGS[css.cgroup.kn.id.ino.value_()] =3D memcg
> +            MEMCGS[css.cgroup.kn.id.value_()] =3D memcg
>              find_memcg_ids(css, name)
>=20
>=20
> but now get empty output.
>=20
> # ./tools/cgroup/slabinfo.py /sys/fs/cgroup/memory/1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesp=
erslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_s=
labs> <num_slabs> <sharedavail>
>=20
> Guess this script is not yet ready for the upstream kernel?

Yes, looks like I've used a slightly outdated kernel version to test it.
I'll fix it in the next version.

Thank you for reporting it!
