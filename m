Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3743EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FD72073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kbhzaqGe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="diDXwlZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGBSSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:18:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgGBSSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:18:11 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 062IAjpM002068;
        Thu, 2 Jul 2020 11:17:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SeRwImw+QWuCtlznLLAfvpLB9u70Fr5FNgOO4t6uRBk=;
 b=kbhzaqGeAwYe9FNQ7oSzHwbr0+UR/2UW6WH+7JIKP+Wi5VKBHNcveECDYN+fgsrFRttC
 kryNHCzunUEHRVVDNcNZq2CKnaSKA+Hi11REOpeoLz0kHBFg0fU9Kt9F5WPEweTisgVX
 Tu1tDYrJhjEqe+eF3EiO0dEDiNGvL6Vy0ao= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3216k83rqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Jul 2020 11:17:33 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 11:17:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPYB3aKXP26s1p/vPjxm4678M+KYYOqwW4mL9zpHYO/WewSG96PZ80g9CEZG2AVfUXC9qnIwiJu1e5N1bONpe5HihtVmPnpSQV4j7nd6gpsoNGHEc2R43v9q+jmqhnS1eyCHYhdZMnBOj2O3qHQfGYBe7TRVJwBKscxXcO6TpoF/dO98aUFz87+PnAkZyAWIeXP8AevuZHCdzbLcDxMZZWrgAjkQ9nCe4BoX21Of4MwPIK/Ou1NbQ0Iky6CDJoU8+GITy1A6J51JkB36webNtrgSDvBey0WWJRd+croA+W7DNyWm/frycd/KkrBvtuWtv08gM4ig0+GFqXbFQOzfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeRwImw+QWuCtlznLLAfvpLB9u70Fr5FNgOO4t6uRBk=;
 b=goOsSRcHEbBOfM+4WMhEbKb4Hg4QNuWYg/3uoDS4+U5KfWBy+FB29CHSk3aedTZ0w+pNiLa0HXwrh6x8yvp8eqVROWLVy72ES0/VoAETFI20Cp9dk7DH5QjvCoOz2ANmO02aAonwS4BgOtevFZ1Uvc+FBWxyHq07YpfFNfZcP2Hty2PBzk4XaPbmZoHYKietXRDyxEv+v6XyR/BCqNwiBLMK5ffmlUHZCsj6PSArF3mHjwcNiJR3NOkpupaIp8jWmKaSRy0xKPxHRROlxOFAZk5Ai99aohJQIPuTZPkB94nRnoG29LXRxznTRF7XDC63p5LI/xtBd9dXZjQJgZiwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeRwImw+QWuCtlznLLAfvpLB9u70Fr5FNgOO4t6uRBk=;
 b=diDXwlZ57+iWm2BIu3gWfayEsi6l0sdX63gseKV8P54WZLnAWSptfqO8buGxh91GhPTp3ROEO1s4AkqoPfBsyLArd3sApxCPNJMAdBhyIi/Comzw7TM/W2HhbRQ63B2N5mJwOcLJY51ZGZmrn2TRu4HY2CZ7ZInjAbRYKXUIY3k=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2757.namprd15.prod.outlook.com (2603:10b6:a03:156::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 18:17:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.034; Thu, 2 Jul 2020
 18:17:29 +0000
Date:   Thu, 2 Jul 2020 11:17:26 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] mm: kmem: make memcg_kmem_enabled() irreversible
Message-ID: <20200702181726.GA114903@carbon.dhcp.thefacebook.com>
References: <20200702180926.1330769-1-guro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702180926.1330769-1-guro@fb.com>
X-ClientProxiedBy: BY5PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:58c6) by BY5PR16CA0010.namprd16.prod.outlook.com (2603:10b6:a03:1a0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 18:17:29 +0000
X-Originating-IP: [2620:10d:c090:400::5:58c6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a8e6ca-cf95-4ab5-3c05-08d81eb42e6e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2757:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2757FC0968BD65F8A55E4B29BE6D0@BYAPR15MB2757.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+te24rMl7P24lYMkm3FZLnvqcnNaMKDWSrjrevWi4r6yM1Ilc1YeGj9cBsWUtH8+IxUCeuoKcltFj8b3pRqs0WY00mh9BTq+eaOwY/Kw4ZxRoAGvKCxXSdK/r07dzKVRStHx56mIB6UWFrj6nt1zUtrrigYKfalb/pFKLVCeo8sDDBsQbjYzP2CJmuZVdCylmU5DhHDiCscXYPeY/ex/5mUdKsomdHrsvey0rcLhMD8HaaZ78zcOyMP9uocjKGEUS2hsWaH2eFe5IkX5uHVEq3seg1GkOXKczIDtZCyp/RyCTHCTyagLzKTaCI00fL+KsY+bdOF0qM037wpDG6FHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(7696005)(52116002)(86362001)(6916009)(186003)(5660300002)(16526019)(8676002)(33656002)(83380400001)(8936002)(55016002)(66946007)(4326008)(54906003)(1076003)(66556008)(66476007)(9686003)(2906002)(6666004)(6506007)(498600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4d/TQ5pK3DRNJmu9aCR4ygUYO+PfcBDXdLSt5aS1uS/B4kIrzS3k9Crquo8hW7xtOngDYV/f2e9aQlcR1FXOrtcIW1VsFk6ua0rth+XE0YQ+aMzRRocrvLxLtcp5RGWnP6ig0S6M68Yanzih571lHMtewI3WYPLqLV51XyQy5TAPiZc/M4BIh2F9FotdLu9pOsMSmEYO0xYyReZlXrJN4RULp1WVaZyMo6eP9WcOZkSQBha4epUxOboOvc/WRqwS/wZklSjc/0uXN/3M1onWcKAMf7r206v+1aGAqVgRzeS4dCvIZacUvRhPYOwQKUIy3+SuAFnDNW4ecmPJp5WvPDi2Zhjx3mnFFIsPPGkiuf4Z/J6WRf/h2Y44hr0tButufu3TRR0vTbtGZP/Zy3/3+q6fVUpVplb3aj7wAzwlysjYj/pwFhhHuulbayeGsmQmbwbUjfWa/dnMYx3jb9CCogYflsZ3ZD12vYk8fgi3utE4hQk97PbG+pi8GwKBwOm+m7oGKYQCjM8YenojfDl7EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a8e6ca-cf95-4ab5-3c05-08d81eb42e6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 18:17:29.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5xfuiemC+hEdIXjnFE5yCKbbDaCWDBcx2QQRlqHF/c3m3lMNaRKsGKh0ymNCgYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2757
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_09:2020-07-02,2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=1 spamscore=0 mlxlogscore=662 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020124
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:09:26AM -0700, Roman Gushchin wrote:
> Historically the kernel memory accounting was an opt-in feature, which
> could be enabled for individual cgroups. But now it's not true, and
> it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> user has at least one non-root memory cgroup, the kernel memory
> accounting is on. So in most setups it's either always on (if memory
> cgroups are in use and kmem accounting is not disabled), either always
> off (otherwise).
> 
> memcg_kmem_enabled() is used in many places to guard the kernel memory
> accounting code. If memcg_kmem_enabled() can reverse from returning
> true to returning false (as now), we can't rely on it on release paths
> and have to check if it was on before.
> 
> If we'll make memcg_kmem_enabled() irreversible (always returning true
> after returning it for the first time), it'll make the general logic
> more simple and robust. It also will allow to guard some checks which
> otherwise would stay unguarded.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Michal Hocko <mhocko@suse.com>

Andrew,

can you, please, put this patch before my slab series?

Thank you!

Roman
