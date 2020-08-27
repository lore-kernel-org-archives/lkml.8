Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D10BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F6C22B49
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RFQnPflk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgH0HB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:01:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726882AbgH0HBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:01:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R6gKtB043578;
        Thu, 27 Aug 2020 03:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XlWyt5CVYj+2LT0Ndl4Db8i8SzubP6K6hviV/4WYMb4=;
 b=RFQnPflkCDO8GllsOMS9pRaaEHzUPsBRP5lCwvpPa4dauTNS8JwHDZiiCVj5z3ZIZkBq
 SuHf4AmLNZinXE/NljJsy9tM2w7kd19OAYJVnuWMztNrXZUr1YcnIffeabKQA8WIpUFx
 WCcAnXM9ofjTeFUJz5K5sN+rFE/hGN4FKiqSpD4NC7jX+oJ5nLZbI9ZQLUhf7Xiwvuvg
 cDsw4aNwQyqtgtv+oqeTf4OebNrdrZrmYMZo6o1BZdgzO3xd+9aXvtJEr4emuFYxYpRW
 +FSfnoQTEbIjZX/OVOsPg141M/vUXnMzC7dH3wjFn7Sko+wTbtJ78qINbcHHvQcaYFz0 tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3367syrdjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 03:00:22 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07R6hJGD045214;
        Thu, 27 Aug 2020 03:00:22 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3367syrdhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 03:00:22 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R6rj87026801;
        Thu, 27 Aug 2020 07:00:21 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 332utu1vsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 07:00:21 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R70KeG47513970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 07:00:20 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E7A878063;
        Thu, 27 Aug 2020 07:00:20 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1E6678067;
        Thu, 27 Aug 2020 07:00:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.77.207.180])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 07:00:13 +0000 (GMT)
Subject: Re: [PATCH v2] perf expr: Force encapsulation on expr_id_data
To:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20200826153055.2067780-1-irogers@google.com>
 <20200826155733.GB783610@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <4b6bc995-d468-3137-f00f-3867233740a3@linux.ibm.com>
Date:   Thu, 27 Aug 2020 12:30:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826155733.GB783610@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_01:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1011 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 9:27 PM, Jiri Olsa wrote:
> On Wed, Aug 26, 2020 at 08:30:55AM -0700, Ian Rogers wrote:
>> This patch resolves some undefined behavior where variables in
>> expr_id_data were accessed (for debugging) without being defined. To
>> better enforce the tagged union behavior, the struct is moved into
>> expr.c and accessors provided. Tag values (kinds) are explicitly
>> identified.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> great, thanks for doing this
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> jirka
> 
