Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FFEC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56166206FA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IC5us754";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Cc6ifLs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgFFAeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:34:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbgFFAea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:34:30 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0560TamO001983;
        Fri, 5 Jun 2020 17:34:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=G0pLlA1QJ1UNZx8HpD+LdGZfGrSbwNf7CQSwuz98cC8=;
 b=IC5us754i9dLqV/rOf9SXsMgk+HbEV9DsLjm5DIirN2cndbK7gpHkWOE1d4vXe0mInR4
 dbTY5kQnReEZamOjlBfMIQLlnA95NVjpgPHcJgi4jjxQSaMFIyWKF6tSAQNgdHpTQ7hp
 g+ilOElik9JKR623wElCVw+UO28nsqFo1Q8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31f90365ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 17:34:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 17:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZjE16HqPpguYq4NagT6GyCHHB6HbXg2UNrG/kgTQJqZ+1MB82aPW61rWt0KQ65oYgILPNR/yMZ/znA+Ego9sajUKumQPMte8YUjpwKREH8me1obJiV8SwKpNdw+hVtlkpETYBqIyyqq3H1Odbltfy5C3MofiVduzMXFzHo7vX4V5PO43cyll3oth2Eoqt+fefWLGplPROr663xPAddzQn3ac9IN9o9qZu5zVvnTrdeWnGTDHM1f2JHM+7X6hvV0QjtkisAzR9UGv0XV+rXIPREGkPX9DMdYFm+zs4wAJv6gv7Gm+aCurIffdBdqdVXjDx8JW8DQdMoPvmQj6CvWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0pLlA1QJ1UNZx8HpD+LdGZfGrSbwNf7CQSwuz98cC8=;
 b=h4iKFaPfzj9DdrrsrqLJSrAzuv8QLyKkTtV20CD8Lk7uTfBEafnwlkFosEhpjja5U08rkZlMdmmzYiyHVwdCSAkr/ZDVfXOM5/l2AvNDwC21OHCYdprAb0MKWSOtRYlg4hMGe3fYNcrTqL7tk7dhXtOh62nKub2btnGFKfaVEv3m3uOPoRUcnaXFcTERGTLco2ttJ0CmI+nffoQ9TDuoDmUQEPdFbEE8TiB86YMiNhuWcxYBsAlKTat3zomovrOKAs1wjJsK/UjTomHT6dnK5XD3uufQs6z25Xx4uT8hEBrtTgd6jRcimeZvNbx8rbMJMO8XNUd5/OOtQzfPx5RIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0pLlA1QJ1UNZx8HpD+LdGZfGrSbwNf7CQSwuz98cC8=;
 b=Cc6ifLs3je40ZGnXgeksK8i5psPJqeV8ln17YEiJeVE8k7Y/2M6w0XgLJvgSZ4gKTmXkQBtqDlsGi/5lrYY9QvjtFDC8X0aXswlkcEThXmGwmMF0SQsNX1jfq1wct+VFeO2sTTOIMWq6BdOvgt0jC0KihILwkg1AUSQFg4RwwG4=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2214.namprd15.prod.outlook.com (2603:10b6:a02:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Sat, 6 Jun
 2020 00:34:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Sat, 6 Jun 2020
 00:34:14 +0000
Date:   Fri, 5 Jun 2020 17:34:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        <vinmenon@codeaurora.org>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 5/5] mm, slub: make reclaim_account attribute
 read-only
Message-ID: <20200606003411.GH561977@carbon.DHCP.thefacebook.com>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-6-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-6-vbabka@suse.cz>
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9cf1) by BYAPR11CA0102.namprd11.prod.outlook.com (2603:10b6:a03:f4::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 00:34:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:9cf1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea868537-9bb1-4e15-0e33-08d809b156e7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2214:
X-Microsoft-Antispam-PRVS: <BYAPR15MB221492646A1ECF383A0AE61DBE870@BYAPR15MB2214.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YEgMpVlxtqRRZRDtLc5J7pdewZaQYv2Bi+TqXVUGsA4fNDGArRSGKD4jpZZgAfwnOzt9qb6slhFg+N5RzpVwShYhhnDjLfWP/A3tcSB2jMXTiWLlBYyOsATbSTuPFzKjfgKkeqg+kMbx4xI1qrbdmw2dCr5Mxw6f7nMYv/Zri7KO+E+rRMgSmykAt5n8vKdG8B+SVVuGOvyDDrPUVh7lnxNDCLZlxcpP0lHvvPsS04jSIW4gDIkJZfHzRfPP7HYP393iANsNi0vBJIOF3sOB1Kd+ASA87GK5qO8lTu18DhQzONLJry8Ew98AFcyBOFpRE5p0kLuX8le8RLC+UIwfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(52116002)(7696005)(54906003)(2906002)(33656002)(6506007)(83380400001)(9686003)(6916009)(1076003)(16526019)(5660300002)(186003)(478600001)(4326008)(55016002)(66476007)(66556008)(8936002)(7416002)(66946007)(86362001)(8676002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7z/SiRi/VatjnT1bZwf3A+jnB/wG50RFDjbBfwoGBRODFg5J0xUcFhfdQM9Eq/sAlPcL3Akbm0uv8jhPrOZFTncVvb0YBo6MsFJr6A1mK8o/tapJwAIEoZOVY7sPNjYu2zaK38+xmFe9O0L5/+w9SWx1JwghLtTHcasPVcaIqsz27nXkcQzjNtd5L3ZMJ60ESR6zNvW7CUAsK0izAmkuobA+pffgL4nTloMoWLDJQd5qLV1b63MQilBlbZDROlEQ7nxDbOSr29uLAI/viU+trOcn8gDmQs6QbyyFeM4tnXh48UayJ1pTPJCuJEWv35qszvMbQqvlbACmGroRoyFbaB+5DK1j3/hlal6Pguv+JngXY5GcfyZFb4v0glfIO6hXBLBzDoXprgXi+YcgYaGOFwBKj1vI1KVoL9agK+pTJDnK7BJkgu8xdKmo7b+SFB2bkh9X6kxbx8IUq6PxuP+piJVkqThFqyCt2xVrhmdB9/fdqQuSUc83ic3H+yzM/g4tPYYlAwkTrud/XlWs7fVylw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea868537-9bb1-4e15-0e33-08d809b156e7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 00:34:14.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQFA9PIGg2SOPfqVWuqKT7cTGPy8KxMt2nUVN/GEq7Y/NgRKJX/623GfxNsNh71s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2214
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 suspectscore=1 priorityscore=1501
 cotscore=-2147483648 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006060001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:19PM +0200, Vlastimil Babka wrote:
> The attribute reflects the SLAB_RECLAIM_ACCOUNT cache flag. It's not clear why
> this attribute was writable in the first place, as it's tied to how the cache
> is used by its creator, it's not a user tunable. Furthermore:
> 
> - it affects slab merging, but that's not being checked while toggled
> - if affects whether __GFP_RECLAIMABLE flag is used to allocate page, but
>   the runtime toggle doesn't update allocflags
> - it affects cache_vmstat_idx() so runtime toggle might lead to incosistency
>   of NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE
> 
> Thus make it read-only.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/slub.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 38dd6f3ebb04..d4a9a097da50 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5223,16 +5223,7 @@ static ssize_t reclaim_account_show(struct kmem_cache *s, char *buf)
>  {
>  	return sprintf(buf, "%d\n", !!(s->flags & SLAB_RECLAIM_ACCOUNT));
>  }
> -
> -static ssize_t reclaim_account_store(struct kmem_cache *s,
> -				const char *buf, size_t length)
> -{
> -	s->flags &= ~SLAB_RECLAIM_ACCOUNT;
> -	if (buf[0] == '1')
> -		s->flags |= SLAB_RECLAIM_ACCOUNT;
> -	return length;
> -}
> -SLAB_ATTR(reclaim_account);
> +SLAB_ATTR_RO(reclaim_account);
>  
>  static ssize_t hwcache_align_show(struct kmem_cache *s, char *buf)
>  {
> -- 
> 2.26.2
> 
> 
