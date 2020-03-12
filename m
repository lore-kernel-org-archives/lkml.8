Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6492FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278AA206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="I05pp4Bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgCLMy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:54:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:18412 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbgCLMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:54:58 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 08:54:58 EDT
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CCr87U023681;
        Thu, 12 Mar 2020 05:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=L3ykhozuoV+rOVNWMAajI21yAIRTGCml/nuygnf/V44=;
 b=I05pp4BpR+Oc525KVV5bRyZlfKFu2yvlomentw0VhjlRPflhPU6OH0UBsKtr5UCYLava
 uhhOeHVO4VfwXYxO+xg7r3JXDO8zbCsLBxdR4CTxQ5XJq9GSTdGrClW9r5MJCZJlIRsb
 lzpqbyRh4zppF5AZwBWN158iO9pL3COBo2b8BeauGDStofW0eNGFEHdEyKZjK5pfmvcf
 24KMI5mewTvyT8wlaXIM8Gjl3gFOZQhkXdLfIbnean3uM9zBxooYomsBc1A/dhgMDY+y
 +OBVRkKaCqSSPUhjGOJg5g1PPBKJXOSQDrOAtDGuuoVRBOu2xLw98s61PWDmNKgQfp8M cg== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2yqf32rut5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 05:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpgPqZae/Bqgl3WwpD5tHPtfBlErF8vnjPf3wgVLOI/TFPDWVjn22+FiUIqcfjbKgaqstfLk/VNV7R84EHW5yOQbLJH+0faEMkK2MZzVDYHKy7+AqSxO3rwLNJMjy5Be2fsYtws2+9+tZ/UInppdi5X5KBp8jKfNgHbAZoCae6lYWu6FvPwf/oVsSVOL7lWIZbAd5YG4CS79wHpZ4AMcpnFSkrlV5p3nk7oIo0jwLyFEIF6jcVQG5htusJZ6XVgsZ6wZ63QdVIRXddK9Or+k9rmwkYsWYYgho6wKSuAGdMKUJ6dX2Ag+tQ2UY5GLf9tAlpCntVy2tDmH/jT9LIMQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3ykhozuoV+rOVNWMAajI21yAIRTGCml/nuygnf/V44=;
 b=dcG77ZHI014kDvNgBhq9ne0Q6sFVcbAcZqIuFajTqW/BbQCKEs7LD6WEsoTfqzLhfLVP197OxK2wAbMkU8MWAPsPlyKVhdyn6nFUWdh97Q2PunptHfTyBPua4dQRoCPmdvIM8c7Ql76nceTcJLaQ+cmbB68XA+aLLL9GAeiigsLcImcjptrlsDkkDxfElMh7LVFZcwXZRCC61IvCPw7NmZl551wAhvNfUgvudG0Vwq5lgY/e9gNnlAFJmPAUVLwPsiqUdmz6uBjoLENLC0ILyCaMEH8ZSzx0A4wZ8umMXedx0z4LXNZUTktuoRzbCWpf7qQ5YYHfALR3gNwtWn6sHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB5601.namprd02.prod.outlook.com (2603:10b6:208:88::10)
 by BL0PR02MB5394.namprd02.prod.outlook.com (2603:10b6:208:37::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 12:54:19 +0000
Received: from BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c]) by BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c%6]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 12:54:19 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Topic: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Index: AdX3zHNqbuFpQvKERxyPueA21j6FDgAg7liAAAcXdAA=
Date:   Thu, 12 Mar 2020 12:54:19 +0000
Message-ID: <BL0PR02MB5601B50A2D9AEE6318D51893E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312092531.GU23944@dhcp22.suse.cz>
In-Reply-To: <20200312092531.GU23944@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f004e9f3-cf40-41c2-e964-08d7c6847ae1
x-ms-traffictypediagnostic: BL0PR02MB5394:
x-microsoft-antispam-prvs: <BL0PR02MB53945260CE682FC33A4508E2E9FD0@BL0PR02MB5394.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(6506007)(86362001)(33656002)(4326008)(55016002)(26005)(316002)(71200400001)(8676002)(8936002)(7696005)(66946007)(66556008)(81156014)(76116006)(52536014)(2906002)(81166006)(64756008)(66446008)(5660300002)(66476007)(478600001)(9686003)(44832011)(186003)(7416002)(54906003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB5394;H:BL0PR02MB5601.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjlnF77M70fd9ENMQ/EuYCyJ6rPCgLNqYM21pG+55EvnWvZhiOgRDPx03AjoXWRU2JTqi7Uar9VPRgcT5tBAd3EL4uX+eXZfO5Cqfz+OB5oGi2X2kjywLLu/RehG2BZfNHk+gpMQx7Lt/vlY6U0dKF1ZaxAVvS6BNL4Q3VUnR/5nBcHFeRzfu5+fN8ZsJMN31CBctbBV5Hn1vhFyG279eAgGZ9sUN3FJcK5LB3AtLcKpCVlXicco6a8CfMa33hUe0ZBqPYFN4ahID6E696aonzCC6Ps2CR1csypthfJ/0MjazdQY3Pr29P/MY8Zv/X4TxPElALTD6qrcHiMpWYnLRN9FWKKKJCONiHNJD9aZ6gqVRsDog7aLMA+UghzsYX98MCs8qJMuFMlC4tgiS9Ai9zn0j+HyxXHQlDmB4DY5szUR3/0A4DsLohzsfNtzkc8A
x-ms-exchange-antispam-messagedata: 8GQqVdgMr2ueYOjOZPwTzQM130V6C2rDVCGflyoDByYUHM/+dPsNWN9qqMgT9jSXHq7ftIiA9awKdyTX176CTXoOkFc3CDOy0EXmKRzvly4T396TgPkjG8IShGDUuNPbSg5KVaQqMbiPEY6ruyt/2A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f004e9f3-cf40-41c2-e964-08d7c6847ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 12:54:19.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyrE3lQPGjcGkhF5zKQtURcGS+KFqm0mPaJairhHo3Jc0rFXDZdROZen15xqjYarjOWOCzt1dpTZtU2xwMRmBnvm/TTVuUzFxsaQomvQPIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5394
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_04:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thurs, 12 Mar 2020, Michal Hocko wrote:

> On Wed 11-03-20 17:45:58, Ivan Teterevkov wrote:
> > This patch adds a couple of knobs:
> >
> > - The configuration option (CONFIG_VM_SWAPPINESS).
> > - The command line parameter (vm_swappiness).
> >
> > The default value is preserved, but now defined by CONFIG_VM_SWAPPINESS=
.
> >
> > Historically, the default swappiness is set to the well-known value
> > 60, and this works well for the majority of cases. The vm_swappiness
> > is also exposed as the kernel parameter that can be changed at runtime =
too,
> e.g.
> > with sysctl.
> >
> > This approach might not suit well some configurations, e.g.
> > systemd-based distros, where systemd is put in charge of the cgroup
> > controllers, including the memory one. In such cases, the default
> > swappiness 60 is copied across the cgroup subtrees early at startup,
> > when systemd is arranging the slices for its services, before the
> > sysctl.conf or tmpfiles.d/*.conf changes are applied.
> >
> > One could run a script to traverse the cgroup trees later and set the
> > desired memory.swappiness individually in each occurrence when the
> > runtime is set up, but this would require some amount of work to
> > implement properly. Instead, why not set the default swappiness as earl=
y as
> possible?
>=20
> I have to say I am not a great fan of more tunning for swappiness as this=
 is quite
> a poor tunning for many years already. It essentially does nothing in man=
y cases
> because the reclaim process ignores to value in many cases (have a look a
> get_scan_count. I have seen quite some reports that setting a specific va=
lue for
> vmswappiness didn't make any change. The knob itself has a terrible seman=
tic to
> begin with because there is no way to express I really prefer to swap rat=
her than
> page cache reclaim.
>=20
> This all makes me think that swappiness is a historical mistake that we s=
hould
> rather make obsolete than promote even further.

Absolutely agree, the semantics of the vm_swappiness is perplexing.
Moreover, the same get_scan_count treats vm_swappiness and cgroups
memory.swappiness differently, in particular, 0 disables the memcg swap.

Certainly, the patch adds some additional exposure to a parameter that
is not trivial to tackle but it's already getting created with a magic
number which is also confusing. Is there any harm to be done by the patch
considering the already existing sysctl interface to that knob?

> --
> Michal Hocko
> SUSE Labs
