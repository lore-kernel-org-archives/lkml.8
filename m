Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEEC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29DD2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="utNXHKmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgD3WLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:11:13 -0400
Received: from mail-eopbgr680102.outbound.protection.outlook.com ([40.107.68.102]:29614
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbgD3WLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 18:11:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EklrEmIFlfcAwzv+d9dt338wDYvvG8oPaxys4fLHSBUjlG0PRN47tLiBpCLHaMqRDP4xy97SmM6JwpzRMPnQ31AjC2jbbjE3siKZ8zIK/dax6AgAIiEKX6GlLgwfjlXQnwNzEGRpnsUBtOX7KQpmI+LCLUvLhdmbsCFzlLsN/V4we6rIEGzgRKdrhI6uMkWWRVc9Lcyt0r2JK+HgQjh53ItFQd5N663Hbneaz9lK49pIg7N/2gC0y+QaGgkAfGx3Q/XDC1BihAIFCjLHWIWk0WwC38g9uSOf3Ou/BNDFuzsGl+anzxCxNhYv6ps688/UxQIYwMQGltGUy+J8oyZ8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg3NOjmSv02qxJ8ci4PKUqRaasptyMK/kDqyNpiEmNA=;
 b=hAzimnZpIzyZGA39wZtnUoaQFCWzlEP61Y9Z+y2HvJC2MBZt5GeUSW+Bum48SE+G5ilOfaPPY/6GOWkMaCNmnZ0slsu6QNmLDZiMtt7C/0iKK+DIqjXeOQhp/MhwX1VzfhSD5Runr+b6y6CkepxaGOlpmawRH4liwTy8497mKQb965IhTBsWHFe+tPIWOoJYi+2VUqx4/E1uQhHd07/6eQIAjESVFhmzInF1/tTcHG3QFO+kvWU893jis8yFcfZ3oCgR82K7odLqPK7LSXmHAKuZYefAR4f0KnwXWAxLhT23f+RuoTQhF64eysJECpHVRSVj27FAWGXLVspyPxuTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg3NOjmSv02qxJ8ci4PKUqRaasptyMK/kDqyNpiEmNA=;
 b=utNXHKmxBNESXbC7nWquj510C5F4CKQI9Mw1uYpl1IjZ7Z3SpFldD51Nq0AmlVXrqehOTFIB8vC79c7Sssn2hl623BpMHbiE2lMJ9ugb74MsGpZhrGNylJ72+kEaVg2AoUiIgFp2540K6WYaFt1eEoHfsEcEMEBeFnMZXEDXs9c=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4646.prod.exchangelabs.com (2603:10b6:a03:81::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Thu, 30 Apr 2020 22:11:07 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2958.019; Thu, 30 Apr 2020
 22:11:07 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [RFC PATCH] perf/smmuv3: Fix shared interrupt handling
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
Date:   Thu, 30 Apr 2020 15:11:03 -0700
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        shameerali.kolothum.thodi@huawei.com, john.garry@huawei.com,
        harb@amperecomputing.com, tuanphan@os.amperecomputing.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <72C1BA0A-E4D4-4740-860D-B343A836821E@amperemail.onmicrosoft.com>
References: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-ClientProxiedBy: CY4PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:903:18::16) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.173] (73.151.56.145) by CY4PR02CA0006.namprd02.prod.outlook.com (2603:10b6:903:18::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 22:11:05 +0000
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b373e6-b137-4406-8432-08d7ed536184
X-MS-TrafficTypeDiagnostic: BYAPR01MB4646:|BYAPR01MB4646:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB4646E8AD69413F73C5030731E0AA0@BYAPR01MB4646.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39840400004)(376002)(346002)(366004)(8936002)(33656002)(316002)(54906003)(478600001)(16576012)(186003)(26005)(53546011)(4326008)(52116002)(2616005)(66476007)(83170400001)(30864003)(42882007)(66946007)(2906002)(8676002)(956004)(6916009)(5660300002)(16526019)(66556008)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hj+1PdIN1cJbkYm/5HcsVdYdfLqiF6YErvHTspmhsdWlL7CXxqly+x+g6vknsedRP/V2CLotTrGoEFjPf76drNtBb4S2A9HkZJhygul2uNkM1gByGzizCxGFRBv85RecR8djflCJMH0cLNeZE3la5of3eIP9Hjs22XdVbd6gzugeFLzNwyPHJO5G24vVspzl/aq5q/bE6lteubKTH8zpedJbYrCDlgD5iNii0kGPB5u8+tupMM8tlbwzVIgZO1J8wSBxKQv/UBUsTDj130dA7Fd4T6o4LO+2Ksrzm9IB1Q/G55NwrvK5tkn0fm15gR5XiRziasMIgMIRBvEWXN7BDCLhNi7BPxCiO6QAW2J+AC3RQ3rZYibfjMKRYtjjiqpdDTtLZY/KPLHk6OfD9bdxfIj2mzvgnCitcTDUcRe67918bTBdoCBRboOWxyyopqZ
X-MS-Exchange-AntiSpam-MessageData: cwa81sEody8PlyndKjEQFkTuAMRLGj6odroBzpUKmtu5W34NvFPsaVO745LtVrjFia7cOINN3BAC+k0wM6oXE1+BAVyh+LRQWNa4FCEn+oci/l0yo0h+38nN3STc2VjH/bI/C8nhQ46o1EiF3le0XrKx/5hGvAZlcNxDORKNejKEcW2ADpMSL1Yir7Rcs5XdCgYW1Jm4Ip5ZUF4NOTZjkNZgTi2DDnmERN+PzJhNx4OU8Uk80IXC04dsnVshH+UFFKf6dvDWvHMSWEzTAaNcCWISWb0X51GgcGdgN5C31T3P9+H8WLnTuVAM2+BjBjyEOFxZynM6CiSnA5wcAJywRxJFr2dcCRuxZULBXl5lNvhNxfD+oAAQH9ks/Rs1AY933Ln9T8BGnkFI0L9rDpBZ+qLnwyiKa0Eg7Nf4m1oEhPtGme2C2TdXl/A29IEeZnU9ZyVictb/Py0diYbWMLE7NGW1NH+thHxUevkcFsLREq8LknlzFL8fScGatLmxK7MATKtxAZMIgmWBCIf438aY6n4HvO89J4F3zfNXXB4BNxr0Bewk8gGoG5ZeJ6ScQQ9Yy24p7hgiRuSw6k5PXp88M/5BmaSmkzyk4C0uYpU16MgBiykOPvpTPzqRQ5eYdK6ECRhbEpvTRn787DkDzXgIiHMVEnTuOU3/23MJoPsGiY9GI5UYiOKuqaMiKJpKfeZ7Gb20zexpcqQTemUPJO7+T4mVlqnspj0iAKiDqICROUB4gWsYafnaoYubE7oaRsT6yXhIBXkk0tCKkRA16smZYZTNDsobIyJYdAUQCQEPNWQ=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b373e6-b137-4406-8432-08d7ed536184
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 22:11:07.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rmN8pJ0XVnpPdd3qMrYW6ndjbc5NlR/12I5lyyFJikDqEBLc5bzwYNqI6LoSlIQlzMAy/xNsC4ExWOZUXVJ/1a6p2xH+2uncweaz286haPgEYC1gLDKUFeHdReZ2IS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

> On Apr 8, 2020, at 9:49 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> IRQF_SHARED is dangerous, since it allows other agents to retarget the
> IRQ's affinity without migrating PMU contexts to match, breaking the way
> in which perf manages mutual exclusion for accessing events. Although
> this means it's not realistically possible to support PMU IRQs being
> shared with other drivers, we *can* handle sharing between multiple PMU
> instances with some explicit affinity bookkeeping and manual interrupt
> multiplexing.
>=20
> RCU helps us handle interrupts efficiently without having to worry about
> fine-grained locking for relatively-theoretical race conditions with the
> probe/remove/CPU hotplug slow paths. The resulting machinery ends up
> looking largely generic, so it should be feasible to factor out with a
> "system PMU" base class for similar multi-instance drivers.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> RFC because I don't have the means to test it, and if the general
> approach passes muster then I'd want to tackle the aforementioned
> factoring-out before merging anything anyway.
>=20
> Robin.
>=20
>=20
> drivers/perf/arm_smmuv3_pmu.c | 215 ++++++++++++++++++++++++----------
> 1 file changed, 152 insertions(+), 63 deletions(-)
>=20
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.=
c
> index d704eccc548f..8daa7ac6e801 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -47,8 +47,11 @@
> #include <linux/kernel.h>
> #include <linux/list.h>
> #include <linux/msi.h>
> +#include <linux/mutex.h>
> #include <linux/perf_event.h>
> #include <linux/platform_device.h>
> +#include <linux/rculist.h>
> +#include <linux/refcount.h>
> #include <linux/smp.h>
> #include <linux/sysfs.h>
> #include <linux/types.h>
> @@ -98,13 +101,24 @@
>=20
> static int cpuhp_state_num;
>=20
> -struct smmu_pmu {
> +static LIST_HEAD(smmu_pmu_affinities);
> +static DEFINE_MUTEX(smmu_pmu_affinity_lock);
> +
> +struct smmu_pmu_affinity {
> 	struct hlist_node node;
> +	struct list_head affinity_list;
> +	struct list_head instance_list;
> +	refcount_t refcount;
> +	unsigned int irq;
> +	unsigned int cpu;
> +};
> +
> +struct smmu_pmu {
> 	struct perf_event *events[SMMU_PMCG_MAX_COUNTERS];
> 	DECLARE_BITMAP(used_counters, SMMU_PMCG_MAX_COUNTERS);
> 	DECLARE_BITMAP(supported_events, SMMU_PMCG_ARCH_MAX_EVENTS);
> -	unsigned int irq;
> -	unsigned int on_cpu;
> +	struct smmu_pmu_affinity *affinity;
> +	struct list_head affinity_list;
> 	struct pmu pmu;
> 	unsigned int num_counters;
> 	struct device *dev;
> @@ -394,7 +408,7 @@ static int smmu_pmu_event_init(struct perf_event *eve=
nt)
> 	 * Ensure all events are on the same cpu so all events are in the
> 	 * same cpu context, to avoid races on pmu_enable etc.
> 	 */
> -	event->cpu =3D smmu_pmu->on_cpu;
> +	event->cpu =3D smmu_pmu->affinity->cpu;
>=20
> 	return 0;
> }
> @@ -478,9 +492,10 @@ static ssize_t smmu_pmu_cpumask_show(struct device *=
dev,
> 				     struct device_attribute *attr,
> 				     char *buf)
> {
> -	struct smmu_pmu *smmu_pmu =3D to_smmu_pmu(dev_get_drvdata(dev));
> +	struct pmu *pmu =3D dev_get_drvdata(dev);
> +	struct smmu_pmu_affinity *aff =3D to_smmu_pmu(pmu)->affinity;
>=20
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(smmu_pmu->on_cpu))=
;
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(aff->cpu));
> }
>=20
> static struct device_attribute smmu_pmu_cpumask_attr =3D
> @@ -584,50 +599,140 @@ static const struct attribute_group *smmu_pmu_attr=
_grps[] =3D {
>=20
> static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node=
)
> {
> -	struct smmu_pmu *smmu_pmu;
> +	struct smmu_pmu_affinity *aff;
> +	struct smmu_pmu *pmu;
> 	unsigned int target;
>=20
> -	smmu_pmu =3D hlist_entry_safe(node, struct smmu_pmu, node);
> -	if (cpu !=3D smmu_pmu->on_cpu)
> +	aff =3D hlist_entry_safe(node, struct smmu_pmu_affinity, node);
> +	if (cpu !=3D aff->cpu)
> 		return 0;
>=20
> 	target =3D cpumask_any_but(cpu_online_mask, cpu);
> 	if (target >=3D nr_cpu_ids)
> 		return 0;
>=20
> -	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
> -	smmu_pmu->on_cpu =3D target;
> -	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq, cpumask_of(target)));
> +	/* We're only reading, but this isn't the place to be involving RCU */
> +	mutex_lock(&smmu_pmu_affinity_lock);
> +	list_for_each_entry(pmu, &aff->instance_list, affinity_list)
> +		perf_pmu_migrate_context(&pmu->pmu, aff->cpu, target);
> +	mutex_unlock(&smmu_pmu_affinity_lock);
> +
> +	WARN_ON(irq_set_affinity_hint(aff->irq, cpumask_of(target)));
> +	aff->cpu =3D target;
>=20
> 	return 0;
> }
>=20
> static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
> {
> -	struct smmu_pmu *smmu_pmu =3D data;
> -	u64 ovsr;
> -	unsigned int idx;
> +	struct smmu_pmu_affinity *aff =3D data;
> +	struct smmu_pmu *smmu_pmu;
> +	irqreturn_t ret =3D IRQ_NONE;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(smmu_pmu, &aff->instance_list, affinity_list) {
> +		unsigned int idx;
> +		u64 ovsr =3D readq(smmu_pmu->reloc_base + SMMU_PMCG_OVSSET0);
>=20
> -	ovsr =3D readq(smmu_pmu->reloc_base + SMMU_PMCG_OVSSET0);
> -	if (!ovsr)
> -		return IRQ_NONE;
> +		if (!ovsr)
> +			continue;
>=20
> -	writeq(ovsr, smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
> +		writeq(ovsr, smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
>=20
> -	for_each_set_bit(idx, (unsigned long *)&ovsr, smmu_pmu->num_counters) {
> -		struct perf_event *event =3D smmu_pmu->events[idx];
> -		struct hw_perf_event *hwc;
> +		for_each_set_bit(idx, (unsigned long *)&ovsr, smmu_pmu->num_counters) =
{
> +			struct perf_event *event =3D smmu_pmu->events[idx];
>=20
> -		if (WARN_ON_ONCE(!event))
> -			continue;
> +			if (WARN_ON_ONCE(!event))
> +				continue;
> +
> +			smmu_pmu_event_update(event);
> +			smmu_pmu_set_period(smmu_pmu, &event->hw);
> +		}
> +		ret =3D IRQ_HANDLED;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +static struct smmu_pmu_affinity *__smmu_pmu_get_affinity(int irq)
> +{
> +	struct smmu_pmu_affinity *aff;
> +	int ret;
> +
> +	list_for_each_entry(aff, &smmu_pmu_affinities, affinity_list)
> +		if (aff->irq =3D=3D irq && refcount_inc_not_zero(&aff->refcount))
> +			return aff;
> +
> +	aff =3D kzalloc(sizeof(*aff), GFP_KERNEL);
> +	if (!aff)
> +		return ERR_PTR(-ENOMEM);
> +
Do we need to initialize aff->instance_list?

> +	/* Pick one CPU to be the preferred one to use */
> +	aff->cpu =3D raw_smp_processor_id();
> +	refcount_set(&aff->refcount, 1);
> +
> +	ret =3D request_irq(irq, smmu_pmu_handle_irq,
> +			  IRQF_NOBALANCING | IRQF_NO_THREAD,
> +			  "smmuv3-pmu", aff);
Do we need to save irq to aff->irq?

> +	if (ret)
> +		goto out_free_aff;
> +
> +	ret =3D irq_set_affinity_hint(irq, cpumask_of(aff->cpu));
> +	if (ret)
> +		goto out_free_irq;
> +
> +	ret =3D cpuhp_state_add_instance_nocalls(cpuhp_state_num, &aff->node);
> +	if (ret)
> +		goto out_free_irq;
> +
> +	list_add(&aff->affinity_list, &smmu_pmu_affinities);
> +	return aff;
> +
> +out_free_irq:
> +	free_irq(irq, aff);
> +out_free_aff:
> +	kfree(aff);
> +	return ERR_PTR(ret);
> +}
> +
> +static int smmu_pmu_get_affinity(struct smmu_pmu *pmu, int irq)
> +{
> +	struct smmu_pmu_affinity *aff;
> +
> +	mutex_lock(&smmu_pmu_affinity_lock);
> +	aff =3D __smmu_pmu_get_affinity(irq);
> +	mutex_unlock(&smmu_pmu_affinity_lock);
> +
> +	if (IS_ERR(aff))
> +		return PTR_ERR(aff);
> +
> +	pmu->affinity =3D aff;
> +	mutex_lock(&smmu_pmu_affinity_lock);
> +	list_add_rcu(&pmu->affinity_list, &aff->instance_list);
> +	mutex_unlock(&smmu_pmu_affinity_lock);
> +
> +	return 0;
> +}
> +
> +static void smmu_pmu_put_affinity(struct smmu_pmu *pmu)
> +{
> +	struct smmu_pmu_affinity *aff =3D pmu->affinity;
>=20
> -		smmu_pmu_event_update(event);
> -		hwc =3D &event->hw;
> +	mutex_lock(&smmu_pmu_affinity_lock);
> +	list_del_rcu(&pmu->affinity_list);
>=20
> -		smmu_pmu_set_period(smmu_pmu, hwc);
> +	if (!refcount_dec_and_test(&aff->refcount)) {
> +		mutex_unlock(&smmu_pmu_affinity_lock);
> +		return;
> 	}
>=20
> -	return IRQ_HANDLED;
> +	list_del(&aff->affinity_list);
> +	mutex_unlock(&smmu_pmu_affinity_lock);
> +
> +	free_irq(aff->irq, aff);
> +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &aff->node);
> +	kfree(aff);
> }
>=20
> static void smmu_pmu_free_msis(void *data)
> @@ -652,7 +757,7 @@ static void smmu_pmu_write_msi_msg(struct msi_desc *d=
esc, struct msi_msg *msg)
> 		       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
> }
>=20
> -static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
> +static int smmu_pmu_setup_msi(struct smmu_pmu *pmu)
> {
> 	struct msi_desc *desc;
> 	struct device *dev =3D pmu->dev;
> @@ -663,34 +768,34 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu=
)
>=20
> 	/* MSI supported or not */
> 	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
> -		return;
> +		return 0;
>=20
> 	ret =3D platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
> 	if (ret) {
> 		dev_warn(dev, "failed to allocate MSIs\n");
> -		return;
> +		return ret;
> 	}
>=20
> 	desc =3D first_msi_entry(dev);
> 	if (desc)
> -		pmu->irq =3D desc->irq;
> +		ret =3D desc->irq;
>=20
> 	/* Add callback to free MSIs on teardown */
> 	devm_add_action(dev, smmu_pmu_free_msis, dev);
> +	return ret;
> }
>=20
> static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
> {
> -	unsigned long flags =3D IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD=
;
> -	int irq, ret =3D -ENXIO;
> +	int irq;
>=20
> -	smmu_pmu_setup_msi(pmu);
> +	irq =3D smmu_pmu_setup_msi(pmu);
> +	if (irq <=3D 0)
> +		irq =3D platform_get_irq(to_platform_device(pmu->dev), 0);
> +	if (irq < 0)
> +		return irq;
>=20
> -	irq =3D pmu->irq;
> -	if (irq)
> -		ret =3D devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
> -				       flags, "smmuv3-pmu", pmu);
> -	return ret;
> +	return smmu_pmu_get_affinity(pmu, irq);
> }
>=20
> static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
> @@ -730,7 +835,7 @@ static int smmu_pmu_probe(struct platform_device *pde=
v)
> 	struct resource *res_0;
> 	u32 cfgr, reg_size;
> 	u64 ceid_64[2];
> -	int irq, err;
> +	int err;
> 	char *name;
> 	struct device *dev =3D &pdev->dev;
>=20
> @@ -771,10 +876,6 @@ static int smmu_pmu_probe(struct platform_device *pd=
ev)
> 		smmu_pmu->reloc_base =3D smmu_pmu->reg_base;
> 	}
>=20
> -	irq =3D platform_get_irq(pdev, 0);
> -	if (irq > 0)
> -		smmu_pmu->irq =3D irq;
> -
> 	ceid_64[0] =3D readq_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CEID0);
> 	ceid_64[1] =3D readq_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CEID1);
> 	bitmap_from_arr32(smmu_pmu->supported_events, (u32 *)ceid_64,
> @@ -789,12 +890,6 @@ static int smmu_pmu_probe(struct platform_device *pd=
ev)
>=20
> 	smmu_pmu_reset(smmu_pmu);
>=20
> -	err =3D smmu_pmu_setup_irq(smmu_pmu);
> -	if (err) {
> -		dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0->start);
> -		return err;
> -	}
> -
> 	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmuv3_pmcg_%llx",
> 			      (res_0->start) >> SMMU_PMCG_PA_SHIFT);
> 	if (!name) {
> @@ -804,16 +899,9 @@ static int smmu_pmu_probe(struct platform_device *pd=
ev)
>=20
> 	smmu_pmu_get_acpi_options(smmu_pmu);
>=20
> -	/* Pick one CPU to be the preferred one to use */
> -	smmu_pmu->on_cpu =3D raw_smp_processor_id();
> -	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq,
> -				      cpumask_of(smmu_pmu->on_cpu)));
> -
> -	err =3D cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> -					       &smmu_pmu->node);
> +	err =3D smmu_pmu_setup_irq(smmu_pmu);
> 	if (err) {
> -		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
> -			err, &res_0->start);
> +		dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0->start);
> 		return err;
> 	}
>=20
> @@ -832,7 +920,8 @@ static int smmu_pmu_probe(struct platform_device *pde=
v)
> 	return 0;
>=20
> out_unregister:
> -	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> +	smmu_pmu_put_affinity(smmu_pmu);
> +	synchronize_rcu();
> 	return err;
> }
>=20
> @@ -840,9 +929,9 @@ static int smmu_pmu_remove(struct platform_device *pd=
ev)
> {
> 	struct smmu_pmu *smmu_pmu =3D platform_get_drvdata(pdev);
>=20
> +	smmu_pmu_put_affinity(smmu_pmu);
> +	/* perf will synchronise RCU before devres can free smmu_pmu */
> 	perf_pmu_unregister(&smmu_pmu->pmu);
> -	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> -
> 	return 0;
> }
>=20
> --=20
> 2.23.0.dirty
>=20

