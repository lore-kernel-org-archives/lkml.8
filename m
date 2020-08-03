Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBCDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E252065C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Fmd8l7Jm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OZAHAK6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHCFwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:52:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31438 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728263AbgHCFwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:52:24 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0735keWN017655;
        Sun, 2 Aug 2020 22:52:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GxfxDLTRmTDWnDjZ4AXC6im4X5kkcqBKsU+E4Q65UOs=;
 b=Fmd8l7Jm2eLkQXz4mvL5qgCbE3DWEJSysOy/NUXSJL9OeU1FXeK3BTusgmnxMaxWvYOy
 3qiIZ+O+lt29QARwOLdz4LYjn6EXntLnZQvPPm/HlkA78o+pqoK5uSSyJ0gQQuL+kqZZ
 nImFm2xAXKF+gjWffPY9aQ3W1YRPfEeDvao= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32nrnntwp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 02 Aug 2020 22:52:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 2 Aug 2020 22:52:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg0JszK4z3BAx303KeN8pwPwdmTUb7feLLwx8HILH8KkDlikr7XE9slhF0PPVumKtJOcuZVTeqBO8vQKoTKB21xOrfw7Y3h7mQT8qRZn9A4VoV2RBd9LwNrjPmhAczGiXhSlwMc49eMerYaPuVj6R8JexPEvr5ltpvlfGvPbI5FMaa8QEaP38+p5yd5Uw6QOCDkJLHvMUGM1Bb4B/tYfpm8s/igTApxyHvdJfsAQDQzlgZDqUoeEvQMNMJ23B2yaDkzAZZgOMQBTW4DQLAqudbRnIu9urDFnE44xE8ztIrDEFqjMsH/AzhcTE4fFs2UPXejR+gw/ob9kMHH1eh+W+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxfxDLTRmTDWnDjZ4AXC6im4X5kkcqBKsU+E4Q65UOs=;
 b=Lyph7IWuggxSPFD5xhafMW8BomdByM/C8zWXrJjDJJsS8Ykbi+kiilKNQXPwPShtyZYVkhF9dibzYwDU8rtX0Fk9gtdhAQf8oPHFwUQzfghF7dHAmotzQJnGmYBxgncHt/RZ4lqukGpW48y5G+geWAeOzFCcGCDn3qop5u0x18y1CD/5i+0KP5q7+H7JVXWo7hqWivJVqz4WgZvs9Wi0MC78bV60p08UPOoksQFoTqtV7TGashS7lVN3WoJ9R89okX/eTUU2oGssoAyFC4QAdvtUZy5uF/Vqpe/WmFy3kbOHeYupXTY5Daw+UvtNaOnQA4fT80Oc5hFUok4e8JlAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxfxDLTRmTDWnDjZ4AXC6im4X5kkcqBKsU+E4Q65UOs=;
 b=OZAHAK6VGI+mh3wGO8q1uMZru9SwiKk+MffrBZyqi+6c8FnvHX9zde2ownEtU9Rp+hhXZyauj6LkhC7vIcmxMpy6Z+rd4B358RR9WJQHeZ8aN+4+pHNH8aWirGoEv1bw7T+4HZ7Mlibn4WmWyliuJY2b8DFJO4G7LgKxjyq+ErA=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3048.namprd15.prod.outlook.com (2603:10b6:a03:fc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Mon, 3 Aug
 2020 05:52:03 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 05:52:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>
CC:     LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        "kernel test robot" <rong.a.chen@intel.com>
Subject: Re: [md] e1a86dbbbd:
 mdadm-selftests.enchmarks/mdadm-selftests/tests/07layouts.fail
Thread-Topic: [md] e1a86dbbbd:
 mdadm-selftests.enchmarks/mdadm-selftests/tests/07layouts.fail
Thread-Index: AQHWZYdrTnvuLu/0HEuot/wCz5xG9Kkl6VuA
Date:   Mon, 3 Aug 2020 05:52:02 +0000
Message-ID: <C6E82A56-754C-4FA3-A15B-6A6F80A9457D@fb.com>
References: <20200729090451.GK23458@shao2-debian>
In-Reply-To: <20200729090451.GK23458@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:8f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 334bfb4a-7df4-4dd9-5e9c-08d837715882
x-ms-traffictypediagnostic: BYAPR15MB3048:
x-microsoft-antispam-prvs: <BYAPR15MB304893E6FC1A51B79670226CB34D0@BYAPR15MB3048.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDgBc4591xUJbBh6BUJWpVcw2RkEQ3MT20a0upwjfnFNmyIHxKGt0EMCwHNhVKjx0i2rlB2NpMkw5NCpk8Oz/xoC9h+PEkNKjrIJt4ely9G1utY3JMm0NgT/VFvqc4zAW2VAS/QjOIHtpZ9tc1x2vovEOlWpl8WAJ5AOeLhQx6VZxfQNRCoiNKpVp+kKq97CYgdJ9/G7sv4+xAzVKJjC+kCkKvTokNq7ILsitNIC58sKBOP8nN+ghpuZ0+MrrQ4UdEp2DOq98EpNTp+uSirFA0YIP+mWHjNEtCYxPD5iJ6uex0rbgtFrCmGt8261xct+tzquumBwpX7+sZsED5wOwcMQF+QPW55SbkX9OW5NCiBRHL3lke7SQwh0mMeIqH6PXJdc+o0ll2cltJ0PLpt3xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(136003)(346002)(366004)(396003)(66946007)(316002)(8936002)(66556008)(66446008)(54906003)(66476007)(186003)(64756008)(478600001)(33656002)(6512007)(36756003)(53546011)(6506007)(4326008)(6916009)(2616005)(6486002)(83380400001)(2906002)(966005)(5660300002)(8676002)(86362001)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YHzK03B3TlfS68RPpZNAptx1tvVqBS0KQ8A/ZAmcGEN+/HRxZIM16osPzSDY4obowlbjevAvleraCttdxbzEjqVTjgL4fMHqtLc4zEfobPprDp4bRlKWm6jOhJ0N7eZvqPp1vskS6txtPC+xfuYLPeE66XYI1BTrOZ6LRRxfL7Ura0+zZbrR21JIvAG5sPvavtIPKYVrleFb/X/Ync0tONP039EpU9SGha6ZNQrieVR/NDZf2ABW7U0SdpMc6CbXlx7OULZGaLO9KyNsUBu0yjJRaBG97YUEK7ZG/PKwOmkWUHWaC2P1P+dlGgU8rK7vwxlnfKGJyp9esCYy7vfTEvKMjJQVzl/Tp9HIiNPsArW5uvhiXcXNXATl32NBdWjJF8MsMUTYQ38oXwsVx1dDHp5WbHBZLPDT5orcVDZOVh7NzM+OtovddjMSjc/Sb31FhddOSeMVfBCJfUgdAs8Bj5hGHypkxRoDMk5stmNEiqb2aslEMs6vRiXvXfXlBXOH6Tvmx/jbDnl2mI17vqiXnliW8FAwo7Ln7shXm2o9Y87FFnfxtmGieDJeUZH/DLtmz9IMFeB+m7tYqQLaisI9seWC5AUfi4HeFK572CGw/8Qdo1svLmAgOnUNYacpeuBLHVLU3+qMgSG16Lvv6zydM/Lyc6mzc45oAK3jFEHmsko=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <621FD2F4C31F314692CD52C5CC892AC3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334bfb4a-7df4-4dd9-5e9c-08d837715882
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 05:52:02.6807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJxwtrxJ6wIZVFdnO3Wus4mO+2ZgAf67Tr7J5N5jTDWUv+ePKLbya5mJePkCiblicrV6raTHfNCVrof/1IEaYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3048
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_04:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030043
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 29, 2020, at 2:04 AM, kernel test robot <rong.a.chen@intel.com> wr=
ote:
>=20
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-9):
>=20
> commit: e1a86dbbbd6a77f73c3d099030495fa31f181e2f ("md: fix deadlock causi=
ng by sysfs_notify")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20
>=20
> in testcase: mdadm-selftests
> with following parameters:
>=20
> 	disk: 1HDD
> 	test_prefix: 07layout
> 	ucode: 0x21
>=20
>=20
>=20
> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4=
G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>=20
>=20
>=20
> 2020-07-29 01:06:34 mkdir -p /var/tmp
> 2020-07-29 01:06:34 mke2fs -t ext3 -b 4096 -J size=3D4 -q /dev/sda3
> 2020-07-29 01:07:36 mount -t ext3 /dev/sda3 /var/tmp
> sed -e 's/{DEFAULT_METADATA}/1.2/g' \
> -e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
> /usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
> /usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
> /usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
> /usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.conf.5
> /usr/bin/install -D -m 644 udev-md-raid-creating.rules /lib/udev/rules.d/=
01-md-raid-creating.rules
> /usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.d/63=
-md-raid-arrays.rules
> /usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rules.d/=
64-md-raid-assembly.rules
> /usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules /lib/ud=
ev/rules.d/69-md-clustered-confirm-device.rules
> /usr/bin/install -D  -m 755 mdadm /sbin/mdadm
> /usr/bin/install -D  -m 755 mdmon /sbin/mdmon
> Testing on linux-5.8.0-rc4-00129-ge1a86dbbbd6a7 kernel
> /lkp/benchmarks/mdadm-selftests/tests/07layouts... FAILED - see /var/tmp/=
07layouts.log and /var/tmp/fail07layouts.log for details
> 07layouts TIMEOUT
>=20
>=20
>=20
> To reproduce:
>=20
>        git clone https://github.com/intel/lkp-tests.git
>        cd lkp-tests
>        bin/lkp install job.yaml  # job file is attached in this email
>        bin/lkp run     job.yaml
>=20
>=20
>=20
> Thanks,
> Rong Chen
>=20
> <config-5.8.0-rc4-00129-ge1a86dbbbd6a7><job-script.txt><kmsg.xz><mdadm-se=
lftests.txt><job.yaml><reproduce.txt><07layouts.log>

Hi Junxiao,=20

Could you please look into this issue?=20

Thanks,
Song

