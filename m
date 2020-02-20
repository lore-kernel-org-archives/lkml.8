Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ABAC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FAC2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBTJx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:53:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgBTJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:53:57 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K9nHca087556
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 04:53:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubv0h6s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 04:53:55 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maddy@linux.ibm.com>;
        Thu, 20 Feb 2020 09:53:52 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Feb 2020 09:53:47 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01K9rjAq48758894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 09:53:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C260AE056;
        Thu, 20 Feb 2020 09:53:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30CACAE051;
        Thu, 20 Feb 2020 09:53:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.143])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Feb 2020 09:53:42 +0000 (GMT)
Subject: Re: [PATCH 8/8] perf/tools/pmu-events/powerpc: Add hv_24x7
 socket/chip level metric events
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org
References: <20200214110335.31483-1-kjain@linux.ibm.com>
 <20200214110335.31483-9-kjain@linux.ibm.com>
From:   maddy <maddy@linux.ibm.com>
Date:   Thu, 20 Feb 2020 15:23:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214110335.31483-9-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022009-0012-0000-0000-000003888D03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022009-0013-0000-0000-000021C5233A
Message-Id: <276f2495-c838-cae4-d654-065e43b0323a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/20 4:33 PM, Kajol Jain wrote:
> The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
> facility to continuously collect large numbers of hardware performance
> metrics efficiently and accurately.
> This patch adds hv_24x7 json metric file for different Socket/chip
> resources.
>
> Result:
>
> power9 platform:
>
> command:# ./perf stat --metric-only -M Memory_RD_BW_Chip -C 0
>             -I 1000 sleep 1
>
> time MB       Memory_RD_BW_Chip_0 MB   Memory_RD_BW_Chip_1 MB
> 1.000192635                      0.4                      0.0
> 1.001695883                      0.0                      0.0
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>   .../arch/powerpc/power9/hv_24x7_metrics.json  | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json
> new file mode 100644
> index 000000000000..ac38f5540ac6
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json

Better to have it as nest_metrics.json instead.  Rest looks fine

Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> @@ -0,0 +1,19 @@
> +[
> +    {
> +        "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
> +        "MetricName": "Memory_RD_BW_Chip",
> +        "MetricGroup": "Memory_BW",
> +        "ScaleUnit": "1.6e-2MB"
> +    },
> +    {
> +    "MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
> +        "MetricName": "Memory_WR_BW_Chip",
> +        "MetricGroup": "Memory_BW",
> +        "ScaleUnit": "1.6e-2MB"
> +    },
> +    {
> +    "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
> +        "MetricName": "PowerBUS_Frequency",
> +        "ScaleUnit": "2.5e-7GHz"
> +    }
> +]

