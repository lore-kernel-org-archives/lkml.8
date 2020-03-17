Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0ECC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3031120714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eNEOjqDn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ceDrTlCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCQSix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:38:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgCQSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:38:52 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HIccp6031103;
        Tue, 17 Mar 2020 11:38:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0rh9zaTJrkWhJJJs1MCIFr+pLgUg78JwWwPFe+bt++0=;
 b=eNEOjqDnL2RCOaPSX0tpKBLO0qsrZMhBE/GITgKjPcksKuGFhs4Yfr3/ssCDxKQhSAT7
 6VF8OlBiMGroy23GSUS7IuBgP7GTi4FCRVxxYlNf5laD9br/GME8CKrM8QeH3ZQgc7Bv
 +2+RFGT8xh64/3HvG3AWMS+cPqMUvH+utPU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yts6vk2bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Mar 2020 11:38:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 17 Mar 2020 11:38:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaZ5s7sWJWj3mWdq0Dwkl3HkZaRTIJBOY2n4blQYa43rMoyySHXvuyCWl0E6MRHMGKo3r4Z124138tZn7ZjRX7DI8bgXPAHdD0xx91ggkmIRBrDZUkTwmnI3v1mw/qA3DX/mGaqUq+Qa+6+yp0gUHQerdCQwF8GUTAQApzk77nuCi8pxNhHxRIfI5BvsPX9WaacWNPeYBQVo1RFkyiJFoqQWLCjvy4J2IAZHEehecRcZrGaeMsKIhUrKjdJey35VMuxprTNIONSdBe5ryDu4qurXWz6YhCySywtgZDb+hfX4OVo6bur8P3ba0vr4b+evS1q6SoeisuR2gl3b9dn0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rh9zaTJrkWhJJJs1MCIFr+pLgUg78JwWwPFe+bt++0=;
 b=T/BP77FjUCWObaSFfdHFwRQQCBcoQ1fIa0IdyWRt3xu55vKpP7nzM2vww2UilijRn+hY5whJv+DCyxAcxIY4LdIed3ldySpUx+xAXMhAACVQr1dEEQIre19UxP5zhUCYD/upSSE0swuJCVje//xRfoMWZp1sC+LNSwf785hNIZEM1N1AVUtp4b86x3bmWwc5uNboZ/aJq4uiWDn/l5lrSyBji7nZkD4nA5lf+p9Dc+2cXcXLkR4rMbUJCo9TlBx3Lthcs9KzET5EDwziolrN+QlO52qeMm6kKBtvhNhn8XD1vh1tLaiExofpizW39CKiodiX8PWr3K8avIKPRh3h6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rh9zaTJrkWhJJJs1MCIFr+pLgUg78JwWwPFe+bt++0=;
 b=ceDrTlCQMsLwgAw0g61+6oVx1gt7SM3paZwMm7TBGlbbdbScr3txuStvd1YU1DHg+QFX+QAgJbKPA2gg8EVKEEMlKy/SopfWA8AEmgcwBmFLteO1FdzyL/jGzNgY8wWn88jw4BXSbfaUxN/lvLgQfQO0x/Twu7kIROM6pNXuORU=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2807.namprd15.prod.outlook.com (2603:10b6:a03:15a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Tue, 17 Mar
 2020 18:38:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::a0af:3ebe:a804:f648]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::a0af:3ebe:a804:f648%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 18:38:45 +0000
Date:   Tue, 17 Mar 2020 11:38:36 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcg: make memory.oom.group tolerable to task
 migration
Message-ID: <20200317183836.GA276471@carbon.DHCP.thefacebook.com>
References: <20200316223510.3176148-1-guro@fb.com>
 <20200317075212.GC26018@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317075212.GC26018@dhcp22.suse.cz>
X-ClientProxiedBy: CO2PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:104:5::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:3538) by CO2PR04CA0192.namprd04.prod.outlook.com (2603:10b6:104:5::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Tue, 17 Mar 2020 18:38:44 +0000
X-Originating-IP: [2620:10d:c090:400::5:3538]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617da454-d6f1-43ad-3e61-08d7caa26c52
X-MS-TrafficTypeDiagnostic: BYAPR15MB2807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28079618C4CF662E97FDE4F2BEF60@BYAPR15MB2807.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(346002)(366004)(376002)(199004)(6916009)(1076003)(6666004)(7696005)(81166006)(8936002)(55016002)(316002)(8676002)(16526019)(52116002)(4326008)(2906002)(9686003)(81156014)(186003)(478600001)(5660300002)(66946007)(66556008)(6506007)(33656002)(66476007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2807;H:BYAPR15MB4136.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBkjbQLf205UVBxVoe0m/EIfwu1dDQQKDxymJU4SOox007LfXmj2xWT5eC0hQx73OWKY0H6fLuHfGnh8wgbuzJyPShu4ouvDGMI6aNjGDWotPefV4uwoziIiuZqOMzUmdZPv4S2q44s9OSMHXaKm+QGMOwnrUgrkpWKaVV5Suu2UW9/uelQl80kDy1CN/78M45H24fhoLY02HCd0GTPqp8H+SAe8FNsK9ktgPnhqdOPXSfRSWa9FfrAPRSer+QbHRgHg7sUXRj87LEczg9B7zm+kusfTq63s30upb8DAvCa00+uRi/ftpLJgLdoo7oVfLQzYUMnCPJFDHFFoQ8hckNfqHSg7v4Rlr3I+YmFdZdt3w4gzLWOVdLekao/HqqPsgHJBgv8vT84smtlkoWszbf3/y9mcU2NQNwG7BbEaglA0jcouxNT3oi6ez/tpPCUr
X-MS-Exchange-AntiSpam-MessageData: /Ptf+1zdWto3RZheaA0d4vrRIypLfDKp/FUPGmSPux29tEN0yJ3IWBiGtMwZwV42Xl2Gv0q2rzfhgXIAkp21+QigHyclvY5a305+OOEf62W3JpjlnF0NL+Bi3Bge9Geixopfn6pTFS75HrNB2ITBACXJlzUlNBMv8+ESe7zzdLsPPQBYg+h4cVZkd/3wvEdy
X-MS-Exchange-CrossTenant-Network-Message-Id: 617da454-d6f1-43ad-3e61-08d7caa26c52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 18:38:44.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF50tVzdXKYpMzfmv4zCgdaCgUcS8Nlo+9hRenzIfwdS9YfvY4sB4wQSNNs/SZZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2807
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_08:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170072
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 08:52:12AM +0100, Michal Hocko wrote:
> On Mon 16-03-20 15:35:10, Roman Gushchin wrote:
> > If a task is getting moved out of the OOMing cgroup, it might
> > result in unexpected OOM killings if memory.oom.group is used
> > anywhere in the cgroup tree.
> > 
> > Imagine the following example:
> > 
> >           A (oom.group = 1)
> >          / \
> >   (OOM) B   C
> > 
> > Let's say B's memory.max is exceeded and it's OOMing. The OOM killer
> > selects a task in B as a victim, but someone asynchronously moves
> > the task into C.
> 
> I can see Reported-by here, does that mean that the race really happened
> in real workloads? If yes, I would be really curious. Mostly because
> moving tasks outside of the oom domain is quite questionable without
> charge migration.

Yes, I've got a number of OOM messages where oom_cgroup != task_cgroup.
The only reasonable explanation is that the task has been moved out after
being selected as a victim. In my case it resulted in killing all tasks
in A, and it what hurt the workload.

> 
> > mem_cgroup_get_oom_group() will iterate over all
> > ancestors of C up to the root cgroup. In theory it had to stop
> > at the oom_domain level - the memory cgroup which is OOMing.
> > But because B is not an ancestor of C, it's not happening.
> > Instead it chooses A (because it's oom.group is set), and kills
> > all tasks in A. This behavior is wrong because the OOM happened in B,
> > so there is no reason to kill anything outside.
> > 
> > Fix this by checking it the memory cgroup to which the task belongs
> > is a descendant of the oom_domain. If not, memory.oom.group should
> > be ignored, and the OOM killer should kill only the victim task.
> 
> I was about to suggest storing the memcg in oom_evaluate_task but then I
> have realized that this would be both more complex and I am not yet
> sure it would be better so much better after all.
> 
> The thing is that killing the selected task makes a lot of sense
> because it was the largest consumer. No matter it has run away. On the
> other hand if your B was oom.group = 1 then one could expect that any
> OOM killer event in that group will result in the whole group tear
> down. This is however a gray zone because we do emit MEMCG_OOM event but
> MEMCG_OOM_KILL event will go to the victim's at-the-time memcg. So the
> observer B could think that the oom was resolved without killing while
> observer C would see a kill event without oom.

I agree. Killing the task outside of the OOMing cgroup is already strange.

Should we somehow lock the OOMing cgroup? So that tasks can not escape
and enter it until the finish of the OOM killing?

It seems to be a better idea, because it will also make the oom.group
killing less racy: currently a forking app can potentially escape from it.

And the we can put something like
	if (WARN_ON_ONCE(!mem_cgroup_is_descendant(memcg, oom_domain)))
		goto out;
to mem_cgroup_get_oom_group?

What do you think?

Thanks!
