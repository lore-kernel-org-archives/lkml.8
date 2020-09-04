Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F84FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0DF206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="orTfstT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIDI3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:29:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbgIDI3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:29:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084831td104754;
        Fri, 4 Sep 2020 04:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=l1sL622nG95v/22CCNwxn/VyJMC+9mPeOmwLNlxEMtE=;
 b=orTfstT6giWKbhdmPKhjg1uF2D0BL9fVo025M+0tZFwsCWCkB++SaFV3eDPaNP5AlemV
 68HTqVVDwESUPFCBx0dd4DI7ygj0io3aYgKCtd+EVw4uMj4e3gk3RHdeao5n3+Nh85kL
 IgR6RZrGmYCxANiQ/KYyS2fE+k+bTYbAAr6qOA9Li/EyepluhWIq7/Lo6M8uKuLb0Mne
 BT6V1EkLdxPb0EHNgkTMiTGhZUTlGDDCAkGA+8DQzSIIjtEZ3l5BZlE3DbdEItF+UgKq
 4tfixWw7Ur1aQgxALnzjl5d645e55myDR/Gi9mBaIWVHQbiGZYY8xbC4Q/QOhoA0KutT iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bhmerxdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 04:29:31 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 084836HZ105407;
        Fri, 4 Sep 2020 04:29:31 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bhmerxdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 04:29:31 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0848RZhS013156;
        Fri, 4 Sep 2020 08:29:30 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 337ena9mxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 08:29:30 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0848TTfp54329626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Sep 2020 08:29:29 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47AC7124053;
        Fri,  4 Sep 2020 08:29:29 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41F82124052;
        Fri,  4 Sep 2020 08:29:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.248])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  4 Sep 2020 08:29:23 +0000 (GMT)
Subject: Re: [PATCH v7 2/5] perf/jevents: Add new structure to pass json
 fields.
To:     John Garry <john.garry@huawei.com>, acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
References: <20200902160439.335232-1-kjain@linux.ibm.com>
 <20200902160439.335232-3-kjain@linux.ibm.com>
 <34566244-88ba-562b-71cf-414a0ba307f4@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <d8f98c89-0a11-3844-01f2-3562ff2bdea9@linux.ibm.com>
Date:   Fri, 4 Sep 2020 13:59:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <34566244-88ba-562b-71cf-414a0ba307f4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_05:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/20 10:35 PM, John Garry wrote:
> On 02/09/2020 17:04, Kajol Jain wrote:
>> This patch adds new structure called 'json_event' inside jevents.h
>> file to improve the callback prototype inside jevent files.
>> Initially, whenever user want to add new field, they need to update
>> in all function callback which make it more and more complex with
>> increased number of parmeters.
>> With this change, we just need to add it in new structure 'json_event'.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
>> +static int json_events
> 
> Adding 'static' should have really been in the previous patch ...

Hi John,
   Right, Thanks for pointing it, I will update.

Thanks,
Kajol Jain
> 
