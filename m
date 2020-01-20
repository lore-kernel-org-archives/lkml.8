Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBE4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23385208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgATMtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:49:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbgATMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:49:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KCTW7q025559
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:49:45 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgbnyt7k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:49:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 20 Jan 2020 12:49:43 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 12:49:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KCmnmu50463050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 12:48:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEDE3A4054;
        Mon, 20 Jan 2020 12:49:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D3A3A405B;
        Mon, 20 Jan 2020 12:49:37 +0000 (GMT)
Received: from [9.199.49.60] (unknown [9.199.49.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jan 2020 12:49:37 +0000 (GMT)
Subject: Re: [PATCH 1/3] perf annotate: Nuke privsize
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200117092612.30874-1-ravi.bangoria@linux.ibm.com>
 <20200117092612.30874-2-ravi.bangoria@linux.ibm.com>
 <20200120100825.GG608405@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 20 Jan 2020 18:19:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120100825.GG608405@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012012-0020-0000-0000-000003A25DDE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012012-0021-0000-0000-000021F9E8E0
Message-Id: <633759b2-8d6c-24b8-b058-b4d4b365fcee@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=565 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001200110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/20 3:38 PM, Jiri Olsa wrote:
>> -/*
>> - * Allocating the annotation line data with following
>> - * structure:
>> - *
>> - *    --------------------------------------
>> - *    private space | struct annotation_line
>> - *    --------------------------------------
>> - *
>> - * Size of the private space is stored in 'struct annotation_line'.
>> - *
>> - */
>> -static struct annotation_line *
>> -annotation_line__new(struct annotate_args *args, size_t privsize)
>> +static size_t disasm_line_size(int nr)
>>   {
> 
> I agree we can get rid of the 'users' privsize passed from symbol__annotate,
> but could you please put it in separate patch, while keeping privsize in here?
> 
> and then put the rest of the code factoring into separate patch,
> so we can see clearly the change and the benefits
> 
> your new annotation_line__new should be renamed to something like
> annotation_line__init ... we keep __new suffix for functions that
> return new objects

Sure Jiri. Will resend with these changes.

- Ravi

