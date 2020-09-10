Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F254AC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3D3214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="zPte7GDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgIJTJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:09:27 -0400
Received: from mail-dm6nam10on2105.outbound.protection.outlook.com ([40.107.93.105]:38625
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbgIJTIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:08:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfgJHRrgSURwo1d7SnAqZavi+p4qVX+/QhVFLJlkn35fZre0/X0bR9Dbm9tt7dkGRpzVmAR+C7sAPPBe64VeRs8IR8VMrNKdyNFBTPzAQSsy39+CfQFdygrrfWDXVbXFkZIXbYWTJ3TsxBE+WxYPA9LtMxlcQUSNFtPiZ6+SasYm2ky2N7EzTWn6QNPPqQYxloY+Wt/ZLNlYhsrtPtSe8C+axTicBanX6tflVHL5Q0IxnYTxcuEPW8S1Oycnf2CMNqZXUGFF2b4cMIFCwrLua5juQtogutZZR+Kq9uh0wEAiuyyooN4AQxWUbN1gKCfo0KtT7U8F19MhIv/dhKyMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX4nnm/V0SCt+v6d2qmgPgeeqsS2Lwlmfs6jg+9dn6c=;
 b=Eunmd7UMIp3F5Q0yYm9+ydwaUugigKQECgjBJ221tTXy8OxbomOqvMrSNAkyVcEfDPR22YmPpdC7u/1yRl6iOzDn2By6K0d4cqPpGwQ77RLhc6Rqev5oh0OGfZGCOiXqjD2I0XuYEeh/PzAqEx/hQabBc6gJgwTJb8E+HzSyMTnq4Upr0mZQOe73n0wlS/TtH6oG+vGgKuUBoW8NxE6dv631Yr9D6FtQgMJjai7Wtu1MiA0/iLQfKTfN5brY9f6wRHPDbo25Iy3XtFPGlQgnqwhFblRPsMZIHaZxC/R1YQhP7uhl7JjJXyKQkntYjtAjqI00G7LYrX0gWj3mmCEuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX4nnm/V0SCt+v6d2qmgPgeeqsS2Lwlmfs6jg+9dn6c=;
 b=zPte7GDEwNe/H0JEggnyaq17BXbynlf5VCtRX8Dy7/5x4PYqNhdFr676/Q3dp2znRo/WWaT3ck5GKb4XdK8YROl1aG399nbCog6LxDhe3XATM05sf7ZrlLvOcSMEj1cbBAJmpTB2UUNg71Ustk9gZFABLvbsyBAwRT7YYzVCkjk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB3686.prod.exchangelabs.com (2603:10b6:a02:8f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 19:07:54 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29%4]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 19:07:54 +0000
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] perf: arm_dsu: Support DSU ACPI devices
Date:   Thu, 10 Sep 2020 12:07:52 -0700
In-Reply-To: <202009102143.A4pW4A7I%lkp@intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1599694141-16056-1-git-send-email-tuanphan@os.amperecomputing.com>
 <202009102143.A4pW4A7I%lkp@intel.com>
Message-Id: <C7729DCE-57C3-4ADD-AFD4-3992798F1FF9@amperemail.onmicrosoft.com>
X-Mailer: Apple Mail (2.3654.0.3.2.26)
X-ClientProxiedBy: CY4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:903:117::14) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.151.56.145) by CY4PR02CA0028.namprd02.prod.outlook.com (2603:10b6:903:117::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 19:07:53 +0000
X-Mailer: Apple Mail (2.3654.0.3.2.26)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e5cea4-3c61-4b6e-2849-08d855bcd21d
X-MS-TrafficTypeDiagnostic: BYAPR01MB3686:
X-Microsoft-Antispam-PRVS: <BYAPR01MB36864705D038B1137A3FBB7FE0270@BYAPR01MB3686.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGTTQEK26+uXPNSqw+++u/5Gs4C6LYUTUiYSzhSTzL9WOuSl3whdRXrn6335yF6dNxjpcpLOk6TSJeaFZLktA+U+UGuhDCxUXKWw1Syr+oYHv3idupN0rcgUrbrA88MU0cb5SSMyvdDmuVKgdIKmlFTVDb8gocLIbxQRQbpICI7FmtCckMVPV7Crg4Vt521AOZY5PsapPY6Ktujn1zZWCaLmGuWMnitrI/ZNPRHnwnJKm/1qW8xu86vOtMdhZFhtxN+Ss1lTkRot5F9MUbLrnmXR+JBXjBSLxkZTbuWmDrq0b3BuDUbsqXad0mwhIrlCkiXWCu4qDR2eFGb6MqsUrYoFFBhPLYAKmUN5C1GmoO/Q7SF5dhBpuVFefbYtx8JbZST5MdLOx7joTk80cGthY0F8m1lDTz6WEaCDbyo/JiOtP+O7/WYirWsJE8AprLXk4XJP69CDtWMVtYWSdQP9GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(54906003)(2906002)(6512007)(26005)(966005)(52116002)(8676002)(42882007)(8936002)(33656002)(4326008)(53546011)(83170400001)(16526019)(66946007)(66476007)(6506007)(186003)(66556008)(5660300002)(316002)(83080400001)(6486002)(2616005)(109986005)(956004)(83380400001)(478600001)(1758585002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: EsFH4nYod3Teiihp1sQQrMd/VMzT52TGkv778lkE+VDg02uKRBu6+5b6TxtSXDxYsjYqtyIAeeJJMP04F5+9RtTfDmNPRTvz4MHN6V3HdDHPYrGoPF1MQCrR/85+GRUEVCvUEISIrB29ss8RqPwuUg8KSo5f6qtJJclhg5OVyIsLn8XvmTVFmDwTxttd0X1rxYOGGRdJ/gPBMD/haHJprNT2gfLb/nC+UXiU32+gJvuGkYhZ5V7bmZq2I42ntsvPXRZpjdbmvVGi/hHBaDSRTXPMnEDppAb0uCUuoBOEfNAtjFWg+iUQkuYHTKGKObjCRZlPYzqxj6+s7UzY7oqO6NQP4ybs7NoQfBl0cYuG/l3yEJ6ggo/ckM4CpXt/H0M7ZLPrEXCfFHwfTIwbPzFb0jKO3zL5nMI46dbU+4cOQQbwZYhGfyYqBGfMVGEcj2UbKKYeAT9JlpQA7vXQCVQ/hEpTVf0HX7Uj9RJs1gWT+t6WrwFVJ+4ZskliOrhwDDpxa0F1D9FaSlRYk5wPrzXAHUkL+y5kMHvJPLbedqKp6JI8jk8UMlSIqYihKqdy/MoIXqoKgmeywBvfu+Vm0CeZopcCLMVRKUlH8OuMc7aDSzj6NtGn7+pzIpG1Ls51QokpwR+mYu330REP32Ep2H/5eg==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e5cea4-3c61-4b6e-2849-08d855bcd21d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 19:07:54.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chrh7oR1QBOgB9LrRN5V3fecSqetd3tjyFJLaBbkAty1m0WOz9s9fT8VGCiSUrur0V914Eqc7+4yyjhqmyLMrOJbgJLctOshu6R2yD8RgrKazypzbsvBI8fazPedDWy0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB3686
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> On Sep 10, 2020, at 6:40 AM, kernel test robot <lkp@intel.com> wrote:
>=20
> Hi Tuan,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.9-rc4 next-20200910]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Tuan-Phan/perf-arm_dsu-S=
upport-DSU-ACPI-devices/20200910-105630
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t ab29a807a7ddaa7c84d2f4cb8d29e74e33759072
> config: arm64-randconfig-r012-20200909 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 0a5d=
c7effb191eff740e0e7ae7bd8e1f6bdb3ad9)
> reproduce (this is a W=3D1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin=
/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # install arm64 cross compiling tool for clang build
>        # apt-get install binutils-aarch64-linux-gnu
>        # save the attached .config to linux build tree
>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross ARC=
H=3Darm64=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>>> drivers/perf/arm_dsu_pmu.c:799:36: warning: unused variable 'dsu_pmu_ac=
pi_match' [-Wunused-const-variable]
>   static const struct acpi_device_id dsu_pmu_acpi_match[] =3D {
>                                      ^
>   1 warning generated.
>=20

Do you need me to fix this warning when CONFIG_ACPI not defined?

Tuan
> # https://github.com/0day-ci/linux/commit/40c3a0c70d4472e2fe1f5364d50939b=
863874fa1
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review Tuan-Phan/perf-arm_dsu-Support-DSU-ACPI-=
devices/20200910-105630
> git checkout 40c3a0c70d4472e2fe1f5364d50939b863874fa1
> vim +/dsu_pmu_acpi_match +799 drivers/perf/arm_dsu_pmu.c
>=20
>   798=09
>> 799	static const struct acpi_device_id dsu_pmu_acpi_match[] =3D {
>   800		{ "ARMHD500", 0},
>   801		{},
>   802	};
>   803	MODULE_DEVICE_TABLE(acpi, dsu_pmu_acpi_match);
>   804=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> <.config.gz>

