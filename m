Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF17C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E0020727
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NHXzT8d5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SuEpIAoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbgGVXxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:53:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51116 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728914AbgGVXxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:53:23 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06MNmPsk005982;
        Wed, 22 Jul 2020 16:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4h/hHvmBmxC3u6Qa/L6CvEfMKc+b9pURuwOb4VuPkbo=;
 b=NHXzT8d5Kc8vVZrihRYl4X5hfQM+w7gqd4+xP1LolMHtPwd3w3gUe9pRIabE6eh5nJIw
 4RIkHy56O2SxPQ0sHyXnGT6mrbHFKYG9zYWljkq5bcLA4RGlD/7nMspda3KIckAPJISY
 hDQEsaAdHKyAujD59p4H4nLxqp3ok6mVXvc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 32er2fadyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jul 2020 16:53:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 16:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBlReDuJa+YbG1u4ibKUpyDxLO28l4vEnEMET93Cx6U33IJwCns3rnOtPLyzXGxyTzJXhrXah3MmYC+pCE5KyYh32zCR1r4LZxLbgYW69t4NlOymyPeE9s6sgDm7jafZqMSMXjP4GmHDwhOv51z2be4TmruDIl6bZql2kzhDzC+TSfrgRrJl2/h575U7O5yHXesxYGBHljgLtzJPA1COnurFK+XWXAzTYCBsTUhnvsrUp6ISN19Vh/HE7mJBWyIp9vosYNnJnQi5RqaZGv2Rk15cMPauKfaDSS17PUhzq1Gk0AF/EPpW+CzqTIHkPjWm+d07ix0rqCdDQ1ATY/nlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h/hHvmBmxC3u6Qa/L6CvEfMKc+b9pURuwOb4VuPkbo=;
 b=Bla9a8MdNRwrzD0WjhN8p5qlV/dckG/pX622H0j7+0qO2uGBun9Nanm42oj/r9RK+ukFjQEf9Xd77zo22AaWvM9rLpSHdomvBSMO8SlRuzaCQNVkTTpq8KbL1ZK9djPNe3PFmCsy9VMFrHu8bbF4ibe4guHRbNZ1c9uvWJvlL5xWvT7NoLjgFykEbFsC/AW1Ke2iCK0/Uwab9+3VJAcSbAoqUfybvLLF0s1sj2eccs/Z3X7Iy/zS76GiIk49JCR+/6zki2DQyd5nEV54VJKo+qGRZ7PdXgrOVn7WTeIqFKVjnBA067TDqL2Xuk1CAzsfhk6Adv7DUrgmaXiMNXqiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h/hHvmBmxC3u6Qa/L6CvEfMKc+b9pURuwOb4VuPkbo=;
 b=SuEpIAoFP51eeOmL9JLxzUURyp4u5Nb7qrjpE0r4CuPPDGRhUzx03DQassBZ774EQsuMmbWUnbWB6AGL8u5ApdmmqIu/dekN/vj9EhzBIZejjRfdvOMr//tAGgXOf5fipxdxCQmls1YDe4I2mI3EraFSaXeF+yWSUZaZ0H5sLAs=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2838.namprd15.prod.outlook.com (2603:10b6:a03:b4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 22 Jul
 2020 23:53:11 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3195.028; Wed, 22 Jul 2020
 23:53:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "Markus Elfring" <Markus.Elfring@web.de>
Subject: Re: general protection fault in khugepaged
Thread-Topic: general protection fault in khugepaged
Thread-Index: AQHWXOEOoN3ulk33p0OSvPFPZQM2EakQMOIAgAQb3QA=
Date:   Wed, 22 Jul 2020 23:53:11 +0000
Message-ID: <27C67962-55A0-4815-ABE3-7F71C5FDCE4D@fb.com>
References: <000000000000358aec05a9fc8aa8@google.com>
 <20200718085409.1448-1-hdanton@sina.com>
 <20200720090824.gjg4bay2pnnurasm@box>
In-Reply-To: <20200720090824.gjg4bay2pnnurasm@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:cffe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9262d149-6f67-4819-3511-08d82e9a643e
x-ms-traffictypediagnostic: BYAPR15MB2838:
x-microsoft-antispam-prvs: <BYAPR15MB283853906FB1B05DFBCDBD5BB3790@BYAPR15MB2838.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iyxa/TnwwBUubLb79f7qiePofdtOATmwKIJpcrX/ZagyYs68f3suNeEPOuvlSD1S5VPZN/qVEvAceMQyIzCrBl/xz/VQ/QN85xWVoSl4EkCHrYa7ujUD+gRN53dtYWdqcS76agYtY5+cWD+ZFscYHofaJ6i0U23yaCF+yC4stFetBi+iq14cNtJBvcUbaE3ST5WuUGPrprqA5qsDGHX5SL675jDYIdU/hJUNfekt8Fed8fKBoBi63ZhzK4emPAfzPJEjIKwubQWJQqfzC5zXo/hUMfSWCmJnbmK8ZpkBndbOYK/qnrleXK7dExhutnwHTMYvGs23qwCyXAUPXu+RX/Ok/4cXEKlPVS6g0gkvUQJrY0Sm5JMPqvpkPY+WstmFcQMB4mMw1OPiRrHfybjMu6www8PLAACFsBaqaEA+2SGRC/QlKDpGo4hn1c6lUCl99ogqhok4QNH6GJhkDVrGew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(6916009)(5660300002)(66446008)(64756008)(66556008)(66476007)(8936002)(36756003)(2906002)(33656002)(6512007)(6486002)(66946007)(76116006)(4326008)(54906003)(71200400001)(2616005)(478600001)(83380400001)(86362001)(966005)(8676002)(186003)(83080400001)(6506007)(316002)(53546011)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mliVBEI9Fq86N4zoRE6OfcDJQMtHc9C/EPXxsjJcI9r+7Tru/88YLcom6pJrcjVKWgkCAyudHVmFekaxZNcFk/ncMLzyalHgWlcr0UdHquNJ2T2hZjuOvd3eYjr9BEZDfvrkSk0NkbxRj86Yz75LJKUfy7IAD4/99BSx9O8l9SvJBjgqzTh98RzTonqAXJjK546c4NgaBk+zqv/Ez1oDpmWYkQarO4+eivu40I3c5T837H1pSNC1D1XtA0zRAJhRZwtoOL2VzKSpPBBMSF0vvfaAdOZW8ZB050l8N1bezcm2pBovlNbxHcfXaNejdCrl28QKz4vKuF7lgBRtVVxRIC4hmOT5kPv6J5lP70XEDa0aCxZe3WS3XoKc6mhbF+a/ZEhGUnEGOqYvoaKzHHzjC8Ae1Z0pmQjTOPWpCqlpv0ZKdK1cbRZXpEPwjLkuAybX0nMzMDFrkBkuqEsRSSa4bq8Oj4cZpzjiIgsHFezCRI9bGZ2gtls80wt3+rJ4fU50AZoVLYHK+HJf5pvi81Vu0Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07FC5C49F5A3E24EAC8A4F2377142B64@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9262d149-6f67-4819-3511-08d82e9a643e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 23:53:11.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sD+4wy5npWq5TLG6fC4YYcKIu6EDceVg76jxVxbMwga+FcA544/9vp0XrKE9Gb3Kp/ami1EklDg1xnfFz5NvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2838
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_16:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=693
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 20, 2020, at 2:08 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Sat, Jul 18, 2020 at 04:54:09PM +0800, Hillf Danton wrote:
>>=20
>> Wed, 08 Jul 2020 23:43:19 -0700
>>> syzbot found the following crash on:
>>>=20
>>> HEAD commit:    e44f65fd xen-netfront: remove redundant assignment to v=
ari..
>>> git tree:       net-next
>>> console output: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
syzkaller.appspot.com_x_log.txt-3Fx-3D15de54a7100000&d=3DDwIBAg&c=3D5VD0RTt=
NlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DMQfhDjE=
9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=3D6MfBZJE4yUynBic_FV4udh1WdM1wXz8vdc=
sOfuR23y0&e=3D=20
>>> kernel config:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
syzkaller.appspot.com_x_.config-3Fx-3D829871134ca5e230&d=3DDwIBAg&c=3D5VD0R=
TtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DMQfhD=
jE9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=3DKvhWD3PT9mC8iTIUtQGrMj2UJpBMlsmJ=
Ov_wx1kxkQQ&e=3D=20
>>> dashboard link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
syzkaller.appspot.com_bug-3Fextid-3Ded318e8b790ca72c5ad0&d=3DDwIBAg&c=3D5VD=
0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DMQf=
hDjE9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=3DsLoGzpV5UcRyP33XaPaGp_NoxP6VSX=
h4jttnxne6n6I&e=3D=20
>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>> syz repro:      https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
syzkaller.appspot.com_x_repro.syz-3Fx-3D113406a7100000&d=3DDwIBAg&c=3D5VD0R=
TtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DMQfhD=
jE9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=3DHXYlOJ8r_Xv84UDkW6MSoEiG122ATfKJ=
dhQlv3J7mao&e=3D=20
>>> C reproducer:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
syzkaller.appspot.com_x_repro.c-3Fx-3D175597d3100000&d=3DDwIBAg&c=3D5VD0RTt=
NlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DMQfhDjE=
9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=3Dc5Vlm43NNztzFCNb0S6s8IKJuVUtEtm0yW=
wfV55CeAo&e=3D=20
>>>=20
>>> IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
>>> Reported-by: syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com
>>>=20
>>> general protection fault, probably for non-canonical address 0xdffffc00=
00000000: 0000 [#1] PREEMPT SMP KASAN
>>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>>> CPU: 1 PID: 1155 Comm: khugepaged Not tainted 5.8.0-rc2-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
>>> RIP: 0010:anon_vma_lock_write include/linux/rmap.h:120 [inline]
>>> RIP: 0010:collapse_huge_page mm/khugepaged.c:1110 [inline]
>>> RIP: 0010:khugepaged_scan_pmd mm/khugepaged.c:1349 [inline]
>>> RIP: 0010:khugepaged_scan_mm_slot mm/khugepaged.c:2110 [inline]
>>> RIP: 0010:khugepaged_do_scan mm/khugepaged.c:2193 [inline]
>>> RIP: 0010:khugepaged+0x3bba/0x5a10 mm/khugepaged.c:2238
>>> Code: 01 00 00 48 8d bb 88 00 00 00 48 89 f8 48 c1 e8 03 42 80 3c 30 00=
 0f 85 fa 0f 00 00 48 8b 9b 88 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 30 =
00 0f 85 d4 0f 00 00 48 8b 3b 48 83 c7 08 e8 9f ff 30
>>> RSP: 0018:ffffc90004be7c80 EFLAGS: 00010246
>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81a72d8b
>>> RDX: ffff8880a69d8100 RSI: ffffffff81b7606b RDI: ffff88809f0577c0
>>> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8881ff213a7f
>>> R10: 0000000000000080 R11: 0000000000000000 R12: ffffffff8aae6110
>>> R13: ffffc90004be7de0 R14: dffffc0000000000 R15: 0000000020000000
>>> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:00000000000=
00000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000000000000 CR3: 00000001fe0cf000 CR4: 00000000001406e0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>> kthread+0x3b5/0x4a0 kernel/kthread.c:291
>>> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
>>=20
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) =
FS")
>=20
> It looks sane, but I think it's easier to check in
> hugepage_vma_revalidate(). Something like this (untested):
>=20
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b043c40a21d4..700f5160f3e4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -958,6 +958,9 @@ static int hugepage_vma_revalidate(struct mm_struct *=
mm, unsigned long address,
> 		return SCAN_ADDRESS_RANGE;
> 	if (!hugepage_vma_check(vma, vma->vm_flags))
> 		return SCAN_VMA_CHECK;
> +	/* Anon VMA expected */
> +	if (!vma->anon_vma || vma->vm_ops)
> +		return SCAN_VMA_CHECK;
> 	return 0;
> }

Maybe move the new check to earlier in the function, say right after=20
we get the vma?=20

Thanks,
Song

