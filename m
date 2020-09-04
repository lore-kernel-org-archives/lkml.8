Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67840C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BF22074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iXWMsgKV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YJGbqFiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgIDPSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:18:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26180 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730286AbgIDPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:18:17 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084F4R73019526;
        Fri, 4 Sep 2020 08:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gB+3yG9ziEmklJbAoEk6z4D72cWxdMkENqdTLutxxgg=;
 b=iXWMsgKVb+w2MVx/e1zxdx7kFf1WtGjzmP3v7B6MKaL/44tOdP6zc8onpSfeyWiVTU4g
 AoPoODGCrdIjz1y3H5Pb1IL+FyfHMZD8RWurf12YEuPGWUUWHmbIxIXNfb5tvJSols84
 I6kwSmzayTeMdYEO2m0B6Lqbq7kj11tmdKE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33b99qku6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Sep 2020 08:17:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Sep 2020 08:17:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB9dpF5+9pS+Zwf+BQL9zdbJ6ZcRSm4g+M+9+Dwa33q5OQtsdGLZna/g7/NJZL0pC6TL5ZNzkMvw94swPZWOYmkQZZq859ywzfpPunzKBJtjw9e2Xiy5eDx6C8TBpx5I590XlxmNQ1XOJ8Wm4+AQ5g+mTW1Ob1AVpVgZOXQ78MEr2SWr95d9z3YRNETdp54t6pUhxsy4ymqnVrwhse/VdnfLzU/0GdjbyJlI7+o69R/TdcuGg5q9bSYMgJNpQDNkL9fXzlQcUzZsZeKS1dnxBmQisgYW4V68FGshophzSm3QoKJXADxm/TVlW1C/fR8Y+ZdaOj1cjSJEK0yZugqm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB+3yG9ziEmklJbAoEk6z4D72cWxdMkENqdTLutxxgg=;
 b=iK2JKBfRkQnJ7w6pUT2nbAbMXdAj8q2BeM4rp0FDUyP95rKvFCxaTpNIv0oPxxOw1XCtY+Sk6GQOxSDtZbICG057qvv+hC+tRKDSiI1hhg11F6wOPaCZg+hl7ELWGJU5sVt/PT9fdo8Qcq9F+gcYFiVmxxzxEP5CQikSJNepPsr86fkbmPVgYhujdxiqFRh+vOEqV3piYt2eJDojAVSKkPRtcYdqhzfO5SdPNdMDGsIwuBSZbw8mju8T2EGLN65CrvmF7SXFidHs0Rj/PtNWhLPPWdcYqeNR1vqgzcy23KU24ovkJRzAtWc+tiUn5loCUUirJtFmvsfkgbcQyyjKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB+3yG9ziEmklJbAoEk6z4D72cWxdMkENqdTLutxxgg=;
 b=YJGbqFiZU+KlEqneVPhXl2NpY+FUWu+xUTwl3lXw+lB0cHMHDkaa1ge5cHAVusdZ5tCHC2xzFliepr4xI0I/buVCfetPDxaXdzKrZ624BwT4h8ClvOSOvXznU0+T8oeizxL91oyP8s2bccBmsqiOfhQAaWPa5Wk7dysUQPuHYEA=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BYAPR15MB2694.namprd15.prod.outlook.com (2603:10b6:a03:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 15:17:32 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::80ff:5c88:e972:a2b3]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::80ff:5c88:e972:a2b3%3]) with mapi id 15.20.3348.017; Fri, 4 Sep 2020
 15:17:32 +0000
Subject: Re: [PATCH] nvme: use kobj_to_dev() to get device
To:     Xianting Tian <tian.xianting@h3c.com>, <kbusch@kernel.org>,
        <hch@lst.de>, <sagi@grimberg.me>
CC:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
References: <20200904150140.12717-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@fb.com>
Message-ID: <de7cca47-16ea-c0f9-6c48-ef71b51f3554@fb.com>
Date:   Fri, 4 Sep 2020 09:17:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200904150140.12717-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::25) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1188] (2620:10d:c090:400::5:1a09) by BY5PR16CA0012.namprd16.prod.outlook.com (2603:10b6:a03:1a0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 15:17:31 +0000
X-Originating-IP: [2620:10d:c090:400::5:1a09]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c97b905-eb1a-45b3-b32a-08d850e5a4cc
X-MS-TrafficTypeDiagnostic: BYAPR15MB2694:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2694B661599B6791F252F103C02D0@BYAPR15MB2694.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5m4XlB/j+1YpqgnSXWcbqdv60SjKp8KzaBuyBr1eOFcolDpIfPG7IMcy+3ioJDoL+KBXGS0+pCrdVDkO6V6crT8nMtYNsE3j9O+Vzk9bcJ6W4+EZ3hS5ZnMlClO8aecBFYC3zNNbyu6odUTWGzi2gmg4QpJjnBJgFzSJDALtq6pdRvFspX28jo5XeumAXP6ydp9/QVlbSxw9TzbWOb1eyQCyTJHYiRhvXFfGlG1R/OGPibzHzc0RJ+QCFQAABuL71BFBaMr6NvY666L343bAtbPgQonvmkYxEpoKVEX5geLcm+hNBmD4Q0IsCUBw8FJbCTjPP/DXxxsyI98uA5zOUjXHPI6oFj3kqg5pg/Z57fORaWJDEng4ziPMaVYr1EPA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2566.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(52116002)(31686004)(4326008)(86362001)(6486002)(4744005)(66556008)(186003)(16526019)(31696002)(5660300002)(316002)(66946007)(2616005)(53546011)(8936002)(8676002)(66476007)(36756003)(478600001)(83380400001)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TxIc55El9k/1Nw85qbeVWCflAxT/U9SzBV1mc/43OYsKxeoMiAz4jy1wmVjS0ln2rrbXhDCqioAlid/v6So8vYh9r6D55fq2pixR9U5+PtUOaOUHNUjCPbm99pNGm5+ea3AinP16kuC0CePm0ZVcaaj9P1S69GqnGmPnOhTO0izRAR4ZOGaJXcVt4ZMO45w7cmr9PYTZPZ9ixeH5yVH7fgZES8fAPHAma0JZFuQ68o8pTPlUyCq2SK36HOquGoGcH9mY7FgduAd5d+xOw/arOKIW66V3a8qOagfVkhYKVysLsrhUDnBEZ5Ei29ljs6Cf/q5QBLhN4RiW2fbAlt52fOKH1xmLE4X+AjeARmDXxKszRNWRtcd0Rac1v2YafgBEgg2twRwCgXupGVlQ8BW7U5Sj88yBcSmW/ObUIA5eais8K19xNYusV1Juk4XNxDewWOQqvnuWVaKJIzN5TY02ydNm2Tm8T5xhjTVz6I0d4e4InDFGMprNtF6QQ9haE+197Lr+l9a5h3uSskaFxT3nA6xJelsAjGv/UnORoRiJVTvLZR3q/sWOYU4p5APYlrAnMRLHd6Fn240uUZ1vyP6Xdw3Ah0lrwWdezpwF8aOjIXsp1oxxfH/DBM0oRUgzNPqpcu5ylZ0wRTUqEmtko3zqaX36phi7y8seQY4njmCzYun88zWgZ5TFUhwmhb6x3eG1
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c97b905-eb1a-45b3-b32a-08d850e5a4cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 15:17:31.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLySWgPjB1LlPhYPMtgf8o1qolkvWE4b/m8xMh9Z7T8hIrMnufrg5trYOuR48lm3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2694
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_08:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009040133
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 9:01 AM, Xianting Tian wrote:
> We already has the interface kobj_to_dev(), which can be used to get
> 'struct device *' from kobj, so use it.

Let's please not, this is immediately obvious what it does:

struct device *dev = container_of(kobj, struct device, kobj);

while this one is totally not:

struct device *dev = kobj_to_dev(kobj);

Any sort of privte whatever_to_foo() should be removed from the tree,
imho.

-- 
Jens Axboe

