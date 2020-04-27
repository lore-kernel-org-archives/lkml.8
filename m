Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80AEC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF142078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WTyK3e3c";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AlTs/gbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgD0QrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:47:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbgD0Qq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:46:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RGkjMU009345;
        Mon, 27 Apr 2020 09:46:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hSLr8FXv0jFcZkOEHE8DKu2DgGOKpc0hynYpQ0wigrE=;
 b=WTyK3e3cI/KUoQj9jquRJY6pZF1ap0724FYHmlCNrcZlfaDPMMuQNSy0Z3FtbFHglUIS
 RSq7tpCyGlxeKwDSMwAKC/YEtU7ZmIRZd0W/mZKve1/6ormYprsmHLCbnrCeysVIQu22
 Fh6wmvh4a84wGRZNC4WiLF98PXqSfkoUYgs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30n515s1d1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 09:46:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Apr 2020 09:46:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y07cGUF3kCq9kroA+JaetdwY3KbFR3LUDqXk9vfLjWEnhXT3FkSZ4PiUraqedqYkomLg++jAY42qq51IVXfz+oNLEsT24E34OUKEKEpQOuKjdmD/tvzur8WZPOONjCNidc7c/LvifPRsltwtLi8hWvoq+P1K3IIFgsb0+DrPJlUggEBXrGQ/DIHu5Mu0MONqiztQJ+jHHzJjYKiPR679VXo2PvY7DOMm5oR+3+0FEE1TzV88l5B8WXCTqXOqNOIST7S/FeWr3/JUmmsCdZWYQG5QHL1C1bNGawSk/duRDzEWmwlGtKS4joWnLFiFGBaUIU6DmCyUZHWimUMDadF1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSLr8FXv0jFcZkOEHE8DKu2DgGOKpc0hynYpQ0wigrE=;
 b=aRYhxdYQZxQWok7TtPGwW0vH5MccGRxRqaT6qeYMXQgoKgopb7BCz3jr5L+z0wFXcXnx37gvQi/riGIZV2PUdi+ysY8RXojQGdUcDllzg2dRdDA1T55LSHYnejb74gHPzTk8zbD9L7iDXUj5ipW27a0QV0clrXH3oj8uoUBNAyfSuw8xuyT4shDndn5nx3HdsiZXZy9/ByQcnpKlnvDHCKc/b88+9O0TphfMBfEsh4iFcCXv2HqFP11BLhSFwZT4ePaCe6kkDmAfh8EFzBxMqCVLQyLHq6rn0aqi095xn/RJSgEcY7UVIEVpYzsw0qwxbgLOzU6e5DFmIa9/uvkGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSLr8FXv0jFcZkOEHE8DKu2DgGOKpc0hynYpQ0wigrE=;
 b=AlTs/gbzC6BI3Zs2WodSxWBH5SlJTHaHElwBA9kSr50zp2cX6AMyVlyKAui/Jjva7FqG9qBItxPZzFTXECGAoRCQqTPWMNjXp0SJrXOGMy0sltKRiElRmfer1JqpzYpMLmSigIcuHfIaU8IRvDhO3YtPVcRpmyrPafBpMETzqA0=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2552.namprd15.prod.outlook.com (2603:10b6:a03:14c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 16:46:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 16:46:44 +0000
Date:   Mon, 27 Apr 2020 09:46:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
 <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
X-ClientProxiedBy: CO2PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:102:2::48) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:3b72) by CO2PR05CA0080.namprd05.prod.outlook.com (2603:10b6:102:2::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.12 via Frontend Transport; Mon, 27 Apr 2020 16:46:43 +0000
X-Originating-IP: [2620:10d:c090:400::5:3b72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84164830-3219-466d-7c6f-08d7eaca914a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB25523E5322FF34EE85855996BEAF0@BYAPR15MB2552.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(39860400002)(396003)(366004)(376002)(86362001)(54906003)(316002)(33656002)(478600001)(9686003)(2906002)(5660300002)(52116002)(55016002)(4326008)(6506007)(7696005)(966005)(8676002)(81156014)(186003)(6666004)(16526019)(1076003)(66556008)(66476007)(66946007)(6916009)(8936002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hr2htDgolf2hQTmkOYFB2YAlnXqWM+17NVAEBz0YSuFemRhP3SQchWvq/coggI42QUywOrdMXjoug0fq+wZYYgxkNNzRF+0BbZXKSqNNlrzWKImQHzui0o3/6ZBRZAV0x8GkPY4b3Q/nTjr1gj8eGxDmvuqmuXCckLPIlM6S5dSv8roZMOyUDB5KznVMcLuIa6G+iInK79M5waM1Jf1UGPfOkSZYpgtx0EGDAGTictGwMESlzW7TZhJWok2SHMAU4WQSH/LpBSjKi+q6uuv27XAon8fcHn764Nv2t/m6QaPehi5b1JMj5Ght10ZRFNcJdGjsropM3YR7pUGoYzhD/oif4qzsW+YaNkbnkJWI9HRFpMi1OpgfKLO5AAr/rx0WIY8RtJ4JI4g+ljvXOZRpVBMScijhQBtQiufbl0nyXm66BcwcMB1aAzQK8sCG7f+UDEhRSk7Ovmdm4X54pDfwwkKygpt6jHJVa1X7IF5QkZ7GcDRGkDtnt82Z/U3Nds8TGOBBW22GRE5p7vxoBiZ0SQ==
X-MS-Exchange-AntiSpam-MessageData: IU6JiuLMoltv2LiZ/F9g4onN0rZOpF6cUQ1fuHazaBuu/ydd2c46qypCIBQ++3SNwt9j8KE4CCB7yvYLeN3mKsoeVkkDQsJKX6wLkUcqXP4WgknTCZPJL6LtooGSNg5gQu0rBRztXpI0DdczT9noi8y/Jt90XR36surpv2x9zCbONoL0i/HDANoN69spZkmRtGhHrU+B2cFw8bAsvG3GQ5TQCZt4AEDsdPxbC7uNZPaLMHRq7rP8odsPB0faY1eYZKk5U+rOMuNU00LD6AUOkW2GKdbe2HzftuxIf1E1tXHCoxITv1r9PIpKVf3SvAcVh/2Kpu4ZxFa8WantE5BbVgi3e5j76zKx74ywtDAt5d/OShfwZFbk8xhlOrxSldMzvKBFWkeeYC2gWuqxg6AUwuL5z6SWC9na/myIDdWv5SsiKWXsq0VSqhvgvaw0PkB2yZWSdcAmvJrqT9nNVapi/Fcn8HiB1VdQFaPyDnR4kpn9BJ282jF9cGobfAK/a+khGDEl7DxDEQx9dQjE+QkRSNCzD2IXr/UMYDswdoLKKPa5/DFV/j9HQIxp/aN5iE7XdsjBNqRTk9NrS6DDbmzl3kh2uwvHzp/swkKGtJct8yHvlYVRvLsiwKnEpzEm1gjA6ETYvaedH8OfIxbijeIWESuMcoYO/Yqtl9wpVU/cwCDXPivXI5lOz45aXbmYFmZEaw5VxlCpPo0nPxjQRPtsDy4gnoIt3TY/L4lPVVgUvBhL0zCZAA2pOevWkZpdNmxa/30nlFrl1Ycnu73N9kKG0sbt5StYqB8yNtheHnofOR8A/YtMJpWlHWhYqxMqq4sah2SfkNNn0CHf05H825Z3zQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 84164830-3219-466d-7c6f-08d7eaca914a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 16:46:44.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMKVBsCGtRxjV8wQ4f8Zo+O7b5WlzcHl6LWI+T+hg2UPc0E8yGXkzodlE5WgTMJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2552
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_12:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270137
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 04:21:01PM +0000, Christoph Lameter wrote:
> On Fri, 24 Apr 2020, Roman Gushchin wrote:
> 
> > > The patch seems to only use it for setup and debugging? It is used for
> > > every "accounted" allocation???? Where? And what is an "accounted"
> > > allocation?
> > >
> > >
> >
> > Please, take a look at the whole series:
> > https://lore.kernel.org/linux-mm/20200422204708.2176080-1-guro@fb.com/T/#t
> >
> > I'm sorry, I had to cc you directly for the whole thing. Your feedback
> > will be highly appreciated.
> >
> > It's used to calculate the offset of the memcg pointer for every slab
> > object which is charged to a memory cgroup. So it must be quite hot.
> 
> 
> Ahh... Thanks. I just looked at it.
> 
> You need this because you have a separate structure attached to a page
> that tracks membership of the slab object to the cgroup. This is used to
> calculate the offset into that array....
> 
> Why do you need this? Just slap a pointer to the cgroup as additional
> metadata onto the slab object. Is that not much simpler, safer and faster?
> 

So, the problem is that not all slab objects are accounted, and sometimes
we don't know if advance if they are accounted or not (with the current semantics
of __GFP_ACCOUNT and SLAB_ACCOUNT flags). So we either have to increase
the size of ALL slab objects, either create a pair of slab caches for each size.

The first option is not that cheap in terms of the memory overhead. Especially
for those who disable cgroups using a boot-time option.
The second should be fine, but it will be less simple in terms of the code complexity
(in comparison to the final result of the current proposal).

I'm not strictly against of either approach, but I'd look for a broader consensus
on what's the best approach here.

Thanks!
