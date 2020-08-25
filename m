Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1103AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A8D2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7rhqOGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgHYGQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:16:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726015AbgHYGQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:16:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P62OnK151685;
        Tue, 25 Aug 2020 02:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3lt9n+xylShg1nAnIhyMPuf0nMy+IWs9NzPJh3a0kqo=;
 b=l7rhqOGHy5Yjh0DD5875O+BNchFUuULnXRXHGttUPxQaBNEKDc+sejqLReIdmIPMfrul
 Iuplm+oSu5KRd36z1Oo0h/2tyG/b3VApRx3PnnldoKQf4ovmGYBkdMl1Wju0/5HFURzC
 9KSz9tcb9iKYFhFcUy2AtXZGE9PJ8DauppGxDMGJRIhhmkwCcyhd0t5JlvOq+xae2xXs
 WW+F0eX7uJ5ehKElMCUSeDvnXkHfG4BYDqT0rtG9DFJdJI9w8jW5yd0ld9+iZqUnUelv
 oW/BTM5OowxLXgEaZVgqYaI3a8aoe2Wvb9JUJr8Hw8M0AbJ5/4L8UybEut1gIqJGQGFO Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334vjugyc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 02:15:49 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07P641j5157800;
        Tue, 25 Aug 2020 02:15:49 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334vjugyba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 02:15:48 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P68PCs022600;
        Tue, 25 Aug 2020 06:15:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 332ujku3ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 06:15:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07P6EEtT45023572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 06:14:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 647C442061;
        Tue, 25 Aug 2020 06:15:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5207C42045;
        Tue, 25 Aug 2020 06:15:37 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.81.204.251])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 06:15:36 +0000 (GMT)
Subject: Re: [PATCH] Fix s390x compile error on F32 utils/stat-display.c
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
References: <20200722092053.22345-1-tmricht@linux.ibm.com>
 <20200812112708.GA13995@kernel.org> <20200824202215.GA631468@krava>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <9753b4ff-2f28-9012-5849-d82031d3ec76@linux.ibm.com>
Date:   Tue, 25 Aug 2020 08:15:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824202215.GA631468@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=2 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/20 10:22 PM, Jiri Olsa wrote:
> On Wed, Aug 12, 2020 at 08:27:08AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Jul 22, 2020 at 11:20:53AM +0200, Thomas Richter escreveu:
>>> Fix a compile error on F32 and gcc version 10.1 on s390 in file
>>> utils/stat-display.c.  The error does not show up with make DEBUG=y.
>>> In fact the issue shows up when using both compiler options
>>> -O6 and -D_FORTIFY_SOURCE=2 (which are omitted with DEBUG=Y).
>>>
>>> This is the offending call chain:
>>> print_counter_aggr()
>>>   printout(config, -1, 0, ...)  with 2nd parm id set to -1
>>>     aggr_printout(config, x, id --> -1, ...) which leads to this code:
>>> 		case AGGR_NONE:
>>>                 if (evsel->percore && !config->percore_show_thread) {
>>>                         ....
>>>                 } else {
>>>                         fprintf(config->output, "CPU%*d%s",
>>>                                 config->csv_output ? 0 : -7,
>>>                                 evsel__cpus(evsel)->map[id],
>>> 				                        ^^ id is -1 !!!!
>>>                                 config->csv_sep);
>>>                 }
>>>
>>> This is a compiler inlining issue which is detected on s390 but not on
>>> other plattforms.
>>
>> What is the sequence of events that gets to this? I.e. is it valid to
>> get a config->aggr_mode == AGGR_NONE, then have evsel not be percore and
>> config->percore_show_thread to be false?
>>
>> I wonder if this won't be papering over some bug :-\
>>
>> Jin?
>>
>> This is where this came from:
>> commit 4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c (tag: perf-core-for-mingo-5.2-20190517)
>> Author: Jin Yao <yao.jin@linux.intel.com>
>> Date:   Fri Apr 12 21:59:49 2019 +0800
>>
>>     perf stat: Support 'percore' event qualifier
>>
>>     With this patch, we can use the 'percore' event qualifier in perf-stat.
>>
>> ---
>>
>> Also please add at least Jiri and Namhyung on the CC list, having the
>> person that added that array usage also helps.
>>
>> [acme@quaco perf]$ scripts/get_maintainer.pl tools/perf | grep reviewer
>> Mark Rutland <mark.rutland@arm.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
>> Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
>> Jiri Olsa <jolsa@redhat.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
>> Namhyung Kim <namhyung@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
>> [acme@quaco perf]$
>>
>> Thanks,
>>
>> - Arnaldo
>>  
>>> Output before:
>>>  # make util/stat-display.o
>>>     .....
>>>
>>>   util/stat-display.c: In function ‘perf_evlist__print_counters’:
>>>   util/stat-display.c:121:4: error: array subscript -1 is below array
>>>       bounds of ‘int[]’ [-Werror=array-bounds]
>>>   121 |    fprintf(config->output, "CPU%*d%s",
>>>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>   122 |     config->csv_output ? 0 : -7,
>>>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>   123 |     evsel__cpus(evsel)->map[id],
>>>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>   124 |     config->csv_sep);
>>>       |     ~~~~~~~~~~~~~~~~
>>>   In file included from util/evsel.h:13,
>>>                  from util/evlist.h:13,
>>>                  from util/stat-display.c:9:
>>>   /root/linux/tools/lib/perf/include/internal/cpumap.h:10:7:
>>>   note: while referencing ‘map’
>>>    10 |  int  map[];
>>>       |       ^~~
>>>   cc1: all warnings being treated as errors
>>>   mv: cannot stat 'util/.stat-display.o.tmp': No such file or directory
>>>   make[3]: *** [/root/linux/tools/build/Makefile.build:97: util/stat-display.o]
>>>   Error 1
>>>   make[2]: *** [Makefile.perf:716: util/stat-display.o] Error 2
>>>   make[1]: *** [Makefile.perf:231: sub-make] Error 2
>>>   make: *** [Makefile:110: util/stat-display.o] Error 2
>>>   [root@t35lp46 perf]#
> 
> I tested on s390 with rhel8, but did not get this error,
> f32's gcc must be smarter
> 

i Jiri,

that is correct. I have installed Fedora 32 on my LPAR and the gcc version
is:
[root@t35lp46 ~]# gcc --version
gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[root@t35lp46 ~]# cat /etc/redhat-release
Fedora release 32 (Thirty Two)
[root@t35lp46 ~]#

Same commands on a RHEL 8.2 installation reveal
[root@m35lp76 ~]# gcc --version
gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[root@m35lp76 ~]# cat /etc/redhat-release
Red Hat Enterprise Linux release 8.2 Beta (Ootpa)
[root@m35lp76 ~]# 

So there are 2 major revisions difference between a F32 and a RHEL8
gcc compiler installation.

>>>
>>> Output after:
>>>   # make util/stat-display.o
>>>     .....
>>>   CC       util/stat-display.o
>>>   [root@t35lp46 perf]#
>>>
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>> ---
>>>  tools/perf/util/stat-display.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>> index 57d0706e1330..e49e544188e4 100644
>>> --- a/tools/perf/util/stat-display.c
>>> +++ b/tools/perf/util/stat-display.c
>>> @@ -118,10 +118,11 @@ static void aggr_printout(struct perf_stat_config *config,
>>>  				config->csv_output ? 0 : -3,
>>>  				cpu_map__id_to_cpu(id), config->csv_sep);
>>>  		} else {
>>> -			fprintf(config->output, "CPU%*d%s",
>>> -				config->csv_output ? 0 : -7,
>>> -				evsel__cpus(evsel)->map[id],
>>> -				config->csv_sep);
>>> +			if (id > -1)
>>> +				fprintf(config->output, "CPU%*d%s",
>>> +					config->csv_output ? 0 : -7,
>>> +					evsel__cpus(evsel)->map[id],
>>> +					config->csv_sep);
> 
> -1 is only through print_counter_aggr which is called for AGGR_GLOBAL
> case as you described, but I guess we can have this check as precaution
> 
> you could put it together with above else
> 
>     } else if (id > -1)
> 
> thanks,
> jirka
> 

As suggested I will send a new patch.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
