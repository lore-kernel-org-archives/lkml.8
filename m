Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA42C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8682074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cTukUVpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgDGN54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:57:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38236 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:57:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037DtWx0143825;
        Tue, 7 Apr 2020 13:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xcWl0/RLZI+rRm19VaCtBfLo0RsQgPHMgtE9vFZ4Fvk=;
 b=cTukUVpV7tEYYfRw3vib2RUWtKckkPGvag7e5FHILhitPjnLHZF6vrFvNu4mJ6EdQGlT
 C/brjB7s2e+nSR3tvlig5r55FN+jEdIL1Werk+VTt+gtOFGkMt6FDLAq9vS2jvrjpa9w
 eTwHdfwd2YKQSo5TqNcSaAShFeAW3N63TaBy98tnZoWZJySV8bgYDgVixBYwMKz/q8gC
 fMzgDzyAB2vrJEKnPsKqzDFA02yopz8gHDDR0eWynOcqtM7ub0cqqF2rrqbboBcnIEHD
 jCvkq8tima6FpZHne3F3MHQy0O8EDWrOb4ika9umW444Q4YnqcEz8b7ACsHa/hdNTnL0 hA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 306jvn535s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 13:57:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037DrIdi044963;
        Tue, 7 Apr 2020 13:57:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3073qg4bnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 13:57:40 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037DvcQU030005;
        Tue, 7 Apr 2020 13:57:38 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 06:57:38 -0700
Subject: Re: [PATCH V2 0/9] objtool changes to remove all
 ANNOTATE_NOSPEC_ALTERNATIVE
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407133528.htoxyrfc7fv625lh@treble>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <ae8f307f-0e41-ea25-7119-e3ee517d57db@oracle.com>
Date:   Tue, 7 Apr 2020 16:02:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200407133528.htoxyrfc7fv625lh@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/20 3:35 PM, Josh Poimboeuf wrote:
> On Tue, Apr 07, 2020 at 09:31:33AM +0200, Alexandre Chartre wrote:
>> Hi,
>>
>> This is version v2 of this patchset based on the different comments
>> received so far. It now uses and includes PeterZ patch to add
>> UNWIND_HINT_RET_OFFSET. Other changes are described below.
>>
>> Code like retpoline or RSB stuffing, which is used to mitigate some of
>> the speculative execution issues, is currently ignored by objtool with
>> the ANNOTATE_NOSPEC_ALTERNATIVE directive. This series adds support
>> for intra-function calls to objtool so that it can handle such a code.
>> With these changes, we can remove all ANNOTATE_NOSPEC_ALTERNATIVE
>> directives.
>>
>> Changes:
>>   - replace RETPOLINE_RET with PeterZ UNWIND_HINT_RET_OFFSET
>>   - make objtool intra-function call action architecture dependent
>>   - objtool now automatically detects and validates all intra-function
>>     calls but it issues a warning if the call was not explicitly tagged
>>   - change __FILL_RETURN_BUFFER to work with objtool
>>   - add generic ANNOTATE_INTRA_FUNCTION_CALL macro
>>   - remove all ANNOTATE_SPEC_ALTERNATIVE (even for __FILL_RETURN_BUFFER)
> 
> I had trouble applying the patches.  What branch are they based on?  In
> general the latest tip/master is good.

Oups, this is on based on 5.5. I didn't realize I was that late, I though
I recently rebased but it looks like I didn't. Sorry about that, I will
make sure the next version is more recent.

alex.
