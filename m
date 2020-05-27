Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DDB2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kDMig03l";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JoLGaSIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391154AbgE0Q22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:28:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11460 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389867AbgE0Q21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:28:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RGPZgq001651;
        Wed, 27 May 2020 09:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=K8JdwCMoYfyePBWrfVzbmVUFLHueBA/RGJhFv2j1wh8=;
 b=kDMig03l6POpRM7oJm3G7u47oKhsldT9PJ85FP3S/GlzXw05nol0BKiiOMSFQ8Zo7ine
 Z9C0qrqu1et9Zf1rhZ0OX14uk/RjdAxHZvgpd4px2cXkCE50UvSI5vDZbWZuxJOxRhcs
 RFN+mYyyMINzgWcp/sLxYwOk4YaoxMA6e1s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 317kp3xm78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 May 2020 09:28:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 09:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq4H31/VoaaVpTUuCoKmlCW3gdemGeyk/6EflA4htwCWjYEHXmJKuZtgf9RFv7sn6W6avpo1XYnfM5JrOy74ylpLgT8s3lahpORCiLRKYjlmg9Cwmo6v0FiAgJtd74x5KrHWpwiqZCVN4aRYA5d/OWrVJQRKVzU6/os4boQAj/Auzy22Vh+7ztiAUxMMMVA1l3DTnQVvlpPYa9ubLa5BWvKEp3GegUsHiiWzj4X1TWPXuIG3mzhwtZ0vlSOO9gtmq7FDF7WPGz2uqjE6YcgkazhDxEYdGgpQyk7oqnamysHZjz0Kf/P3SLkZ0MGqkcgY4ua+ZmqkjuX+qDNT0BSr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8JdwCMoYfyePBWrfVzbmVUFLHueBA/RGJhFv2j1wh8=;
 b=i22HTSuKyxNH9AI92lWrOjQNUGyOysAHWX3z4IhMUJtRugrtuWIZGGTdKqbR+agkwQOw2u7Eb2nLoHurNPhWcdarplnayQ+Ga3ZYnGCYr2bqDrPtvpNHhBfEPrzR9yLw7s8w6W9k/sPqV3xWmJcLB11jgJRUQw+geeplqqCYdwPXvE47K3tXuUpN0Iash6nTYZ7NEbQMbCVyfUuDepfqbwVM8YICmzFwVz+1hYu1uBJr6JlHfMqIcvBIy2GLhphXkvnI6zqioyvAnLH+rU/VbgBAgjUzj+EfMJUwgtBfEAobe2vMFlQfnPOfDC+YL4Z2JdMvTPjd+vjuw1tB2mq8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8JdwCMoYfyePBWrfVzbmVUFLHueBA/RGJhFv2j1wh8=;
 b=JoLGaSILkR9dJQomXfSMeahWo7sdeN/BdM1lrJ2XDpwFG2S3XDvhxUcJYTm+cBjTtFEZD+dnqED1LKg5srESWxCcmY+wcYnJzJi0H1NcQoyD1Znm/Z1f1JiEdN/PD4j+PJHmC1cUapIomswo45lXogNQdZTO9so/jXLr8KRi6Is=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3447.namprd15.prod.outlook.com (2603:10b6:a03:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 16:28:12 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 16:28:12 +0000
Date:   Wed, 27 May 2020 09:28:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
Message-ID: <20200527162808.GB396660@carbon.dhcp.thefacebook.com>
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-11-guro@fb.com>
 <2dc94375-2ac6-9dd7-64e8-6e66aeb3a662@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc94375-2ac6-9dd7-64e8-6e66aeb3a662@suse.cz>
X-ClientProxiedBy: BYAPR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::48) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ecd9) by BYAPR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:e0::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.8 via Frontend Transport; Wed, 27 May 2020 16:28:11 +0000
X-Originating-IP: [2620:10d:c090:400::5:ecd9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa187d11-31aa-44cd-4bea-08d8025af2be
X-MS-TrafficTypeDiagnostic: BYAPR15MB3447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB344726AC93B91B43F8821E73BEB10@BYAPR15MB3447.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqgqtvWpKvbRL9X/3Ja+AP8G9xhmAIAVQWEfat2u4+QzFiQVpVwU33N5oQmoY+piPNOBljZLfOqHeM7kk9dCebOl/cOPIeDpY4ctHYT90p07ck8BNqP2emx5V6JyAM1Oz51YhCpY4lwn+0HpAJREP5u6kmxl9or/J348KgCghjaSD3fB0QeGIqZx87yzpKft0KKJu637eQPrc5gogrgQbkXO8HfvXNYqCGlPOCQPitTve5vZAZT8dZxDD4Ofa5Of14/1ucCx9cv0EC+aOMCfoFJPGZByV80vFbIz+V11sfuvWrveestErXnKNr7KPkQmgkP0GV1rwTuRQYojiF3poQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(66946007)(66556008)(2906002)(6506007)(53546011)(86362001)(5660300002)(1076003)(186003)(16526019)(4326008)(6916009)(55016002)(9686003)(6666004)(66476007)(8936002)(52116002)(33656002)(7696005)(478600001)(8676002)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ibUny1KdGYEmU/r1lNH3O9zjlU2OBvHyzDuUxy5R5q+dMnfCzpW4dep26id2Kj+ekJzezmL58Tu/JBxD0I4+JzWhcTZe9S+FHnF2zsePAmAaE3izfEFoRIWGJRc6vbAPMtBOHJzG8KVepNwVnwuGaFGA4mI8UlTVLzf0OWsPXQ5XLxhlTfcQ3YkC18aEZNU2IjiIJcK5RcPUTlzYgCbPvFbE+7WHbGXepYVdpjHI3ddKqx3pufPHZpwCXkeGa3MgPDTgacXroqmuQxGaW70MiwI3rTBM0w3zEd9jm94GYdnLrY0Q8WKXnr0CW3rBdHU1TlkGirpDrM1PFnayqYS8wFaKgQ/k0+bN30XkKiUbIwypVonEBNUVC/MYKSBlYR+e+lkrk/ha4UvTG4G5ZYds2BISP4WwcGIAwxMhe+y1bpA6KNFJdXKJimQiixDqm+NzjH9EgfrgZwpSJPrfROFw8eO9gTO/oPfW6PAuL6Tk3Fjib7Hkvq7K1wRW3br0jmHdL7S3FW0VbKqlNveoC7a7Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fa187d11-31aa-44cd-4bea-08d8025af2be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 16:28:12.1931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmPZq2MVV64ZBfe/YaCvQQkXGcy0dojXXZF3/e9yYNu/bjhemCo2SoFnxkMAbQGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3447
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=821 suspectscore=2 priorityscore=1501 cotscore=-2147483648
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270127
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 05:54:50PM +0200, Vlastimil Babka wrote:
> On 5/26/20 11:42 PM, Roman Gushchin wrote:
> > Deprecate memory.kmem.slabinfo.
> > 
> > An empty file will be presented if corresponding config options are
> > enabled.
> > 
> > The interface is implementation dependent, isn't present in cgroup v2,
> > and is generally useful only for core mm debugging purposes. In other
> > words, it doesn't provide any value for the absolute majority of users.
> > 
> > A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
> > It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output
> > and also allows to get any additional information without a need
> > to recompile the kernel.
> > 
> > If a drgn-based solution is too slow for a task, a bpf-based tracing
> > tool can be used, which can easily keep track of all slab allocations
> > belonging to a memory cgroup.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Also there was a
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> for this patch.
> And here's mine:
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> 
> Of course this depends on whether we break somebody's workflow and they complain.

We've discussed it a bit around RFC/v1. I hope nobody uses it for anything
except debug purposes, where dragon + bpf can be as good or better.

And actually it is what it is: there are no more per-memcg kmem caches,
so there is nothing to display.
