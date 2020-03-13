Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B045C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D69620746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgCMM1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:27:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgCMM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:27:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DCPTLi084494;
        Fri, 13 Mar 2020 08:26:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yr0ch4s88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 08:26:37 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02DCPhTp086252;
        Fri, 13 Mar 2020 08:26:36 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yr0ch4s7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 08:26:36 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02DCO2dc003156;
        Fri, 13 Mar 2020 12:26:35 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2yqt6q7pvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 12:26:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02DCQY0J47644968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 12:26:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8066DAC05E;
        Fri, 13 Mar 2020 12:26:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A498AC05B;
        Fri, 13 Mar 2020 12:26:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.93.91])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 13 Mar 2020 12:26:25 +0000 (GMT)
Subject: Re: [PATCH v4 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
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
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309062552.29911-7-kjain@linux.ibm.com> <20200312105214.GD311223@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <55e17c86-5adf-bf3c-ec38-ffe77a45f7f3@linux.ibm.com>
Date:   Fri, 13 Mar 2020 17:56:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200312105214.GD311223@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_04:2020-03-12,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/20 4:22 PM, Jiri Olsa wrote:
> On Mon, Mar 09, 2020 at 11:55:50AM +0530, Kajol Jain wrote:
> 
> SNIP
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
>> +		expr__runtimeparam = i;
>> +
>> +		if (expr__find_other(pe->metric_expr,
>> +					NULL, &ids, &idnum) < 0)
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
>> +		eg = malloc(sizeof(struct egroup));
>> +		if (!eg) {
>> +			ret = -ENOMEM;
>> +			return ret;
>> +		}
>> +		sprintf(value, "%s%c%d", pe->metric_name, '_', i);
>> +		eg->ids = ids;
>> +		eg->idnum = idnum;
>> +		eg->metric_name = strdup(value);
>> +		eg->metric_expr = pe->metric_expr;
>> +		eg->metric_unit = pe->unit;
>> +		list_add_tail(&eg->nd, group_list);
>> +		ret = 0;
>> +
>> +		if (ret != 0)
>> +			break;
> 
> the inside loop is essentialy what you factor out to
> metricgroup__add_metric_param right? please nove
> addition of metricgroup__add_metric_param function
> into separate patch
> 
> jirka
> 

Ok will put it in seperate patch.

Thanks,
kajol
> 
>> +	}
>> +	return ret;
>> +}
>> +static int metricgroup__add_metric_param(struct strbuf *events,
>> +			struct list_head *group_list, struct pmu_event *pe)
>> +{
>> +
>> +	const char **ids;
>> +	int idnum;
>> +	struct egroup *eg;
>> +	int ret = -EINVAL;
>> +
>> +	if (expr__find_other(pe->metric_expr,
>> +					     NULL, &ids, &idnum) < 0)
>> +		return ret;
>> +	if (events->len > 0)
>> +		strbuf_addf(events, ",");
>> +
>> +	if (metricgroup__has_constraint(pe))
>> +		metricgroup__add_metric_non_group(events, ids, idnum);
>> +	else
>> +		metricgroup__add_metric_weak_group(events, ids, idnum);
>> +
>> +	eg = malloc(sizeof(struct egroup));
>> +	if (!eg)
>> +		ret = -ENOMEM;
>> +
>> +	eg->ids = ids;
>> +	eg->idnum = idnum;
>> +	eg->metric_name = pe->metric_name;
>> +	eg->metric_expr = pe->metric_expr;
>> +	eg->metric_unit = pe->unit;
>> +	list_add_tail(&eg->nd, group_list);
>> +	ret = 0;
>> +
>> +	return ret;
>> +}
> 
> SNIP
> 
