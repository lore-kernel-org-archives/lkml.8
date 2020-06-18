Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA9AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F3420890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CSMvsTN7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c2q3cU3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgFRUoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:44:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727900AbgFRUoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:44:01 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IKf31O026756;
        Thu, 18 Jun 2020 13:43:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5/N62/QnkNOKUIbBqY3uIFBMtmh+yRaxUpm+lg42BrQ=;
 b=CSMvsTN7WpTu1CTbMOvJahH0gh3JyKQclLgNsuy5AkzNE/5HVo4UonuoNV7sSF4P5n1F
 6ybidwDLqKhk0vbqkpkFoMBj/nSFxxq+SVHWXmBh3q44ehEz3Ai6lb1ZRPckKioUGBCI
 8ydqagc3vMzrS/3eCl5g5YOToGUvIwfEmwk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q8u6nvjy-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 13:43:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 13:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT5gRn+BHIoURqF54rN/pMDMb7soQ5sX+dwX8G6KqwwwFfLhl3ffgq93tN2ZVFOeFL3O2d9Njq5PBiHb7k/jhkJoiJtD5iZSvE9Q/H8cAJWlDsD0yq7+jb1t56naux0XG6hTOFhVdr731QPSnah4C/vkfmmJvwrhUjWjq/Vf6QwsJIImU1N5vntZxrEoSYIWLTmraYgwiRnuQqxdYdo4LxAcpQZ40LJCmfgNgJYvug8flZZMtv8MMyjxsnFEVikpHG7Zvrc+meofqeT4QOFzS0fepBjaODdcOvkwZ8y4+twAZZsWUDtDqpR/w7LHjsmlcfEHxc4SZrBAa+ywjarUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/N62/QnkNOKUIbBqY3uIFBMtmh+yRaxUpm+lg42BrQ=;
 b=ceDUra/bjfcvLgixkzwKmi/0bTDbQzQXeW7KOy9cwOlpVBuRtPgW1g/KzEEPkO/ivibnG69mlXdeevgoxWiktNG8PZBt4HsMrV1e52tm6nS+z5HHHb8+p07jyyvb/TZLgGB4kHSSFXtm7cg9t4KtiRsFIMXk0YLqYW65ENCN7siYfklqPunBTVk3Z91O3/TPNvKJIC4akhmT1aIUWTRcmE/W+ZDSXC1O9bzQxO/8gPAkOA21lxNqusJ3unyFokEZvDjOeIBAzMbLSgGkOGzkks7mpEDb5BVvBAUIonGBHvMaSb5zrkrI1YWfo6cNpjVO4cNFbQTXbIv+0QmnOQLb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/N62/QnkNOKUIbBqY3uIFBMtmh+yRaxUpm+lg42BrQ=;
 b=c2q3cU3TAocJa9+pdMg+g9iVjDg0vIuOwqqkQrd+2Vx8ZPb62Vjnz1C7CcI2SiFuNesoEcOT8HC+8nuLE5b36Xnos7A0eQhBANKVSuY2NDOobtMpyurK8a4QWt2kYGjcqJ6sXyTJiez22fRMDqACetAFp8gbacJo6o/qETbeWUg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2487.namprd15.prod.outlook.com (2603:10b6:a02:8d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 20:43:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 20:43:35 +0000
Date:   Thu, 18 Jun 2020 13:43:30 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200618204330.GF110603@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200618092707.GD6571@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618092707.GD6571@kernel.org>
X-ClientProxiedBy: DM6PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:5:134::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:632d) by DM6PR13CA0053.namprd13.prod.outlook.com (2603:10b6:5:134::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10 via Frontend Transport; Thu, 18 Jun 2020 20:43:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:632d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97c0f75-813f-45b5-9320-08d813c84554
X-MS-TrafficTypeDiagnostic: BYAPR15MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2487E6D78AF505AAD5B10D17BE9B0@BYAPR15MB2487.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whvOkUG5W15hJddHHiCCa7TCDGPcwXMKpljuWzLQcdq5N3d/h8H/o59gdTrZAcQVcKZP/yvlLGgCJd8ltFeBYqdH/gFNbk87zgGJlfKhLCQo5EFaSFOPzjnvFkr4UOV3+W+2Hde/6JpenLNKKUfwB9l+ViAhvGBI9imcGcqZ/eSZLnAdyusw2yLBaJMVESmdSwnjIKeNXBwZcdUUBDYEZswi1Gh3o3ndd+QA8TFhNRYVNc5pHV5V3xco3e9eDgKPg+PVOCG3Tl8r+FDq3M+54CGlf46AqykvEQHP1gtcc5hZvyu4bF4xUKCQnbEXC7IgxPL0Mvs6mkpuV/VkXq11Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(1076003)(6506007)(478600001)(86362001)(83380400001)(8676002)(6916009)(8936002)(2906002)(9686003)(4326008)(66556008)(33656002)(316002)(54906003)(5660300002)(52116002)(186003)(7696005)(55016002)(16526019)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tv7LIZ+J4UJj0ZRJyFHDka8fRtJiLOLBIloyn48t5ryMPXj9xTHCrGAC29Ksp3Vsh5Vd9A4az3r153pq4ypudBZy/gMpiP2Nfx8YkowIbxog3PbpWa62RfuN2TsvaTKzc/uIhI4UhSqWBz5SRxzkxQL3/CtrSqytMQy2uuP3EeoZVxE1iBMK0vCV6FU7b/S2Abpqk/REIU8LcP1yiS/T41/vs1ekJ0qBSJsGbgQ7aK12DjggFazg3J8ERfnfeKXYlu7RM3m00sIFZ3UNoQmluOLSN7/4yIDC/GlqCfBgsmOOmxriKqW6YxAnyuAw9w4/AGnJdgA5V7esIY5Ofgybv4yCHxqhX5FzHN4RVwpPdVEJuB+zsK1cwUJEPUzqOmj6qliE3bFBeQe6Qqp9Y4PDvZRe7qRqamB1I1KR3x0U/6xpTaNagc29turDtRf5saFz7E/z8iiXKnulrzyp+MuMsXuapKI7BR6Y2Ga67CjnJ9pZADhyBqyNJ4owzWJJnoJeL0pKdYhLOMgxDdWbW5cZdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a97c0f75-813f-45b5-9320-08d813c84554
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 20:43:35.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnspN0YfATBQtK3kEWR+mfMJfbbxX5t0eMoz0lzLvwk1HBTdrYvXHgGop7amV+el
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2487
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 cotscore=-2147483648 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=2 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:27:07PM +0300, Mike Rapoport wrote:
> Hi Roman,
> 
> On Mon, Jun 08, 2020 at 04:06:35PM -0700, Roman Gushchin wrote:
> > This is v6 of the slab cgroup controller rework.
> > 
> > The patchset moves the accounting from the page level to the object
> > level. It allows to share slab pages between memory cgroups.
> > This leads to a significant win in the slab utilization (up to 45%)
> > and the corresponding drop in the total kernel memory footprint.
> > The reduced number of unmovable slab pages should also have a positive
> > effect on the memory fragmentation.
>  
> ... 
>  
> > Johannes Weiner (1):
> >   mm: memcontrol: decouple reference counting from page accounting
> > 
> > Roman Gushchin (18):
> >   mm: memcg: factor out memcg- and lruvec-level changes out of __mod_lruvec_state()
> >   mm: memcg: prepare for byte-sized vmstat items
> >   mm: memcg: convert vmstat slab counters to bytes
> >   mm: slub: implement SLUB version of obj_to_index()
> >   mm: memcg/slab: obj_cgroup API
> >   mm: memcg/slab: allocate obj_cgroups for non-root slab pages
> >   mm: memcg/slab: save obj_cgroup for non-root slab objects
> >   mm: memcg/slab: charge individual slab objects instead of pages
> >   mm: memcg/slab: deprecate memory.kmem.slabinfo
> >   mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
> >   mm: memcg/slab: use a single set of kmem_caches for all accounted allocations
> >   mm: memcg/slab: simplify memcg cache creation
> >   mm: memcg/slab: remove memcg_kmem_get_cache()
> >   mm: memcg/slab: deprecate slab_root_caches
> >   mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
> >   mm: memcg/slab: use a single set of kmem_caches for all allocations
> >   kselftests: cgroup: add kernel memory accounting tests
> >   tools/cgroup: add memcg_slabinfo.py tool
>  
> Sorry for jumping late, but I'm really missing 
> 
>    Documentation/vm/cgroup-slab.rst	      | < lots of + >
> 
> in this series ;-)

Hi Mike!

That's a good point. I'll write something and send a separate patch.
Changes are barely visible to a user, so no rush here,
but it's definitely a good idea to document the new design.

Thank you!
