Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66327C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CC22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA1N5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:57:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbgA1N5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:57:42 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SDs6RU123741
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:57:40 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtfgyfpft-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:57:40 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 28 Jan 2020 13:57:37 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 13:57:34 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00SDvXT617498556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 13:57:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48B2BA404D;
        Tue, 28 Jan 2020 13:57:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13535A405B;
        Tue, 28 Jan 2020 13:57:31 +0000 (GMT)
Received: from [9.199.63.41] (unknown [9.199.63.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jan 2020 13:57:30 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] perf annotate: Simplify disasm_line allocation and
 freeing code
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200124080432.8065-1-ravi.bangoria@linux.ibm.com>
 <20200124080432.8065-3-ravi.bangoria@linux.ibm.com>
 <20200127115911.GB1114818@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 28 Jan 2020 19:27:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127115911.GB1114818@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012813-4275-0000-0000-0000039BB2A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012813-4276-0000-0000-000038AFCAEB
Message-Id: <41357577-deaf-fcbd-d6c1-8c2fc45d758e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_03:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=2 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/27/20 5:29 PM, Jiri Olsa wrote:
> On Fri, Jan 24, 2020 at 01:34:28PM +0530, Ravi Bangoria wrote:
> 
> SNIP
> 
>>   
>>   /*
>>    * Allocating the disasm annotation line data with
>>    * following structure:
>>    *
>> - *    ------------------------------------------------------------
>> - *    privsize space | struct disasm_line | struct annotation_line
>> - *    ------------------------------------------------------------
>> + *    -------------------------------------------
>> + *    struct disasm_line | struct annotation_line
>> + *    -------------------------------------------
>>    *
>>    * We have 'struct annotation_line' member as last member
>>    * of 'struct disasm_line' to have an easy access.
>> - *
>>    */
>>   static struct disasm_line *disasm_line__new(struct annotate_args *args)
>>   {
>>   	struct disasm_line *dl = NULL;
>> -	struct annotation_line *al;
>> -	size_t privsize = args->privsize + offsetof(struct disasm_line, al);
>> +	int nr = 1;
>>   
>> -	al = annotation_line__new(args, privsize);
> 
> ok, I finally recalled why we did it like this.. for the python
> annotation support, which never made it in ;-) however the allocation
> in 'specialized' line and later call to annotation_line__init might
> actualy be a better way

Sorry, I didn't get your point about 'specialized' line. You mean the way
I'm doing is better wrt existing code?

> 
>> -	if (al != NULL) {
>> -		dl = disasm_line(al);
>> +	if (perf_evsel__is_group_event(args->evsel))
>> +		nr = args->evsel->core.nr_members;
>>   
>> -		if (dl->al.line == NULL)
>> -			goto out_delete;
>> +	dl = zalloc(disasm_line_size(nr));
>> +	if (!dl)
>> +		return NULL;
>>   
>> -		if (args->offset != -1) {
>> -			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
>> -				goto out_free_line;
>> +	annotation_line__init(&dl->al, args, nr);
>> +	if (dl->al.line == NULL)
>> +		goto out_delete;
>>   
>> -			disasm_line__init_ins(dl, args->arch, &args->ms);
>> -		}
>> +	if (args->offset != -1) {
>> +		if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
>> +			goto out_free_line;
>> +
>> +		disasm_line__init_ins(dl, args->arch, &args->ms);
>>   	}
>>   
>>   	return dl;
>> @@ -1248,7 +1219,9 @@ void disasm_line__free(struct disasm_line *dl)
>>   	else
>>   		ins__delete(&dl->ops);
>>   	zfree(&dl->ins.name);
>> -	annotation_line__delete(&dl->al);
>> +	free_srcline(dl->al.path);
>> +	zfree(&dl->al.line);
> 
> no need to zfree if you're freeing the memory on the next line

dl->al.line is allocated using strdup() in annotation_line__init(). So I
think we still need that zfree(&dl->al.line).

> also could you please put it to annotation_line__exit, since
> you already added the __init function

Sure will do it.

Thanks for review :)
Ravi

