Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8183C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B47B206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nxFqtgb5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="X2OpbXZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgFRXV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:21:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64256 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727937AbgFRXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:21:24 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05INJoCG028379;
        Thu, 18 Jun 2020 16:21:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yTaE2AY8zbI/W72Gr/EaUhIFGs+LUa1huZkv/ga34rA=;
 b=nxFqtgb5fEweC6xgcTtml0/KVYVjkfP+SNhFgfvMiMrFkibGN1mybLnvcRl7lLOQasUY
 8VGXbPuQInaSjAD2UBDzmpe7lNOtGPh5udx154ZYqG9bGtqlSPtP35PD2+R4MfHlstqL
 mdIM+sX26TBbSZ8T7L2hULCi86+5AP4sUSw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q653pvuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 16:21:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 16:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F75Mn8yu18WZ0dXP1QZY3lZsd81Dolqby4VeVdcdvegAXrDoIYwXh+m4MBRIXDDMkIrdVaWMhenjm+9l6GS78Ww8E/hN4MVivIPTuBdkdCpqkFb+cqUAWV/YIXt5M5K1LqVjTqSgmAwctuLGdX8/POaFGgL3y3wMe5i9Kx2OxCpw445Xe+Jw5yZaAK5Xzg2vNi1cxeDT9qsRugd7BYpeIFraY05gApqctchqWtnV5k4qu98m3F0KW6kh+L0IeyRfgIfGPO6tNoLGXJUEb0199u7YaCRaPvBBUNAv2i9lOrr0/c0MHPL+ya1IkX+iJ2sAD5KMq/sHGFT7R86e7ls1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTaE2AY8zbI/W72Gr/EaUhIFGs+LUa1huZkv/ga34rA=;
 b=bkMsgPCGQoF+H/Qsn0wNpFNTtJNQzuXyMkUAQI2o3JPo+75tUqmtjRDQIKe4uQsYrEJ/P8KSZGp8mO5UtIxdDzGepvNRQX9ahbEjT/of4tOQ8Vqdsj9g2QiFyzeXidwUaupbn8xpBIlC/OXbiFnFedsX/YgJt+A+vBfu4iYHqkMnllmeUa0i6TaaQPPvE79lOLbhaCXpvh7wbtmWcBzh0VUzWcLtIWGIcPmfYWw0PdJlwbwrIuLgXUlZViP3R4HD1oIY35sOlE/+3PzytxtZHyzuYhJqVozzLpaVPuWu+LWPXUDhNHCptE4+adN2cX/Rr5vW7l761ymv9+CrkjE2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTaE2AY8zbI/W72Gr/EaUhIFGs+LUa1huZkv/ga34rA=;
 b=X2OpbXZ4bGnbKSqs+LZNzYwPAUkQO0HuJQDWf9CJHNTAh1ZazLgON/u8DF+cNH0HWJTQPvnDUXNCitTPKC40X/K0hYScW4yVcFljhQAtpQyTk0oGFWrLDN8Z47zNe89MnorpGQmaqDY92vCDNBRUVAVlM7ZdwWylwVmlypenzQ4=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2725.namprd15.prod.outlook.com (2603:10b6:a03:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 18 Jun
 2020 23:21:11 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 23:21:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, "Andrii Nakryiko" <andriin@fb.com>,
        Francis Ricci <fjricci@fb.com>
Subject: Re: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Thread-Topic: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Thread-Index: AQHWRZVzS1zA6qEPN0CAIz19Cc1kQqje9n2AgAAMpQA=
Date:   Thu, 18 Jun 2020 23:21:11 +0000
Message-ID: <4889871D-5E00-4E50-9089-2A18C29B8D93@fb.com>
References: <ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.com>
 <20200618223555.GB793265@tassilo.jf.intel.com>
In-Reply-To: <20200618223555.GB793265@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:30b0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2162aec0-e7eb-416d-c179-08d813de4999
x-ms-traffictypediagnostic: BYAPR15MB2725:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB27254817B6F143A4E1B652FAB39B0@BYAPR15MB2725.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Id14SWs05cnPLAjuR4iHHT9K4U2PnEbHshyo05amcK5xyt4Q8H6pFVSTa0EIGkQchipEHEPXMJZuuG+NaDvoX3VtvAkREUPKwO8Msdg217375e92MiiNM/wPh/AknlRXe7Adi/Lca/VNmQpc28y0g4UsacfMWZUX1YCUpund+yhhqh1yl+CJzXAG1je10/ZbgI11aIZ/jXWy8TA09sXFwR2muVkDlyD3PFt2exqDuAjNudXgJE0D7yRfU8fQ6urlN2peCkymAaxx7LO/+hUrU4uwuQnni25cPY9F6d6udfbSJZEKWhl9kvjs9+D5vafx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(39860400002)(366004)(8936002)(8676002)(71200400001)(5660300002)(4326008)(2616005)(316002)(54906003)(478600001)(6512007)(53546011)(6506007)(186003)(36756003)(83380400001)(6916009)(66946007)(76116006)(66446008)(33656002)(2906002)(86362001)(66556008)(66476007)(64756008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gpqp8edzNSwFGnaYupNQNKJfac7Hi2btmnOk2lKOAgjgyV9SjslkcdXCexOUkic0C9/F1q+Nc1CVHHUI7KB9LjdrSWwaIEyNDBwHMIQoVCSSo5dWfcpbqRop7H8SJ9XLiIKgkloN1r1lAmpoo8oFUnXBNAeNJwV7k5kEIUTO4R08BPAH3xPOAfO1FgkMjFB7PTr2yoyAp/TmMm40zy7+K4x+348SH0WHHPLJfmBfOO+6TaZe1+gusAkhfnWBFiVnJCsTHBN8YndrHL7ZFCldpK2GhcydEQC1I5is1NRj1+by4ZG60B0FWKh35LN4Bwn9ms2mbbe5/9GE/+CglwclKv1uEG7BFgyU6Ts/yeuumVikFUS1e5jLvrtNuU88wSv5Ee7/wBdIZKoMRXIteNlQazEtvS3B45R7ylTFkfOxmW3LVg5tGTruN7ljaZjiLwxY8EvRC3ILfj9zBmWdJMDxdYpxpo6pGEBZHnbGk9WCyLEA9huiBsJ21i6fsrLwUqy84zvdPlsYyxYhKS+0ECoGHQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D845E33F01D3044A8CBD2E01A7C6B6E1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2162aec0-e7eb-416d-c179-08d813de4999
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 23:21:11.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0owxUwlFHX4EV3naLiJDr18B/DUTFtalKzyazbnpLFubb1+cTPv5TFgWGSfdjo12wxGAC+ilo5TSJRor8neS1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2725
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=852 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180179
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 18, 2020, at 3:35 PM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
>> We noticed that this only happens with precise_ip >=3D 2. This is caused=
 by=20
>> setup_pebs_fixed_sample_data() using pens->real_ip:
>>=20
>> 	set_linear_ip(regs, pebs->real_ip);
>=20
> With precise_ip =3D=3D 1 the IP will be one instruction behind.
> That's the only difference to 2 or 3.
>=20
> So something about the actual instruction confuses the unwinder.
>=20
> I would check if there is anything special about these IPs:
>=20
>> 0xfffffe00004d1f78 entry_SYSCALL_64
>> 0xfffffe00004d1fa0 entry_SYSCALL_64
>> 0xfffffe00004d1fd8 entry_SYSCALL_64

I don't have this system at the moment. For the system I have, I got:

[36000.163945] WARNING: can't access registers at error_entry+0x74/0xe0
[36000.243879] WARNING: can't access registers at error_entry+0x65/0xe0
[36000.334288] WARNING: can't access registers at syscall_return_via_sysret=
+0x12/0x7f
[36000.540940] WARNING: can't access registers at syscall_return_via_sysret=
+0x6/0x7f
[58419.640387] WARNING: can't access registers at syscall_return_via_sysret=
+0xb/0x7f
[58423.082418] WARNING: can't access registers at syscall_return_via_sysret=
+0xf/0x7f
[58423.155705] WARNING: can't access registers at syscall_return_via_sysret=
+0x6/0x7f

And

(gdb) x/5i error_entry+0x65
   0xffffffff81c01075 <error_entry+101>:        pop    %r12
   0xffffffff81c01077 <error_entry+103>:        mov    %rsp,%rdi
   0xffffffff81c0107a <error_entry+106>:        callq  0xffffffff81aa7a30 <=
sync_regs>
   0xffffffff81c0107f <error_entry+111>:        mov    %rax,%rsp
   0xffffffff81c01082 <error_entry+114>:        push   %r12
(gdb) x/5i error_entry+0x74
   0xffffffff81c01084 <error_entry+116>:        retq
   0xffffffff81c01085 <error_entry+117>:        nop
   0xffffffff81c01086 <error_entry+118>:        nop
   0xffffffff81c01087 <error_entry+119>:        nop
   0xffffffff81c01088 <error_entry+120>:        retq
(gdb) x/5i syscall_return_via_sysret+0xb
   0xffffffff81c000ec <entry_SYSCALL_64+236>:   pop    %r10
   0xffffffff81c000ee <entry_SYSCALL_64+238>:   pop    %r9
   0xffffffff81c000f0 <entry_SYSCALL_64+240>:   pop    %r8
   0xffffffff81c000f2 <entry_SYSCALL_64+242>:   pop    %rax
   0xffffffff81c000f3 <entry_SYSCALL_64+243>:   pop    %rsi
(gdb) x/5i syscall_return_via_sysret+0xa
   0xffffffff81c000eb <entry_SYSCALL_64+235>:   pop    %rsi
   0xffffffff81c000ec <entry_SYSCALL_64+236>:   pop    %r10
   0xffffffff81c000ee <entry_SYSCALL_64+238>:   pop    %r9
   0xffffffff81c000f0 <entry_SYSCALL_64+240>:   pop    %r8
   0xffffffff81c000f2 <entry_SYSCALL_64+242>:   pop    %rax
(gdb) x/5i syscall_return_via_sysret+0x12
   0xffffffff81c000f3 <entry_SYSCALL_64+243>:   pop    %rsi
   0xffffffff81c000f4 <entry_SYSCALL_64+244>:   pop    %rdx
   0xffffffff81c000f5 <entry_SYSCALL_64+245>:   pop    %rsi
   0xffffffff81c000f6 <entry_SYSCALL_64+246>:   mov    %rsp,%rdi
   0xffffffff81c000f9 <entry_SYSCALL_64+249>:   mov    %gs:0x6004,%rsp
(gdb) x/5i syscall_return_via_sysret+0x6
   0xffffffff81c000e7 <entry_SYSCALL_64+231>:   pop    %r12
   0xffffffff81c000e9 <entry_SYSCALL_64+233>:   pop    %rbp
   0xffffffff81c000ea <entry_SYSCALL_64+234>:   pop    %rbx
   0xffffffff81c000eb <entry_SYSCALL_64+235>:   pop    %rsi
   0xffffffff81c000ec <entry_SYSCALL_64+236>:   pop    %r10

I am not sure whether there is anything special. Maybe "pop"?

Thanks,
Song

