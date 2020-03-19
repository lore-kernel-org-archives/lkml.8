Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD80C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D619206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="I2kmGBKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCSWtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:49:23 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:52997
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbgCSWtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6wFD+TiCBvzCOxyf/Ta/Vi4x39m5YShozMJf+g30axKk1qWD5lT1u4MzQBy2dDFjmaCIxmLv2jrdeQW31BrIWHsqi3cZbf0TYOaZlE6144V+YePfbGayBbeFHGZYaCpzBsAPlGGjbp3OfANIvlXYkukgSrN+6s84Eilx2jiImVEtDhR8clfy37fr+M5Z9s7rSrPLtq3DMN9WvHjRFSDEOaD22QcPtDRBPUOBp4hPN4+faPom9r3x/n4CyHiZcxHkci4u6ovsLRS/Ylf/H9rprlnS0lwHaE7MJSuFHJuAI+WPAmOF+aqJiM4EsJyCZ+Vr/w71zW/9LN8af3smETVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9/YgwEACpRwWArAMf1CdO5cOKiqFly8PLwSEswRlag=;
 b=N9FK7UgV35nFRhWUCmfoD7lz+YB6Ac0IbUJJGzVh7nO6sZEZ8Oh+hWNMJrXKVelTqZfJzqglt0fXJ96IVLCpQa3BLOWr7J7KxELj3nY9GscEdBMGUXHc0THlCIsiGy4DT6Nb4rr7OC7OtbvBDoREu8Sp0w4iMsWub2c6/OUH7MOHJpnyP06MTrwBYgOedjaTxh2+Swp0kJwD/W49RAeemQMb1KegJHfZRl9FjRyjPj8O1R6F0pkLgBv8wbwHRXj78PGGGXggycNqw6zLGgObZwAUzv/s8RwvFeWr7gCkdMQd0/NEaiR4YibFrhkj4uqj7tjtXWPo2oxcJspD2FafBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9/YgwEACpRwWArAMf1CdO5cOKiqFly8PLwSEswRlag=;
 b=I2kmGBKSB7qHOao1C2eIBHGEQplTd8gOtDpXG53sksWg10FXtTakh8o2s6ZHPVqYYk7OivHQ0/Yj9248vmv0iHAjyU6wu1KMiimOn9hYi9QJYs9sZm23WSAW0h+T88ulWWt42FIDgeX6LoSUn7v2gBGICmdP1S1v1e9hct9FzmA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tuanphan@os.amperecomputing.com; 
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4229.prod.exchangelabs.com (2603:10b6:a03:5d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Thu, 19 Mar 2020 22:49:16 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::94fd:d242:1a35:9b22]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::94fd:d242:1a35:9b22%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 22:49:16 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH 2/2] perf: arm_dsu: Support DSU ACPI devices.
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <a571cf7e-c2a5-e8f8-e782-8087249143b0@arm.com>
Date:   Thu, 19 Mar 2020 15:49:12 -0700
Cc:     tuanphan@os.amperecomputing.com, patches@amperecomputing.com,
        will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <64AE7BB3-F2A9-4A62-82FD-FFF2D6B7101C@amperemail.onmicrosoft.com>
References: <1584491323-31436-1-git-send-email-tuanphan@os.amperecomputing.com>
 <a571cf7e-c2a5-e8f8-e782-8087249143b0@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-ClientProxiedBy: CY4PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:903:101::14) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.104] (73.151.103.95) by CY4PR14CA0028.namprd14.prod.outlook.com (2603:10b6:903:101::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Thu, 19 Mar 2020 22:49:14 +0000
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Originating-IP: [73.151.103.95]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 461e8391-2a5a-4005-d674-08d7cc57c040
X-MS-TrafficTypeDiagnostic: BYAPR01MB4229:|BYAPR01MB4229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB42293F8F72FB8A43B76D29C0E0F40@BYAPR01MB4229.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(186003)(26005)(66946007)(2906002)(66556008)(16576012)(66476007)(6916009)(16526019)(498600001)(42882007)(956004)(33656002)(2616005)(81166006)(52116002)(53546011)(4326008)(6486002)(5660300002)(8936002)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB4229;H:BYAPR01MB4598.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXb1nIZWy2yXdjddb3jB5QTMGFXlWWjpSqK79NYs6+dJJQc/Y3ZzKt+0FfOo4p+WZI2RqKLNeT24LQQewJjmy1Kn5tDCDsmkMEWlp/zd+JHRUwZlarJeZvl/sfyVdFDGUvn3iO2HO/rgCMoSZe/v33gJlzyUpk4IhVEM6W9ZJ4KVXmp4Nr8w31ZIIeWjc8xi3PgERL9lGYDe9vSCnNNNtSWzmYxjvx8So6WD8EIvN/m6N1TyB8ONFotA81ZbuY7Iygek3FqjmcSDvymd0GxfrgJ9id/2SfwD65fZQqDnhFTJcfesJ6TW3k2qHD7vCSjBpPOVTwPLF+h6xEWDP/hCZROTmsRVOs/7wvjm5l13vehUGrHHh2DtWdMZJuNwgpkVzVOrCQffrdm4toMoOf6nPS+rwt+frHuYOqrI5J9qLD6JAN1VjN15lKYTXw3/ozYm
X-MS-Exchange-AntiSpam-MessageData: fc2Pw2Cca7RbeF1dELjf5VE8jQNGzd1As3brGherZGbgd8pbPDxOuZKHM7qrc8MpKgiX8UMco6mxMQuhiTnDhbzl9JjGWAQqlUp7kGbpSRmwsbSAj/z68htCO6nuBnHreYGcl966K5YTMFchrzyRoQ==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461e8391-2a5a-4005-d674-08d7cc57c040
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 22:49:15.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSUQns/LR5pqQYQ0tl7A5eC/l0Tb9o9nAASEIBq7uYNGgOHdWE0GAxSGRxauippKJ3RpOeHN9o/iVb7tvJUFXgrHku74smhbPY3TykYvQFGLkZGVCOECNytmL0i6+c0V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

> On Mar 18, 2020, at 5:45 PM, Suzuki K Poulose <suzuki.poulose@arm.com> wr=
ote:
>=20
> Hello,
>=20
>=20
> Please find my comments below.
>=20
> On 03/18/2020 12:28 AM, Tuan Phan wrote:
>> Add support for probing device from ACPI node.
>> Each DSU ACPI node defines "cpus" package which
>> each element is the MPIDR of associated cpu.
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>> ---
>>  drivers/perf/arm_dsu_pmu.c | 53 +++++++++++++++++++++++++++++++++++++++=
-------
>>  1 file changed, 45 insertions(+), 8 deletions(-)
>> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c Tua
>> index 2622900..6ef762c 100644
>> --- a/drivers/perf/arm_dsu_pmu.c
>> +++ b/drivers/perf/arm_dsu_pmu.c
>> @@ -11,6 +11,7 @@
>>  #define DRVNAME		PMUNAME "_pmu"
>>  #define pr_fmt(fmt)	DRVNAME ": " fmt
>>  +#include <linux/acpi.h>
>>  #include <linux/bitmap.h>
>>  #include <linux/bitops.h>
>>  #include <linux/bug.h>
>> @@ -603,18 +604,22 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platfo=
rm_device *pdev)
>>  }
>>    /**
>> - * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
>> + * dsu_pmu_get_cpus: Get the list of CPUs in the cluster.
>>   */
>> -static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask=
)
>> +static int dsu_pmu_get_cpus(struct platform_device *pdev)
>>  {
>> +#ifndef CONFIG_ACPI
>> +	/* Get the list of CPUs from device tree */
>=20
> What if we have a kernel with both:
>=20
> CONFIG_OF=3Dy
> CONFIG_ACPI=3Dy
>=20
> and boot the kernel on a system with DT ? In other words, the decision
> to choose the DT vs ACPI must be runtime decision, not buildtime.
>=20
> See drivers/hwtracing/coresight/coresight-platform.c:coresight_get_platfo=
rm_data() for an example.
>=20
>>  	int i =3D 0, n, cpu;
>>  	struct device_node *cpu_node;
>> +	struct dsu_pmu *dsu_pmu =3D
>> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
>>  -	n =3D of_count_phandle_with_args(dev, "cpus", NULL);
>> +	n =3D of_count_phandle_with_args(pdev->dev.of_node, "cpus", NULL);
>>  	if (n <=3D 0)
>>  		return -ENODEV;
>>  	for (; i < n; i++) {
>> -		cpu_node =3D of_parse_phandle(dev, "cpus", i);
>> +		cpu_node =3D of_parse_phandle(pdev->dev.of_node, "cpus", i);
>>  		if (!cpu_node)
>>  			break;
>>  		cpu =3D of_cpu_node_to_id(cpu_node);
>> @@ -626,9 +631,33 @@ static int dsu_pmu_dt_get_cpus(struct device_node *=
dev, cpumask_t *mask)
>>  		 */
>>  		if (cpu < 0)
>>  			continue;
>> -		cpumask_set_cpu(cpu, mask);
>> +		cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
>>  	}
>>  	return 0;
>> +#else /* CONFIG_ACPI */
>> +	int i, cpu, ret;
>> +	const union acpi_object *obj;
>> +	struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
>> +	struct dsu_pmu *dsu_pmu =3D
>> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
>> +
>=20
>> +	ret =3D acpi_dev_get_property(adev, "cpus", ACPI_TYPE_ANY, &obj);
>=20
> Is the binding documented somewhere ?
>=20
>=20
> nit: Also, why not :
> 	ret =3D acpi_dev_get_propert(adev, "cpus", ACPI_TYPE_PACKAGE, &obj);
> 	if (ret < 0)
> 		return ret;
> ?
=3D> I couldn=E2=80=99t find the device tree binding document of DSU anywhe=
re. Is It enough
to put a comment describing the acpi binding in the code or need somewhere =
else?
>=20
>=20
>> +	if (ret < 0)
>> +		return -EINVAL;
>> +
>> +	if (obj->type !=3D ACPI_TYPE_PACKAGE)
>> +		return -EINVAL;
>> +
>> +	for (i =3D 0; i < obj->package.count; i++) {
>=20
>=20
>> +		/* Each element is the MPIDR of associated cpu */
>> +		for_each_possible_cpu(cpu) {
>> +			if (cpu_physical_id(cpu) =3D=3D
>> +				obj->package.elements[i].integer.value)
>> +				cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
>> +		}
>> +	}
>> +	return 0;
>> +#endif
>>  }
>> =20
>=20
> Otherwise looks good to me.
>=20
> Suzuki

