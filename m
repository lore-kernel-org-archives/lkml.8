Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C37C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71FC207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p73conPT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RNSPDWUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGBP7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:59:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgGBP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:59:52 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 062FujQU000910;
        Thu, 2 Jul 2020 08:59:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KGhF1Yui7oVknVKjxued1ScC4zlcRaN90AYFYnGENx8=;
 b=p73conPTo5P7sWQnSdouYTsXB+LTR/aFPLVOkPbadyRiR1FaANuSpSL42U+eSE8T6AcX
 63lLerzV66CAeW4HcZa/QJ7/qjYJocWbjM0XoUDOl0pxYf5/zfiSe+Nsr5HijvbLFmnw
 3CD3Dt9vpWQwSwB3xIWNK04vGPPSDhNxqdM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3216k831au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Jul 2020 08:59:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 08:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TetdB8TknuoPDQPHvGK8ByUMw7ZQ0/xLmGUPa/5W0JAeiRuV2bxL/P8aqgdmeiajK5cwq+KAWNiDknz4rjZSQoFZHERsECjRKDF9NFL3nZ3EFdJ8H/3TBFOr/9ynKcVe+NVpNCXtqt+LMj67AQZ7PGQPZ0qKl33vZjGwSIQ/p4FjL7WwktlECpGDdaNHIJjIc7yEcueiW0y1HNdfqSJaI6OyrLyWn5ibR7tIJNYOTGM+64r/rpnyHQFZIV5QAJEzbTNmCQ1Tyz1CKcwOedT5FL8qmBm7ch3r1MYJ4HQel9H/pejuYFLTv3yS44zdcFChbFRqN0QRtYNYaceNIV3lTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGhF1Yui7oVknVKjxued1ScC4zlcRaN90AYFYnGENx8=;
 b=FQJAxB5iBo3Xp0qdg3QSmSd8sMaX7i1Rw7L08C+Hrg1UbO/fdXnSq6hW61Vwfj9cX6ZJeAEsGikg+Erw46Ib7U1YDxii+8Iq/Kk03oK1aN4+LVJTvq1V+Bynn2nnPJVkLLaRVyNQLm6zobxB7FL5bvZLRSDaOOdaGn59OBWR8QJf/56mPiLxPEFeIVPqy4hvgZL3Thx5tZXlM3RM8N01xdH7crbTEPtFbtcUZvnwisR/pYO3tgaBO0zX1/BCv1cvumBeqxfl+JxW3WCmc5qazbA7LR6yd0gCkWF7TKGIny/1dO6eqJtc1zaye4/PL3J5L9psJO9Lw+EQTcrWO5buBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGhF1Yui7oVknVKjxued1ScC4zlcRaN90AYFYnGENx8=;
 b=RNSPDWUsjD6Q4M5nkJOTmxTQ4fDrVf+1W+DNN/S0iAGCLeASzbPs/Groh0pRPRvKC4A51fEba0ZNFSDK9u4T67nzTrAQ2rsvS8NcAeD6Y6mWpyDMZKMxjHEy0MzDjwqXwdiL725ZKBXWcCIKOXfKTZ7SKM/cR2FiQUnqnhGqNQU=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3523.namprd15.prod.outlook.com (2603:10b6:a03:1ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 15:59:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.034; Thu, 2 Jul 2020
 15:59:38 +0000
Date:   Thu, 2 Jul 2020 08:59:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>, Chris Down <chris@chrisdown.name>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200702155935.GB90961@carbon.dhcp.thefacebook.com>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
 <CA+G9fYvC_+Gmab=b5pJW+5m1cR=JnLKLuMfxh3p-j8XKBzseSA@mail.gmail.com>
 <20200702154920.GA90961@carbon.dhcp.thefacebook.com>
 <CA+G9fYs7y+FHhcExWp96W5j-NVqv_8nR4Pz7cex5ttb-L7QQqA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs7y+FHhcExWp96W5j-NVqv_8nR4Pz7cex5ttb-L7QQqA@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::43) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b0bf) by BY5PR16CA0030.namprd16.prod.outlook.com (2603:10b6:a03:1a0::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Thu, 2 Jul 2020 15:59:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:b0bf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b09edffc-2d47-479f-cf0c-08d81ea0ec23
X-MS-TrafficTypeDiagnostic: BY5PR15MB3523:
X-Microsoft-Antispam-PRVS: <BY5PR15MB352326E589857ED57A5C0954BE6D0@BY5PR15MB3523.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1LIj11xsGOt9GqXbCYAtt4dQf09WVc+2tmjvQdFKsGvXF6gHGg4oR7rZTCsW2pItnJ1+AuNm27Ae5j7nmt0vQcidJfsxhNj/oy+bYXRDxkmf0DRLdhyGNBGTUQdMuKxNH0Ua0HcYltagwFwE1O6JhPfVxED+p7v+uwsUnTX0P/+X5se6mO4chGcV2nshgnujW0iblJrOy7HmLhXx7YMymbNlXHwBQssA84oSzpaQv+Is6sqLEfbqmHzcsdobesN80U1LkUv1SRXHvwRGi4w91FGGqXe4dGpCfMMxSGt5l2ubsCLCdrhXzqImYBC809O7ttk4Y6voupGVB16zuQHLoixI2Y//MlbEc6URBS2ud+v5WzUZWP6kC+wsPZA7viUxIyERZGxJ7k0f40mC1OSMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(55016002)(66556008)(1076003)(5660300002)(66946007)(8676002)(6916009)(30864003)(66476007)(8936002)(33656002)(2906002)(45080400002)(478600001)(6506007)(966005)(9686003)(7696005)(52116002)(83380400001)(316002)(16526019)(86362001)(4326008)(54906003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: at6nxMki0HdFxLMKGdsdXu5GI2sYwOTrpAJpJdd9cS9Hnyja6KHKObHau5X82SvcL3TmGeCSRIvYwTbCuiqS59GWZU/TcV25YesDDDHA48SmdXEDY3uggaURtbNFD58OuBWTm1EwtK6OqJRUTASMOposklJryIqwUMOnd/i8bCihn4vxKdbcnoWVanigLWZiQ9/jD0LHlbB7pgh074GRb+zxhHCfkPy37U/M0GTpUdSAy1/bANIHAIurAuiRXfkvBAFQAfNm3im+I/y8Lm/idJY2hxg+02gUs8/EPsiauDkzrj5HzdTp3BDblQG3lSNYcjRAqPHLdCpAbpiCIlNwu6e8lzbYWFX7Obx/s4xkytsF9q/2x4Zp1WHpq+5uwUDpMW6w/NfIjryDulQEkd8VX1D9ZpnZ+kGwmnCXOB6mrgsSMqh332d+TZTupNGOUepRmmp9oSmw986vbibO5mNXUQ3yUywWODH3VT5HR9Tx5R3bM7qa2M4113fEIBinKDqsYt1bIeBpPq4yCMXsbRI9Lg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b09edffc-2d47-479f-cf0c-08d81ea0ec23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 15:59:37.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oMevD8Pnf0sXWLIk/pm6TnakS1b2EAXBwWmfuer2GsUjHK+DDIu1L/mJU8+SeUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3523
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_09:2020-07-02,2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020110
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 09:25:08PM +0530, Naresh Kamboju wrote:
> On Thu, 2 Jul 2020 at 21:19, Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Jul 02, 2020 at 12:22:03PM +0530, Naresh Kamboju wrote:
> > > On Thu, 2 Jul 2020 at 00:16, Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Wed, Jul 01, 2020 at 10:29:04AM +0200, Michal Hocko wrote:
> > > > > Smells like a different observable problem with the same/similar culprit
> > > > > as http://lkml.kernel.org/r/CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNspc=OzzFhL=xRQ@mail.gmail.com
> > > > >
> > > > > On Wed 01-07-20 13:48:57, Naresh Kamboju wrote:
> > > > > > While running LTP mm test suite on x86_64 device the BUG: Bad page
> > > > > > state in process
> > > > > > noticed on linux-next 20200630 tag.
> > > > > >
> > > > > > Steps to reproduce:
> > > > > > - boot linux-next 20200630 kernel on x86_64 device
> > > > > > - cd /opt/ltp
> > > > > > - ./runltp -f mm
> > > > > >
> > > > > > metadata:
> > > > > >   git branch: master
> > > > > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > > > >   git commit: f2b92b14533e646e434523abdbafddb727c23898
> > > > > >   git describe: next-20200630
> > > > > >   kernel-config:
> > > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__builds.tuxbuild.com_j60yrp7CUpq3LCmqMB8Wdg_kernel.config&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=h_KJ0e7abuh0BK2eDlDmWnAxqHPccpqchPgBS-oJcVE&s=qofg2XRToTeHvi8vSdOvDPtKpJsUqf3IWfqwieZqITg&e=
> > > > > >
> > > > > > Test crash dump:
> > > > > > [  803.905169] Node 0 Normal: 2608*4kB (UMEH) 1380*8kB (UMEH) 64*16kB
> > > > > > (MEH) 28*32kB (MEH) 13*64kB (UMEH) 164*128kB (UMEH) 39*256kB (UE)
> > > > > > 1*512kB (M) 1*1024kB (M) 1*2048kB (M) 1*4096kB (M) = 62880kB
> > > > > > [  803.922375] Node 0 hugepages_total=0 hugepages_free=0
> > > > > > hugepages_surp=0 hugepages_size=2048kB
> > > > > > [  803.930806] 2418 total pagecache pages
> > > > > > [  803.934559] 0 pages in swap cache
> > > > > > [  803.937878] Swap cache stats: add 0, delete 0, find 0/0
> > > > > > [  803.943108] Free swap  = 0kB
> > > > > > [  803.945997] Total swap = 0kB
> > > > > > [  803.948885] 4181245 pages RAM
> > > > > > [  803.951857] 0 pages HighMem/MovableOnly
> > > > > > [  803.955695] 626062 pages reserved
> > > > > > [  803.959016] Tasks state (memory values in pages):
> > > > > > [  803.963722] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
> > > > > > swapents oom_score_adj name
> > > > > > [  803.972336] [    332]     0   332     8529      507   106496
> > > > > > 0             0 systemd-journal
> > > > > > [  803.981387] [    349]     0   349    10730      508   118784
> > > > > > 0         -1000 systemd-udevd
> > > > > > [  803.990262] [    371]   993   371     8666      108   118784
> > > > > > 0             0 systemd-network
> > > > > > [  803.999306] [    379]   992   379     9529       99   110592
> > > > > > 0             0 systemd-resolve
> > > > > > [  804.008347] [    388]     0   388     2112       19    61440
> > > > > > 0             0 syslogd
> > > > > > [  804.016709] [    389]   995   389     9308      108   122880
> > > > > > 0             0 avahi-daemon
> > > > > > [  804.025517] [    391]     0   391     1075       21    57344
> > > > > > 0             0 acpid
> > > > > > [  804.033695] [    394]   995   394     9277       68   114688
> > > > > > 0             0 avahi-daemon
> > > > > > [  804.042476] [    396]   996   396     7241      154   102400
> > > > > > 0          -900 dbus-daemon
> > > > > > [  804.051170] [    397]     0   397     2313       72    65536
> > > > > > 0             0 crond
> > > > > > [  804.059349] [    399]     0   399    34025      161   167936
> > > > > > 0             0 thermald
> > > > > > [  804.067783] [    400]     0   400     8615      115   110592
> > > > > > 0             0 systemd-logind
> > > > > > [  804.076734] [    401]     0   401     2112       32    57344
> > > > > > 0             0 klogd
> > > > > > [  804.084907] [    449] 65534   449     3245       39    69632
> > > > > > 0             0 dnsmasq
> > > > > > [  804.093254] [    450]     0   450     3187       33    73728
> > > > > > 0             0 agetty
> > > > > > [  804.101541] [    452]     0   452     3187       33    73728
> > > > > > 0             0 agetty
> > > > > > [  804.109826] [    453]     0   453    14707      107   159744
> > > > > > 0             0 login
> > > > > > [  804.118007] [    463]     0   463     9532      163   122880
> > > > > > 0             0 systemd
> > > > > > [  804.126362] [    464]     0   464    16132      424   172032
> > > > > > 0             0 (sd-pam)
> > > > > > [  804.134803] [    468]     0   468     4538      105    81920
> > > > > > 0             0 sh
> > > > > > [  804.142741] [    472]     0   472    11102       83   131072
> > > > > > 0             0 su
> > > > > > [  804.150680] [    473]     0   473     4538       99    81920
> > > > > > 0             0 sh
> > > > > > [  804.158637] [    519]     0   519     2396       57    61440
> > > > > > 0             0 lava-test-runne
> > > > > > [  804.167700] [   1220]     0  1220     2396       52    61440
> > > > > > 0             0 lava-test-shell
> > > > > > [  804.176738] [   1221]     0  1221     2396       55    61440
> > > > > > 0             0 sh
> > > > > > [  804.184680] [   1223]     0  1223     2462      135    61440
> > > > > > 0             0 ltp.sh
> > > > > > [  804.192946] [   1242]     0  1242     2462      134    61440
> > > > > > 0             0 ltp.sh
> > > > > > [  804.201207] [   1243]     0  1243     2462      134    61440
> > > > > > 0             0 ltp.sh
> > > > > > [  804.209475] [   1244]     0  1244     2462      134    61440
> > > > > > 0             0 ltp.sh
> > > > > > [  804.217742] [   1245]     0  1245     2561      229    65536
> > > > > > 0             0 runltp
> > > > > > [  804.226010] [   1246]     0  1246     1072       15    53248
> > > > > > 0             0 tee
> > > > > > [  804.234012] [   1313]     0  1313     1070       29    53248
> > > > > > 0             0 ltp-pan
> > > > > > [  804.242374] [   3216]     0  3216     1613       20    53248
> > > > > > 0             0 oom01
> > > > > > [  804.250554] [   3217]     0  3217     1646       31    57344
> > > > > > 0             0 oom01
> > > > > > [  804.258728] [   3245]     0  3245    81271      469   266240
> > > > > > 0             0 NetworkManager
> > > > > > [  804.267688] [   3249]     0  3249     6422       54    98304
> > > > > > 0             0 systemd-hostnam
> > > > > > [  804.276734] [   3250]     0  3250    52976      178   172032
> > > > > > 0             0 nm-dispatcher
> > > > > > [  804.285603] [   3254]   998  3254   131113      828   245760
> > > > > > 0             0 polkitd
> > > > > > [  804.293956] [   3261]     0  3261  4726385  3349389 26939392
> > > > > > 0             0 oom01
> > > > > > [  804.302129] [   3265]     0  3265     3187       33    73728
> > > > > > 0             0 agetty
> > > > > > [  804.310397] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=oom01,pid=3261,uid=0
> > > > > > [  804.322751] Out of memory: Killed process 3261 (oom01)
> > > > > > total-vm:18905540kB, anon-rss:13397556kB, file-rss:0kB, shmem-rss:0kB,
> > > > > > UID:0 pgtables:26308kB oom_score_adj:0
> > > > > > [  806.652952] oom_reaper: reaped process 3261 (oom01), now
> > > > > > anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> > > > > > [  807.579373] BUG: Bad page state in process kworker/u8:12  pfn:374308
> > > > > > [  807.579521] BUG: Bad page state in process kworker/u8:13  pfn:4182a4
> > > > > > [  807.585734] page:ffffea000dd0c200 refcount:0 mapcount:0
> > > > > > mapping:0000000000000000 index:0xffff88837430e000
> > > > > > head:ffffea000dd0c200 order:3 compound_mapcount:0 compound_pincount:0
> > > > > > [  807.585736] flags: 0x200000000010000(head)
> > > > > > [  807.585740] raw: 0200000000010000 ffffea000dce6e00 0000000200000002
> > > > > > 0000000000000000
> > > > > > [  807.592099] page:ffffea001060a900 refcount:0 mapcount:0
> > > > > > mapping:0000000000000000 index:0xffff8884182a5e00
> > > > > > head:ffffea001060a900 order:1 compound_mapcount:0
> > > > > > [  807.607719] raw: ffff88837430e000 0000000000040000 00000000ffffffff
> > > > > > ffff8883bda6cac1
> > > > > > [  807.607720] page dumped because: page still charged to cgroup
> > > > > > [  807.607720] page->mem_cgroup:ffff8883bda6cac1
> > > > > > [  807.607721] Modules linked in: x86_pkg_temp_thermal
> > > > > > [  807.607725] CPU: 0 PID: 3242 Comm: kworker/u8:12 Not tainted
> > > > > > 5.8.0-rc3-next-20200630 #1
> > > > > > [  807.607727] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > > > > > 2.0b 07/27/2017
> > > > > > [  807.607731] Workqueue: rpciod rpc_async_schedule
> > > > > > [  807.611836] flags: 0x200000000010000(head)
> > > > > > [  807.619563] Call Trace:
> > > > > > [  807.619567]  dump_stack+0x84/0xba
> > > > > > [  807.619569]  bad_page.cold+0x7b/0xac
> > > > > > [  807.619573]  __free_pages_ok+0x95b/0xab0
> > > > > > [  807.633461] raw: 0200000000010000 dead000000000100 dead000000000122
> > > > > > 0000000000000000
> > > > > > [  807.641189]  __free_pages+0x42/0x50
> > > > > > [  807.641191]  __free_slab+0xcd/0x1f0
> > > >
> > > > Hm, interesting, it means that page->obj_cgroups is still set.
> > > > But before __free_pages() __free_slab() always calls uncharge_slab_page(),
> > > > which sets page->obj_cgroups to NULL except when !memcg_kmem_enabled().
> > > >
> > > > So it makes me think that somehow memcg_kmem_enabled() became false
> > > > after being true, which can cause refcounting problems as well.
> > > >
> > > > Naresh, can you, please, check if the following patch solves problems?
> > > > And thank you for reporting the problem!
> > > >
> > >
> > > Thanks for providing a quick fix patch.
> > >
> > > >
> > > > From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
> > > > From: Roman Gushchin <guro@fb.com>
> > > > Date: Wed, 1 Jul 2020 11:05:32 -0700
> > > > Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
> > > >
> > > > Historically the kernel memory accounting was an opt-in feature, which
> > > > could be enabled for individual cgroups. But now it's not true, and
> > > > it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> > > > user has at least one non-root memory cgroup, the kernel memory
> > > > accounting is on. So in most setups it's either always on (if memory
> > > > cgroups are in use and kmem accounting is not disabled), either always
> > > > off (otherwise).
> > > >
> > > > memcg_kmem_enabled() is used in many places to guard the kernel memory
> > > > accounting code. If memcg_kmem_enabled() can reverse from returning
> > > > true to returning false (as now), we can't rely on it on release paths
> > > > and have to check if it was on before.
> > > >
> > > > If we'll make memcg_kmem_enabled() irreversible (always returning true
> > > > after returning it for the first time), it'll make the general logic
> > > > more simple and robust. It also will allow to guard some checks which
> > > > otherwise would stay unguarded.
> > > >
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >
> > > The below patch applied on top of linux-next 20200701and tested and
> > > the reported bug got fixed on arm64, arm, x86_64 and i386.
> >
> > Hello, Naresh!
> >
> > Thank you very much for testing the patch!
> >
> > Btw, did it also fix the problem reported here:
> > https://lore.kernel.org/linux-mm/20200701081951.GL2369@dhcp22.suse.cz/T/#t ?
> 
> Yes it got fixed the reported problem on the above e-mail thread.

Thank you for the confirmation!
