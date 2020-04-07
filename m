Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEA820730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E/x9m24E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgDGQOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:14:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDGQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:14:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037G9wsq140724;
        Tue, 7 Apr 2020 16:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1//3QeBEtaoZSXxnV8zned1KuVjvYnBfZKQumGBDNHM=;
 b=E/x9m24EjcMVFhK+tOGTPgmbgK9aOvYFVIywzehvoWFwXrBmqyiNfQkqqnC0ta0evdVG
 1QPEkr8Znco+tAjs4uj+3UUhACBCITEExVqFocuttGDwCvEJ8s3p4MwLXoOvmIVZ1nAe
 Na2FLhFH6H4SOBLmQCUSw8Q7vT7jqpSEtAZw1FtAIn/I6i5fLwbi9tdapAHxQrxKXgoR
 hqxp2mYgsiSm30rO1ntq3qvmfT1KLqYuQcKOuY0+tGU2CbPSxqaHTBom/ae5GEMObKgi
 mv94vDBgEFld7ofsyvtFVPfC+/OBMlOdhjru6sr8QNCkOLz2ZkQBPbkC9RpNQDMG0G1H nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 306j6me1ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 16:14:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037G7RxO051001;
        Tue, 7 Apr 2020 16:14:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3073qghd4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 16:14:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037GEQbB008161;
        Tue, 7 Apr 2020 16:14:29 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 09:14:26 -0700
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
Message-ID: <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
Date:   Tue, 7 Apr 2020 18:18:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/20 4:32 PM, Alexandre Chartre wrote:
> 
> On 4/7/20 3:34 PM, Josh Poimboeuf wrote:
>> On Tue, Apr 07, 2020 at 03:28:37PM +0200, Peter Zijlstra wrote:
>>> Josh, we should probably have objtool verify it doesn't emit ORC entries
>>> in alternative ranges.
>>
>> Agreed, it might be as simple as checking for insn->alt_group in the
>> INSN_STACK check or in update_insn_state().
>>
> 
> We could do that only for the "objtool orc generate" command. That way
> "objtool check" would still check the alternative, but "objtool orc generate"
> will just use the first half of the alternative (like it does today with
> ANNOTATE_NOSPEC_ALTERNATIVE). We can even keep all ANNOTATE_NOSPEC_ALTERNATIVE
> but only use them for "objtool orc generate".
> 

I have checked and objtool doesn't emit ORC entries for alternative:
decode_instructions() doesn't mark such section with sec->text = true
so create_orc_sections() doesn't emit corresponding ORC entries.

So I think we can remove the ANNOTATE_NOSPEC_ALTERNATIVE directives,
this will allow objtool to check the instructions but it still won't
emit ORC entries (same behavior as today). In the future, if ORC
eventually supports alternative we will be ready to have objtool emit
ORC entries.

alex.
