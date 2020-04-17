Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAD9C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07140221F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZsNpV9Zq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="a8Ws7BK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgDQTVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:21:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26422 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbgDQTVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:21:41 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HJEpbg030424;
        Fri, 17 Apr 2020 12:21:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=VyTbFaHNEHiypWN6s616Rxi49QtBfOxM7B7MyS8gwfE=;
 b=ZsNpV9ZqOB4LGV9W0YF4+z7hVVvfXcxmVW3O/mSdmXuWAjUXAtNctyIEGhOWuaCe9ty2
 SVfFEQp9Pdlt3ILQGcaXuITuC6qBtHxFTl66fbqezVK/XVaQ4uwkHe4sG+UFOCFjZlcN
 dNq102mWfFbEvGv/yg4YPzSuAXd6Yg6hnAw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30ff1q1ajm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 12:21:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 17 Apr 2020 12:21:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6mbjNdEaOxRdLGfEBdpzsRmID0UAl/ZNSq8G0czkq9YcAMzQHpkCuAXW0DLohO01S1ACegsub6ShafMX2hCbLdMpi1OmJfvJvU5SO6kgJmxsoJzOz4PGg2299SPsBjO6fFovNCpKcFxRlEeiOcZ0sY4Tz+5HQo5YUvVd2NHRZRzPj0VtEvM3fHg/2KCljsgjp+RYKtVaZMdeVZNTPcFCnG7+97jG0yfbcRvgp/F27w3QDxDI1EmlYJ+7FuiifrwJIl4goy2f4YvSMbmGwC0biU4/HQnwD1xFCo2gZhBJbw18TaKMbt6ywALEzi0GsCCTTyI/gGQN2cBamMkLdMfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyTbFaHNEHiypWN6s616Rxi49QtBfOxM7B7MyS8gwfE=;
 b=df2roMwUghe5QCyreZwN840DC+5ubLFyD3Eb6VaLfm2kvDQRx8z47/p9WKfzc7XKqffi+Bv0GZIvJmebOSwmcxTMyflAi+8pkS2Rf/q5Md4J6TPxPIBREkhfy7oHNt4T7+pzmIarmBgzQYyVV2HInZ9ROBlmtIY/trU88OyRJNvYwZbibxLwweLwINrQn8PIVlJL4CujZJHkCTfb7j6jujPYJiGvIeElcXLG2g3zf6GmaP2LQfYIVslUi22UpuEyZKdn++0RWWzqFcbzMVGvB1AFOkwZ1SydZcjh5AQ8QCNVi4RPeID9eAOIsKyv5FFwHBWh9UkCSegpn0Kxekd+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyTbFaHNEHiypWN6s616Rxi49QtBfOxM7B7MyS8gwfE=;
 b=a8Ws7BK7LbZ5iSEDJyofhgWB8pPb5rYfWzohM8DW0gjNEcdGS3fPmJaRfV1d02g0plQgEkOyFoLq4CUCksBsW1hMedW67MHjqAaqKb0AjmmxJvKQrWuCgBCuCcqdjIH88OveIvzdV132xWMh5cLQo9W3mEu0tsIDq/FefDannrw=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2888.namprd15.prod.outlook.com (2603:10b6:a03:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 19:21:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 19:21:20 +0000
Date:   Fri, 17 Apr 2020 12:21:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Qian Cai <cai@lca.pw>, Andrea Arcangeli <aarcange@redhat.com>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH RFC] mm: compaction: avoid migrating non-cma pages to a
 cma area
Message-ID: <20200417192116.GA338526@carbon.DHCP.thefacebook.com>
References: <20200408194119.1076232-1-guro@fb.com>
 <225868db-b9b0-3614-de0f-4b264023df2b@suse.cz>
 <20200414154204.GC42877@carbon.lan>
 <c60fc30f-463c-31cd-0100-d26a92b83c9d@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60fc30f-463c-31cd-0100-d26a92b83c9d@suse.cz>
X-ClientProxiedBy: MWHPR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:300:ad::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:8544) by MWHPR15CA0029.namprd15.prod.outlook.com (2603:10b6:300:ad::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 19:21:19 +0000
X-Originating-IP: [2620:10d:c090:400::5:8544]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b00ccab-dae0-4bd7-70fd-08d7e304825a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28886A0F0E6D3B2408E5BD51BED90@BYAPR15MB2888.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(366004)(346002)(39860400002)(396003)(376002)(33656002)(316002)(54906003)(2906002)(7416002)(16526019)(186003)(6506007)(66556008)(66476007)(6916009)(5660300002)(66946007)(52116002)(53546011)(7696005)(86362001)(4326008)(478600001)(1076003)(55016002)(8936002)(81156014)(8676002)(9686003)(6666004);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UznMrLbPm3uyhaSGq9duS+0h3gSpiPC+3La6mfxPGDJ745qlHodzs6tTu2E38KEnHIJCyfxkqBUkXv9lksYrJIP+f9kgv0g6bEy2sP89NmCu22m31wwOa+CP8o0z1a+ct8T4tLks2JdMiWLaKYDdyXnY6KJL7XWUoL3lsMgcYPJPW00MMiJIRf5HhKmS9kvqRSdP85E6QM0LgyvR701uf2yh28u4uA8j1ejSDLscPZPP7TDJAFTxMn3khzqYyAjI+Ge8oQRYu7rZxR3/Z5idO9iIXzvBp+om2oWE+LPVB+X2P+71fa4e6PHOE5LxZQXov8gdDXWRToK+TKSMlPdDCumMs4wftB6Fh5oVVxayoad53Y4BYv2MIEHx1KgIRAGo18ImRvYEOnxJnM9jwuB+3Tz2VwVBCbs26TyR+eRoN9Eg9yKnyXAuVLsupGH8D+t3
X-MS-Exchange-AntiSpam-MessageData: QGyvgkSuD87opyktMDUwOi0Fqi6eb7RXB2NDYg0ve1UmNwqRIgBcT/h5y1chYw7LTlhOSI5KyZDu5KA4weTNlOQAWSyssQpBkuJxMbLhHVoIVc542tBZK+N0/xcAoqmB75eerC/HyxoJxKt7dQjeZmiR74uYKpZ9kpiuL09peOUBaajFsuEZrP0cYukIN/tB
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b00ccab-dae0-4bd7-70fd-08d7e304825a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 19:21:20.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCXK3hEmOHpgzXU/6Chhjt2O8LkKWibo3xXEiBw9bqQDdUri057OxKnQferzI550
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2888
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_09:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=5 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170145
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:37:14AM +0200, Vlastimil Babka wrote:
> On 4/14/20 5:42 PM, Roman Gushchin wrote:
> > On Tue, Apr 14, 2020 at 01:49:45PM +0200, Vlastimil Babka wrote:
> > 
> > Hello, Vlastimil!
> > 
> > Thank you for looking  into it.
> > 
> >> Hm I think I'd rather make such pages really unmovable (by a pin?) than deny the
> >> whole CMA area to compaction. Would it be feasible?
> > 
> > Well, it's an option too, however I'm not sure it's the best one.
> > First, because these pages can be moved quite often, making
> > them completely unmovable will make the compaction less efficient.
> > Second, because it's not only about these pages, but in general
> > about migrating pages into a cma area without a clear need.
> > 
> > As I wrote in the commit log, if a cma area is located close to end
> > of a node (which seems to be default at least on x86 without a movable
> > zone), compaction can fill it quite aggressively. And it might bring
> > some hot pages (e.g. executable pagecache pages), which will cause
> > cma allocation failures. I've seen something like this in our prod.
> 
> Hmm, I see.
> 
> >> 
> >> > Compaction moves them to the hugetlb_cma area, and then sometimes
> >> > the cma allocator fails to move them back from the cma area. It
> >> > results in failures of gigantic hugepages allocations.
> >> > 
> >> > Also in general cma areas are reserved close to the end of a zone,
> >> > and it's where compaction tries to migrate pages. It means
> >> > compaction will aggressively fill cma areas, which makes not much
> >> > sense.
> >> 
> >> So now the free page scanner will have to skip those areas, which is not much
> >> effective. But I suspect a worse problem in __compaction_suitable() which will
> >> now falsely report that there are enough free pages, so compaction will start
> >> but fail to do anytning. Minimally the __zone_watermark_ok() check there would
> >> have to lose ALLOC_CMA, but there might be other similar checks that would need
> >> adjusting.
> > 
> > A really good point! I've looked around for any other checks, but haven't found
> > anything. Please, find an updated version of the patch below.
> 
> Technically there's also __isolate_free_page() using ALLOC_CMA for watermark
> check, but it's shared by compaction and alloc_contig_range(), so we can't just
> remove ALLOC_CMA from there. It's probably not worth to complicate it though. If
> we pass compaction_suitable() without ALLOC_CMA and then reach
> __isolate_free_page() and meanwhile watermarks changed so we wouldn't pass
> without ALLOC_CMA anymore, it should be rare hopefully and not cause us deplete
> non-CMA free pages too badly.
> 
> But I've only now also realized how dynamic setting cc->cma is. So in case a
> zone consists mostly of CMA blocks, removing ALLOC_CMA in
> __compaction_suitable() would be actually wrong and prevent compaction from
> doing any work? Sigh. Any idea about that?

Hm, idk, is it a realistic setup? Looks like it depends significantly on
the exact usecase.

Another option is to move the cma area closer to the beginning of a zone.

> 
> >> 
> >> And long-term what happens if the "CMA using ZONE_MOVABLE" approach is merged
> >> and there are not more CMA migratetypes to test? Might this change actually also
> >> avoid your issue, as said pages without __GFP_MOVABLE won't end up in a
> >> ZONE_MOVABLE?
> > 
> > Yeah, this is what I was thinking about. Basically I want to mimic this behavior
> > right now. Once this approach will be implemented and merged, it will happen
> > automatically: obviously, compaction won't move pages between different zones.

After the second thought it's not so obvious: CMA would need to migrate pages
(data) between zones, right? It might bring some other complications.

> 
> That will be much better. Can't wait, then :)

Yeah, if it will happen soon-ish, we can just wait. I just don't know
how hard it is and how many edge cases are there to be figured out first.

Do you think that it's better to wait and do not merge this patch upstream?

Thanks!
