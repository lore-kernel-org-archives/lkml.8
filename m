Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC74C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C0220734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgFJEgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:36:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgFJEgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:36:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A4Wpc9115465;
        Wed, 10 Jun 2020 00:35:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ja3a87aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 00:35:30 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05A4WuKW115906;
        Wed, 10 Jun 2020 00:35:29 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ja3a87ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 00:35:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A4PMSs015838;
        Wed, 10 Jun 2020 04:35:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 31g2s7tvun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 04:35:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A4ZP5S59244578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 04:35:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AD744204C;
        Wed, 10 Jun 2020 04:35:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D452C42045;
        Wed, 10 Jun 2020 04:35:23 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.87.192])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Jun 2020 04:35:23 +0000 (GMT)
Subject: Re: [RFC][PATCH v4 27/32] objtool: mcount: Generic location and
 relocation table types
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <311ccd169cec877d0c1993772818f0e5cdf11dc4.1591125127.git.mhelsley@vmware.com>
 <79552506-b994-63ce-d3d9-8053dcbc02db@linux.vnet.ibm.com>
 <20200609181231.GD1284251@rlwimi.vmware.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <a9bd2caa-5e82-e7e1-b68e-b2d0bbab6d8b@linux.vnet.ibm.com>
Date:   Wed, 10 Jun 2020 10:05:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609181231.GD1284251@rlwimi.vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_01:2020-06-09,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 cotscore=-2147483648
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 11:42 PM, Matt Helsley wrote:

[...]

>> Hi Matt,
>>
>> I was trying out the patch series on ppc64le and found that __mcount_loc
>> and .rela__mcount_loc section pairs do not get generated. 
>>
>> # readelf -S fs/proc/cmdline.o|grep mcount
>> #
>>
>> Debugged the cause to get_mcountsym()'s return type.  It returns reloc
>> type from GELF_R_INFO() and expects Elf64_Xword a.k.a unsigned long
>> to be the return type but get_mcountsym() returns unsigned int on 64-bit.
>>
>> On power the _mcount is of relocation type R_PPC64_REL24 (info 0x170000000a),
>> using unsigned int truncates the value to 0xa and fails the above check.
>> Using below fix, that converts mcount_sym_info to use unsigned long, generates
>> the __mcount_loc section pairs.
>>
>> --- a/tools/objtool/mcount.c
>> +++ b/tools/objtool/mcount.c
>> @@ -163,7 +163,7 @@ static int is_mcounted_section_name(char const *const txtname)
>>                 strcmp(".cpuidle.text", txtname) == 0;
>>  }
>>  
>> -static unsigned int get_mcount_sym_info(struct reloc *reloc)
>> +static unsigned long get_mcount_sym_info(struct reloc *reloc)
>>  {
>>         struct symbol *sym = reloc->sym;
>>         char const *symname = sym->name;
>> @@ -274,7 +274,7 @@ static int nop_mcount(struct section * const rels,
>>  {
>>         struct reloc *reloc;
>>         struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
>> -       unsigned int mcount_sym_info = 0;
>> +       unsigned long mcount_sym_info = 0;
>>         int once = 0;
>>  
>>         list_for_each_entry(reloc, &rels->reloc_list, list) {
>> @@ -363,7 +363,7 @@ static void sift_rel_mcount(GElf_Addr **mlocpp,
>>  {
>>         GElf_Rel *mrelp = *mrelpp;
>>         GElf_Rela *mrelap = *mrelpp;
>> -       unsigned int mcount_sym_info = 0;
>> +       unsigned long mcount_sym_info = 0;
>>         struct reloc *reloc;
>>  
>>         list_for_each_entry(reloc, &rels->reloc_list, list) {
>>
>> # readelf -S fs/proc/cmdline.o|grep mcount
>>   [31] __mcount_loc      PROGBITS         0000000000000000  00022f10
>>   [32] .rela__mcount_loc RELA             0000000000000000  00022f20
> 
> Fixed for next posting.
> 
> I've essentially added this as another patch before it moves into
> recordmcount.c, gets renamed to get_mcount_sym_info(), etc. I did it
> this way because it only becomes necessary to change the type before
> moving the function (and eventually its callers) out of the wrapper.
> 
> I feel I should credit you as author or at least co-author of the added
> patch since it's basically a "backported" version of the changes you
> suggested. I reviewed the process in submitting-patches.rst and propose
> the commit message:
> 	
> 	objtool: mcount: Extend mcountsym size
> 	    
> 	Before we can move this function out of the wrapper and into
> 	wordsize-independent code we need to explicitly size the
> 	type returned from get_mcountsym() to preserve the symbol info.
> 
> 	Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> 	Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> 	Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> 
> Is that OK with you or do you have another preference?

Thanks, it works for me.

-- 
Kamalesh
