Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53CA20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rEYkwShx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EaioTwHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbgFWPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:39:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732978AbgFWPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:39:34 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NFaGHK030300;
        Tue, 23 Jun 2020 08:39:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XhA1ASKbQfD7wScnYVo+F0F811MZVdZ2heKI3NbDIgk=;
 b=rEYkwShxbrRpdOsiJun933UtGSgT7awH1sMXdEgdx642y812MjYXlCsWKNPyHIVcjXOc
 5FDo8iv8RVe8R4W8rrlodRZYLF/4jwE0kdkgvY1ORP74RFiq1/16zIZoQxGJXY4H36jR
 B4fiyLqrWFKi0hsw68YIsBuYTvMYAktvHKE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk2r0gax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jun 2020 08:39:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 08:39:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiWyUu77q54lJgs2xT1ctSMBRCxO59g3dtaH8mWotDIhFKI/2wARbAgisuBOgKndXzi6PQHP9Harhl7azJljJEOzM8dC/FhtUleNesCvCkkSDwl/oNzOvLSrMCVaxCRb9G4DjxLZDOJYI/9Z6a3BY+B8wQulWI8p5gxyRTlCaTOmCxR1ezvqJyDcTOKBE+wOWLGr+Av2pPn4ttB9DABM2YOtpvedyi9tK5EBtig2wkZrkksWvNJ/DY821Q4JBwhhiKsZ2ky9rz7CWAUR3BWgavG8i4JkKM1z6QOZ7wOpvYBLDjidrWVoHltXmYZCvlz8WYInka4lqY+zbC+pGDAnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhA1ASKbQfD7wScnYVo+F0F811MZVdZ2heKI3NbDIgk=;
 b=N/JGepcktvcVWgD5JiuLNpXo056D3KMd1eLUlrAHE5K3iNIOHtRLMWSvaa9QJWWuE7zfm60oqTUEyaNKjXH8aeFa8zV77xTV97Ds5rpRmGcec3AQ9YAiUrjak1DeE0or41aUW5dSUEeak4lk5quE9r067ez5Ppg6w+UxeCoVYrfTQtncE7l+saNfbk3Ho3rVryR3jY3GEZRmMLjxHorJr4O7ETiBthAkO3DXHQ7DDg+aw9zRiWt/bK4wWpSlaysu/nQCnAgnYszUeobdUTrdBAAHWd0G93EpeS69EU0r2eSYRA9shQXlMcQJwjT1xhp1IDJbdPRFT6VYEo8FFOvQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhA1ASKbQfD7wScnYVo+F0F811MZVdZ2heKI3NbDIgk=;
 b=EaioTwHEEeQK1TPogNwK39g7XRGPi0luE6X3yclS0OTJbwsDmTOSYAF+yL7D1TicNpqjjN/lPfIMvdsr4a3M7mzvmfTa32KCo42PCMzOHfs1oYmV6ngcCRrzqCOVJJ19qBwvV3pRpd30BxzUqrilix7+eLXVdPgWa2O/GL2eYkI=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3349.namprd15.prod.outlook.com (2603:10b6:a03:110::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 15:39:17 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 15:39:17 +0000
Date:   Tue, 23 Jun 2020 08:39:14 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v7 00/19] The new cgroup slab memory controller
Message-ID: <20200623153914.GA345679@carbon.dhcp.thefacebook.com>
References: <20200623015846.1141975-1-guro@fb.com>
 <cd62f7ee-0851-69cd-14e1-e926ecdfd490@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd62f7ee-0851-69cd-14e1-e926ecdfd490@suse.cz>
X-ClientProxiedBy: BYAPR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:161f) by BYAPR06CA0016.namprd06.prod.outlook.com (2603:10b6:a03:d4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 15:39:16 +0000
X-Originating-IP: [2620:10d:c090:400::5:161f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6a27621-493a-49ff-1cd0-08d8178b96ca
X-MS-TrafficTypeDiagnostic: BYAPR15MB3349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB33496614507B1EC91C518BCEBE940@BYAPR15MB3349.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiurp+w2zdaORulnhok3IvuzYEcPc+SMwFntZw18schzH7Or5lbZLfW2K2S+y2NIbbgKb6X9aZpwHUzOeGVfteNrsFWBMAgNHTfFkvEF25qjX1pHBBgThYBZCjfbfrqjDJlG0j2pUh6IoXugZfUbdCuN+cG+Rk/9+JoskWFhc+/D8Law0u4qS8f+6ay5A5lAnngaSSOZ5GSEgb/rrNcmHD+La2PB5Wi7xAjMKPfyEI4X9U8Slwno0ei2V1ZseaGO6YFb90k+86drQ1UQ5DcEiFKa7wFbIZdvQaMyJ65K9eKNMB+9bVbAAoaNZ/yaWzGx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(396003)(39860400002)(136003)(376002)(8676002)(8936002)(1076003)(6916009)(4326008)(66556008)(316002)(9686003)(86362001)(16526019)(186003)(54906003)(55016002)(5660300002)(53546011)(6506007)(33656002)(4744005)(66476007)(2906002)(478600001)(52116002)(7696005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5wOhXCn3tKWjkzbNpInrok0CIWC9daOVgWfBAN5hSp8Ap9nT/JCGttkkCyhi543D/IkLBZnlPJJHSvU0uL8YcAtpcOaVUovYEZoui0IW6ZJ+sUFYQDbKXERGP45BBKBPRrTe87Gh+vS8SjlS1OnBjqVGFhH7AoFBzYqvSB8zF9mJ/XF3+y3Z8xQsFehdWcf7XjHHA0UudhX/+UK7UNzfnAZSK14MKUyoDqzh1niaulse2GXkOONW9z6aRMQZl8lMQetYL6YZ+nevV5kRCup+2VKyluNJuUr648fu4CnmllXl6doSoycv7Tf45dS8WtjGW5hKxW6j8XrqdOgi1FgIeV3kGiRUYC59JFcXhFCCssLqa2SQwR+XxsZ8Olu5+m4mmskug2JwlbFZJuxLtgm+fg4lzczRzoaS8vagndVRfjNJnUucGnRckXzzIjcPSVqOWaDyJnkeZEQsxZFTI8RwkT/82KXeLf+8QdwubTXB56yo9hCsQ8yUSWFaQCYAmXXe9h3dfNMXG/1K0IrXc0M6Yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a27621-493a-49ff-1cd0-08d8178b96ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 15:39:17.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsX92bXvvQlGmn0i6GuQ0O8RcE1sSwViwyi6hgZej2cix2OZN+c7Gn+l25YRpqPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3349
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_10:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 suspectscore=1 phishscore=0 mlxlogscore=759 adultscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230119
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 03:53:06PM +0200, Vlastimil Babka wrote:
> On 6/23/20 3:58 AM, Roman Gushchin wrote:
> > This is v7 of the slab cgroup controller rework.
> 
> Hi,
> 
> As you and Jesper did those measurements on v6, and are sending v7, it would be
> great to put some summary in the cover letter?

Good point! Let me add this and resend.

Thanks!
