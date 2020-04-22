Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B5CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A909E206B9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JlXEuF2M";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Eb1s0T9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDVBD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:03:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48394 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgDVBD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:03:29 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M10q9I017826;
        Tue, 21 Apr 2020 18:02:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lm6yKrGvoCscCY5AQkoqYEr5rx5671S8biMuuDyjZts=;
 b=JlXEuF2MlkqEdfi4gDsZWjxJqZhkU7zBftMquCVvbWU6gk1owTfEdal/4qyNXxba0w1/
 6zxDWWKJPNS1CBMY6ZSFLYDZE6uAfzkXGC23/B/g9GE7xG00HjzooHL3FhbYih73i2r2
 P6cRYoMvFXkhkYkxQ9FnB597oagrNi5rGiM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30ghpwp9v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Apr 2020 18:02:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 21 Apr 2020 18:02:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARnPK67vLvnZIpNZ3jo0CWNTrsN0B5XHqkLLNPIAnhOQ7nrr1GsO51ZMfG2JBC96Dk4gkZ4rqmtt1Rs4NIE7G2T6pWtPGi41S7yfYVZtqhLgX/XGxBvJ3MKr3uWqeJs/1hwttxTxT82Lqdvrtaepjx2YIDdnEBAi8skat82adg/4GlHahzNeOHnyPp5rcMsjA6Qrfo2VVnVJbDPyTOE29i6dCDCfvxxeH3pV0gibBwE9GydDbTvOpizfvsCO7FOb3R+7yKXFuVnhx4PpQpS6wmo2wIQ2nRTZVqQohiGZeFHIjAJ2KLcNfF22JRTDoO3/DambcduAZ3ob7ZqAIbLLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm6yKrGvoCscCY5AQkoqYEr5rx5671S8biMuuDyjZts=;
 b=S1mxTMxgJHMjCrbEHYDVDmd+1amFJFW2G8D/ulgyrbgRQ1MBnxTQdr2V/6W5rQFkWlgtGh5k1+QQatqlB6kEt/KSbmP37vW6ePvub5R3gGOlfCSNony1vKo8HPc5kmJ8XjaFWOpoVp/QgbE9mGQatEFOciIAa5mghQVsS758GFKgBvna6UelMWpyAEPKpXro5g0CUhPxzC06GEBl2GhahrYiV4H92nqdfhZpPYhddDkvuYNsFGcurHeXkvDB2PjAneUVtSpjq7y8aqf5qxflm3aPxJASWosCvB71lc92ahhU38kEYY84UR0EHROErWqPgP5+oVl0JBpD3waTmdDyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm6yKrGvoCscCY5AQkoqYEr5rx5671S8biMuuDyjZts=;
 b=Eb1s0T9R8beg4E/V156a9kolSsU9CtYb9Ty/pwdHktRN00XHSDSAnIYBvXtaznH2bYytEXTX3eF/d9EsaE26nk6UHfZiRuoiNcXNSYF3ntTzXcPXHYNd4dF8Cl8Rrceb0PdADbSKDjDLydqqweZi4pJxRlY4t+dbCKJBZup03W0=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3127.namprd15.prod.outlook.com (2603:10b6:a03:b0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 01:02:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 01:02:39 +0000
Date:   Tue, 21 Apr 2020 18:02:34 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <js1304@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
Message-ID: <20200422010234.GA23005@carbon.DHCP.thefacebook.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20200421090005.GA23085@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421090005.GA23085@infradead.org>
X-ClientProxiedBy: MWHPR2001CA0024.namprd20.prod.outlook.com
 (2603:10b6:301:15::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:75ea) by MWHPR2001CA0024.namprd20.prod.outlook.com (2603:10b6:301:15::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 01:02:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:75ea]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fbb1b35-9b77-4510-a25e-08d7e658daa9
X-MS-TrafficTypeDiagnostic: BYAPR15MB3127:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31274C8C3EC07F5048A4B8F5BED20@BYAPR15MB3127.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(6916009)(5660300002)(316002)(478600001)(55016002)(2906002)(16526019)(9686003)(54906003)(186003)(33656002)(86362001)(1076003)(6666004)(4326008)(4744005)(6506007)(7696005)(8676002)(52116002)(81156014)(66946007)(7416002)(8936002)(66556008)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zLn4QaYzuHgDxZ59yDOsYv4XUQgXR5XOYxgUBNHOkmqm1aqL2vb9pXTkOYdsUriSNw22zeXYgDo9Tun6E6gDvAC+kxe8EZoLtRvL0ZprpjUQlD63r+NiZAkE6WZEK4R6a151an1qlSwQEPaCdLV41LTDzBp+xgeYWLVjngUifE/mj88JpolpAX3Pq80k1jHvpg05vjj03ZvEUnL5f96JX6Ev1bCt2dQmMul6/JEaqYDPp/gJGPW0ndHWWOjJzc0+hz//8DZGT3MZLMhFeklSo/1lITaUqTzRo+7OjBAaweIG9VvjYFRqWMBK5J+johVhy0j3mXZQixSF7ObJKZMyGYMKV+TKuW8rvfuNOb/EHZJ+sxw/k2OF4jzZXQuqPRJnzJFnD60rsmLp+d4I+x/0Q2TRgDTT7EMVmYzgH3BUA6MhDH+sbv8rJtE67fLBdAr
X-MS-Exchange-AntiSpam-MessageData: Lv1LBuXfubrkLPV2vLvxn3A+piJG4jK5+NVIXIz5p8fxtRj3zKsSUAIDaZWeP9akuOfap458l8sAKxuwtOSQjlzO6I0bsWzJg2xMF6KmjZ/zcykEpvqfc8f/oHC6Thtkh9K3KfrRf7XbqnFOqFyNAmvoW1HJFT7nVYRwfjOqbKrXaQJ2in+jvFAxfkizsn9V
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbb1b35-9b77-4510-a25e-08d7e658daa9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 01:02:39.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sndidO0R7WWavBJ59xyBmH82fW6ndL5RXEByXXpIrHFt6eZGSJbkMVSBnNuK5EU/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3127
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_10:2020-04-21,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=793
 suspectscore=1 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004220005
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:00:05AM -0700, Christoph Hellwig wrote:
> I don't think the names are very good.  I'd keep PageHighMem for the
> existing highmem zone, and add something like PageDirectMapped or
> similar for ay page that has a valid direct mapping address.  This will
> also come in handy if we plan to go ahead with the xpfo work.
> 

I agree. It also looks like the only remaining place with PageHighMem()
is using "if (!PageHighMem(page))", so "if (PageDirectlyMapped(page))" would be
even better.

Joonsoo, the series in general looks very good to me. Please, feel free
to add "Acked-by: Roman Gushchin <guro@fb.com>".

Thanks!
