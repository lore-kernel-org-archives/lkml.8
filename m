Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31970C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13CF206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="H8im6dcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEUPuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:50:37 -0400
Received: from mail-eopbgr750139.outbound.protection.outlook.com ([40.107.75.139]:52645
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727911AbgEUPug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOMFCvgHyFu5SnLg3Wbsh7JIYJUUBzVA24vRRB4G6WvC5i+nmkCVxrqq/iNMbQq3LQhA1BUrWdusu5O7qWtr3V9wc+lP0G3PmPGaP+lE3O29IPGF8SZfQQ8fuiE76GhezTdrXaLQXenq2r+iaeFrYamAs7GLGtgRYn1zJrq5WwL4sMEnGthZ/1BsWu41UygP/uglOyqq5X/gS2lqw2vmnJs1JMr49d5mrusYf+qGBIqQKdcCgdB2x+fmzlii0xRhZKOTZptWr5Df84SxZS9l9q4dz7kxSVnjz/rTQGEDa3bo7C94mWRob2Xf//U0vYs7g3Ukyy3hLcUiOdLT3KmPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/D6mldSTSQU1bsxZ0a+/zu/56vtZ00PLTqInvP2S4E=;
 b=nzn+fG8mqv9IHMtF/uRDulspIUxscjf3sFa3lXwuOAiqPKhsQ9BBlOi2pSGUGy7a7i5pjQJApes6EBtXVj91CVlrCz2T4EbZmkL+Y1KPR+txV/hPUu11o9kk3bhM8Ow+Bh1166zsWh8JrVepeIgUtZeFZUcmoeNn6s0TdeGZ+Dct60a/n8M+XJqw5ldrTW1qdHfbTfLBWfrlELk+PEUwc93FjO0uvc9zUuwc5SrFxnpvp1/SdCArOKR+CguDIulGtfx1HuBm1Gn3T6KsOQHLDe20IKPZvw4IOQXlL2A64Ji5+4sVYFrcS29AcSoTdNAGw16otezAAkLPh74ucf30nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/D6mldSTSQU1bsxZ0a+/zu/56vtZ00PLTqInvP2S4E=;
 b=H8im6dczdIr2I3VW+yuW2+0sZ73SLfREkHoANSQ0Rv+06CP27MMVu39WYq+wlpAG75KqST4N7lICPlB2Te9WM1HxdYNR8+4zf+/3kxrpcWzdDkHJgKfF1CGmQRAP6bXOSZqzZyz7tr4KkvEnv3BG3dc5r65MU4YcFwJSNXxeok4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4680.prod.exchangelabs.com (2603:10b6:a03:84::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20; Thu, 21 May 2020 15:50:31 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 15:50:31 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH v2] perf: arm_dsu: Support DSU ACPI devices.
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <20200521135557.GB12282@bogus>
Date:   Thu, 21 May 2020 08:50:28 -0700
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Mark Rutland <mark.rutland@arm.com>,
        patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2684F75B-98BC-4C24-BF29-C5214F9CD3BB@amperemail.onmicrosoft.com>
References: <1589229160-18558-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200521135557.GB12282@bogus>
To:     Sudeep Holla <sudeep.holla@arm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-ClientProxiedBy: CY4PR01CA0019.prod.exchangelabs.com (2603:10b6:903:1f::29)
 To BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.173] (73.151.56.145) by CY4PR01CA0019.prod.exchangelabs.com (2603:10b6:903:1f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 15:50:30 +0000
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17767772-c034-423d-0bd0-08d7fd9eb0fa
X-MS-TrafficTypeDiagnostic: BYAPR01MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB4680F45AA3A07E21594893C6E0B70@BYAPR01MB4680.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKKrP5crpGSRTJ5kfkmJhxh7yy1WVgk6f0fZnrcbdTwrumtmgfjXrqhWat6IYnClkzN+EqalaDMW2kqZsMiPu7fEreOZF2lEv8WiEi3thrzH8t476H948NXuc6fzJ7MBdlklSJntXqzV9K7dUnjEebJYUSaeZG2K7x/j8Z6KuXLwonuC6sdUeMz+R++UofxQK3JRaVfWnVrE0PeGk2LpOt4Oelp2Z4zRgerTbhBMiBEwicBIRxelEc/mYEvdgWs1/VWKOQrVsoQNrGi8jVUtjM7YdExzcSmzycXvcmxtW47wxJKGxTYhmFD3wx+KGa58uMAgzNc+jR+3hRWtLiLq7FBkZqEdRCFRp7LFlmSU5Cfqi+C0/5+HxNi/rLz2qWLKhqkF/kpAl0OQKlL5D912xbEQ8EjYoaZH0KqbcdDNqvU0CcMaUoZELmmDr7NTE770cxow+kT3fPJUiddY1JdDCjuXXh/akUATwUuQV66Sm8/pweQc0XrXn7L3a+CwRMSB8FGKlbnpfRxfeDsZcMdNQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39840400004)(136003)(366004)(478600001)(54906003)(16526019)(966005)(8936002)(5660300002)(4326008)(8676002)(6916009)(33656002)(2906002)(6486002)(52116002)(83170400001)(956004)(2616005)(16576012)(53546011)(42882007)(186003)(316002)(66556008)(66476007)(26005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CstIhkSVTVCRMTZ/cukH1Uob2N7fjTHgv0zfwjO4KlCC7FvY/YSQY6RFNwDWJ+MPUJ5D7OGCJc30VsIpjXFeNRxg2bL1vJ8Psa302Qqk2/KmPGTrTs5SZQEWw1te+SXDOazh/QphsQ2gduxpC9NvTKAKpkQIBJLK4kaB4ai61QcHsL9+TLZlqCzHZQ53//0L0KgvKS9hSgGG5lECyXESDN7bP4iOtCDUA4J/IhKM1qf1jEigzD6q0v9lNUFA8CvBDJ8akqMxurtMMdCk53/UwwPhsSm/bSdBzLJlnoqrb1FmkQHaa/gE3kMzc/HMg5uXYUH0GZ8LqIlnlzJJEwtgVoOFMosk8bZ9KRVJTATsEzW3pa9+xuZRcyAttTjqi9hPikR4wnefrZN6vHsL1s3woX6cuRVDUf/gecAl+7wo395+7/B1HYpQmKDGp0UqhlDAMIA2AIMmvR9uMHEcKZ+qrWKkmiBEb3t3zCLbwlPOE64=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17767772-c034-423d-0bd0-08d7fd9eb0fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 15:50:31.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wl0UIWOL/EkVDPDfwe2QB4rR6C1CGLfLfnXn9vb0xsVbNhYmO7AC68RdMAjvsCNpxo5U2faBDPmtWvHJsjgc/uPx0UjoIbAPfR3kMdEXdYzUzes/Yv7hObI+q2d3bV7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 21, 2020, at 6:55 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>=20
> On Mon, May 11, 2020 at 01:32:40PM -0700, Tuan Phan wrote:
>> Add ACPI node probing device support. Each DSU ACPI node
>> defines a "cpus" package with a per cpu MPIDR element.
>>=20
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>> ---
>> Changes in v2:
>> - Removed IRQF_SHARED.
>> - Fixed ACPI runtime detection.
>>=20
>> The ACPI binding spec for DSU ACPI node is under beta and located
>> in ARM server group under project "ACPI on ARM".
>>=20
>> drivers/perf/arm_dsu_pmu.c | 71 ++++++++++++++++++++++++++++++++++++++++=
------
>> 1 file changed, 63 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
>> index 70968c8..784d177 100644
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
>> @@ -626,11 +630,54 @@ static int dsu_pmu_dt_get_cpus(struct device_node =
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
>> +	int i, cpu, ret;
>> +	const union acpi_object *obj;
>> +	struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
>> +	struct dsu_pmu *dsu_pmu =3D
>> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
>> +
>> +	ret =3D acpi_dev_get_property(adev, "cpus", ACPI_TYPE_PACKAGE, &obj);
>=20
> I don't see any property "cpus" in the document:
> DEN 0093 A (Generic ACPI for Arm Components 1.0) [1]
>=20
> Is there any newer updates that I need to look at ?
>=20
There is a newer DEN 0093 A version but it has not been public yet. Let aba=
ndon this
patch and I will post new one when the document has been finalized and avai=
lable to public.

Thanks,
=20
> --=20
> Regards,
> Sudeep
>=20
> [1] https://static.docs.arm.com/den0093/a/DEN0093_ACPI_Arm_Components_1.0=
.pdf

