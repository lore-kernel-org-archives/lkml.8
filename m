Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC6EC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0450C222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NEY+RyTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgBUB1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:27:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgBUB1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:27:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L1A71h177849;
        Fri, 21 Feb 2020 01:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Rrw6zgBhTpZljWDelufh2KactDAgrwod4+Cs5lb4FDc=;
 b=NEY+RyTFyy2FGrVUbrdlBVFDULgpx8TCrxN8cmcptSujsXK0CXHpHQcZgxtkNyVC3Ihn
 EFPN5XW0ZI4sEiMLj2rTjGiuMeUnze+UiWCaUB72fn5EoTBzEMWNd3Uz34bTfQwdFxnG
 Cp8bo0YXM5sNaoQz4tfOQ0Tlfpo9D/hLt5VxpD2OiNO4pIM9npfF07ebUVYay0O6r0nW
 vFlUg3XolpJ7hSmT3job3mMeA1ggG88o5YPGcAg2apJurCwNIUOYY3o6MyZUteAtScB5
 HCrxEkOx173B2e7bixzQymPl7bNFmKqxrrRwxuzfFfkFqAzlr8sawtCavOVehWqfvaZA eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y8udddn8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 01:27:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L17q0J169437;
        Fri, 21 Feb 2020 01:27:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y8ud7ex04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 01:27:30 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01L1RTdD009636;
        Fri, 21 Feb 2020 01:27:29 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 17:27:29 -0800
Subject: Re: [PATCH] mm/page_alloc: increase default min_free_kbytes bound
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org
References: <20200220150103.5183-1-jsavitz@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bfada5d3-23a1-5cec-3cc2-6a7a015c4dcd@oracle.com>
Date:   Thu, 20 Feb 2020 17:27:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220150103.5183-1-jsavitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=948 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=979 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 7:01 AM, Joel Savitz wrote:
> 
> Further work to make the calculation of vm.min_free_kbytes more
> consistent throughout the kernel would be desirable.
> 
> As an example of the inconsistency of the current method, this value is
> recalculated by init_per_zone_wmark_min() in the case of memory hotplug
> which will override the value set by set_recommended_min_free_kbytes()
> called during khugepaged initialization even if khugepaged remains
> enabled, however an on/off toggle of khugepaged will then recalculate
> and set the value via set_recommended_min_free_kbytes().

I took a shot at fixing some of those inconsistencies.

https://lore.kernel.org/linux-mm/20200210190121.10670-1-mike.kravetz@oracle.com/
-- 
Mike Kravetz
