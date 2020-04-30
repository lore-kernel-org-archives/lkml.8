Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E0C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A782082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UDi/KixN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WkyOyYQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgD3RQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:16:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39662 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgD3RQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:16:13 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UHB6MB005874;
        Thu, 30 Apr 2020 10:16:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uJa90Kg0nbsWBRGlMhkgFlAR+qF4ICx6t6Gr+PGg1KE=;
 b=UDi/KixNF3/VZB75vLM3sAd3qUvxL1WqhC0ICWwmFfVXMVz+AJqKKj5crwupGp3avuTJ
 4fezfTw3nX7vXwrFR3bTY6DV8PGYyrph7BSg4Xk/TANHjMmel5TIdCHlgJKxjvdx9Zsg
 qsaVeGuGnZcoMYnwd2PISDCc17DorQXatUA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30qf81e83d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Apr 2020 10:16:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 30 Apr 2020 10:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEsCufCLHXDnasbJMKfVWhL8esBT2YztFNoLyLT9zY0XWjtvzFStqGZ5B4tnWjApeeI/7Y+vrHMCm7kbVe//EeJ2cedextVpNNjVPmtFA6sEDT2g7sGwQz1VG7M5VCRp/Wqp/8eEse/HZLWQPcNFSKTMMmgXJdlLwmCzH3pS5MMoKSWzZRePPPH9Mv3lc1iBmU09TZkQ4KRqF+X/o2b9UWCiewcGKaJ6I5q7udVu3sSmoe7YdBvPiQpjKm8HuEzOHVeGgInNLRdI9fkfnbW33YIAxGcC7ivkHNiHTT/0YU0rAu219kUKBKXNQkKy/2/4JsP3WvXLqAbQhWAiODCylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJa90Kg0nbsWBRGlMhkgFlAR+qF4ICx6t6Gr+PGg1KE=;
 b=S4oySf9YNXq3q5hxRfbQBFH1gXjoQyZgVdjXIwIt6F0UUFMmKZ10EJd3l+2NtItHKs6k/neik/phLyjbuwFKsAQeRe/mOJhbX+iiXPMY7olJvcN+luW3H9lagAbcoviuPru+JRqrabNVS//O3JbiD2qd/bW170B7MEAMQKtqL38cUVbR3vo6z8auUqDTfDsbjThY8WrmXwa8+ZMJ+fhOT5boDN/rNH1ZR2sM5hvHD38HuqS7/6EeuW+BNVSroFx+ZRGDAaGDz+ymgY+UGWljAVaHPwKdNpoxQ2Kp7c6OQr2DqFE7usTXy4Zf2IYwK9i7OuqzSbUhvNgSnq+42cEuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJa90Kg0nbsWBRGlMhkgFlAR+qF4ICx6t6Gr+PGg1KE=;
 b=WkyOyYQ83ee+Zr+q8vRniXcDXLQTurMODq+Q0Vwn/Nk/uIxb/21P9ei9+Pet1bJqxeFx6qnv4upN93m33qi3Egc2hjjbfGiYwJDJRQmx0wTGm0myMwh31LaaVKOQUAF3n7r/FqY7BY7khCJcXcTahg6q76DcbDwqzaXc/26LRpQ=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2920.namprd15.prod.outlook.com (2603:10b6:a03:b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 17:16:02 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 17:16:02 +0000
Date:   Thu, 30 Apr 2020 10:15:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
 <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
 <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
X-ClientProxiedBy: CO2PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:104:1::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b543) by CO2PR05CA0100.namprd05.prod.outlook.com (2603:10b6:104:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14 via Frontend Transport; Thu, 30 Apr 2020 17:16:01 +0000
X-Originating-IP: [2620:10d:c090:400::5:b543]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecfa1f39-a011-43c1-948f-08d7ed2a28b7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2920BFEAB0743C63CC0BE4ADBEAA0@BYAPR15MB2920.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnZsqdiMQRMJTV41eM2uAR84L0I2ig9lv1qBQknLwmI/2j+jK1WkE/COt4GNXEp2YnuW31XGyD8fWRKY2TH1qzHflOqH8+yVbSP4gB0s1HwH1IRUUTySYo+Da4nDQBzJ8J6IIKj53P8hUzPmbvbJiC7Qs1J5emTMnXFIQnfrMGUGpK2HEWgvUOpvtg87OO/p5BLCWznUgXnSXPon2TmGGaJWDUwkyb8ksArOHexqU5xB8LeQROYPigURxAp3K0eElbOqtX6E8JZz6CtGYf1ivGg+baDLMmpBIryO3v7TwP/BOLxfYMPAzgUMcu7fq4HerPtYy4SeIq3Atn1+k64NosCZoySVrRDOOaD0+KxaMZIezNK4W2m5K+Jel7i18MpzKQkPX134zcU4kEKW6hEIyT6h9DZ69p5sNwPfHyueGVjkZbSPKgAkOgx6N2+VhiSC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(66946007)(9686003)(55016002)(8676002)(6916009)(478600001)(52116002)(2906002)(5660300002)(6666004)(7696005)(54906003)(33656002)(186003)(16526019)(1076003)(316002)(66556008)(66476007)(8936002)(6506007)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nJr74yMbhqwLkNnPcw6VxFp5A7D0eQgr6qJQqXxP6x1NkK2Fm3LUO73zBkt4NUPAUQl3zrfU1CMcdB3umGVsi2wW/glkt7MtxZc6jh0taUI2YX6fsCTYma4j+wZRU3aiaOqupA9940N8tVOgXAc/aQOYj5+VmUcDKkLSSCZK/FLt/bE10hPWl47fqWsHdSOrVstXU4MxF20UKGmgeVEVf9zkQgN1JhI/2bYUGVsgYGchOzF8vQGQsVXR34ERO1hejg0HFcyo4T4e5jf67UgtERjUw3qzpMDHXK06ZV6weq6G/W36qsj1SiGAcHzijH2RVyEt1jZTqt7p4hYZ4SO+Y4C29lZdfWbwA4jtTFxMIO9ljfdn0VkrgpHNk2lNgFFbHLRbm5kNYVAoA61Tm7OnVnB6NIjBrEbzO+8lMclN0UZrIFcNE7SU9qhUq7zBosEYCjJV77XSqGLta9m5DvbQJzReffsoY1nEcK0u6G6NSF9e4o8LOG3k1UnLZbV5bfRSj4nucAxSWvFt8jDEejtN15teV6/6VbHmfag+PBmzoWTMFCTGAoIFKiujzniLt/iqRWO99aFTAgcf5ofTGUk692IBxm5j0GOPAq4kEzz15oT7SLirAz2g7Af9bCgO96M6Ymlu2Lbm3QmPRymjhefjA6sQRjSBqwMio6G+7MyiiW+vrpm8AQCj8ywm8Mdy9GF+mrlP42kdFJO1Gfro8xP+vhgwKx+CR3Ml3F6BOG8O25MziE+mAUBOHJ+UxucriV8B0myn6+OkFXQNOdAWzALzQAL1TtvpRr3AjEEq1GTUmvEVh9CSxGVXXeJtJd06yPRwED3PrVofYPNT+tdnvsLpYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfa1f39-a011-43c1-948f-08d7ed2a28b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 17:16:02.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4Qf+P7vLia+rs2mA40+8T7i7H7JknyGz0TfMFA1QkRSjUdisKRUT1cltNa46iJm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2920
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_11:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=1 mlxscore=0 impostorscore=0 mlxlogscore=913 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300136
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:29:50PM +0000, Christoph Lameter wrote:
> On Mon, 27 Apr 2020, Roman Gushchin wrote:
> 
> > > Why do you need this? Just slap a pointer to the cgroup as additional
> > > metadata onto the slab object. Is that not much simpler, safer and faster?
> > >
> >
> > So, the problem is that not all slab objects are accounted, and sometimes
> > we don't know if advance if they are accounted or not (with the current semantics
> > of __GFP_ACCOUNT and SLAB_ACCOUNT flags). So we either have to increase
> > the size of ALL slab objects, either create a pair of slab caches for each size.
> 
> >
> > The first option is not that cheap in terms of the memory overhead. Especially
> > for those who disable cgroups using a boot-time option.
> 
> 
> If the cgroups are disabled on boot time then you can switch back to the
> compact version. Otherwise just add a pointer to each object. It will make
> it consistent and there is not much memory wastage.
> 
> The problem comes about with the power of 2 caches in the kmalloc array.

It's a very good point, and it's an argument to stick with the current design
(an external vector of memcg pointers).

> If one keeps the "natural alignment" instead of going for the normal
> alignment of slab caches then the alignment will cause a lot of memory
> wastage and thus the scheme of off slab metadata is likely going to be
> unavoidable.
> 
> But I think we are just stacking one bad idea onto another here making
> things much more complex than they could be. Well at least this justifies
> all our jobs .... (not mine I am out of work... hehehe)

Sorry, but what exactly do you mean?
I don't think reducing the kernel memory footprint by almost half
is such a bad idea.

Thanks!
