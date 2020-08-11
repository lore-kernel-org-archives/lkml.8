Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FC2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C242B2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dVOjrOnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHKXLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:11:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59456 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:11:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BN7wlD097318;
        Tue, 11 Aug 2020 23:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sPV5JQ+e38i1YMMKVPdkIvnzXO+BvLyLRtktxRzbHX8=;
 b=dVOjrOnNQx2fPB/uYH7ZCSEXYnnrE9keiBdVc6lR+HHDAoQ0VM9WKGWF4VGlat4QeSm2
 GbD5+Fo5NVa5z6Wn1Kx0l97/LFY0mXyXCVfdx8ETTpXasZEgHVDvil1R1esgc3DxhM30
 QeM2/PimG1/G9xqi0z2N7kJACSCS/s8fr+T6iSW/bLwLSp5bGQDmRywCmQrY3fNofLmR
 z03oKc9ZmO53CS5kD48OdnPn7vRyBJB1b/78wKF7rBG87mM8dDBHtBiaJlv50uyIYHQi
 GRo+oPnFCF1ZHEZ2cSI7GCoY6PQnjavK+cfrYkewrYRjpGqIfioTIsvUxYRcFmOf7Sys PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32t2ydp0cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 23:11:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BN4VK3108105;
        Tue, 11 Aug 2020 23:11:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32t600ggbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 23:11:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07BNBcY5006285;
        Tue, 11 Aug 2020 23:11:38 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 23:11:37 +0000
Subject: Re: [PATCH v2 4/4] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
        akpm@linux-foundation.org
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-5-bhe@redhat.com>
 <62c8ce6c-fe98-f371-99b6-cfdb96d1c2fd@arm.com>
 <20200723091142.GR32539@MiWiFi-R3L-srv>
 <b94f4dc1-5c53-68ca-2023-0aa4de4df8b7@oracle.com>
 <20200811021152.GW14854@MiWiFi-R3L-srv>
 <f659959f-47c5-93f0-ad84-48e53561b1e2@oracle.com>
 <20200811072212.GD4793@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <89039447-f2f6-1c5e-f8c0-10314a002069@oracle.com>
Date:   Tue, 11 Aug 2020 16:11:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811072212.GD4793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 12:24 AM, Michal Hocko wrote:
> 
> My opinion is that the warning is too late to add at this stage. It
> would have been much better if the user interface has provided a
> reasonable feedback on how much the request was sucessful. But this
> is not the case (except for few error cases) and we have to live with
> the interface where the caller has to read the value after writing to
> it. Lame but a reality.
> 
> I have heard about people making an opportunistic attempt to grab as
> many hugetlb pages as possible and they do expect the failure and scale
> the request size down. I do not think those would appreciate warnings.
> 
> That being said I would rather keep the existing behavior even though it
> is suboptimal. It is just trivial to add the check in the userspace
> without risking complains by other users. Besides the warning is not
> really telling us much more than a subsequent read anyway. You are not
> going to learn why the allocation has failed because that one is done
> (intentionaly) as __GFP_NOWARN.
> 

Thanks Michal.

As previously stated, I do not have a strong opinion about this.  Because of
this, let's just leave things as they are and not add the message.

It is pretty clear that a user needs to read the value after writing to
determine if all pages were allocated.  The log message would add little
benefit to the end user.
-- 
Mike Kravetz
