Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB30FC33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1226206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgA3CRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:17:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726715AbgA3CRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:17:41 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U29Y60077227
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 21:17:40 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xttnubhm1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 21:17:40 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Thu, 30 Jan 2020 02:17:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 02:17:35 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00U2HYDh32178262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 02:17:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74D82AE04D;
        Thu, 30 Jan 2020 02:17:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36E6FAE045;
        Thu, 30 Jan 2020 02:17:32 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.51.93])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Jan 2020 02:17:31 +0000 (GMT)
Date:   Thu, 30 Jan 2020 07:47:29 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 27/28] tools/cgroup: make slabinfo.py compatible with
 new slab controller
Reply-To: bharata@linux.ibm.com
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-28-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-28-guro@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 20013002-4275-0000-0000-0000039C283E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013002-4276-0000-0000-000038B044AF
Message-Id: <20200130021729.GB21973@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_08:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:52AM -0800, Roman Gushchin wrote:
> Make slabinfo.py compatible with the new slab controller.
 
Tried using slabinfo.py, but run into some errors. (I am using your
new_slab.2 branch)

 ./tools/cgroup/slabinfo.py /sys/fs/cgroup/memory/1
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
  File "./tools/cgroup/slabinfo.py", line 220, in <module>
    main()
  File "./tools/cgroup/slabinfo.py", line 165, in main
    find_memcg_ids()
  File "./tools/cgroup/slabinfo.py", line 43, in find_memcg_ids
    MEMCGS[css.cgroup.kn.id.ino.value_()] = memcg
AttributeError: '_drgn.Object' object has no attribute 'ino'

I did make this change...

# git diff
diff --git a/tools/cgroup/slabinfo.py b/tools/cgroup/slabinfo.py
index b779a4863beb..571fd95224d6 100755
--- a/tools/cgroup/slabinfo.py
+++ b/tools/cgroup/slabinfo.py
@@ -40,7 +40,7 @@ def find_memcg_ids(css=prog['root_mem_cgroup'].css, prefix=''):
                                        'sibling'):
             name = prefix + '/' + css.cgroup.kn.name.string_().decode('utf-8')
             memcg = container_of(css, 'struct mem_cgroup', 'css')
-            MEMCGS[css.cgroup.kn.id.ino.value_()] = memcg
+            MEMCGS[css.cgroup.kn.id.value_()] = memcg
             find_memcg_ids(css, name)


but now get empty output.

# ./tools/cgroup/slabinfo.py /sys/fs/cgroup/memory/1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>

Guess this script is not yet ready for the upstream kernel?

Regards,
Bharata.

