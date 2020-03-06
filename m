Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B5EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E7E20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCFExF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:53:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgCFExE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:53:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0264oiqu066365;
        Thu, 5 Mar 2020 23:52:38 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhsvbxhk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 23:52:38 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0264qRB4070297;
        Thu, 5 Mar 2020 23:52:37 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhsvbxhjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 23:52:37 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0264oGbO030012;
        Fri, 6 Mar 2020 04:52:36 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 2yffk70t6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 04:52:36 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0264qZKT62980478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 04:52:35 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 697116A047;
        Fri,  6 Mar 2020 04:52:35 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 177716A04F;
        Fri,  6 Mar 2020 04:52:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.186])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 04:52:28 +0000 (GMT)
Subject: Re: [PATCH v3 6/8] perf/tools: Enhance JSON/metric infrastructure to
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
References: <20200229094159.25573-1-kjain@linux.ibm.com>
 <20200229094159.25573-7-kjain@linux.ibm.com> <20200302150819.GA259142@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <d15a8aa6-e2d5-3edf-699a-8eda0862fd9b@linux.ibm.com>
Date:   Fri, 6 Mar 2020 10:22:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200302150819.GA259142@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_08:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=950 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/20 8:38 PM, Jiri Olsa wrote:
> On Sat, Feb 29, 2020 at 03:11:57PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>>  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
>>  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
>>  
>> +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/"
>> +
>>  int
>>  get_cpuid(char *buffer, size_t sz)
>>  {
>> @@ -44,3 +51,43 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>>  
>>  	return bufp;
>>  }
>> +
>> +int arch_get_runtimeparam(void)
>> +{
>> +	int count = 0;
>> +	DIR *dir;
>> +	char path[PATH_MAX];
>> +	const char *sysfs = sysfs__mountpoint();
>> +	char filename[] = "sockets";
>> +	FILE *file;
>> +	char buf[16], *num;
>> +	int data;
>> +
>> +	if (!sysfs)
>> +		goto out;
>> +
>> +	snprintf(path, PATH_MAX,
>> +		 "%s" SOCKETS_INFO_FILE_PATH, sysfs);
>> +	dir = opendir(path);
>> +
>> +	if (!dir)
>> +		goto out;
>> +
>> +	strcat(path, filename);
>> +	file = fopen(path, "r");
>> +
>> +	if (!file)
>> +		goto out;
>> +
>> +	data = fread(buf, 1, sizeof(buf), file);
>> +
>> +	if (data == 0)
>> +		goto out;
>> +
>> +	count = strtol(buf, &num, 10);
>> +out:
>> +	if (!count)
>> +		count = 1;
>> +
>> +	return count;
> 
> we have sysfs__read_ull for this
> 

Hi Jiri,
    Thanks for suggesting it. Will update.

Kajol

> jirka
> 
