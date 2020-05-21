Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5EFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D952120826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EmO62saU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="if1oIQF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgEUVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:14:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31916 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgEUVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:14:27 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04LLCE4M021261;
        Thu, 21 May 2020 14:14:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6fLLjVrnE8/3C1FnIziNiGSluEVU8jCr8sbsksmTkHs=;
 b=EmO62saU6zyrDDYTO1vYeTLwLUo1TAg5eWi1QgYFyDb8uvdeD1pIAeSRKC3xRM1ZXkGB
 5SD4PBGnF69i/FipxsAK1emR8ZP67r89hrHIAA2iU2OW7/mCbuJmM4JZ5atvnOGfix1Z
 vrAayKMUOwXLdbWG3ZVEudTVj1DQztrLQK0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 315bt2k8uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 May 2020 14:14:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 May 2020 14:14:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVC2GNvkuZOFlMdAkIKpA6DvgBHwHKtJswgfwSttNWBkNtHDX4B67vsBUvynYg4+PSpCc/LMJLiM5GIR+cjC0C8NMajw8AcIaIuK2NWWs0Je9lyGujAtA3HFt6MOFkQHk0knJ8nvmHNLmhmXQCS/026FM62kYavHATCZrtaRIU8Y0nnSm+97MCWd5h/CQfcGOSJK6pu6zKhfF1UxvqwdyW+jD4kMdUlugoHmf4JxOglxq/imF0dmTMJizTCBLMO1JaHv2g+mSkXs4xVsy+AUY7nwDD4McfMKcTmKJdkRTNQn/EADcJCfqpA66GXJtYI4fIJYUg2M9+/gvAxnyyV5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fLLjVrnE8/3C1FnIziNiGSluEVU8jCr8sbsksmTkHs=;
 b=HzN/rqpFLAM/EBdXpaTrvBX+/Kq8HS5h6teV5WxMF+2ik7OcjniMUCP0eBTKtMq8jpzS1wrMAKSabxEWb6lx9I9XA1p4CLX4x1kbLxeTPbpY30IxtpwaPZlhQb0TECNHGfoA4RBJoQbd90V6wu8kqaiPvB8JGHf95wF1Wyw/gciRz7+Wcf4oXBvsufRy5D7Epp5KO2WvoA8GHGM9BkvK8Q6SDiwoXtHV/wnitVZfQDB02HgFGpDQUkXzdzOPvggUsbjRhb0tpRiM9xD7ZyrVTz0jVfdvJmjhXdoHk5J+jVGghVmisk6glvJ0iV6qdooRz160a+BGHIpwU5sI7IgHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fLLjVrnE8/3C1FnIziNiGSluEVU8jCr8sbsksmTkHs=;
 b=if1oIQF42YUfskhscvu2s3HbtETYQwGLZL8QBRezCIr+DxUvLwA1JwRYOAhaujUoYe8s3f35A7sPOzOykaQY9YmQP7hDwz4otAzc49j6K6a5J39cZGvMZZxQcCTSbi0XH5VOONuJ3R0a+RFd/YjIl5omx1aOvgPK5Gd9nOCTafU=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4101.namprd15.prod.outlook.com (2603:10b6:a02:ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 21:14:18 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 21:14:18 +0000
Date:   Thu, 21 May 2020 14:14:14 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/19] mm: memcg: convert vmstat slab counters to bytes
Message-ID: <20200521211414.GB339999@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-4-guro@fb.com>
 <b72ff85a-22aa-f55d-41ee-2ddee00674a7@suse.cz>
 <20200520192652.GA278395@carbon.dhcp.thefacebook.com>
 <21975f76-f58f-14ef-9547-7e32afac1681@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21975f76-f58f-14ef-9547-7e32afac1681@suse.cz>
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:edd) by BY5PR20CA0033.namprd20.prod.outlook.com (2603:10b6:a03:1f4::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Thu, 21 May 2020 21:14:17 +0000
X-Originating-IP: [2620:10d:c090:400::5:edd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce924f10-e641-447c-c519-08d7fdcbec1d
X-MS-TrafficTypeDiagnostic: BYAPR15MB4101:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB4101C90E69A2A9E6C066A9C6BEB70@BYAPR15MB4101.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ho2tIswiXi0yi3XJims7nOKVWxH/nKECSZMSYnIGJ+D8D2NP2S4of/zvc+GWdOteHEipLHM85OQ8jwsSqan+AxdTIjjWvbpSO/t1B07cx7XAaQcnvDNJqWGU866zgOVA0O2sCfEIg9OU55EDPPenwmLSCnZQbK+/87Q+rh6NgGXN7kPktEh0BiDrzsXTgD1aczew09AscsJanLb9+qXZApyNHx+8xanTZiOLQbC8RQ0x4WDRiZ1w86EMUnq4+POHden24v/5JjV0N6az8mozL8d27/J46ZgbNo3m9UvnfesISdqbKf1vAEayoPb8jkG1YY+5KhZ6o9SevZ+Ia+hUYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(39860400002)(136003)(366004)(376002)(53546011)(52116002)(16526019)(8936002)(316002)(8676002)(7696005)(478600001)(4326008)(86362001)(33656002)(54906003)(9686003)(55016002)(1076003)(6666004)(6506007)(186003)(6916009)(66556008)(5660300002)(66476007)(2906002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: HLdytQW2zoqECIK5JNuDfzGIp7QVhoiVrQcG7eG1lUvrNUjnaDfByFNIX4Sk9YX8NSjKTMpQKzK6rz+Nk8Bd3cSN1t7xn3cbPdj3ISEdct/uK4H7XMEfJErpADc+Q60ALy0v5w2o2mccrhs4/wA3Phw8/8IQTk1iQzS56O7Ai4mgk5JTvJ16AO64UFUjiilu6tYtnC2VRqaKBXC3Q3gI4t0FcSaGKD3tP8sTpKh4ARPAdaVRY4LYIM3c5gc3WTTe/HmsC1J9MtHxiruPSt9pk361gTjqzcNFbC0q8hC+VREisI98yle7agvYbegHYeESKF2iczkYmlCdk8Nnl6ayg0SsxDTo9Vh6CN46ga3b6hOYcVo54kUdHZmle3WiGfQHG6bqwwb23ffoLeF3KmESu0g86OVUkD88sTH0n+fW5lYrX2gYs5n4afVN/1Pyi2056VN1LX2PGIKpXeWSsCkeydHybaM+PYei/CSCJWM68Udl4EhCYkmByUVm2xSYmwxEBZGuirKNHrHrlQ5sa0XXjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce924f10-e641-447c-c519-08d7fdcbec1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 21:14:17.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLJU41cHuu7j9GGfC4rWJBf3n741eKD7/0YXxDCCurxOY26m5ciqZUKpOlUA5j/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4101
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_14:2020-05-21,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=872
 impostorscore=0 bulkscore=0 cotscore=-2147483648 phishscore=0
 priorityscore=1501 suspectscore=1 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:57:12AM +0200, Vlastimil Babka wrote:
> On 5/20/20 9:26 PM, Roman Gushchin wrote:
> > On Wed, May 20, 2020 at 02:25:22PM +0200, Vlastimil Babka wrote:
> >> 
> >> However __mod_node_page_state() and mode_node_state() will now branch always. I
> >> wonder if the "API clean" goal is worth it...
> > 
> > You mean just adding a special write-side helper which will perform a conversion
> > and put VM_WARN_ON_ONCE() into generic write-side helpers?
> 
> What I mean is that maybe node/global helpers should assume page granularity,
> and lruvec/memcg helpers do the check is they should convert from bytes to pages
> when calling node/global helpers. Then there would be no extra branches in
> node/global helpers. But maybe it's not worth saving those branches, dunno.

The problem is with helpers like mod_lruvec_state(), which do modify both global
and memcg-level counters. Also memcg- and global counters share idxes, so
it will be confusing to have NR_SLAB_RECLAIMABLE in bytes on one level and
in pages on the other.

So, idk, maybe there is a better way of organizing these counters in a less
complicated manner, but I've no ideas at the moment. But if you do, I'll appreciate it.

Thanks!
