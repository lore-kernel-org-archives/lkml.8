Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D72BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DA220658
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IdppthKy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fZkSvKVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgEDS3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:29:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10818 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730642AbgEDS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:29:36 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044ILhmo019117;
        Mon, 4 May 2020 11:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=yKoxBFKOB12ft7ahvIB3iujflYmUWvevHI3ebCDRR94=;
 b=IdppthKyM9J2Q9GqRpZZogLRYf9NtftFwzhzluhSfBBD0JNq5xKNSd2AXFm4b5Sgs4r3
 JbZsVSZyCPxwvuwoEm9+rwQfBMm1yIiLSSj7cmc/fXR954P99gqHaqPlcYao65OqgxsQ
 Qg6WnmcmB8I37ECZCdzCe2oYmK/cAZHA350= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30s6kphq55-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 May 2020 11:29:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 4 May 2020 11:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBiS8+bOlD9BIgTSpmNmB3u+DJMxDvQ5xaLTEKYh9RsTTMKExqLfbp5PmAv50uvY/kOi0GG7GXfMYSRVRp8BxaIMMEpeF2JEFfJw07y7oeq6UzpJv+YYcMIDL3G372QjdFShYqz2LDeoT1fgEUE8zd5ckLxD2eCB7WDGipVAWPqcSNNaNKQ9dnqH6Q9Kwaz5g3WcvB78JZpIfs/TNlbzCumHzelVseBxKQC/alJw1dWTUDNXelIHuhEMg024tsbJNem/BugpYNh0uTridayj1rE2HEcb7ABlfQ02WLrGMKz1bRsZyISuzrYBF1wvoYr++eZN3EEgEYJH5nQstx1w0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKoxBFKOB12ft7ahvIB3iujflYmUWvevHI3ebCDRR94=;
 b=L7SSQ6fCutjHVX4oTmmG4lSSGlTHGyq/XYaEMWgNCX8LIUcBjlPAHVSeQFyytW57nthNDDgr7aPKmfRuSbnkFzdA34K//FPrtkQaY2pO2tSJV5FYuq5PTCHJmzl9lZRKyhO8kNHMZXeggAGfO5pmZCYU/6dEJ09E3Pje/eWP4FsHZFEauIU2vwQSYw+Xi9LWwQEYf9YHfcOyNUgVw15UCi1YvSZY7hQI97ofwhlYNxKyosQtj9KowOsy3VFLzt4kohMS/ONueUvnn5DCFQxbcwFxL/VOH+10MJnlBMZmSV1dzOOav/zp+EM7VfEyAikYWpgg9SEsUbg+pa88rNt1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKoxBFKOB12ft7ahvIB3iujflYmUWvevHI3ebCDRR94=;
 b=fZkSvKVZAfTGorc1zLNQHjFop9PPowaYCnUORxCdaJ8sd1G+Q+AN6o6UYw96oO6RXIb+UzGglEZLqosDW8JAhaL67BlihMU0jnZcJ8n/EDn2/gPFTVN5MSJf8eP2SJcHKh7hIgxwi1PxdU6g/CgE4cRTtb2M8OuRsPKQIT1wvkI=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2645.namprd15.prod.outlook.com (2603:10b6:a03:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Mon, 4 May
 2020 18:29:25 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 18:29:25 +0000
Date:   Mon, 4 May 2020 11:29:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200504182922.GA20009@carbon.dhcp.thefacebook.com>
References: <20200422204708.2176080-5-guro@fb.com>
 <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
 <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
 <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
 <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
X-ClientProxiedBy: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:cc1a) by BYAPR07CA0017.namprd07.prod.outlook.com (2603:10b6:a02:bc::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 18:29:24 +0000
X-Originating-IP: [2620:10d:c090:400::5:cc1a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 426aa318-4e5d-45b9-2757-08d7f05912ba
X-MS-TrafficTypeDiagnostic: BYAPR15MB2645:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2645F8933DCC7E70E8BE8153BEA60@BYAPR15MB2645.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qv4Aabn0ItGUrLgUAeLDutg87RDyMKizt7OxYxAJS+XBdxTeGCo+FKwnuS+W6DwOz4jnZ6/hCiZNmEBD5VONVDo4BTtmYYRO0Fqsdyplh5o3RxXKyG0BH8hCPYbmW7OqAYPbWQv29qyZlFC7+iqDEEpjDpIZsdG54m9Yd5u0l8crB21N4pBA4+M4zOF9mJzwolFVTkOmZk3KCJ7h20QthoYw+aGYx3ikjuLlX6FJU8fL0upSMmSmHxrEv4zvBv4kX8acMeeWgOlMXfF2GJG7z2eEoveuYVy8FFFFzcCeUmYJEiTdiCeVXl1Cl7xGDaehQeamH6LDrtbr1iTCKnB1gDHXIJ6nZWIOD87nWgCZmacpOsQubaT7XBQVeZsalWGW4dregbAsjGXudnabyPzaBSvYxqPbm2ogEFjFHHo9DK91y85bQleVu7W1vVDtgPt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(366004)(39860400002)(396003)(5660300002)(6916009)(66946007)(66476007)(66556008)(2906002)(8676002)(16526019)(8936002)(1076003)(186003)(478600001)(6506007)(4326008)(54906003)(33656002)(86362001)(316002)(9686003)(7696005)(52116002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dO50jlkfEWPdKbeNixoKmsfumtPxREjvJ14DSYHNvXPuWatz9KOaMURi+aAe9M77k0WGD5wbIshifNMI4yqn3LfQFtDRYh4RzikJ/RRfeT1WTHKAV6/7C27ZKzce2mrtgxiwp7PYVE9W0S5u0oHQZFxyKYXcCzLMEuYGDCzNCBfV79hEs/O1X3aQDf9RY2+Oc5p8x2jPOPUSm/CK2wU0M1zVRR3hmu1lQgYjx1OK558YugGpTAwhqsmxCKGWLXGfyjQl0OayoSUtvwI05jFjNjtOtPmtyfHiaZRXmS/6lkgSTo70iPFNPV/5izKJv/ScvXeBD1zWBvPjdqrj+5wJqiWowuSssGjVJGFAJ7NOw8zBFvWIaejSUQq+7u4wx+/n87T8HuikUBZOXcxoo+iCNiJSIDqIzahlXb4XD26WMknAh7Hn5UbhvqjJPkq+cVgJ+nNqekzZhc0zhYyR41YnHptCdMUtYsFe+qFAvbpFAmGmHXczxSN7dGGZvE/I3zJMSK7qeD/YpwZXZNDlFCtlhpzM3MIFw+vN92Ow3FvszSgUZWF0Gn+io7vNtp7DxDFMmtk5ABFjPXMzNExA62ZazpIbXEgGFDCrsPjBeVr5/GF2r+Ktet6pZdLTKXRU36linmDm5s2cVA4jr7K4WIG7ogKQ8p1V5GUT4um8tSeb9srU6qg//l7sBLNFD9g0/W0fIhfTDpi92+2wEEMuSeK/qzY+a4NEulKpxeP+DHD5mYZMMsx1cvYVi+onG7qxNkoRdQ0xFRHS3rTxxDIblXM9yTc5iG6EGKRD8tmEyt5QEFuemA71SqD0H2AeVRdW0P7o2yjwdAoIqmbslwrcD6qm9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 426aa318-4e5d-45b9-2757-08d7f05912ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 18:29:25.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iR9Y8G4Krq/tDF+9nBtmp21zI5jGaVoIgUgj06t4b8xNLHZtWXhS2toqT2cKwjSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2645
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_11:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=1 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 mlxscore=0 mlxlogscore=580 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040144
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 11:54:09PM +0000, Christoph Lameter wrote:
> On Thu, 30 Apr 2020, Roman Gushchin wrote:
> 
> > Sorry, but what exactly do you mean?
> 
> I think the right approach is to add a pointer to each slab object for
> memcg support.
>

As I understand, embedding the memcg pointer will hopefully make allocations
cheaper in terms of CPU, but will require more memory. And you think that
it's worth it. Is it a correct understanding?

Can you, please, describe a bit more detailed how it should be done
from your point of view?
I mean where to store the pointer, should it be SLAB/SLUB-specific code
or a generic code, what do to with kmallocs alignments, should we
merge slabs which had a different size before and now have the same
because of the memcg pointer and aligment, etc.

I'm happy to follow your advice and perform some tests to get an idea of
how significant the memory overhead is and how big are CPU savings.
I guess with these numbers it will be easy to make a decision.

Thanks!
