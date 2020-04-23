Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0A7C55185
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BC220776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nr80KI7m";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SM8Pey+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDWAFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:05:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45638 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbgDWAFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:05:44 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N004xq021076;
        Wed, 22 Apr 2020 17:05:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vUB/aPIyKqX+bvEjFw20MrR6zuqRKIu3N8uFP7AIEP4=;
 b=nr80KI7m98YsosU0ngbpO0DkBpJQJEpY2vvUp9TFvMt15ehCSB+2PWOybLYZmJ2aeztz
 6UmJNSPbc9hBOyqARBp0zC/eV/lJgJkgSEiWB8xbVqg0gDdoCrOgWDZ96/iSrAwaxPM/
 qKQ6SPBJlkLFz2q/6JP5AXemYla6/aRcxKE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30jtc5hygs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 17:05:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 17:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2aBgUndQ+bUUp/Rwh/pKfFfIxHxAkhJGOgRcsDLqYI0wI1VleIpfgtrW9rlpQ/bGkEPyOjFTFW/3dggh5Siqx+RG3ffKqUiImcVNNB4hNwOwPK7wOYaMCDLbGtAJ5gjYqEZfDvQUuOV8kRasq2AGmh/gDAHfdW2fA6eaaG/dFFa1h9Irw82e2vu9RtBkanFFetYi1tO/HDQxM0r62gpvTT1EAiqIsBVpbcNlJaNBqPiZp9WT69OefhMxqmjDSa+RnNOtXFY0RpwPQM0LacM1j4WyJzSfkrh8WMwxXuI5PwZqjYm2w5s3uPv/WZhY3rNb/rr1RGmgE+UlqlYcututQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUB/aPIyKqX+bvEjFw20MrR6zuqRKIu3N8uFP7AIEP4=;
 b=KXxgZs/9mgURD07AQdg724dQqczK6mPEiyfBNsCJXc4mhW7JUCs2UHfM041lI4pUEUKqSQ7nfLwDj4nyp/JcUbHVW5W1UtVWZPyBVj8xleAoyix8+N8iZuGzKJyd/I9TscsxGz+HLXzlaaKl7f2g23I99KgUzIqAq6Gci8iS74dawtGJQD6K+yVl3VLiwOZ+jpTp/OHU4jnJNtmeyBUrX2iMpS1ajixYe//SIWoUlcD0EET+w6IoxIWZv7mm2JyuVli9NcLVbHKjEE6p5PPb7ixQBYIlG8AcK/3K1yMEkz/SuibQxxqIKHsCS3f++4hZz2gxxslOS5e1zXXn1g6elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUB/aPIyKqX+bvEjFw20MrR6zuqRKIu3N8uFP7AIEP4=;
 b=SM8Pey+fd8RZASiliZ0QMTi/jhi5R/D5OiCQa4uF5JU9UIUU2zWRrR4eaofrEVtJ79DRNm52nmteUVNEjlDSOVvJYL0EgRcAiXJ/6xZORVY/iXplxlskyFG3XgrQjPbhA1t+IPnkGqe6Z6yNpQX9XbvE9cJkpAr4Q7LIg/ZY8zA=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2903.namprd15.prod.outlook.com (2603:10b6:a03:f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 00:05:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 00:05:35 +0000
Date:   Wed, 22 Apr 2020 17:05:30 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200423000530.GA63356@carbon.lan>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
X-ClientProxiedBy: MWHPR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:300:6c::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:3fb8) by MWHPR04CA0062.namprd04.prod.outlook.com (2603:10b6:300:6c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 00:05:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:3fb8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2caed472-c5e5-4091-8c7b-08d7e71a0bab
X-MS-TrafficTypeDiagnostic: BYAPR15MB2903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2903CB66AB1E44856DD8EE3EBED30@BYAPR15MB2903.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(5660300002)(55016002)(8936002)(36756003)(66946007)(316002)(6916009)(9686003)(4744005)(8886007)(4326008)(33656002)(478600001)(7696005)(2906002)(6506007)(52116002)(1076003)(16526019)(54906003)(8676002)(81156014)(86362001)(66556008)(66476007)(186003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NT/X7PQwXGaBXJ0Jfmm+94Z31wcFeg5LAo8gh9VlBtv1E0w7LDJzlBf2Wd5dpjDtfrXNem2oJschQM1j4A2DW14PLFNVfqG6c/yAMKzcBLOOPfuhBiubvJkL2Ku55QMVysbQSr9oiQUSUMCL4b9fYnS0+DcQWSFhg6TCWWxy2lCQlu2wK5a0ObuPxrh+s+YwvF+OahzS+QfJxlaCNXUYSENtt4vsBiZp09c2a9RfopwOL4xHaVUCbCtGUK+qSZ6boRUN3Rm3T3+UyYf0RSZhbgXX+HD7YBGqhc5cx4D3VMQ50zf+8ru4oU/cM/PHlZY3KQZH08pPBrQabPiccxIeXYvDRCIUzi7XhIlAAsvJwHR4XvrgO71is/hrk1XAAZ+LLrtoSAlxvpCR59FA0isNhfeIIk9yzM2WgnElWRAlTWGSzjhWOtKt68TlLbd7+8xl
X-MS-Exchange-AntiSpam-MessageData: qnJsUn56UFHMphE9ZHTPIMuj4T3iFrKhgwK58bxLRWvoq7g8T7rW1nkH9v/C4HaNDwjgr5I+v9RPSya9axkurEaYm1RZUUQPtFz313jq+0GJe79gLzoDAGehSjPSPZkHEYaB+MGeR7nKJMm8yRR4iLmvsd0wG1luEKNRqzzupiDwXlCv/EVfX5ptQPlT1GDQ
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caed472-c5e5-4091-8c7b-08d7e71a0bab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 00:05:35.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYIY1FM+Y0SWjfxkIY7ydRa3CmPz534ny13klxdkCOD69TrL5YCoYpqCIx5ZALL2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2903
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_08:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=1
 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220184
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 11:52:13PM +0000, Christoph Lameter wrote:
> On Wed, 22 Apr 2020, Roman Gushchin wrote:
> 
> >  enum stat_item {
> >  	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> > @@ -86,6 +87,7 @@ struct kmem_cache {
> >  	unsigned long min_partial;
> >  	unsigned int size;	/* The size of an object including metadata */
> >  	unsigned int object_size;/* The size of an object without metadata */
> > +	struct reciprocal_value reciprocal_size;
> 
> 
> This needs to be moved further back since it is not an item that needs to
> be cache hot for the hotpaths.

It could be relatively hot, because it's accessed for reading on every
accounted allocation.

> Place it with "align", inuse etc?
> 
> Hmmm. the same applies to min_partial maybe?
> 
> 

And min_partial should much colder.

So maybe a patch on top of the series which moves both fields can work?

Thanks!
