Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249AAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0161C24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAUKSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:18:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727220AbgAUKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:18:24 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LAHYPj124347;
        Tue, 21 Jan 2020 05:18:02 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgbq3pbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 05:18:01 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00LAI1VT126081;
        Tue, 21 Jan 2020 05:18:01 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgbq3pan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 05:18:01 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00LAGMEZ000712;
        Tue, 21 Jan 2020 10:18:00 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2xksn6h6b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 10:18:00 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00LAHx5h38207810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 10:17:59 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 478FBAE062;
        Tue, 21 Jan 2020 10:17:59 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB919AE05C;
        Tue, 21 Jan 2020 10:17:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.61])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 10:17:54 +0000 (GMT)
Subject: Re: [RFC 5/6] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
To:     Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org
References: <20200117124620.26094-1-kjain@linux.ibm.com>
 <20200117124620.26094-6-kjain@linux.ibm.com>
 <20200117162807.GL302770@tassilo.jf.intel.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <b6e3ae17-ce41-2709-1a87-dcd9bd1f365a@linux.ibm.com>
Date:   Tue, 21 Jan 2020 15:47:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200117162807.GL302770@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-21,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001210088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/20 9:58 PM, Andi Kleen wrote:
> On Fri, Jan 17, 2020 at 06:16:19PM +0530, Kajol Jain wrote:
>> Patch enhances current metric infrastructure to handle "?" in the metric
>> expression. The "?" can be use for parameters whose value not known while
>> creating metric events and which can be replace later at runtime to
>> the proper value. It also add flexibility to create multiple events out
>> of single metric event added in json file.
> Please add a proper specification how this ? thing is supposed to work,
> what the exact semantics are, how it is different from the existing
> # mechanism etc.
>
> The standard way to do similar things before was to define an explicit
> # name and let the expr code take care of it.

Hi Andi,

     Thanks for reviewing my patchset.

I did review the existing '#' mechanism. It is quiet useful for runtime
dependency (like ex. event selection based on a return value). But I want
to handle couple of more things. Meaning, filling in parameter of event code
based on runtime value and replicating events at runtime.

So the '?' can handle, 1) replacement of a value in the event code based 
on runtime

and 2) replicate the event (metric expr) at runtime (handled in new 
metricgroup__add_metric()).

This patchset add an arch specific function called 
'arch_get_runtimeparam'. Ideally,
arch_get_runtimeparm() returns the number of metric exps one want to 
create (it defaults to 1).
The loop added in 'metricgroup__add_metric' will handle the event addition.

Example ppc64 hv_24x7 pmu metric event using '?':

(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + 
hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@)

Here, '?' will be replaced with a runtime value and metric expression 
will be replicated.

Thanks,

Kajol

> -Andi
