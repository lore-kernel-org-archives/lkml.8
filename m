Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440BDC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1D1207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBUJm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:42:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgBUJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:42:28 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L9ehol101721;
        Fri, 21 Feb 2020 04:42:23 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ya6e6arr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 04:42:22 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01L9gMsE106897;
        Fri, 21 Feb 2020 04:42:22 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ya6e6arqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 04:42:22 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01L9eepf011377;
        Fri, 21 Feb 2020 09:42:21 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 2y6897bvc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 09:42:21 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L9gKqM49807818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 09:42:20 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3663CBE04F;
        Fri, 21 Feb 2020 09:42:20 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE9BABE053;
        Fri, 21 Feb 2020 09:42:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.35])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 09:42:16 +0000 (GMT)
Subject: Re: [PATCH v5] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200220050104.14094-1-kjain@linux.ibm.com>
 <20200220105645.GB553812@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <1346f859-601f-4d79-c0b9-2dda41e71354@linux.ibm.com>
Date:   Fri, 21 Feb 2020 15:12:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200220105645.GB553812@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_02:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/20 4:26 PM, Jiri Olsa wrote:
> On Thu, Feb 20, 2020 at 10:31:04AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> +				i++;
>> +				if (i == idnum)
>> +					break;
>>  			}
>>  		}
>>  	}
>> @@ -144,7 +142,10 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>>  			    !strcmp(ev->name, metric_events[i]->name)) {
>>  				ev->metric_leader = metric_events[i];
>>  			}
>> +			j++;
>>  		}
>> +		ev = metric_events[i];
>> +		evlist_used[ev->idx] = true;
>>  	}
>>  
>>  	return metric_events[0];
>> @@ -160,6 +161,14 @@ static int metricgroup__setup_events(struct list_head *groups,
>>  	int ret = 0;
>>  	struct egroup *eg;
>>  	struct evsel *evsel;
>> +	bool *evlist_used;
>> +
>> +	evlist_used = (bool *)calloc(perf_evlist->core.nr_entries,
>> +				     sizeof(bool));
> 
> no need for the (bool *) cast

Hi Jiri,
     Should I resend patch with this change?
Thanks,
Kajol
> 
> other than that
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 
