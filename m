Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF71E20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ctwov784";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Q2xwI3Nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJQTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:19:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14606 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgDJQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:19:44 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AGANEK012391;
        Fri, 10 Apr 2020 09:19:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=COkj6VR0vCjeiDKw6GABGPHuKGVKyTGAHLaWvbMimm4=;
 b=Ctwov784GHh8B08r/7/Jwjw2FYXgsurUPXwgdRxzEa2xthtWOlZv775VC4CJTsDBEwur
 wreG7ouxYnRVFJQOgVDYHGcg14UfEM8vI37p8N+KJ0Cb9ziAqTeEJTrLW6WPTrMMMyC1
 vXAxrcKNnOBoB8WGnbLO1IclObL/Guvkav0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30afb82rus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Apr 2020 09:19:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 10 Apr 2020 09:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/be5qzFhZk+EKWLi0vTQ/SOEICSepuCe9T2bDZg1AvJxQZXcsn8fcdkdxFu3P/p12xwnUAmF9qXTdnjOiEXvUtrP04Amd7W620g5mrEVnQ8AffU906lbJQAywRlL6CVqQTwRLv8trffawEkIelazPrAMvqPiG32Wiui1kq8b1f9jg5gN0A/N8uDmTP9I9AOMogfz17DE19326kPVxxL9IdBKMk+cdVE2OzihrAG5TjuLed7ohc2hfRG5qeKO8IdvS8Yo4GmK5nyDcJNbZJennRfI/AZsFxl6rWGo41mJZFi7/OIEo4UlKzowpA8oYp5veQS0ObdY+3clnc79d1Pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COkj6VR0vCjeiDKw6GABGPHuKGVKyTGAHLaWvbMimm4=;
 b=FH+6iP9dcuFkKgrqovDGwQzz4Fcldy3o3970q9Y0Z4OTNRTIeT+XU3zG65LtF5oEl97LqXIT8rdFzqFMyoXP+7Bib1/M6oEUhT9f0PqaQEYrVsv8KbD2uqf7/m38C3Y/gltoabTgcdANAuO5BkfHyJoM6Qq44l4gxnhxHWRbLHUfj5ijW2/hoNAbmRykth25w1gFnWx2mJ03vRtTueQRW2+tROJa/P3/LQlQyzX8we/cnyCTO4+BBSiNiCa6K3mKu2NF2AYhVaxPx8IDoci5cmTy8vjGu7ZuWut24Mc5BPtz6TNgpVVXOiRq5gtKtKNpak7mhpj2ry0UrhQvCgZXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COkj6VR0vCjeiDKw6GABGPHuKGVKyTGAHLaWvbMimm4=;
 b=Q2xwI3Nz5Zb0vsavGRFNfVKbViM01uCm0/JfA3fo2aVFhST/nRhJBTFCF9bim4thdo74eAjv5G3HpBA3HAgLhrhjjSKi3hsD9IrZ5rRPzyXASBRY4fU25S55USYlmQx6WDeg51A7rKp6eycW/sDTS1UUVl0dv4mR5LeahZl8fSI=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3046.namprd15.prod.outlook.com (2603:10b6:a03:fa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Fri, 10 Apr
 2020 16:19:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2878.023; Fri, 10 Apr 2020
 16:19:28 +0000
Date:   Fri, 10 Apr 2020 09:19:23 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Yang Li <pku.leo@gmail.com>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        <andreas.schaufler@gmx.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, <js1304@gmail.com>,
        <lkft-triage@lists.linaro.org>
Subject: Re: mm/hugetlb.c:5580:3: error: implicit declaration of function
 'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'
Message-ID: <20200410161923.GB14685@carbon.lan>
References: <CA+G9fYtfG4nZs0ON=bBNarPaycNOgGNvhXxcdrGzM1epDDBt7A@mail.gmail.com>
 <20200406172525.GA338360@carbon.DHCP.thefacebook.com>
 <CADRPPNTSOJsz3kihZ3vXK0i6zWpUY_C36GxqmMO6ehACPT=aBg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNTSOJsz3kihZ3vXK0i6zWpUY_C36GxqmMO6ehACPT=aBg@mail.gmail.com>
X-ClientProxiedBy: MWHPR19CA0060.namprd19.prod.outlook.com
 (2603:10b6:300:94::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:2a98) by MWHPR19CA0060.namprd19.prod.outlook.com (2603:10b6:300:94::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24 via Frontend Transport; Fri, 10 Apr 2020 16:19:27 +0000
X-Originating-IP: [2620:10d:c090:400::5:2a98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9a42dc3-caae-45f4-e22c-08d7dd6af14c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3046:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3046A82356B861522466B13EBEDE0@BYAPR15MB3046.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(136003)(376002)(366004)(346002)(396003)(8936002)(4326008)(8886007)(9686003)(478600001)(16526019)(7416002)(36756003)(186003)(8676002)(81156014)(1076003)(55016002)(66946007)(2906002)(7696005)(33656002)(6666004)(6506007)(52116002)(316002)(5660300002)(53546011)(86362001)(4744005)(6916009)(66556008)(66476007)(54906003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SfbyAr3vYbUDvH63ankBm9zBwByC9GeLhyjd98LEVivRC8G8EpYdd4fpBJmkLhCI9C6Nm0O/gz83Cs+66OBFCEdJhTOCECQmeaZCAyR+cAIxoXChg2UbbVtEHgqu80SKsPhapW5fMjRCq+q2JIDVNBqM9UcD5lqwzWfUHtwWSuxegnYbhdenEMqbUxZKrkeXwjHudO8PQTpSXmtx2Fw1sP+E6Y7GfywG+SgOvGnonAClqAMuAThRwBHyPdbba9PK+YKdkpNQ8sbkC3qRl8bPKtg8foDMF2yyIHK7SQw8dfAIyroBFO5FqqYFB9QgNztnZEOsiFEz9CxHSADIKU1OBq3lWCmOIxjCieazyGYvQmPSv7Zy9g5v+XLOvJ9XGgmvvUbGjJq67rmxB9QICoW+iijHmIThAokW96kzcw5gvkcxv7wfvFw94091vC4yCAK
X-MS-Exchange-AntiSpam-MessageData: IqJdiw7UZ24jHhVZ53KPQySghGXMg1z+t6HwpQT3v2LTHcjnaBcMbCnFQFdo5gKq9bdJ/VZmKYJDpNN5Bz8wPQ28JmcqdCqvzZN/ZlVmgl7+88LGwWu7FIoOPkysFk8Iyy7ur/IiDiHhv39iSQg3HSmNV5FK13HjLw9i+KlqaqDknregV79Y2ZktW3WZid19
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a42dc3-caae-45f4-e22c-08d7dd6af14c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 16:19:28.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qblGXmIbeQDy2Gy7O/Q+SaLuAyhsflVFy6H3alqHb4qKD1PPKYnXytAILCb0cEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3046
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_06:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 suspectscore=1 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=733
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100135
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 05:06:17PM -0500, Yang Li wrote:
> On Mon, Apr 6, 2020 at 12:37 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Apr 06, 2020 at 07:48:54PM +0530, Naresh Kamboju wrote:
> > > While building Linux-next master for arm beagle board x15 the following
> > > build error was noticed.
> >
> > Hello Naresh!
> >
> > There was a number of cleanups and fixes to the original hugetlb_cma
> > patch, and it looks like some parts were lost.
> > I'm going to gather all changes and resubmit a new version later today.
> > Sorry for the inconvenience.
> 
> Hi Roman,
> 
> I'm still getting this compile issue with linux-next tag
> next-20200409.  If the current patch set is broken, can we remove them
> from the linux-next for now?

Hi Yang!

The correct patch is already picked by Andrew Morton, it just haven't been
propagated to the linux-next tree. It should happen automatically in the
next day or two.

Thanks!
