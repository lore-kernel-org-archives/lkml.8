Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00859C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02AC20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aW79YjoL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Bl8Z6RQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGGDiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:38:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47822 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727792AbgGGDiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:38:08 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0673UuGl021912;
        Mon, 6 Jul 2020 20:36:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zM5Z/kJnPMn11GQN+JHEZ5D7XjDLwzvJv2nHeheDT5E=;
 b=aW79YjoLo2Dc5sidTxqZ/1D1SgmrZMVyoPXQp64I770ueUvuzO/e6LZcMV7RBBoRQXr1
 CTIbbLT2x46NGb2dBpj+6/cq2xjIikMiasUcoiaC0p12S8KL6IIBajaBr6ZRmk8kaGB+
 f6GO+cAEoJy/mH/h+n8JbbI7YCRtGKQEV9Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 322n90jq3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jul 2020 20:36:49 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 6 Jul 2020 20:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OobX+SLnZRVGEpkIlbvxv8qhbwDINX9GWvxoOJvmn1QX+QIEfp6RODZLP0LbQdmk8sUX/N5rIxTiN2OYVAa+hE1bTo9vG5vXNMmqBFqDFhMscLpGjImE/5osYIP7DHjRDRu+9hI3yHVR/IVxIKIkAGCkDQgsP39hDMMo2DY4Ki44MOskUupv/jKF03uEbt/tI0mlMTcmcJfP0rKbiqv9J0/dkbVV0fohIeF8NXhqCFF8TYxmHOB38S6aCC+pUqUMssKdamjLckMrcRMQUMLjEY6PH4b5WAptbB+8FZ/KtERbD8Z/X1HtcziRJnDVtCp+TacdMnrN3Nu4aMfQ5rft4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM5Z/kJnPMn11GQN+JHEZ5D7XjDLwzvJv2nHeheDT5E=;
 b=fG3LBjhOvKBpWOV93wMzIDWIDkoyvz4dvo3UEOFSJVgGpgdsZs/vU+T5AlmI/5bIOAIwwPpdVJXz9EhOgndiNiqLMTjEtGt3agSOAqJKINSiMCrPBjAOg3af7fwxEV6Qirry+G5GZMd4RZzrO2hKZrOxbYUl1Y6v5UbYMEUxOeO51nzbl1FbUBIqQuPUyzSVmhmMHAEAJwrG+7BoJ6IxV+o0qNhCzIfQ79NSX5GmZ3TkVLotx4zOJPJGiOGz9P6DSx4jh3q8Ze1IggdunWGHDxdq1LyWqYSYSKuNkUC6lZSCj5nyNRkRoPIvFcHqVjjspOZOd4/qmkTa0gz3GByn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM5Z/kJnPMn11GQN+JHEZ5D7XjDLwzvJv2nHeheDT5E=;
 b=Bl8Z6RQiO5spsyqktzppwNEDakAFmiL2g6+HjCn9R370hQBTLxIAaox0sdFcrYzpzj1Pxjxe+70Mvo4PscHicE4s5FWefdFtmwzjKPY4QV6KTSWIKW5EV8fgkXjgKw7/zZ1lfKkY8WsQAhTq1rgk2SuuT30M1akxn3RHDJLQIPc=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2712.namprd15.prod.outlook.com (2603:10b6:a03:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 03:36:34 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 03:36:34 +0000
Date:   Mon, 6 Jul 2020 20:36:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2] mm/hugetlb: avoid hardcoding while checking if cma is
 enable
Message-ID: <20200707033631.GA164297@carbon.dhcp.thefacebook.com>
References: <20200707031156.29932-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707031156.29932-1-song.bao.hua@hisilicon.com>
X-ClientProxiedBy: BYAPR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:a03:60::46) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2ff8) by BYAPR07CA0069.namprd07.prod.outlook.com (2603:10b6:a03:60::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Tue, 7 Jul 2020 03:36:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:2ff8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50db167-3568-4f55-df6c-08d82226f253
X-MS-TrafficTypeDiagnostic: BYAPR15MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR15MB271244F4D1647FDDFE451DE9BE660@BYAPR15MB2712.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Pniv55m15QT6sxBGGG9PF42jS44v7wN8S0KCwMmaH8hVEHOb2ExHTnAy/Cbq3p12/sahgYzEWfF3HXu6FcFjF9TLfGpC0uUSPut7mX+PvCCR2InIH1qPzvuRVrE5lrJ79WvjOVBJk9PlEfCfb0c7yb3vnp1gGtub92lzutFw8FEjShnjku0DfMsZiRv9bcA5IW0o3XUcZyFfo0b3NWIpoZYpgVDhiNyWOC9nV5epPHYxahbVlrCe3l9bbib0YaOLRmWylyw+JJGHfloqFJ5EzxQ3ZiqBjOXXWC/K59D2CjiZfNfYvSV76uTPJai9ictMGQTzrGO4LS9zX+MZNtH3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(16526019)(186003)(6506007)(33656002)(7696005)(52116002)(5660300002)(6916009)(2906002)(86362001)(83380400001)(478600001)(9686003)(55016002)(8676002)(8936002)(54906003)(316002)(66556008)(1076003)(4326008)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IY0tBVjVjYHjPVZ5fd52YauEJxIedgKiRLj9crtQiPyeXDOZ5Nn42LeiFXyj6PXWj1aecoW8/XSJJx+B1xXmve516j+epwcuxfC7D7lr0CklVkDx1F/kA9tuAHz3jg4wuPEyvUguUlv1qjoBq6mk7TDr08WEYLaAJk/QxOQ1pr+sN+EWayRnC3Wkj4O3VigUeSe2rhQHOHZoe9wL84NVbDjbukSFFGrKRhjrA+moZ/Km7A/a/EochVjG/UYYTUSjf3yiSM1nVJ/waVbggJS8WlK7klibBRSB+/HrdFXguXEz4ZvJTVcLZwxM9ATqO9Fi943cHUOyGaAAUXIfk5ghsi57Jd5oC2BeLEqUqxGkBLIygWVusJiy+CuGkcI478qurBnrRO1WuKSbhyhF1dUwJcnqrZK1sFR7q/kaAhFef8fd5lk1/tot4Xr3XK9mnlY1pDyQYLmriG7w2oIeeLAqGqVt2N5aZc3bUFO6RvZaUdr6+aKLP6/9ojf7lMBLhU3JALMYeCbeBtoUGmIq1bpTVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b50db167-3568-4f55-df6c-08d82226f253
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 03:36:34.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eshC+uhNQPdIULYjusLbBSo4r7STVLre5QrxH3qT03IAhRJwNjGCSCpSzVzf7mwC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2712
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 cotscore=-2147483648 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 spamscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070025
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:11:56PM +1200, Barry Song wrote:
> hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
> no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> enabled. gigantic pages might have been reserved on other nodes.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v2: add hugetlb_cma_enabled() helper to improve readability according to Roman
> 
>  mm/hugetlb.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 57ece74e3aae..d5e98ed86bb9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2546,6 +2546,20 @@ static void __init gather_bootmem_prealloc(void)
>  	}
>  }
>  
> +bool __init hugetlb_cma_enabled(void)
> +{
> +	if (IS_ENABLED(CONFIG_CMA)) {
> +		int node;
> +
> +		for_each_online_node(node) {
> +			if (hugetlb_cma[node])
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +

Can you, please, change it to a more canonical

#ifdef CONFIG_CMA
bool __init hugetlb_cma_enabled(void)
{
	int node;

	for_each_online_node(node)
		if (hugetlb_cma[node])
			return true;

	return false;
}
#else
bool __init hugetlb_cma_enabled(void)
{
	return false;
}
#endif

or maybe just 

bool __init hugetlb_cma_enabled(void)
{
#ifdef CONFIG_CMA
	int node;

	for_each_online_node(node)
		if (hugetlb_cma[node])
			return true;
#endif
	return false;
}

?

Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com> after that.

Thank you!
