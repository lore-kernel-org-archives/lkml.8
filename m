Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB42C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01CF2467D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="acGlmLyc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iUDzq+9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgBLUoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:44:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727548AbgBLUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:44:14 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CKa15e011476;
        Wed, 12 Feb 2020 12:42:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rX0JS28tLp5sLmqA8qTv7joeSTzcZXpJsube1bE9z3k=;
 b=acGlmLycpLNs38grNZ3EjWDAmAu0QXGX+mXI2kC7OvZ2IybNieDfs5jiOFS2CiFJk1N5
 7q25Tq9ZCqJO07HJRtSCuzWhaKyU8GQnQNhW3yQagdC1Llo8HTRW/IDwox8pgd9bJtOK
 DRnM19lFwe8sDIYGtmtl27k3i3jXT8lbrtQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2y3pq41w2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 12 Feb 2020 12:42:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 12:42:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAIRdSBFha1BY3X2CHGhFERtyVbwH65Qb4cAh2BoSCOp9JbxSgJTdLAadksZVSqCD33SnLn60JKc1xhzUtSfYoNNNQqYS1Z3PvAkxDZuiM5mlDfQLw9pSpy9MHOhYZywctgZraeWuaI24Q5lxX3wHIUmS+qZaEejIL3KIv9WOIFZ1SrbCpjPvJjopfzVNG+RURIE3Tu9eTpUYis6EPvRK4UW9bD6ME6LPzkWQ4HoThcyWZwtoCvD8sHqK0aR+dGfy+6OOmLrIvpTshawkJ9XdFYiP54B/OhkcrSd4eS79hPfAGxHzueNhs36nWkzfw8K05X39qqEtO7PywsTmp1vsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX0JS28tLp5sLmqA8qTv7joeSTzcZXpJsube1bE9z3k=;
 b=Rhul1SNoRZY/t55/E8p4iFQIhg5lJHrIHS7kNdzmVNgjIh7RtVjpAD29EKG3mYrZrwvVsZ137sbA68Hk90UnF2YrRGzk1KmTDxCYoYEdukjJRvBatYfe4FEaId0m14+kIhQXXUCCl93nTQRZfW1qR3tEvTRgh5vhEYC3KpEbQRUuyMD8IO8+DwW0GmcAVwghJM/IjhGyHQw+tI8Y/ErbXIyciBNvFmm56g/TXmQ7jadEqQF3Hma/0adFTiPOi/HygHtOQgWsdP/Qdf0Iu97FnwitMwansWxnodmmE2IYO3mOAABdxTTsjgPzEqqraNLAPIOOYlsdBlQsT4w8vbP+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX0JS28tLp5sLmqA8qTv7joeSTzcZXpJsube1bE9z3k=;
 b=iUDzq+9oyU574MwkziR/aHFUx6oSe6jAwdR2ip6zN7+HQnMfE4wd+PahH2jkMsjvKGU0k1GR3uW/uaYGPT1WUr2vKsrs61JFKNMD50wkvUhqHNq6YZjaH4ILZyWZJg/qiDuxaw8Do9o8TQH92XFM6QqImfo38cvnmjHbDq+dLWg=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2551.namprd15.prod.outlook.com (20.179.155.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Wed, 12 Feb 2020 20:42:50 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 20:42:49 +0000
Date:   Wed, 12 Feb 2020 12:42:43 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 27/28] tools/cgroup: make slabinfo.py compatible with
 new slab controller
Message-ID: <20200212204243.GA177958@carbon.lan>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-28-guro@fb.com>
 <20200130021729.GB21973@in.ibm.com>
 <20200131222346.GA20909@xps>
 <20200212052124.GA12769@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212052124.GA12769@in.ibm.com>
X-ClientProxiedBy: MN2PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:208:236::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from carbon.lan (2620:10d:c091:480::6d5) by MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.14 via Frontend Transport; Wed, 12 Feb 2020 20:42:47 +0000
X-Originating-IP: [2620:10d:c091:480::6d5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69589680-f2c5-486d-731b-08d7affc1fba
X-MS-TrafficTypeDiagnostic: BYAPR15MB2551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB25514C8EA45065DC96FE93ADBE1B0@BYAPR15MB2551.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(199004)(189003)(8676002)(8936002)(5660300002)(81166006)(478600001)(4326008)(81156014)(8886007)(1076003)(36756003)(6916009)(9686003)(52116002)(6666004)(54906003)(33656002)(316002)(86362001)(66946007)(66476007)(66556008)(55016002)(6506007)(7696005)(2906002)(186003)(16526019)(27376004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2551;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6Lpz2FrZZ6pZPzo3bAcvIr5ZMR1qtjoxLSMAjHEI4IZoxyTDrXpms0AqxT/riD2bmNOmsmHOslMX78eRpJ+/62YqPIChtSVB8HeO+z8BzdEmeTqRJwJnV8dDRsFwTB02km3LfvvAgXCb4JWenJDwy6LA3H7O9dXRu7P3wvnRw00Fdosvf8UUauT73Vlmj157FN0ymydC0Z87pfOrR9lS8a15kIV7v1GtTKVvRdRMFGG10Py1oOrXRNygb4/58gqrrnB/scL1wWPE3aGQpgX+KEuJ69Y3c0i8s/5GGJl5ajiOKlIqVaOTEMBokjmlXRPqBWmQIKfIDG/gR07MpeQF+mHyUMiwJOm05BaxoUW9r4XTM27KA/jQL0VcoOoe/aRs4gn10gysMFhtYNkOJ7dt6JlXiH3q8uLhNS97HVZlZrrefm2lqMBuNeU0CeA37icifCqzlXVrr61e3AIGtBv5UvNcH1zFvVJkE7dLMPFhmAyWCAsHa5o90rVeW3V5JIh
X-MS-Exchange-AntiSpam-MessageData: ByNHMO0jYq89IUUX0oAsCuTwsrI/CiscQ8XZd2ghksoaKrJkuiPFLmd3r9WPCnVny/ZStpaNAd02OO6I9H2uOvNDrbFgZoYsqTnQ4jC2c3OsdzCQKAz8WdJnS7a81NRjRVTNkdFVEpUOj2KU3VaTAcAy116U1SnBJstifp+3YgY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69589680-f2c5-486d-731b-08d7affc1fba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 20:42:49.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVmuC5UOPEFnPUT0wc8BSMRTbGLZD9sL0MGmKF1wXgtbeUbsu9t2V3UUNgjHYGOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2551
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_09:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=2 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:51:24AM +0530, Bharata B Rao wrote:
> On Fri, Jan 31, 2020 at 10:24:58PM +0000, Roman Gushchin wrote:
> > On Thu, Jan 30, 2020 at 07:47:29AM +0530, Bharata B Rao wrote:
> > > On Mon, Jan 27, 2020 at 09:34:52AM -0800, Roman Gushchin wrote:
> > 
> > Btw, I've checked that the change like you've done above fixes the problem.
> > The script works for me both on current upstream and new_slab.2 branch.
> > 
> > Are you sure that in your case there is some kernel memory charged to that
> > cgroup? Please note, that in the current implementation kmem_caches are created
> > on demand, so the accounting is effectively enabled with some delay.
> 
> I do see kmem getting charged.
> 
> # cat /sys/fs/cgroup/memory/1/memory.kmem.usage_in_bytes /sys/fs/cgroup/memory/1/memory.usage_in_bytes
> 182910976
> 4515627008

Great.

> 
> > Below is an updated version of the patch to use:
> 
> I see the below failure with this updated version:

Are you sure that drgn is picking right symbols?
I had a similar transient issue during my work, when drgn was actually
using symbols from a different kernel.

> 
> # ./tools/cgroup/slabinfo-new.py /sys/fs/cgroup/memory/1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
> Traceback (most recent call last):
>   File "/usr/local/bin/drgn", line 11, in <module>
>     sys.exit(main())
>   File "/usr/local/lib/python3.6/dist-packages/drgn/internal/cli.py", line 127, in main
>     runpy.run_path(args.script[0], init_globals=init_globals, run_name="__main__")
>   File "/usr/lib/python3.6/runpy.py", line 263, in run_path
>     pkg_name=pkg_name, script_name=fname)
>   File "/usr/lib/python3.6/runpy.py", line 96, in _run_module_code
>     mod_name, mod_spec, pkg_name, script_name)
>   File "/usr/lib/python3.6/runpy.py", line 85, in _run_code
>     exec(code, run_globals)
>   File "./tools/cgroup/slabinfo-new.py", line 158, in <module>
>     main()
>   File "./tools/cgroup/slabinfo-new.py", line 153, in main
>     memcg.kmem_caches.address_of_(),
> AttributeError: 'struct mem_cgroup' has no member 'kmem_caches'
> 
> > +
> > +def main():
> > +    parser = argparse.ArgumentParser(description=DES,C
> > +                                     formatter_class=
> > +                                     argparse.RawTextHelpFormatter)
> > +    parser.add_argument('cgroup', metavar='CGROUP',
> > +                        help='Target memory cgroup')
> > +    args = parser.parse_args()
> > +
> > +    try:
> > +        cgroup_id = stat(args.cgroup).st_ino
> > +        find_memcg_ids()
> > +        memcg = MEMCGS[cgroup_id]
> > +    except KeyError:
> > +        err('Can\'t find the memory cgroup')
> > +
> > +    cfg = detect_kernel_config()
> > +
> > +    print('# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>'
> > +          ' : tunables <limit> <batchcount> <sharedfactor>'
> > +          ' : slabdata <active_slabs> <num_slabs> <sharedavail>')
> > +
> > +    for s in list_for_each_entry('struct kmem_cache',
> > +                                 memcg.kmem_caches.address_of_(),
> > +                                 'memcg_params.kmem_caches_node'):
> 
> Are you sure this is the right version? In the previous version
> you had the if-else loop that handled shared_slab_pages and old
> scheme separately.

Which one you're refering to?

As in my tree there are two patches:
fa490da39afb tools/cgroup: add slabinfo.py tool
e3bee81aab44 tools/cgroup: make slabinfo.py compatible with new slab controller

The second one adds the if clause you're probably referring to.

Thanks!

Roman
