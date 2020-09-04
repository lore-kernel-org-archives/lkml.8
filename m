Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36108C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EFE20709
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LwhnHPOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgIDIcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:32:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729707AbgIDIcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:32:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08482M3n114145;
        Fri, 4 Sep 2020 04:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LHE5+0l7+s7bBsLWPvYShHZNeUVhMj8/hTqJ1eoQSs0=;
 b=LwhnHPOkPykFtAF2O+kBfyq9GxL/BFbrLFsnj5VTTBKDP1aqeCpDhhONQtvOueqcZ1gT
 kclFEsCqBiRS6qcm7658ZdidPiygBAr5N/9pKa5k9I2NvVpSFJ8B4HJ3SDYW5g6WikgP
 VRtsO0tvOSP7qt/Q+cDsmGvHQIEv/vsx9j/+585GTCUrM0zF8jA9CgeluqO7TU8n8S4g
 gzB/xFRKjBESfukCLHlaYsr862VYBVhdJXPyV1V0Bpd9h1mIutaFxEJrll1A/wq6mdYX
 cQJqsSyBl3XA6PlAeOLyNuWp1i4KmOSzU22oUpZwUelD+qs7dSCb7ITfGZR/rNGYhIky ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33bhpu0t99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 04:31:46 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08482cdx115003;
        Fri, 4 Sep 2020 04:31:46 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33bhpu0t89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 04:31:46 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0848RXOQ012897;
        Fri, 4 Sep 2020 08:30:47 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 337en9p47b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 08:30:47 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0848UkUB14025002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Sep 2020 08:30:46 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7468F12405C;
        Fri,  4 Sep 2020 08:30:46 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 720E0124052;
        Fri,  4 Sep 2020 08:30:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.248])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  4 Sep 2020 08:30:40 +0000 (GMT)
Subject: Re: [PATCH v7 2/5] perf/jevents: Add new structure to pass json
 fields.
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        pc@us.ibm.com, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, John Garry <john.garry@huawei.com>
References: <20200902160439.335232-1-kjain@linux.ibm.com>
 <20200902160439.335232-3-kjain@linux.ibm.com>
 <CAM9d7cjDRGDuZhbZ1BJ2tF_hyrS0-b61kaL2=0VHtSFUcJN7sg@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <7da87918-2ddd-5090-5ed4-0c209a75858b@linux.ibm.com>
Date:   Fri, 4 Sep 2020 14:00:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjDRGDuZhbZ1BJ2tF_hyrS0-b61kaL2=0VHtSFUcJN7sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_03:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/20 8:24 PM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Sep 3, 2020 at 1:05 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>>
>> This patch adds new structure called 'json_event' inside jevents.h
> 
> jevents.c ?

Hi Namhyung,
       Right, I will update it.

Thanks,
Kajol Jain
> 
> Thanks
> Namhyung
> 
>> file to improve the callback prototype inside jevent files.
>> Initially, whenever user want to add new field, they need to update
>> in all function callback which make it more and more complex with
>> increased number of parmeters.
>> With this change, we just need to add it in new structure 'json_event'.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
