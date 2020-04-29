Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3463C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9782082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD2JJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:09:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbgD2JJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:09:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T91dbP041371;
        Wed, 29 Apr 2020 05:09:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mfhf7c6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 05:09:10 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03T91j1i042091;
        Wed, 29 Apr 2020 05:09:10 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mfhf7c5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 05:09:09 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03T95rUL002009;
        Wed, 29 Apr 2020 09:09:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 30mcu51mtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 09:09:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03T97u0g63504810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 09:07:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8052BAE051;
        Wed, 29 Apr 2020 09:09:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D3C3AE045;
        Wed, 29 Apr 2020 09:08:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.16])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Apr 2020 09:08:58 +0000 (GMT)
Subject: Re: [PATCH v7 3/5] powerpc/hv-24x7: Add sysfs files inside hv-24x7
 device to show processor details
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
References: <20200327063642.26175-1-kjain@linux.ibm.com>
 <20200327063642.26175-4-kjain@linux.ibm.com>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
Message-ID: <f4e8fcfd-7147-e463-36d8-7e922f63b6bd@linux.ibm.com>
Date:   Wed, 29 Apr 2020 14:38:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200327063642.26175-4-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_02:2020-04-28,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/20 12:06 PM, Kajol Jain wrote:
> To expose the system dependent parameter like total number of
> sockets and numbers of chips per socket, patch adds two sysfs files.
> "sockets" and "chips" are added to /sys/devices/hv_24x7/interface/
> of the "hv_24x7" pmu.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>   arch/powerpc/perf/hv-24x7.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 9ae00f29bd21..a31bd5b88f7a 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -454,6 +454,20 @@ static ssize_t device_show_string(struct device *dev,
>   	return sprintf(buf, "%s\n", (char *)d->var);
>   }
>
> +#ifdef CONFIG_PPC_RTAS
> +static ssize_t sockets_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", physsockets);
> +}
> +
> +static ssize_t chips_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	return sprintf(buf, "%d\n", physchips);
> +}
> +#endif
> +

rtas call gives you the cores per chip too. We can expose that
also with this patch?  I understand tool side patchset is using
only metrics added to socket/chip information, its better to
include that cores also here..

>   static struct attribute *device_str_attr_create_(char *name, char *str)
>   {
>   	struct dev_ext_attribute *attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> @@ -1100,6 +1114,10 @@ PAGE_0_ATTR(catalog_len, "%lld\n",
>   		(unsigned long long)be32_to_cpu(page_0->length) * 4096);
>   static BIN_ATTR_RO(catalog, 0/* real length varies */);
>   static DEVICE_ATTR_RO(domains);
> +#ifdef CONFIG_PPC_RTAS
> +static DEVICE_ATTR_RO(sockets);
> +static DEVICE_ATTR_RO(chips);
> +#endif
>
>   static struct bin_attribute *if_bin_attrs[] = {
>   	&bin_attr_catalog,
> @@ -1110,6 +1128,10 @@ static struct attribute *if_attrs[] = {
>   	&dev_attr_catalog_len.attr,
>   	&dev_attr_catalog_version.attr,
>   	&dev_attr_domains.attr,
> +#ifdef CONFIG_PPC_RTAS
> +	&dev_attr_sockets.attr,
> +	&dev_attr_chips.attr,
> +#endif
>   	NULL,
>   };
>

