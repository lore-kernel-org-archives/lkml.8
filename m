Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E865521835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgATMvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:51:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbgATMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:51:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KCTYMC019834
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:50:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg7h5qtf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:50:58 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 20 Jan 2020 12:50:56 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 12:50:53 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KCoqFZ65798256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 12:50:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE883A4054;
        Mon, 20 Jan 2020 12:50:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA416A405B;
        Mon, 20 Jan 2020 12:50:50 +0000 (GMT)
Received: from [9.199.49.60] (unknown [9.199.49.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jan 2020 12:50:50 +0000 (GMT)
Subject: Re: [PATCH 3/3] perf annotate: Fix segfault with source toggle
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200117092612.30874-1-ravi.bangoria@linux.ibm.com>
 <20200117092612.30874-4-ravi.bangoria@linux.ibm.com>
 <20200120101246.GH608405@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 20 Jan 2020 18:20:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120101246.GH608405@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012012-0012-0000-0000-0000037F0D82
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012012-0013-0000-0000-000021BB4A3C
Message-Id: <35f06ce1-9604-0cac-c6a7-6684a9a3d8dd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/20 3:42 PM, Jiri Olsa wrote:
> On Fri, Jan 17, 2020 at 02:56:12PM +0530, Ravi Bangoria wrote:
>> While rendering annotate browser from perf report tui, we keep track
>> of total number of lines(asm + source) in annotation->nr_entries and
>> total number of asm lines in annotation->nr_asm_entries. But we don't
>> reset them before starting. Thus if user annotates same function
>> multiple times, we restart incrementing these fields with old values.
>>
>> This causes a segfault when user tries to toggle source code after
>> annotating same function multiple times. Fix it.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   tools/perf/util/annotate.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index fe98d29dfbc4..df09c2070337 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -2610,6 +2610,8 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
>>   	struct annotation_line *al;
>>   
>>   	notes->max_line_len = 0;
>> +	notes->nr_entries = 0;
>> +	notes->nr_asm_entries = 0;
> 
> seems fair ;-)
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks!

> 
> also could you please make that function static (in separate change)
> in your next repost?

Sure will do.

- Ravi

