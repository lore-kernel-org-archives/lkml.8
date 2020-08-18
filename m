Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55919C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9332078B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Od+3yT40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHRJQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:16:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbgHRJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:16:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I93MQb177743;
        Tue, 18 Aug 2020 05:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1eliUMZTEbkWBf+VQBrm/YQjJEBrlLW04a4iyHZxDds=;
 b=Od+3yT40b9LWYR89wCo4gH7As4E9LvfaHi0ToROvnk3au7H4YJfIiugv44RiJLGBqWVr
 Y5S4cW1FrlKapHMPe+pQ+Gm4SKuOroBZzGY7u4KyvwKRvgygz+LF4C3z2Trf9eadrjs3
 Mf53sx5zWn8vt6RDpAuiJNxxQaIIi+lLSdrVmKIqMKdLrmAh292FPhDNVa8IJHAvSUdl
 qGZSKSZR3ht7EAXFDnk7jE6a256W/qn1Tc3+z8Tr89ii1VGPgLmD+CPyCKCbMTqc7Qa1
 Ii3Yw3w0hCwyzt4xD862F1qcNJ5gS9AI1kqR81o2uBzaCJuiasT77BQ6j81KyJDHGilC Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3304t1b4kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 05:16:22 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07I93OU0177841;
        Tue, 18 Aug 2020 05:16:21 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3304t1b4kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 05:16:21 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07I9FDPk032481;
        Tue, 18 Aug 2020 09:16:20 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3304uqb88s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 09:16:20 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07I9GJCX63701320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 09:16:19 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A02C6A047;
        Tue, 18 Aug 2020 09:16:19 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F1636A054;
        Tue, 18 Aug 2020 09:16:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.32])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 18 Aug 2020 09:16:11 +0000 (GMT)
Subject: Re: [PATCH v5 1/3] perf jevents: Add support for parsing
 perchip/percore events
To:     Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
References: <20200816090719.72018-1-kjain@linux.ibm.com>
 <20200816090719.72018-2-kjain@linux.ibm.com>
 <20200816163521.GF1486171@tassilo.jf.intel.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <1265e9f4-fcfd-bb21-bf27-4ce56a04bcb9@linux.ibm.com>
Date:   Tue, 18 Aug 2020 14:46:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200816163521.GF1486171@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_06:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/20 10:05 PM, Andi Kleen wrote:
>> @@ -321,7 +331,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>>  static int print_events_table_entry(void *data, char *name, char *event,
>>  				    char *desc, char *long_desc,
>>  				    char *pmu, char *unit, char *perpkg,
>> -				    char *metric_expr,
>> +				    char *metric_expr, char *aggr_mode,
>>  				    char *metric_name, char *metric_group,
>>  				    char *deprecated, char *metric_constraint)
> 
> We should really define a struct now to pass the parameters,
> the callback prototype is getting ridiculous.
> 
> I know it's my fault originally, but sorry you probably have to do it
> because you are touching it last.

Hi Andi,
   I will look into it.

Thanks,
Kajol Jain
> 
> -Andi
> 
