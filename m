Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE8DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B579420853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UrkH/y/4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OjoiH5dZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGASq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:46:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgGASqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:46:25 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 061IhgUg032477;
        Wed, 1 Jul 2020 11:46:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=afUte7+Mrxuda9SX/DEJRyVmNpDKpCp4wArQIplIai4=;
 b=UrkH/y/4BQzl6tUHhDQ+Vag/3f53acCnYMcJ8UbtZRVpV+oM9tnal1KmMAkl8G9cYxyY
 71lpsbVk1jDeIQWGcln+UzHkI8MJVN2G+lbOzSamHb2yxttiNTplki1mB9G58pMMBCg/
 zub1fOHt4p8J2FFX7MOFajLY0LeXOTzyOR8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31ykcjbswj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Jul 2020 11:46:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 1 Jul 2020 11:46:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZplhdicCF2ewY8OSjirVZ5dEX4deZMeZFDJA62+kWnMJmD3UfkQfw/2cBSkHHz+UgB2pIfXqm7Xlmr0BhznH/ykupUTeq5TfIualOdAVjo/iEPMimTx6RokGQuv78b2/NY9UpceOIKbbmrftSJ87p6KGhMQBlUwNjEsoh0dsR/KIVuV0Y5SX+MOzF9SV9zcx2uD/hNUf5OO5Uaptio+u7E3xPDjchrKSmgRkCZf6nJXeNjmavLtvFAT4LZ2GZMnDN71eUANt7Ww/JEQmZxgBL3QOrnyrtvj2d614DP8MxkRVJv96h/fS3s9amqS6G78ZYy6NSUbPmyAUsKodda0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afUte7+Mrxuda9SX/DEJRyVmNpDKpCp4wArQIplIai4=;
 b=a/xzKeHQYMUjvhhJB1tJsSQv6TLWk7Aoq+5StpDSqjSKQlOr2fJnFMovDasA9lPcu1rF5AcDJx4/VxAt8E3PILzIvVUM2toxQ2u8V1qRJpOSi7i+ke7/yUVEHbno50+WCtpCNJZFUAAiLVNlDcBqoA4gfo4RlEQE7IJlYgeT0559xyz++Cpfo2RCteD9BIQnbSJa7DeiqtsLum3tA4zHz+nCTiEzgFGX964NRo1ipJORhP4w8WAxwODtKfu11zrFV170pFnYni6eBGCHfpHdtfvSmXDwLs32+C+hXvU7xpxN5O0uc2rdtyyyoQ/Selc3lXPfjMCgX+bAv2OgERaUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afUte7+Mrxuda9SX/DEJRyVmNpDKpCp4wArQIplIai4=;
 b=OjoiH5dZtExfqVjdCX/+VEszMKVdzpQW1St+hnbFnRhy/ww1D4K4M/ShTLN7jLV4XlhB2HEL4VoVAS1/dOisM9Vhbp7Vm62VMSikQqHnH4rihmzlyEYatP/uHZLkm/cju39LMIcL6KIss0o0gx5B+sMiJz5xXhfdV/r/fvq66gY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3791.namprd15.prod.outlook.com
 (2603:10b6:806:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Wed, 1 Jul
 2020 18:45:56 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::197f:d445:824d:1efa]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::197f:d445:824d:1efa%6]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 18:45:56 +0000
Date:   Wed, 1 Jul 2020 11:45:52 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>, Chris Down <chris@chrisdown.name>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701082904.GM2369@dhcp22.suse.cz>
X-ClientProxiedBy: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fb80) by BYAPR08CA0033.namprd08.prod.outlook.com (2603:10b6:a03:100::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24 via Frontend Transport; Wed, 1 Jul 2020 18:45:55 +0000
X-Originating-IP: [2620:10d:c090:400::5:fb80]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe5060c2-0c6e-4e6a-c8f6-08d81deefd1c
X-MS-TrafficTypeDiagnostic: SA0PR15MB3791:
X-Microsoft-Antispam-PRVS: <SA0PR15MB379145D26C41922D9B355591BE6C0@SA0PR15MB3791.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6YPflAr9xjjumjmEOlLO9t3iTtiwipmzxU07ox+UUN5LKrPIu53+Vb/5ZlcapWCMVhTfgjHR8JxHQUuiB9HNtIufQljv00I/7Lz9OB8h1wx0Q8vsyUiER6/B0Gh4CH6+4MBNDvpopUoHtnWNkclkoe4BUynMHPWv9de3Jid+oE56joYuOh71saq7XDzq8f+SJQB4Rc5kDxlAIzoV1YXoudcWoTrsfVBFDVbg13kfZ0x/1jhSVf0ikDXtlIbYBtXmnNWlWJxHyh1FCb5jpIju6esjnoNtqbX/8ekCUSLVswWMqem0XVT0kmkhFji+Ob2F2CLiNDH4YroOaruzRdmEjMQg4mnqapIQtWLaMYm8T3p3FdNXhi6+c7hv4pXozfjc+P1Jw1n7Y5iL2I7fmyp/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(33656002)(83380400001)(53546011)(6916009)(316002)(6506007)(5660300002)(52116002)(7696005)(16526019)(66556008)(4326008)(186003)(45080400002)(54906003)(6666004)(9686003)(8936002)(478600001)(86362001)(8676002)(966005)(1076003)(66946007)(66476007)(2906002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hRC5Ww+7SZR0f8Rdtg1CYqyAP0u/tJgjQYsZZ45dWuTGg89W3qhFS0uzXg5EbOfNWAebnirsnM1nQpQEPgb0+j2E6F36tgikJC51XS1K0+rWJAEn94MeTDiASaoQ8ktceoWFnR6nOAx/t7BDOgvpBSXsffo4QL63eKCVIoUB366+LFFrPM98no10rxwKZr0PVscg0P2dCaHTatwGRJUi3BM0xVIqnekXRKP/od2SAj7smehEVO5PWiV4+9Z8KJOB6fAW49Nrhd+YcXN6VIDks9AisRw3o8dhV89wIdpdYWI8ZRn2mvC+eh1vhbCB4e0iDVV3kkGlgZ7G01w4c5y+clKzreG+2vKMXdmSrWiIxYcvTO+Lp+ldhwsOpoOzRQcFYdCcz/AjXJEA7Zw5K8Gt1ChgZfb/hVBVuJ6hKUAZ7o5FqwKEuoOGo63TTZtkkALos9Gi34DOl70/FzvnCHli+KJ7F9aS4+zYNxOiIJSPrnijkNqy4HOHllFqmpRGJac0jtYGKIpPSXCYeDML35j9BQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5060c2-0c6e-4e6a-c8f6-08d81deefd1c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 18:45:56.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzicyzXu2ocDPHTfnmxhxWXaC2W+neeUfOBkDVt9aKjbSfmI0wsVF7MxTnsSOd9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3791
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_10:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010130
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:29:04AM +0200, Michal Hocko wrote:
> Smells like a different observable problem with the same/similar culprit
> as http://lkml.kernel.org/r/CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNspc=OzzFhL=xRQ@mail.gmail.com
> 
> On Wed 01-07-20 13:48:57, Naresh Kamboju wrote:
> > While running LTP mm test suite on x86_64 device the BUG: Bad page
> > state in process
> > noticed on linux-next 20200630 tag.
> > 
> > Steps to reproduce:
> > - boot linux-next 20200630 kernel on x86_64 device
> > - cd /opt/ltp
> > - ./runltp -f mm
> > 
> > metadata:
> >   git branch: master
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   git commit: f2b92b14533e646e434523abdbafddb727c23898
> >   git describe: next-20200630
> >   kernel-config:
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__builds.tuxbuild.com_j60yrp7CUpq3LCmqMB8Wdg_kernel.config&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=h_KJ0e7abuh0BK2eDlDmWnAxqHPccpqchPgBS-oJcVE&s=qofg2XRToTeHvi8vSdOvDPtKpJsUqf3IWfqwieZqITg&e= 
> > 
> > Test crash dump:
> > [  803.905169] Node 0 Normal: 2608*4kB (UMEH) 1380*8kB (UMEH) 64*16kB
> > (MEH) 28*32kB (MEH) 13*64kB (UMEH) 164*128kB (UMEH) 39*256kB (UE)
> > 1*512kB (M) 1*1024kB (M) 1*2048kB (M) 1*4096kB (M) = 62880kB
> > [  803.922375] Node 0 hugepages_total=0 hugepages_free=0
> > hugepages_surp=0 hugepages_size=2048kB
> > [  803.930806] 2418 total pagecache pages
> > [  803.934559] 0 pages in swap cache
> > [  803.937878] Swap cache stats: add 0, delete 0, find 0/0
> > [  803.943108] Free swap  = 0kB
> > [  803.945997] Total swap = 0kB
> > [  803.948885] 4181245 pages RAM
> > [  803.951857] 0 pages HighMem/MovableOnly
> > [  803.955695] 626062 pages reserved
> > [  803.959016] Tasks state (memory values in pages):
> > [  803.963722] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
> > swapents oom_score_adj name
> > [  803.972336] [    332]     0   332     8529      507   106496
> > 0             0 systemd-journal
> > [  803.981387] [    349]     0   349    10730      508   118784
> > 0         -1000 systemd-udevd
> > [  803.990262] [    371]   993   371     8666      108   118784
> > 0             0 systemd-network
> > [  803.999306] [    379]   992   379     9529       99   110592
> > 0             0 systemd-resolve
> > [  804.008347] [    388]     0   388     2112       19    61440
> > 0             0 syslogd
> > [  804.016709] [    389]   995   389     9308      108   122880
> > 0             0 avahi-daemon
> > [  804.025517] [    391]     0   391     1075       21    57344
> > 0             0 acpid
> > [  804.033695] [    394]   995   394     9277       68   114688
> > 0             0 avahi-daemon
> > [  804.042476] [    396]   996   396     7241      154   102400
> > 0          -900 dbus-daemon
> > [  804.051170] [    397]     0   397     2313       72    65536
> > 0             0 crond
> > [  804.059349] [    399]     0   399    34025      161   167936
> > 0             0 thermald
> > [  804.067783] [    400]     0   400     8615      115   110592
> > 0             0 systemd-logind
> > [  804.076734] [    401]     0   401     2112       32    57344
> > 0             0 klogd
> > [  804.084907] [    449] 65534   449     3245       39    69632
> > 0             0 dnsmasq
> > [  804.093254] [    450]     0   450     3187       33    73728
> > 0             0 agetty
> > [  804.101541] [    452]     0   452     3187       33    73728
> > 0             0 agetty
> > [  804.109826] [    453]     0   453    14707      107   159744
> > 0             0 login
> > [  804.118007] [    463]     0   463     9532      163   122880
> > 0             0 systemd
> > [  804.126362] [    464]     0   464    16132      424   172032
> > 0             0 (sd-pam)
> > [  804.134803] [    468]     0   468     4538      105    81920
> > 0             0 sh
> > [  804.142741] [    472]     0   472    11102       83   131072
> > 0             0 su
> > [  804.150680] [    473]     0   473     4538       99    81920
> > 0             0 sh
> > [  804.158637] [    519]     0   519     2396       57    61440
> > 0             0 lava-test-runne
> > [  804.167700] [   1220]     0  1220     2396       52    61440
> > 0             0 lava-test-shell
> > [  804.176738] [   1221]     0  1221     2396       55    61440
> > 0             0 sh
> > [  804.184680] [   1223]     0  1223     2462      135    61440
> > 0             0 ltp.sh
> > [  804.192946] [   1242]     0  1242     2462      134    61440
> > 0             0 ltp.sh
> > [  804.201207] [   1243]     0  1243     2462      134    61440
> > 0             0 ltp.sh
> > [  804.209475] [   1244]     0  1244     2462      134    61440
> > 0             0 ltp.sh
> > [  804.217742] [   1245]     0  1245     2561      229    65536
> > 0             0 runltp
> > [  804.226010] [   1246]     0  1246     1072       15    53248
> > 0             0 tee
> > [  804.234012] [   1313]     0  1313     1070       29    53248
> > 0             0 ltp-pan
> > [  804.242374] [   3216]     0  3216     1613       20    53248
> > 0             0 oom01
> > [  804.250554] [   3217]     0  3217     1646       31    57344
> > 0             0 oom01
> > [  804.258728] [   3245]     0  3245    81271      469   266240
> > 0             0 NetworkManager
> > [  804.267688] [   3249]     0  3249     6422       54    98304
> > 0             0 systemd-hostnam
> > [  804.276734] [   3250]     0  3250    52976      178   172032
> > 0             0 nm-dispatcher
> > [  804.285603] [   3254]   998  3254   131113      828   245760
> > 0             0 polkitd
> > [  804.293956] [   3261]     0  3261  4726385  3349389 26939392
> > 0             0 oom01
> > [  804.302129] [   3265]     0  3265     3187       33    73728
> > 0             0 agetty
> > [  804.310397] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=oom01,pid=3261,uid=0
> > [  804.322751] Out of memory: Killed process 3261 (oom01)
> > total-vm:18905540kB, anon-rss:13397556kB, file-rss:0kB, shmem-rss:0kB,
> > UID:0 pgtables:26308kB oom_score_adj:0
> > [  806.652952] oom_reaper: reaped process 3261 (oom01), now
> > anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> > [  807.579373] BUG: Bad page state in process kworker/u8:12  pfn:374308
> > [  807.579521] BUG: Bad page state in process kworker/u8:13  pfn:4182a4
> > [  807.585734] page:ffffea000dd0c200 refcount:0 mapcount:0
> > mapping:0000000000000000 index:0xffff88837430e000
> > head:ffffea000dd0c200 order:3 compound_mapcount:0 compound_pincount:0
> > [  807.585736] flags: 0x200000000010000(head)
> > [  807.585740] raw: 0200000000010000 ffffea000dce6e00 0000000200000002
> > 0000000000000000
> > [  807.592099] page:ffffea001060a900 refcount:0 mapcount:0
> > mapping:0000000000000000 index:0xffff8884182a5e00
> > head:ffffea001060a900 order:1 compound_mapcount:0
> > [  807.607719] raw: ffff88837430e000 0000000000040000 00000000ffffffff
> > ffff8883bda6cac1
> > [  807.607720] page dumped because: page still charged to cgroup
> > [  807.607720] page->mem_cgroup:ffff8883bda6cac1
> > [  807.607721] Modules linked in: x86_pkg_temp_thermal
> > [  807.607725] CPU: 0 PID: 3242 Comm: kworker/u8:12 Not tainted
> > 5.8.0-rc3-next-20200630 #1
> > [  807.607727] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.0b 07/27/2017
> > [  807.607731] Workqueue: rpciod rpc_async_schedule
> > [  807.611836] flags: 0x200000000010000(head)
> > [  807.619563] Call Trace:
> > [  807.619567]  dump_stack+0x84/0xba
> > [  807.619569]  bad_page.cold+0x7b/0xac
> > [  807.619573]  __free_pages_ok+0x95b/0xab0
> > [  807.633461] raw: 0200000000010000 dead000000000100 dead000000000122
> > 0000000000000000
> > [  807.641189]  __free_pages+0x42/0x50
> > [  807.641191]  __free_slab+0xcd/0x1f0

Hm, interesting, it means that page->obj_cgroups is still set.
But before __free_pages() __free_slab() always calls uncharge_slab_page(),
which sets page->obj_cgroups to NULL except when !memcg_kmem_enabled().

So it makes me think that somehow memcg_kmem_enabled() became false
after being true, which can cause refcounting problems as well.

Naresh, can you, please, check if the following patch solves problems?
And thank you for reporting the problem!

--

From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 1 Jul 2020 11:05:32 -0700
Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible

Historically the kernel memory accounting was an opt-in feature, which
could be enabled for individual cgroups. But now it's not true, and
it's on by default both on cgroup v1 and cgroup v2.  And as long as a
user has at least one non-root memory cgroup, the kernel memory
accounting is on. So in most setups it's either always on (if memory
cgroups are in use and kmem accounting is not disabled), either always
off (otherwise).

memcg_kmem_enabled() is used in many places to guard the kernel memory
accounting code. If memcg_kmem_enabled() can reverse from returning
true to returning false (as now), we can't rely on it on release paths
and have to check if it was on before.

If we'll make memcg_kmem_enabled() irreversible (always returning true
after returning it for the first time), it'll make the general logic
more simple and robust. It also will allow to guard some checks which
otherwise would stay unguarded.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 50ae77f3985e..2d018a51c941 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3582,7 +3582,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 
-	static_branch_inc(&memcg_kmem_enabled_key);
+	if (!memcg_kmem_enabled())
+		static_branch_inc(&memcg_kmem_enabled_key);
 	/*
 	 * A memory cgroup is considered kmem-online as soon as it gets
 	 * kmemcg_id. Setting the id after enabling static branching will
@@ -3643,9 +3644,6 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
 	/* css_alloc() failed, offlining didn't happen */
 	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
 		memcg_offline_kmem(memcg);
-
-	if (memcg->kmem_state == KMEM_ALLOCATED)
-		static_branch_dec(&memcg_kmem_enabled_key);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
-- 
2.26.2

