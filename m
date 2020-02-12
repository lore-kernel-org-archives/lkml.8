Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E732FC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A2F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgBLFVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:21:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725767AbgBLFVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:21:38 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01C5JkU9013999
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:21:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9r1fr0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:21:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Wed, 12 Feb 2020 05:21:34 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Feb 2020 05:21:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01C5LV2v43909278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 05:21:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE6D4C058;
        Wed, 12 Feb 2020 05:21:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EE2B4C040;
        Wed, 12 Feb 2020 05:21:27 +0000 (GMT)
Received: from in.ibm.com (unknown [9.124.35.191])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Feb 2020 05:21:27 +0000 (GMT)
Date:   Wed, 12 Feb 2020 10:51:24 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Reply-To: bharata@linux.ibm.com
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-28-guro@fb.com>
 <20200130021729.GB21973@in.ibm.com>
 <20200131222346.GA20909@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131222346.GA20909@xps>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 20021205-0008-0000-0000-0000035212E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021205-0009-0000-0000-00004A72B62C
Message-Id: <20200212052124.GA12769@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_07:2020-02-11,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:24:58PM +0000, Roman Gushchin wrote:
> On Thu, Jan 30, 2020 at 07:47:29AM +0530, Bharata B Rao wrote:
> > On Mon, Jan 27, 2020 at 09:34:52AM -0800, Roman Gushchin wrote:
> 
> Btw, I've checked that the change like you've done above fixes the problem.
> The script works for me both on current upstream and new_slab.2 branch.
> 
> Are you sure that in your case there is some kernel memory charged to that
> cgroup? Please note, that in the current implementation kmem_caches are created
> on demand, so the accounting is effectively enabled with some delay.

I do see kmem getting charged.

# cat /sys/fs/cgroup/memory/1/memory.kmem.usage_in_bytes /sys/fs/cgroup/memory/1/memory.usage_in_bytes
182910976
4515627008

> Below is an updated version of the patch to use:

I see the below failure with this updated version:

# ./tools/cgroup/slabinfo-new.py /sys/fs/cgroup/memory/1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
Traceback (most recent call last):
  File "/usr/local/bin/drgn", line 11, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.6/dist-packages/drgn/internal/cli.py", line 127, in main
    runpy.run_path(args.script[0], init_globals=init_globals, run_name="__main__")
  File "/usr/lib/python3.6/runpy.py", line 263, in run_path
    pkg_name=pkg_name, script_name=fname)
  File "/usr/lib/python3.6/runpy.py", line 96, in _run_module_code
    mod_name, mod_spec, pkg_name, script_name)
  File "/usr/lib/python3.6/runpy.py", line 85, in _run_code
    exec(code, run_globals)
  File "./tools/cgroup/slabinfo-new.py", line 158, in <module>
    main()
  File "./tools/cgroup/slabinfo-new.py", line 153, in main
    memcg.kmem_caches.address_of_(),
AttributeError: 'struct mem_cgroup' has no member 'kmem_caches'

> +
> +def main():
> +    parser = argparse.ArgumentParser(description=DESC,
> +                                     formatter_class=
> +                                     argparse.RawTextHelpFormatter)
> +    parser.add_argument('cgroup', metavar='CGROUP',
> +                        help='Target memory cgroup')
> +    args = parser.parse_args()
> +
> +    try:
> +        cgroup_id = stat(args.cgroup).st_ino
> +        find_memcg_ids()
> +        memcg = MEMCGS[cgroup_id]
> +    except KeyError:
> +        err('Can\'t find the memory cgroup')
> +
> +    cfg = detect_kernel_config()
> +
> +    print('# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>'
> +          ' : tunables <limit> <batchcount> <sharedfactor>'
> +          ' : slabdata <active_slabs> <num_slabs> <sharedavail>')
> +
> +    for s in list_for_each_entry('struct kmem_cache',
> +                                 memcg.kmem_caches.address_of_(),
> +                                 'memcg_params.kmem_caches_node'):

Are you sure this is the right version? In the previous version
you had the if-else loop that handled shared_slab_pages and old
scheme separately.

Regards,
Bharata.

