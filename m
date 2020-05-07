Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1032AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A4F207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="h/z9vKIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgEGFj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 01:39:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:59252 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgEGFjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:39:51 -0400
IronPort-SDR: xVd1XSNGdzh8dohccvaxMxO+09r010OZ3NzfoYSSp3Un4apjEPLe56f6Xi/w7u4I4umw+D0d13
 1TuOx0Fo55og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 22:39:50 -0700
IronPort-SDR: me6RvGfI7qcY3p3/vSxcvYzS5zXOfR3sciAbTdk1KDnOXc9T6ctMay2dWulyfPlyq3envGN1so
 eTcK/takKrRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="461724236"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga005.fm.intel.com with ESMTP; 06 May 2020 22:39:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 22:39:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 May 2020 22:39:50 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 22:39:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 22:39:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sbk6bAnuoHzeOCjcxdtYktoZnuPnO4MlEyhqBQogUHUkVv7I9v1L3vFvdrCKuvNjV8LNeeSOzKxOTDd+VtryBgeNrmtTD+962JtUzkNzS3IWZxpJM+sGwjF3CPBCaycFG0ebS+5+7RQDWKJZGG0/XfrPv+xGLHtNv9og33puzPkDGebR6TFVIM/jLZ1dB50g8xacJoepXr+w6xkkIbx2+1OPi0jcXKllGHJW8P9UbSISxNhj24PDjKTyynkZpNvH9ovUCDPt/pMnfD2Vbe36fmmcZk5WAManb3rr5eI48PwK/3EWokojV76/hYkpFS7AXh/d0V5OyZfjjAO4ultTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCcC+6ljDFNQMbag6Ksw4Z+NIbfGvuHk4Iyzm8sMDIk=;
 b=S6CNsQ5Pvmdq3cnJ+MSfiVmd6QMW81TX0nhdOutbKZQa49O63jVFDjhO1SV+Lzns37ePNyyBI4yEZd8xmxh59/bZzxsrqdxoIYe+iWoz+EGEpaatGvMSivfxRryRiOyC/tvGUlLIBhYq4GWRO2cAs5JmLs+HqeuybGppb6hY4IWtcFkZLyKEPoBzk1hsQ9D35pUDv0boqdSMZ10U8CEYGyFCCWxt8uadAdmHqLYFYhhsBea8rpEAXK0QU3HNc/QoW9rWLYT66/bVG+MqMZClzRO3mS4Z29XZ6Wr6kezWtk3rlggSP4eNAzZY7cZHPQ3dzzjBrjzU8G+ufOi9C9DuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCcC+6ljDFNQMbag6Ksw4Z+NIbfGvuHk4Iyzm8sMDIk=;
 b=h/z9vKItKsao4BObXblBMZRlz0UNy9/wTyLLcpy/DN2z5jwr2GldFokRsTsi8Aq/G+hQfGXMpP/1jUvasY8u43GEgqdBC/tzBNNTdEia1EDf5Tb1JtvLLR4jBNCUaS9i0ml/c05X5UKw357Ym2muMzl9SXkVVDdjAHtzloOuq3A=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Thu, 7 May
 2020 05:39:47 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be%9]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 05:39:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] iommu/vt-d: debugfs: Add support to show inv queue
 internals
Thread-Topic: [PATCH v4 2/5] iommu/vt-d: debugfs: Add support to show inv
 queue internals
Thread-Index: AQHWJArLv7BajKoxo0O84bRwMQJ8zKicGk/g
Date:   Thu, 7 May 2020 05:39:47 +0000
Message-ID: <MWHPR11MB1645207961313B948C1247328CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-3-baolu.lu@linux.intel.com>
In-Reply-To: <20200507005534.3080-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3569f0a-c4fb-4bc9-37aa-08d7f2490e09
x-ms-traffictypediagnostic: MWHPR11MB0029:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB0029076BB9C5E515B76680458CA50@MWHPR11MB0029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQ8+UaC52EZvXwbvXIt0NmZ9aeQ3sPgsmRBakVlFCqLvUYg9QqtdZcSgNvwoI5mL01tXiv0BkoR0hfgtmVFkzsZReW24cXyNItCOjQ8VfHInXQV67vosZK8YMYa04+DPbWNdTj5Xp80Jsc0Muu8oP1v/DfqSJZJOoZNwtcWcWofZ2pKl4XXMZVV6ZqqZkYrMHa1w2yLw0hUaY5bxHkWebH9a82WSBkxtYdI5R64wsI0VAooF2xzeSiuHyYRsjorRkhImF5MTNmKIbCQasMXhPe1uPR/TED7Y7+WE/gSKOh8thUYSLn1FwOGNNom4qfCFoG9sfu7hBqvjkuzhlAPp0MG2j3rocNwsdecqposqgEhYge8ajeekyl/j/d2KMZaz233fegGnexsCjRNThtxjogrqLVRAuQVU4Kd+zHn7/2YpxyzDtZtyKDSzEmo2f4qRJzzu4dWEkuVgJAi6Z7J1p8NX9YGxdeWIjFbsR0xiKXDjIdMOGLEbnEZZQQW4l3NYk6B12sgAescf650KuZQ6uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(33430700001)(71200400001)(55016002)(33656002)(9686003)(478600001)(33440700001)(86362001)(64756008)(8936002)(5660300002)(316002)(66946007)(2906002)(110136005)(54906003)(66446008)(52536014)(66476007)(186003)(6506007)(26005)(76116006)(8676002)(4326008)(66556008)(7696005)(83320400001)(83280400001)(83300400001)(83310400001)(83290400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yFQxcX7HR/09xS1muPJvYtS5SbbN0jT1HDxTWOFE6guMT0RDgMctlj24UWu32g3LP5cVZJQyNcdBMlx7smlZ4STrBo/vF6H3icKnD49mQA5in+cSb2fLfjHrMzK5yfCzIPr+R6wAdDY2AmjJ/tGkppXJI2K7O3IDVYACRyCUdYa+5bwz/cL4K2z9r3WtaAafCCMwxgwZKHn3QfecB2aoL+R6+HULO6nVn2VIbbKsR3JLy1fO3Of9DyhqF+OLYF5P7am+zyaMG1RsFoSBYP6/w9J6bSAEQd1QeLyVsAbuZ4DWC/3qJ3Vxwej5NrhIXJ8YzmXMPUMetk9tPome0Q7LcU8m+oOGF0Fwna+Am5DwxbmfLz5rDCHXT3Adzc/Ly9b0UTnYfVYrviTXxGjVGPgdh1mTzoyligtVmR0R5v3/0SFwk6SZe21Ej2Ld/c/UniNRAFVnd5OVgEPmFN5uDRzbg65gXtAyxIqfLt9AmFkYVaaKRkUP0JS4RpU5T+cE53nBNDg7GCRk664W/gYthkY51eY5YE+pUsGrqF8Huk8IlbU+RmIL0qZmBhRjw88Q8x2mmZ9dw9HwxA32lwwSL7PlTN1CizZKzcqp6YuD1BvSge5rexnbdQfpfX2pRzf4Uq6SVE5sog1nfSstXZ+N9F10ReyfYJv9TWPFPS0sK7ihcLKt0tleOJpg3tpfGookjRWCZJAlY5ifLYav4bnQpb9Ewd5c8q/tTJ97wUeZUOm7hBdMXXV2R8muBPTQwtVrcoq2jY6qN2NN0FpisZU5xbRxrso2a+t0ZupKwYARBtAyGN0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3569f0a-c4fb-4bc9-37aa-08d7f2490e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 05:39:47.7504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWaEpFkBpUulGv20/bfgvZ77gWTjXeuMAc9T9B5HqE5GaGLfWPbpHslA78RZcyUFGCiLFr5uJs4ggeQhv34h0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0029
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 7, 2020 8:56 AM
>=20
> Export invalidation queue internals of each iommu device through the
> debugfs.
>=20
> Example of such dump on a Skylake machine:
>=20
> $ sudo cat /sys/kernel/debug/iommu/intel/invalidation_queue
> Invalidation queue on IOMMU: dmar1
>  Base: 0x1672c9000      Head: 80        Tail: 80
> Index           qw0                     qw1                     status
>     0   0000000000000004        0000000000000000        0000000000000000
>     1   0000000200000025        00000001672be804        0000000000000000
>     2   0000000000000011        0000000000000000        0000000000000000
>     3   0000000200000025        00000001672be80c        0000000000000000
>     4   00000000000000d2        0000000000000000        0000000000000000
>     5   0000000200000025        00000001672be814        0000000000000000
>     6   0000000000000014        0000000000000000        0000000000000000
>     7   0000000200000025        00000001672be81c        0000000000000000
>     8   0000000000000014        0000000000000000        0000000000000000
>     9   0000000200000025        00000001672be824        0000000000000000
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu-debugfs.c | 62
> +++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-
> iommu-debugfs.c
> index 3eb1fe240fb0..e3089865b8f3 100644
> --- a/drivers/iommu/intel-iommu-debugfs.c
> +++ b/drivers/iommu/intel-iommu-debugfs.c
> @@ -372,6 +372,66 @@ static int domain_translation_struct_show(struct
> seq_file *m, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
>=20
> +static void invalidation_queue_entry_show(struct seq_file *m,
> +					  struct intel_iommu *iommu)
> +{
> +	int index, shift =3D qi_shift(iommu);
> +	struct qi_desc *desc;
> +	int offset;
> +
> +	if (ecap_smts(iommu->ecap))
> +		seq_puts(m,
> "Index\t\tqw0\t\t\tqw1\t\t\tqw2\t\t\tqw3\t\t\tstatus\n");
> +	else
> +		seq_puts(m, "Index\t\tqw0\t\t\tqw1\t\t\tstatus\n");
> +
> +	for (index =3D 0; index < QI_LENGTH; index++) {
> +		offset =3D index << shift;
> +		desc =3D iommu->qi->desc + offset;
> +		if (ecap_smts(iommu->ecap))
> +			seq_printf(m,
> "%5d\t%016llx\t%016llx\t%016llx\t%016llx\t%016x\n",
> +				   index, desc->qw0, desc->qw1,
> +				   desc->qw2, desc->qw3,
> +				   iommu->qi->desc_status[index]);
> +		else
> +			seq_printf(m, "%5d\t%016llx\t%016llx\t%016x\n",
> +				   index, desc->qw0, desc->qw1,
> +				   iommu->qi->desc_status[index]);
> +	}
> +}
> +
> +static int invalidation_queue_show(struct seq_file *m, void *unused)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +	struct q_inval *qi;
> +	int shift;
> +
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd) {
> +		qi =3D iommu->qi;
> +		shift =3D qi_shift(iommu);
> +
> +		if (!qi || !ecap_qis(iommu->ecap))
> +			continue;
> +
> +		seq_printf(m, "Invalidation queue on IOMMU: %s\n",
> iommu->name);
> +
> +		raw_spin_lock_irqsave(&qi->q_lock, flags);
> +		seq_printf(m, " Base: 0x%llx\tHead: %lld\tTail: %lld\n",
> +			   virt_to_phys(qi->desc),
> +			   dmar_readq(iommu->reg + DMAR_IQH_REG) >>
> shift,
> +			   dmar_readq(iommu->reg + DMAR_IQT_REG) >>
> shift);
> +		invalidation_queue_entry_show(m, iommu);
> +		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> +		seq_putc(m, '\n');
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(invalidation_queue);
> +
>  #ifdef CONFIG_IRQ_REMAP
>  static void ir_tbl_remap_entry_show(struct seq_file *m,
>  				    struct intel_iommu *iommu)
> @@ -490,6 +550,8 @@ void __init intel_iommu_debugfs_init(void)
>  	debugfs_create_file("domain_translation_struct", 0444,
>  			    intel_iommu_debug, NULL,
>  			    &domain_translation_struct_fops);
> +	debugfs_create_file("invalidation_queue", 0444, intel_iommu_debug,
> +			    NULL, &invalidation_queue_fops);
>  #ifdef CONFIG_IRQ_REMAP
>  	debugfs_create_file("ir_translation_struct", 0444,
> intel_iommu_debug,
>  			    NULL, &ir_translation_struct_fops);
> --
> 2.17.1

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
