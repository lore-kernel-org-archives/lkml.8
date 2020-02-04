Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14900C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBEF20732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBDCh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:37:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgBDCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:37:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0142bueK143629
        for <linux-kernel@vger.kernel.org>; Mon, 3 Feb 2020 21:37:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxbmnpah5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 21:37:57 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 4 Feb 2020 02:37:41 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Feb 2020 02:37:38 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0142aiSt47776086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 02:36:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34071A4040;
        Tue,  4 Feb 2020 02:37:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2185A405D;
        Tue,  4 Feb 2020 02:37:33 +0000 (GMT)
Received: from [9.199.60.95] (unknown [9.199.60.95])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 02:37:33 +0000 (GMT)
Subject: Re: [PATCH v2 1/6] perf annotate: Remove privsize from
 symbol__annotate() args
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200124080432.8065-1-ravi.bangoria@linux.ibm.com>
 <20200124080432.8065-2-ravi.bangoria@linux.ibm.com>
 <20200130111653.GE3841@kernel.org>
 <ab9edd7d-04d1-f988-9f29-81d65a807250@linux.ibm.com>
 <20200203133004.GA1521029@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 4 Feb 2020 08:07:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203133004.GA1521029@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20020402-0016-0000-0000-000002E36A83
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020402-0017-0000-0000-00003346441B
Message-Id: <6e9b795a-6fc5-dcac-9bfe-ac052e3294cf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_08:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/20 7:00 PM, Jiri Olsa wrote:
> On Mon, Feb 03, 2020 at 10:24:29AM +0530, Ravi Bangoria wrote:
>>
>>
>> On 1/30/20 4:46 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Jan 24, 2020 at 01:34:27PM +0530, Ravi Bangoria escreveu:
>>>> privsize is passed as 0 from all the symbol__annotate() callers.
>>>> Remove it from argument list.
>>>
>>> Right, trying to figure out when was it that this became unnecessary to
>>> see if this in fact is hiding some other problem...
>>>
>>> It all starts in the following change, re-reading those patches...
>>>
>>> - Arnaldo
>>>
>>
>> Ok, I just had a quick look at:
>> https://lore.kernel.org/lkml/20171011194323.GI3503@kernel.org/
>>
>> This change was for python annotation support which, I guess, Jiri didn't posted
>> the patches? Jiri, are you planning to post them?
> 
> yea, as I wrote in another reply, this came in as preparation
> to support python code lines, which still did not get in ;-)
> 
> also I replied that this way is probably even better for that,
> so that's why I'm ok with the change

Thanks Jiri.

-Ravi

