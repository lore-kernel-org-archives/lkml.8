Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B39C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD41120724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCRMUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:20:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgCRMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:20:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IC2WFx021204;
        Wed, 18 Mar 2020 08:18:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu719rsy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 08:18:55 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02IC2mUU022912;
        Wed, 18 Mar 2020 08:18:54 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu719rsx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 08:18:54 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02ICH2uG025817;
        Wed, 18 Mar 2020 12:18:52 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 2yrpw6r8pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 12:18:52 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ICIphS60293496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 12:18:51 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C06A136051;
        Wed, 18 Mar 2020 12:18:51 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07D3713604F;
        Wed, 18 Mar 2020 12:18:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.107])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Mar 2020 12:18:27 +0000 (GMT)
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com> <20200317151047.GF757893@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <45b24f2b-3cb5-2e61-b80b-c19389988a07@linux.ibm.com>
Date:   Wed, 18 Mar 2020 17:48:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200317151047.GF757893@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_05:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 8:40 PM, Jiri Olsa wrote:
> On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:
> 
> SBIP
> 
>> +static int metricgroup__add_metric_runtime_param(struct strbuf *events,
>> +			struct list_head *group_list, struct pmu_event *pe)
>> +{
>> +	int i, count;
>> +	int ret = -EINVAL;
>> +
>> +	count = arch_get_runtimeparam();
>> +
>> +	/* This loop is added to create multiple
>> +	 * events depend on count value and add
>> +	 * those events to group_list.
>> +	 */
>> +
>> +	for (i = 0; i < count; i++) {
>> +		const char **ids;
>> +		int idnum;
>> +		struct egroup *eg;
>> +		char value[PATH_MAX];
>> +
>> +		if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, i) < 0)
>> +			return ret;
>> +
>> +		if (events->len > 0)
>> +			strbuf_addf(events, ",");
>> +
>> +		if (metricgroup__has_constraint(pe))
>> +			metricgroup__add_metric_non_group(events, ids, idnum);
>> +		else
>> +			metricgroup__add_metric_weak_group(events, ids, idnum);
>> +
>> +		eg = malloc(sizeof(*eg));
>> +		if (!eg) {
>> +			ret = -ENOMEM;
>> +			return ret;
>> +		}
>> +
>> +		sprintf(value, "%s%c%d", pe->metric_name, '_', i);
>> +		eg->ids = ids;
>> +		eg->idnum = idnum;
>> +		eg->metric_name = strdup(value);
>> +		if (!eg->metric_name) {
>> +			ret = -ENOMEM;
>> +			return ret;
>> +		}
>> +
>> +		eg->metric_expr = pe->metric_expr;
>> +		eg->metric_unit = pe->unit;
>> +		list_add_tail(&eg->nd, group_list);
>> +		ret = 0;
>> +
>> +		if (ret != 0)
>> +			break;
> 
> again, this is part of metricgroup__add_metric_param no? why not use it?

Yes right, thanks for pointing it out. Will update in next version.

Thanks,
Kajol
> 
> jirka
> 
