Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A78C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30D3206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="SZFEmWIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbgIHR4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:56:50 -0400
Received: from mail-dm6nam10on2095.outbound.protection.outlook.com ([40.107.93.95]:41728
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731222AbgIHR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:56:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnadtED5b8XcuWqT9tNdTsaUXOiqAQRejG9VXht9RSUtccxY8MgQg7emO307XcwgufP+UahnG2+KaU9enBLEYfO4G11KvfLH3gGgJO6Q3AzCwLCqsHNUszvFkmu9UR8ONWPNqEQ0SoHgFtKQQoNiHlXROBmd0wnOcMnakIM9wz81VwFUqORhT8CYCXYLDCxWR1xYd825Rsae9EzABROjFC/Nx4SIru3eIEnBux2BeukvN3x5wy1PT14OQLgrzoByA55Cj5fK7f8fYrl+kfjsixHEMwb4CGtJacmbb16c7nX7jVcjLU4swCfsGzE1A0QdqGuVDFAuYb+QSmZSoyqVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qart2nLW3t6vDdv8Aw9m2h5WOxrVj1/Qxyxft69un8=;
 b=bwDFjNerOrpT8stDkrGeXYwTAk87SmyD4azMOYRkdjG2Z0qZ0eo8aCZgFDE2WofAQTXfcHAkFAnQDnzGjfsZEBHdBbTJy2fL9lGuUIZgkXyDc2wY5sgsS/SjiQrtiS+PH7IjgpR/K/aAhEDdlftUS95wT8REERMMMHdvDuscIHRr/uyTuNo+Q14h3UquurzoajVj8d8OZTC/DVmVaxhtT9of+kBKwwK+j6VmxpD2giur/ShHpw5nh3wd+yVk8VNGdSf7nWVq+PdQv5gVS2bNXKFQgB+1eQ4tnCldK0SEVKoZz+u760Fp5/IgxSkYi1XQ9E5yiMQX7dRG9PRrfyGazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qart2nLW3t6vDdv8Aw9m2h5WOxrVj1/Qxyxft69un8=;
 b=SZFEmWIqU8kVcPatXS8pGLxhW6Xwb7n8Py3vR6BnLIOPR/SDVTTi9aRrl4JFe8AqLFfnN8KAXyfxGcLnCeMN/cPxhGsLlZCpOzaAXO7lRYdlGXmZFsckakyPvp9MDTT/gYF3/quDR6pywxlMSgIgEg6DEWOmXeRNMPf+CW6Vtko=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4229.prod.exchangelabs.com (2603:10b6:a03:5d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Tue, 8 Sep 2020 17:56:38 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29%4]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 17:56:38 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH v3] perf: arm_dsu: Support DSU ACPI devices
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <20200907110236.GA12174@willie-the-truck>
Date:   Tue, 8 Sep 2020 10:56:35 -0700
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        patches@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <833F5E77-0E1F-44F3-95BA-4A8D72939BFC@amperemail.onmicrosoft.com>
References: <1597451980-11405-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200907110236.GA12174@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3654.0.3)
X-ClientProxiedBy: CY1PR03CA0016.namprd03.prod.outlook.com (2603:10b6:600::26)
 To BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.151.56.145) by CY1PR03CA0016.namprd03.prod.outlook.com (2603:10b6:600::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 17:56:37 +0000
X-Mailer: Apple Mail (2.3654.0.3)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47cc4beb-7f1a-437e-79af-08d854208895
X-MS-TrafficTypeDiagnostic: BYAPR01MB4229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB422905F74B257C0F161FF7F9E0290@BYAPR01MB4229.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2eSWqJbY+cE4wz2A1GpElmsUxs3zD91kZ2LXz+d9c5hTC+zmstOLGIzFkjkvaij2srS4cNXLc3H8VZ8fZleiLnMB1tRUAKqEFKIdpB9WCdNk9S0+rnhZSQBLAO5puO9tCaSPFLr0Apa5UuzKw3KcTOnKW3sU5O6TRF0pnnZhf6RUAk6x3MjK45Dtd+K9bqk4RixTizvf5wWBAGzymQvxn/MH84+TmbFFyHH7aeAP8bPwK9dHsuf+tXsHdrISVXnlxB7OMk9uAuTOzJsZichJ3Q1kRUlFUyVuH+2esbC9tIuINvYlUmuVA0vtmkC7o4K/yEEwLvdnhLYDiYKeLpgLKlAUNcmRyY4ShwiSOi0f5/k+FaAA737vsYISf61QG7MGYTeg5Y9RcxrejQ9+IqY+rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(366004)(346002)(376002)(396003)(66476007)(52116002)(478600001)(66556008)(16526019)(83380400001)(42882007)(2906002)(83170400001)(4326008)(186003)(8936002)(6512007)(966005)(26005)(54906003)(8676002)(33656002)(5660300002)(2616005)(956004)(6506007)(66946007)(53546011)(316002)(6486002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4zdoosvm2PYOvHpurVDx9hjQGJVYiXU1JqRoEFIbZ1MVWvp6uRFVb4ssu/2ll7/RgJ2CQbxRU9VtJnJ5wncWDvpcLDqVCz4Ni2yxvivoET8FKH/HKKwdpA4U1S3UVJI+QR+hYXz5CQT+nQYpmpvpp3t2D48Fz51VuUD6hqvOpf+sdWk2io+jv2h7RsBSVbbP216a6THF2rbbQFsobtrx88CBbHYy64C7F7teQwJJ0dV7zdOe25lxbItQ9s7WjoVtDLSxlGLNqHFbtGNe2LQhIt+MonAuFh/ycqYFnjigqIaAn9WLitQsNWxnD57zEQAWuLiq76TBg77rWI5q18bYDuFM9t5pKs5vkosoS3qyfwNbtkHFQfmKVMV1joiq2d32EsXTS7plQ9chnmLEBynqr7AXoibAFZWIXhGx1u3XIsW6lNgUQE/OWE2Gq6UEf0Eisyg/RiDbC4J+lgD8jujQPguWgy8NqzcE/y9xES/5v0PFSvxrq0kE3gk82WIssxAw5lJToT/+mspyiv6cWQIA87U98SHBofz4VS+cxnQY4Wg1/pAbBexijpZxm/j4Dnj8kMyQnTrZbwNWbxliJsHh324N/fYhuyBn1nZyoutdcEaHqJBF8qx+9ztkOdRaGL0O2kX2anFmVUFsXnWHza+NIw==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cc4beb-7f1a-437e-79af-08d854208895
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 17:56:38.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa7pe/DGXgOXa0vkwex60Hy6kay5m3VCgS7qikdyP/qu3AuodnE+/KYVXQ6tUog+yE0tgpM7WQNKLfHEDWaApuk5HyFZiABnN9swirC+81rWHchHW+892chz8QBjbfBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 7, 2020, at 4:02 AM, Will Deacon <will@kernel.org> wrote:
>=20
> [+ Suzuki as I'd like his Ack on this]
>=20
> On Fri, Aug 14, 2020 at 05:39:40PM -0700, Tuan Phan wrote:
>> Add support for probing device from ACPI node.
>> Each DSU ACPI node and its associated cpus are inside a cluster node.
>>=20
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>> ---
>> Changes in v3:
>> - Based on the latest ARM ACPI binding at: https://developer.arm.com/doc=
umentation/den0093/c/
>>=20
>> Changes in v2:
>> - Removed IRQF_SHARED.
>> - Fixed ACPI runtime detection.
>>=20
>> drivers/perf/arm_dsu_pmu.c | 68 ++++++++++++++++++++++++++++++++++++++++=
------
>> 1 file changed, 60 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
>> index 96ed93c..4be355d 100644
>> --- a/drivers/perf/arm_dsu_pmu.c
>> +++ b/drivers/perf/arm_dsu_pmu.c
>> @@ -11,6 +11,7 @@
>> #define DRVNAME		PMUNAME "_pmu"
>> #define pr_fmt(fmt)	DRVNAME ": " fmt
>>=20
>> +#include <linux/acpi.h>
>> #include <linux/bitmap.h>
>> #include <linux/bitops.h>
>> #include <linux/bug.h>
>> @@ -603,18 +604,21 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platfo=
rm_device *pdev)
>> }
>>=20
>> /**
>> - * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
>> + * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster
>> + * from device tree.
>>  */
>> -static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask=
)
>> +static int dsu_pmu_dt_get_cpus(struct platform_device *pdev)
>> {
>> 	int i =3D 0, n, cpu;
>> 	struct device_node *cpu_node;
>> +	struct dsu_pmu *dsu_pmu =3D
>> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
>>=20
>> -	n =3D of_count_phandle_with_args(dev, "cpus", NULL);
>> +	n =3D of_count_phandle_with_args(pdev->dev.of_node, "cpus", NULL);
>> 	if (n <=3D 0)
>> 		return -ENODEV;
>> 	for (; i < n; i++) {
>> -		cpu_node =3D of_parse_phandle(dev, "cpus", i);
>> +		cpu_node =3D of_parse_phandle(pdev->dev.of_node, "cpus", i);
>> 		if (!cpu_node)
>> 			break;
>> 		cpu =3D of_cpu_node_to_id(cpu_node);
>> @@ -626,11 +630,51 @@ static int dsu_pmu_dt_get_cpus(struct device_node =
*dev, cpumask_t *mask)
>> 		 */
>> 		if (cpu < 0)
>> 			continue;
>> -		cpumask_set_cpu(cpu, mask);
>> +		cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
>> 	}
>> 	return 0;
>> }
>>=20
>> +/**
>> + * dsu_pmu_acpi_get_cpus: Get the list of CPUs in the cluster
>> + * from ACPI.
>> + */
>> +static int dsu_pmu_acpi_get_cpus(struct platform_device *pdev)
>> +{
>> +	int cpu;
>> +	struct dsu_pmu *dsu_pmu =3D (struct dsu_pmu *) platform_get_drvdata(pd=
ev);
>> +
>> +	/*
>> +	 * A dsu pmu node is inside a cluster parent node along with cpu nodes=
.
>> +	 * We need to find out all cpus that have the same parent with this pm=
u.
>> +	 */
>> +	for_each_possible_cpu(cpu) {
>> +		struct acpi_device *acpi_dev =3D ACPI_COMPANION(get_cpu_device(cpu));
>> +
>> +		if (acpi_dev &&
>> +			acpi_dev->parent =3D=3D ACPI_COMPANION(&pdev->dev)->parent)
>> +			cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dsu_pmu_platform_get_cpus(struct platform_device *pdev)
>> +{
>> +	int ret =3D -ENOENT;
>> +	struct fwnode_handle *fwnode =3D dev_fwnode(&pdev->dev);
>> +
>> +	if (IS_ERR_OR_NULL(fwnode))
>> +		return ret;
>> +
>> +	if (is_of_node(fwnode))
>> +		ret =3D dsu_pmu_dt_get_cpus(pdev);
>> +	else if (is_acpi_device_node(fwnode))
>> +		ret =3D dsu_pmu_acpi_get_cpus(pdev);
>> +
>> +	return ret;
>> +}
>> +
>> /*
>>  * dsu_pmu_probe_pmu: Probe the PMU details on a CPU in the cluster.
>>  */
>> @@ -683,7 +727,9 @@ static int dsu_pmu_device_probe(struct platform_devi=
ce *pdev)
>> 	if (IS_ERR(dsu_pmu))
>> 		return PTR_ERR(dsu_pmu);
>>=20
>> -	rc =3D dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpu=
s);
>> +	platform_set_drvdata(pdev, dsu_pmu);
>=20
> Hmm, this is a bit nasty because we haven't finished initialising the
> dsu_pmu yet. I think it would actually be cleaner if you kept:
>=20
> 	static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
>=20
> for the DT case and added:
>=20
> 	static int dsu_pmu_acpi_get_cpus(struct device *dev, cpumask_t *mask)
>=20
> for the ACPI case. I suppose the DT case could take the struct device * t=
oo
> if you wanted the prototypes to be the same.

Sure, I can do that.
>=20
>> +	rc =3D dsu_pmu_platform_get_cpus(pdev);
>> 	if (rc) {
>> 		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
>> 		return rc;
>> @@ -705,7 +751,6 @@ static int dsu_pmu_device_probe(struct platform_devi=
ce *pdev)
>> 	}
>>=20
>> 	dsu_pmu->irq =3D irq;
>> -	platform_set_drvdata(pdev, dsu_pmu);
>> 	rc =3D cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
>> 						&dsu_pmu->cpuhp_node);
>> 	if (rc)
>> @@ -752,11 +797,19 @@ static const struct of_device_id dsu_pmu_of_match[=
] =3D {
>> 	{ .compatible =3D "arm,dsu-pmu", },
>> 	{},
>> };
>> +MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
>> +
>> +static const struct acpi_device_id dsu_pmu_acpi_match[] =3D {
>> +	{ "ARMHD500", 0},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, dsu_pmu_acpi_match);
>>=20
>> static struct platform_driver dsu_pmu_driver =3D {
>> 	.driver =3D {
>> 		.name	=3D DRVNAME,
>> 		.of_match_table =3D of_match_ptr(dsu_pmu_of_match),
>> +		.acpi_match_table =3D ACPI_PTR(dsu_pmu_acpi_match),
>> 		.suppress_bind_attrs =3D true,
>> 	},
>> 	.probe =3D dsu_pmu_device_probe,
>> @@ -826,7 +879,6 @@ static void __exit dsu_pmu_exit(void)
>> module_init(dsu_pmu_init);
>> module_exit(dsu_pmu_exit);
>>=20
>> -MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
>=20
> Why have you moved this line?

I moved it to just behind the dsu_pmu_of_match definition as we now also ha=
ve dsu_pmu_acpi_match.

Tuan
>=20
> Will

