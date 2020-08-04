Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C3EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA0D2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cHCJw/J8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c5MlLJDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHDAkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:40:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23044 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgHDAkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:40:33 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0740ZANx020428;
        Mon, 3 Aug 2020 17:40:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=OCh8H0Bc10jEfXOkX9PYoNO1EDA/TJFPtXwpwAs9H4w=;
 b=cHCJw/J8pXqce91NB6wDP4+pb22nNHdlXPVLvZU3zfeWHCM8WOgVLSv6JCOnLQ6eBY0N
 MzidX1i2Mj5r5/rOKiOY2OZT/Qzul4ZeU858D2Oy6gXYV807mHJPJg4Fr9vyV+UR76tD
 pXFTV286/SalTiLgJ1S2T2KDUjv6RU+MMs4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 32n81y9vby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Aug 2020 17:40:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 17:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnr1toohaiC6iqovydcoV5/7Vm7vzop5EP4WDagSkXvrFoNk0y3akcDBHnS1mVbktSQIeshRKoFXChj8scC5xIRRfL0t3LFVhwEBCwYDl4McNePJ5ZNZyfG+sVNjncdStuSnv7f88mhISfniEbIG9Mxp2FBTrBi5CH54tzvK0ns8CpRgp2hMc4pemNkLhcvIDgBesbjACLPMeA8uvIbB/bCqQK8fDvdrBpALUDXBoD+g/59ckN7rTZm5PSBOzktd/vktUBAqIDI2Ml5BDu6WhzX0msK1ACTUxvNlPx3nUt1pRTU0RkbpLt8KknM38LV9TcTzZrvna9gnjaNhdQwE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCh8H0Bc10jEfXOkX9PYoNO1EDA/TJFPtXwpwAs9H4w=;
 b=TEZcY1Tr+K+owD/11gxOLBRedcX+/7FWUdVI95q4gth6DrPMBiaxCoxO3DbiNt2OqajgZdlaUC4duplTXHBgSGT2sdpP9GPzhm7C9S6XAez+0qPF61NxrHFQPLZFiAJudqm/6was0oB82iGmyJYoFQs3XNiymEK8cU9q4jmD9V5vdPjgN16thG8GgGy/Q27j9ybN6K2ZbSWfHgq+HDpG2djnlIR7b7yKCBCnu/0xCfR6vZwMgp9WlJ7MVXUsKzmumsv3kCaGiANn5wHuRGCoFcg20BpMdm93vNAGCxr3Q9PbmXxA+pwPu/y6V3/Sb6ACtCZA77ntdh8/Wn2K8BvifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCh8H0Bc10jEfXOkX9PYoNO1EDA/TJFPtXwpwAs9H4w=;
 b=c5MlLJDK3S/3hj1Os5yPAKg3gkUfQi8ltEkyOJscAxSPUAqZELNkGZ88SRKYIoLSARGhob5gD7eWqpIrsD0myqe5WsbeaCRHSHEWEmOkJ+UmQ1qgGdDKPjLVH096j0zXPhiaTLNMuSLhHT0sKsv2tXwqUkjfvxjkJgsdt7FalDo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3554.namprd15.prod.outlook.com (2603:10b6:a03:1b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Tue, 4 Aug
 2020 00:40:15 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 00:40:15 +0000
Date:   Mon, 3 Aug 2020 17:40:12 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <20200804004012.GA1049259@carbon.dhcp.thefacebook.com>
References: <20200714173920.3319063-1-guro@fb.com>
 <alpine.LSU.2.11.2007291902340.6363@eggly.anvils>
 <20200730162348.GA679955@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
 <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007311915130.9716@eggly.anvils>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007311915130.9716@eggly.anvils>
X-ClientProxiedBy: BY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:99ff) by BY5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:a03:1a0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 00:40:14 +0000
X-Originating-IP: [2620:10d:c090:400::5:99ff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08242036-ca85-4e35-5ac3-08d8380ef43a
X-MS-TrafficTypeDiagnostic: BY5PR15MB3554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3554DFC55247030AEC5A90D1BE4A0@BY5PR15MB3554.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89HF7wwBZDUX8k/95zaXuYXszDsA4ZRin5N4sTTWTDJ4dhrBZc4xU2NxrcEmt/xgBYyiaIfVi2FGLhwgw87hXmSL2fqWr3u9goqkkVsBvVo4bBG7k19YQCGxYaWKiuDszrATooJZX10tK34F/Y9FrsjTMY3bsNNKrgAp0kp5aGSXKiuOw693wmOD08AX9E0XdjPArmfAj4EkZEMZEAIfBqQFTprRbirLu2dW5GDmETNRlDvIo8pig+fzCVK6j4waneHtRTWxkfc5fP3aOkY1BtUkaMcDlAW8FFIJLhFUIGOHFOKGZVySb0+MmXt4oVs6ATGXMaHEnx1ULZiBx5jqtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(346002)(366004)(376002)(83380400001)(55016002)(6506007)(33656002)(5660300002)(7696005)(52116002)(2906002)(86362001)(478600001)(6916009)(9686003)(316002)(186003)(66476007)(66946007)(54906003)(4326008)(1076003)(8676002)(16526019)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IVVCY+0eaWNc9JG4p4pUaCczudoIZc+1YhI2UQd042dH2ST2IgooghHCtFgbzBs0VbGTgdvnZf0NvXjpfVQqppAem1Msu6e7Tlvh33e3+Xr4UbhRzB0ifjz8mtCgmKgWJENcqEvAurmDduQtjQ8T2amTaXET+kWOZZmBalsG69qFvc3gdMd2FrpKXhvoRi8qVhvQq4lg+Rx/nJonVTPBGXHf/EAZOoCPOWzIxTNtoIfCOOBpAhq9uupqmMAXYliqwlSe0NuPqwi+9B22gQ5cLyVV5NL29w5F9lCbaPAJw+H1vFhpNZCH5GWSXkfPvthO1MOvdJRB1GqQduoKnDugGcNWgCErlHKZVBnJCnbcBUJRZA2n3WBxjhas+GX10HNt0zD6oRK3/d2d24RG/hfZizNAbgCObtMD9JDtAH8bIdeB+zw50Q7izaMTAtOTXmVj4O9oS2nAhZLy0tAAVUHglMpRZp5IPEgYGZVpKDVd8xpcydMnub8t3DIE5VZHSG3NYo2m/itDPl3IFrOwoFV95pHkEu4nvo5wNizcuZwNMJ9SWRPy8GCm7SjP/01itpZ0iDbLd5JYuc4ZCLq6hbUlHadDF9LTTBVkWdxwQdgilXNNKpZ8PkYeuYiMfwt2/n37EKWTs47hvtJuIecuZmjzvzlANB5nSxHB1InOzsDGfXE=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08242036-ca85-4e35-5ac3-08d8380ef43a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 00:40:15.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3iu3LKa6xP5mL3J47F2L9JkPIedWsSd9G/uzY0aaZvntjO4s0OoiRxAgxmkjf6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3554
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=5
 impostorscore=0 adultscore=0 clxscore=1011 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 07:17:05PM -0700, Hugh Dickins wrote:
> On Fri, 31 Jul 2020, Roman Gushchin wrote:
> > On Thu, Jul 30, 2020 at 09:06:55PM -0700, Hugh Dickins wrote:
> > > 
> > > Though another alternative did occur to me overnight: we could
> > > scrap the logged warning, and show "nr_whatever -53" as output
> > > from /proc/sys/vm/stat_refresh: that too would be acceptable
> > > to me, and you redirect to /dev/null.
> > 
> > It sounds like a good idea to me. Do you want me to prepare a patch?
> 
> Yes, if you like that one best, please do prepare a patch - thanks!

Hi Hugh,

I mastered a patch (attached below), but honestly I can't say I like it.
The resulting interface is confusing: we don't generally use sysctls to
print debug data and/or warnings.

I thought about treating a write to this sysctls as setting the threshold,
so that "echo 0 > /proc/sys/vm/stat_refresh" would warn on all negative
entries, and "cat /proc/sys/vm/stat_refresh" would use the default threshold
as in my patch. But this breaks  to some extent the current ABI, as passing
an incorrect value will result in -EINVAL instead of passing (as now).

Overall I still think we shouldn't warn on any values inside the possible
range, as it's not an indication of any kind of error. The only reason
why we see some values going negative and some not, is that some of them
are updated more frequently than others, and some are bouncing around
zero, while other can't reach zero too easily (like the number of free pages).

Actually, if someone wants to ensure that numbers are accurate,
we have to temporarily set the threshold to 0, then flush the percpu data
and only then check atomics. In the current design flushing percpu data
matters for only slowly updated counters, as all others will run away while
we're waiting for the flush. So if we're targeting some slowly updating
counters, maybe we should warn only on them being negative, Idk.

Thanks!

--

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6eecfcbbfe79..1d2f2471bb78 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1815,13 +1815,28 @@ static void refresh_vm_stats(struct work_struct *work)
        refresh_cpu_vm_stats(true);
 }
 
+static void warn_vmstat(void *buffer, size_t *lenp, loff_t *ppos,
+                       const char *name, long val)
+{
+       int len;
+
+       len = snprintf(buffer + *ppos, *lenp, "%s %lu\n", name, val);
+       *lenp -= len;
+       *ppos += len;
+}
+
 int vmstat_refresh(struct ctl_table *table, int write,
                   void *buffer, size_t *lenp, loff_t *ppos)
 {
-       long val, max_drift;
+       long val;
        int err;
        int i;
 
+       if (!*lenp || (*ppos && !write)) {
+               *lenp = 0;
+               return 0;
+       }
+
        /*
         * The regular update, every sysctl_stat_interval, may come later
         * than expected: leaving a significant amount in per_cpu buckets.
@@ -1837,35 +1852,24 @@ int vmstat_refresh(struct ctl_table *table, int write,
        /*
         * Since global_zone_page_state() etc. are so careful to hide
         * transiently negative values, report an error here if any of
-        * the stats is negative and are less than the maximum drift value,
-        * so we know to go looking for imbalance.
+        * the stats is negative, so we know to go looking for imbalance.
         */
-       max_drift = num_online_cpus() * MAX_THRESHOLD;
-
        for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
                val = atomic_long_read(&vm_zone_stat[i]);
-               if (val < -max_drift) {
-                       pr_warn("%s: %s %ld\n",
-                               __func__, zone_stat_name(i), val);
-                       err = -EINVAL;
-               }
+               if (!write && val < 0)
+                       warn_vmstat(buffer, lenp, ppos, zone_stat_name(i), val);
        }
 #ifdef CONFIG_NUMA
        for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
                val = atomic_long_read(&vm_numa_stat[i]);
-               if (val < -max_drift) {
-                       pr_warn("%s: %s %ld\n",
-                               __func__, numa_stat_name(i), val);
-                       err = -EINVAL;
-               }
+               if (!write && val < 0)
+                       warn_vmstat(buffer, lenp, ppos, numa_stat_name(i), val);
        }
 #endif
        if (err)
                return err;
        if (write)
                *ppos += *lenp;
-       else
-               *lenp = 0;
        return 0;
 }
 #endif /* CONFIG_PROC_FS */
