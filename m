Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2BEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422B0253AC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DaI/0oBv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LH7d20Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgFVDIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:08:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60646 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726644AbgFVDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:08:45 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05M34Qa8026676;
        Sun, 21 Jun 2020 20:07:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=AEH4SY2s2PuoxZoZHK8SLSt5oaPNNAAW5mi5ceVn+xc=;
 b=DaI/0oBvy/i7wtHlasctP7pssRflAjmYVTWUUSd7jSAwnCp+hO/wQOGCHu1X729Y8Y26
 kHiYJxUdnqYbcuh+wW/4B6G4+Z9chraez7ipbM3Hx+KruLReYNLMqtVATXWmyYQq/ikQ
 0FaXxItvI0zX7OCUAe5iYHuEbKEu+hUUmgQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31sg6s5qxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 21 Jun 2020 20:07:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 21 Jun 2020 20:07:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNHi9rju1MJTcL+zlIE4Ge/zQuBgun3GfsrgWO6qmYKKF1ovO9vM87ByWLY5jcw6rChfct3b3OdEzFadHHhWUJWqvrhUK2jhdo4uC0/ziXpcmKFzTdfmMXeThq1U5+MyCGk0rgDR418VlxyGknRwRja1I1YFiUVchMYq/2QJPFOcT90gqQb8X2EMpBxDPl6KtIOwpNClM9evsQHYraAhAdNblIyxU9ovBo6dow6RSfR7v0qKiSfAQeCrhYO892OJ3mcAWzWbYLRFD/x1w1JYJkzs9lLnDubF3HB3VN3nmxWwBvaH2ncLhNgnEuFEnwPYIv6YWTAVIl9mmJjE6kTUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEH4SY2s2PuoxZoZHK8SLSt5oaPNNAAW5mi5ceVn+xc=;
 b=ZAFTzOphGf9jJkQcHtDF4ves+b4wvdI3Z+CQxpApyVcxKK/f/1dKXEnlZK4lUer81gg9E0YyN8SoXxp56wgbgJNRHVWLcvseyjDixFPWZhwgwNqJnh8R1W1TPggKoZqJv4EhDm3gVaEO9YcsryemHTmIjH1KgZI963jHYh0JnaCB10nO2zkvBeRD7dqI7r3+Z5xK2/Yfy2zbGMMi8JARtRTGHfESA41OE/E/ED1m7xiI0ljzkIz/+HCsQZBlld1zfqUmzIea+xnDJFyf2kd2p2NjdzKPnWK7aZFB6hYptOA+47oqxkX6U2vQrI/2+9arlFeVFSczs6dA4Ep2xdaXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEH4SY2s2PuoxZoZHK8SLSt5oaPNNAAW5mi5ceVn+xc=;
 b=LH7d20XndAdfT3Rc6zFZbkKsi7CMYzTyFH0iU9smzh7HtB4EdMvqL6W7u4wNeksMbG6FVDSDSlVqsiQN6oqSCXcJdzLjuXeUM6/NDeGPqB5FYZQHGws1XLHFQkc/Z+wmJaid4TbIGBCiEsJFknpXq8NPxnZ3p0B41fzBJ3A8zPk=
Authentication-Results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2663.namprd15.prod.outlook.com (2603:10b6:a03:15c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 03:07:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 03:07:32 +0000
Date:   Sun, 21 Jun 2020 20:07:29 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200622030729.GB293939@carbon.DHCP.thefacebook.com>
References: <20200621233429.GA293939@carbon.DHCP.thefacebook.com>
 <7DEA68BC-3B9A-46FA-8103-AE6B72324591@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7DEA68BC-3B9A-46FA-8103-AE6B72324591@lca.pw>
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b541) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 03:07:32 +0000
X-Originating-IP: [2620:10d:c090:400::5:b541]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93485ce1-bfc1-489c-c771-08d8165967fc
X-MS-TrafficTypeDiagnostic: BYAPR15MB2663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2663112D8A499A3B5FFC314BBE970@BYAPR15MB2663.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYS9YU2kfkLyNn34VLhYm5q0Vz8NazmOcXJOkEZ5+bcXkboIpPNH7ME1F1qJH36cvODFHGWHQEIf91Ir6Q2v9xlaOMT/GX4AgbPULON0YFqIr72PV/97BhClB4PBFeKa2MzSm2pikmRgo3OtuuWbEasfDJmwzW3AFFVQCVziA/dUqmady1BdufyjrQJGbgQxpee3dR/Pcb0737iRbZTMJNEGbkU1/LSdH45T6f107ZEbOhtYbdyxOUG5bkf+lFrjmxldVtPW0uG1mWuVB+bH9KVXmai54kWgrJ2FKnnrmdqEqi3/f1Zf4eN+6z4gOD4+hlv5r0hGebGONPyFevqUIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(39860400002)(136003)(366004)(376002)(6506007)(6666004)(53546011)(186003)(16526019)(66946007)(33656002)(316002)(5660300002)(66556008)(66476007)(8676002)(7416002)(9686003)(1076003)(4326008)(54906003)(2906002)(7696005)(86362001)(83380400001)(8936002)(6916009)(55016002)(478600001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: otvlq7+ifRr6BKubFq0IEdxWlFw5/iqCGkm+vMNBU2nujGm3edm08xoUfdiwOwLjQv1uCeR9tf9XnB3fWs+i4FyfJqQC3RF6yx5+E7/idSRnqDs74cxtj223xWYpS2e+liUqx5+lfrceX+tq/VUaTkISzfcfrbf7l53Fv7J1gPlJh7VI0xW/4MtdkbU9Av0A9WpfFvrLB13K/ebx5D7lClSjai0+Qt+ptMOPpCMyDXDKPv00p6jCqg4XPZVgPq/30iPdqDqFMDan9ZSVwtFJbLVZ8uPaISdYHFHLmeg87SpEOTWfxZHeHQw/HMTe/w5wJ96Phzl4NZW0Oosr4/+bK1i+mn6fsGbLAV+gDR3/5gD19awhOlmJ5FD9FE92fFrTFYHFdREaDHolJyrpjUWMOpgjFxmB1wU4qaxYsbmwPWVsSUentLVYL/p8E43N8UDOZeOO/IkFVJQcM8ROTj4gOUW9CzUhThIIjIOMNAh87hFPF/Uaza+RFid9qYJILPCmy9/ElC5zh2xT9EAS/JYheQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93485ce1-bfc1-489c-c771-08d8165967fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 03:07:32.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tGvrCHNdAPVOcw0MKFfqvtk+zUiuJYlDSD/rR89wav/5Q1vaueLsSwmprp9S87v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2663
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-21_14:2020-06-19,2020-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=801 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=56
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220023
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 07:53:23PM -0400, Qian Cai wrote:
> 
> 
> > On Jun 21, 2020, at 7:34 PM, Roman Gushchin <guro@fb.com> wrote:
> > 
> > My wild guess is that kmemleak is getting confused by modifying the lowest
> > bit of page->mem_cgroup/obhj_cgroups pointer:
> > 
> > struct page {
> >    ...
> >    union {
> >        struct mem_cgroup *mem_cgroup;
> >        struct obj_cgroup **obj_cgroups;
> >    };
> >    ...
> > }
> > 
> > We're using the lowest bit to distinguish between a "normal" mem_cgroup
> > pointer and a vector of obj_cgroup pointers.
> > 
> > This pointer to obj_cgroup vector is saved only here, so if we're modifying
> > the address, I guess it's what makes kmemleak think that there is a leak.
> > 
> > Or do you have a real leak?
> 
> The point is that we can’t have a patchset in the current form to totally render kmemleak useless with so many even false positives.
> 
> Anyway, this is rather easy to reproduce where I am able to reproduce on multiple bare-metal machines by just booting it.
> 
> # echo scan > /sys/kernel/debug/kmemleak
> # cat /sys/kernel/debug/kmemleak

Ok, thank you for the report, I'll take care of it.

It's easy to mark these vectors to be ignored by kmemleak, but I guess it's better
to explicitly add an additional reference, so we can track actual leaks.

I'll send a patch with fix soon-ish.

Thanks!
