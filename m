Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632CEC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245D420720
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="e0+jollx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RGHdvH/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBCWjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:39:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbgBCWjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:39:10 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013MaQbe032130;
        Mon, 3 Feb 2020 14:39:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6uK26NfEZFSQTDF18kDt2/imzB7aANwVwiR5mJot9ZQ=;
 b=e0+jollxekekSCLaCPxznowfXYBfZRJRpgcRyb/pHiimAY+R4OewqcjmND2mw5oSYjCI
 Fi6My8k0XUA7BR2b3e9AtTtvUinv/vv7XAskfndfIBlY/7W/VLcJmSXYFeYmlIkA0YQZ
 PeBaK/spv65/WedsnzdYrGyTxUAF2/nbkW4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xxm8yapcp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 14:39:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 14:38:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx1thRfPAIAdndJtN39429qIvt5W9Rd6KHF/a/kpZ6LkzAAkI5cYFbfXUqh3JNlaCAsxT3IYe/W6IcPJzpHMkS6kt+CDwh2lHhN1x8TtnS4s9Fp/MM4hm5nD9/6jQpSvqD3WmwR8uCjRHZGeq/+nROLMWoi1vtFSqckTFHPH7sIKQm9aIoh4Acl3nBhmtVFSH4/sqzFpsY/NVlrF1SzdN1nd9ywBPmSNUcX5baIWcmyytN7eocPOyBpBCLEI5ucLjRA6l9REuuPv/KRJJc1N9IZHQsh8e7d4iL64aDxYvzT9RZj3KZur+S5Vy/GJIJdM1RltlGUTQFGuYgUPyGvJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uK26NfEZFSQTDF18kDt2/imzB7aANwVwiR5mJot9ZQ=;
 b=OV6wwVhyY3Lt7+xYBu/uugLHrusk8MxvJsBUq1gXsdVqZn2/fcM8A86LoD8JR9s1fAP1bTeiurqfmCCN1KJEfiTloaRP0MSo4BbIqgUtFkG0BxLrbfQ0jKbNVDpbgyOGgRE9S16NGlCPsTju5/8h5zfBfh1Q6x9UCuLPz2rJHS3uOcmFD77AFOV6vDv7z0+py3cHjHboILNmTjn+4WNIVmDhw/aLcKcAhZyOnjLdcAmtLbS9+6qysoK6wNDBcyeJBck54loAn/MOYOo8RULVJ0LM7HRqL2eHkCRpNNhvOep47NatOKyXCmihueSVUeL9EhS96f2m7hK4gaCi7cpBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uK26NfEZFSQTDF18kDt2/imzB7aANwVwiR5mJot9ZQ=;
 b=RGHdvH/BE1QvJ87AbyuwDjHUQ2kpJq46zif1Mi0X0XTaxOcaekevWQvLqnWGFtYQaJgnf/nrAYCMemEMAQizI8fkXKfe+ssBphMxyol4EKpOnYVdwUHnPs/KIWEPuaI5xY15b04yLDdfexZrjsTAJ6fItrfTBHCHFzHwU04GCyM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2485.namprd15.prod.outlook.com (52.135.194.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 22:38:56 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 22:38:56 +0000
Date:   Mon, 3 Feb 2020 14:38:49 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 21/28] mm: memcg/slab: use a single set of kmem_caches
 for all memory cgroups
Message-ID: <20200203223849.GE6781@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-22-guro@fb.com>
 <20200203195048.GA4396@cmpxchg.org>
 <20200203205834.GA6781@xps.dhcp.thefacebook.com>
 <20200203221734.GA7345@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203221734.GA7345@cmpxchg.org>
X-ClientProxiedBy: MN2PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:208:fc::25) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::ca34) by MN2PR02CA0012.namprd02.prod.outlook.com (2603:10b6:208:fc::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend Transport; Mon, 3 Feb 2020 22:38:53 +0000
X-Originating-IP: [2620:10d:c091:480::ca34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bd61cea-6dd3-40d4-89a0-08d7a8f9da14
X-MS-TrafficTypeDiagnostic: BYAPR15MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24858B0D8148C528E88AA7CDBE000@BYAPR15MB2485.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(5660300002)(478600001)(66946007)(6506007)(54906003)(8936002)(316002)(55016002)(9686003)(6916009)(1076003)(66476007)(66556008)(6666004)(52116002)(86362001)(2906002)(7696005)(4326008)(8676002)(16526019)(186003)(81156014)(33656002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2485;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MXGndJOdO3U+jO1Z5rwQF8OWyK3dcnqya/KO5Omh5zJePOdTpo2RSGvuzDHSg1G0WZOO8R3BvMYN7A91+T+VHF5VYQfRUe5oaOYS78Vuh4uHk7KhoenCxynJpavOaa87et3RJFGs2BShSN+w69bf3W3svmBAxyWJnMuV/7zrOp27vDJWwz9wKbqKPTwxOKpwFbiSoV8vYfZklcNWDF3NP74fOaicn/XR1QVa+a+nHCwzVLv8ZY6is0xDrCRcTDdsgKyrikeoPo6u2nQERfuJeEVV/TptxwVp/wWBwcKbTKCg+lF1jyqNZ4GoXsagWGwVMVzQM3wmKa2os4gB8pwDNluWZyTO9s53xFYfjuQAZVR0TblPASsvPPGKJvMGrP87UzEJcshAyhFXwVU+UXG0t6zaxWIpccktS9sKeh1c1oNlP0x1taB2508YCp7oL2c
X-MS-Exchange-AntiSpam-MessageData: Yjxl8TkZAwrz3xKL3L9Fzpe+SPUjMnKaNgHRgDNC2rPKd6e1HafUFtA+HXesDXpPAYdrfM2Xr/sDUSMhYwByXMccpE844dnYOxava0r1LdJLsIqXGrmdSCE6kRFOVjoW19zQR9SsDOmNRtDp8S49OwvCrshqcw5Cl1MJXHWHGVo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd61cea-6dd3-40d4-89a0-08d7a8f9da14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 22:38:56.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVnrvojwpOg5cj9Xed/bkGQGio/YRnGaX6EahfM8Tajzyj2lXgk7Ry0c28/o8FzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2485
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_08:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 suspectscore=5 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030163
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 05:17:34PM -0500, Johannes Weiner wrote:
> On Mon, Feb 03, 2020 at 12:58:34PM -0800, Roman Gushchin wrote:
> > On Mon, Feb 03, 2020 at 02:50:48PM -0500, Johannes Weiner wrote:
> > > On Mon, Jan 27, 2020 at 09:34:46AM -0800, Roman Gushchin wrote:
> > > > This is fairly big but mostly red patch, which makes all non-root
> > > > slab allocations use a single set of kmem_caches instead of
> > > > creating a separate set for each memory cgroup.
> > > > 
> > > > Because the number of non-root kmem_caches is now capped by the number
> > > > of root kmem_caches, there is no need to shrink or destroy them
> > > > prematurely. They can be perfectly destroyed together with their
> > > > root counterparts. This allows to dramatically simplify the
> > > > management of non-root kmem_caches and delete a ton of code.
> > > 
> > > This is definitely going in the right direction. But it doesn't quite
> > > explain why we still need two sets of kmem_caches?
> > > 
> > > In the old scheme, we had completely separate per-cgroup caches with
> > > separate slab pages. If a cgrouped process wanted to allocate a slab
> > > object, we'd go to the root cache and used the cgroup id to look up
> > > the right cgroup cache. On slab free we'd use page->slab_cache.
> > > 
> > > Now we have slab pages that have a page->objcg array. Why can't all
> > > allocations go through a single set of kmem caches? If an allocation
> > > is coming from a cgroup and the slab page the allocator wants to use
> > > doesn't have an objcg array yet, we can allocate it on the fly, no?
> > 
> > Well, arguably it can be done, but there are few drawbacks:
> > 
> > 1) On the release path you'll need to make some extra work even for
> >    root allocations: calculate the offset only to find the NULL objcg pointer.
> > 
> > 2) There will be a memory overhead for root allocations
> >    (which might or might not be compensated by the increase
> >    of the slab utilization).
> 
> Those two are only true if there is a wild mix of root and cgroup
> allocations inside the same slab, and that doesn't really happen in
> practice. Either the machine is dedicated to one workload and cgroups
> are only enabled due to e.g. a vendor kernel, or you have cgrouped
> systems (like most distro systems now) that cgroup everything.
> 
> > 3) I'm working on percpu memory accounting that resembles the same scheme,
> >    except that obj_cgroups vector is created for the whole percpu block.
> >    There will be root- and memcg-blocks, and it will be expensive to merge them.
> >    I kinda like using the same scheme here and there.
> 
> It's hard to conclude anything based on this information alone. If
> it's truly expensive to merge them, then it warrants the additional
> complexity. But I don't understand the desire to share a design for
> two systems with sufficiently different constraints.
> 
> > Upsides?
> > 
> > 1) slab utilization might increase a little bit (but I doubt it will have
> >    a huge effect, because both merging sets should be relatively big and well
> >    utilized)
> 
> Right.
> 
> > 2) eliminate memcg kmem_cache dynamic creation/destruction. it's nice,
> >    but there isn't so much code left anyway.
> 
> There is a lot of complexity associated with the cache cloning that
> isn't the lines of code, but the lifetime and synchronization rules.
> 
> And these two things are the primary aspects that make my head hurt
> trying to review this patch series.
> 
> > So IMO it's an interesting direction to explore, but not something
> > that necessarily has to be done in the context of this patchset.
> 
> I disagree. Instead of replacing the old coherent model and its
> complexities with a new coherent one, you are mixing the two. And I
> can barely understand the end result.
> 
> Dynamically cloning entire slab caches for the sole purpose of telling
> whether the pages have an obj_cgroup array or not is *completely
> insane*. If the controller had followed the obj_cgroup design from the
> start, nobody would have ever thought about doing it like this.

Having two sets of kmem_caches has nothing to do with the refcounting
and obj_cgroup abstraction.
Please, take a look at the final code.

Thanks!
