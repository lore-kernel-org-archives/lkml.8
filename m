Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C7420732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JCWLxAZF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ANt+EFi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgFVRkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:40:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbgFVRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:40:52 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MHV7KE025002;
        Mon, 22 Jun 2020 10:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gpOPgXPEyw/BZJtqeDdJpa4uA52MwIS5LfpzSdOWJbA=;
 b=JCWLxAZFK8ByTIt+ZqKEYVvoEduT1Kpe1/ZOU3TjUosrX7Ogean0GNJlxygsuxOcImIh
 70BK5/ncHbKPxO6Zh6hbXOi3KCedawEAtJh8OnxFrsRu+4L2Icys1HsgzbfWUmRVCqfk
 OVTZCuHj6Q0fdI5LcRm5t/Nav8HQNJLgrPs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31t25bpn8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 10:40:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 10:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsrJsyJbE1Zfl2Ecc8p8M42wyJea3jLVPk7G7cdOzJCNVB7wqF+Xw77JkV+iVtDmR8Qgu4aBFpV4GRfxcGnm5Rgm2qQTdmKNCQpekwZmiFJ2nCju8tpEzLH5FCQXy3ln2TbTRojGyts+dD1r090PrBYNZKBLB3HrB0jMfeZxPEMOCPGG+37/0SvMDimtZd4VM87oaok6XzDSqG94iaX/3H1UOKdqmY6P5bfA5S6cRm7xkc1jBpOZaPlqfpHXyS9WyxYyk+KurnW7X2udBWjWr0dqJ0tggwoPj/+GJ6WjSgfUHUG95adnv4q2qxPTLpCslPKz2v4JqDEhLkcRpW0gUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpOPgXPEyw/BZJtqeDdJpa4uA52MwIS5LfpzSdOWJbA=;
 b=NrtPBAGAXauDGOZ7Ab2daL5/GJkfpLfMPtEaIdCykIAQyhCjG9eVO0joBpLqumTFxy3sSdGyCV8BqSToIz7glLauq1YKxsKxcZq/8yZh0YintBKJ1dJVeOVpskL9j20kX8T4Wp+8sOLy1BeWLq7heGQABGWj839sYK1UadfYVAzSz8/Nklcf2nmuXkRrqPudAvj/x0heeFWSZKqeOezFgcsW3gCQPGxCa8g3bCwrXITRdcqecR9SEu6wyrWJv+jje+Cr9IGnm0/tv3Z1TflHrawauAuwJ0hOFKrCaCtCKzTWnYxczB/wYgbB+cD/pzPJEIFQONYldllWrnR3l81LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpOPgXPEyw/BZJtqeDdJpa4uA52MwIS5LfpzSdOWJbA=;
 b=ANt+EFi393QOlbuBdIhjWfrVAlS7R3AXR+1WaQz+PkrAzwecvX7j/vufu71X7O+OfTyUbSjNMfa9xn/a3Vb6QJXSvK+8DbKaQhw6aa8HoK46/HTv//qMewOoALFV237NtkTKoKPpHrNW6/4mvlol8pytt5oK3JGAffKxLOg9NQo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2663.namprd15.prod.outlook.com (2603:10b6:a03:15c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 17:40:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:40:38 +0000
Date:   Mon, 22 Jun 2020 10:40:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 13/19] mm: memcg/slab: simplify memcg cache creation
Message-ID: <20200622174035.GA301338@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-14-guro@fb.com>
 <CALvZod50rUqhknV50zwvm4sLxdP=OWCLqFRKPPO_8Pff_v4EOg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod50rUqhknV50zwvm4sLxdP=OWCLqFRKPPO_8Pff_v4EOg@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:88b0) by BYAPR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:c0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12 via Frontend Transport; Mon, 22 Jun 2020 17:40:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:88b0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4eb1ff-6db4-48fe-6885-08d816d36000
X-MS-TrafficTypeDiagnostic: BYAPR15MB2663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB26633F13E0ADD0023C602E04BE970@BYAPR15MB2663.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFkMQt0HEDK+b0WO9ORjbnUICzagAotaPaGe5JQBdrHAJvYaFDVJmL0Oa2+FZ4VIYeLq2O2uDd2NwmghFeOh4LNf4d4Yuwe8hWajTf3YVZmXe4lCNViPm5MRC9Dyo/iqjbsEMUXOGtVTkIveNW00knyfhc07v1YB0kR0bMW4wVu9s8UfLyjWxrdhBJGVepXwCSJiGX8152wX3tsaubzDIhpf+1kSkOX1F5eRmoJO2CAsObfVhcEH8YoRvYOcZ/v0EgbefmnB7qAouiXeOIkshUU7iLh48aTPggs+gECr4MBATjGEZyQdwwE55tpim+LQ2LSCviIF60SmKw62qlzjVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(39860400002)(136003)(366004)(376002)(6506007)(16526019)(186003)(66946007)(33656002)(316002)(5660300002)(66556008)(66476007)(9686003)(4326008)(53546011)(8676002)(2906002)(54906003)(1076003)(8936002)(7696005)(86362001)(478600001)(6916009)(52116002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2TEDoa6fMoEhrBVN2AyEsphwrcIBvWvm6dSnNMipcVetdPpS3tRmC6DYqdAzRs79/kfqvT1Lt6ovKUvQHsyZCyM/RkNY60yEc6g5QChHE3dQdxleWYFbttPqWpnCYxjiZi/QgqmSgL1ERZedjypWR3k3MOjDk2JhudNsqST4k6S1wx+FtB2Wvms7lwQE2CE/XDCKtLMeoK6g+VCMNjOfIlsHEaIxdeqi/RgbAzeC1tJT1Ti/M0UZaCsR5unhMOpShM8moPQz40x3D2HZioViCMrzMaYQlsYnD5/s+RTA1N7FZWH8OwiYTLlwEf/JJ8U43WiEv658LwWUD+pRM47kYwjx7mNcw/oSe7QNO/rlM0Gz1WlYae2zETYF0JjdIHIoIxYDXFIVLITkPqR3YKE5ZjyhCwo9HlaG9u18MTdr9nueo7mo1QsZ8LAGyFl/6VMWYV4FyvDa0rh7+k9DKzYanIFxfNzict4yceA2ZtCSI4Sp42KDuGa7MbaW3yg+I9Y55az2E0papSxj8OHVpIwOKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4eb1ff-6db4-48fe-6885-08d816d36000
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:40:37.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zE08TBv16eFN7rpR0fJmrRYE5L3lE46xvkdwPKqg65PYups9eLHWND7McuXI0/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2663
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_10:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 impostorscore=0 cotscore=-2147483648 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=1
 mlxscore=0 malwarescore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220121
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:29:29AM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Because the number of non-root kmem_caches doesn't depend on the
> > number of memory cgroups anymore and is generally not very big,
> > there is no more need for a dedicated workqueue.
> >
> > Also, as there is no more need to pass any arguments to the
> > memcg_create_kmem_cache() except the root kmem_cache, it's
> > possible to just embed the work structure into the kmem_cache
> > and avoid the dynamic allocation of the work structure.
> >
> > This will also simplify the synchronization: for each root kmem_cache
> > there is only one work. So there will be no more concurrent attempts
> > to create a non-root kmem_cache for a root kmem_cache: the second and
> > all following attempts to queue the work will fail.
> >
> >
> > On the kmem_cache destruction path there is no more need to call the
> > expensive flush_workqueue() and wait for all pending works to be
> > finished. Instead, cancel_work_sync() can be used to cancel/wait for
> > only one work.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Why not pre-allocate the non-root kmem_cache at the kmem_cache
> creation time? No need for work_struct, queue_work() or
> cancel_work_sync() at all.

Simple because some kmem_caches are created very early, so we don't
even know at that time if we will need memcg slab caches. But this
code is likely going away if we're going with a single set for all
allocations.

Thanks!
