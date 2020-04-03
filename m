Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6DFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9662063A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eBe68WUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbgDCHCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:02:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48898 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgDCHCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:02:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0336wn4W071098;
        Fri, 3 Apr 2020 07:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dlIKwf2o/EY4z2O1MnwkwbKcG+hZpuImBpKfasMrxuk=;
 b=eBe68WUFzJFbEcfrOiAF3rIgtstCOOAExVMhutUwveSesOUI06eOtNpEeSi6HjT4aKyx
 YdiAkQAfPWaod2Zl5vgTgjN3PoCH5AK0TBz3ivRH68QfDgsVaEG9v3phn6HUa2+M9RJm
 mlhiaLQ57sQWi770WUpoaEFjoZwLpwhzwJp1KKhOeLLxRCnXbInC6L+GXa52TYJfSt+I
 XeT1uvHlaGR5d2FpIzp+W5WgQ58ZQXZ6cCQr2QByVtPy/dcbCWJRObwMWptoJmG2oZdQ
 wDcE59SjIOKsIIZr7Ef+v9yDxpgCq/1NvXJ44sua8338JSPzJOzk+utyn/35SgyfKluS jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 303aqhytsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 07:02:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03372AAl050261;
        Fri, 3 Apr 2020 07:02:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 302ga3y4j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 07:02:16 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03372CZP015686;
        Fri, 3 Apr 2020 07:02:14 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 00:02:12 -0700
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <4e779423-395d-5e2e-b641-5604902bf096@oracle.com>
 <20200402150407.GD20730@hirez.programming.kicks-ass.net>
 <20200402155436.q6qbuezmmarr24qp@treble>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <a851047e-afd4-9d3d-60b7-8dd4be7423dc@oracle.com>
Date:   Fri, 3 Apr 2020 09:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200402155436.q6qbuezmmarr24qp@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/20 5:54 PM, Josh Poimboeuf wrote:
> On Thu, Apr 02, 2020 at 05:04:07PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 02, 2020 at 03:24:45PM +0200, Alexandre Chartre wrote:
>>> On 4/2/20 2:53 PM, Julien Thierry wrote:
>>>> On 4/2/20 9:22 AM, Alexandre Chartre wrote:
>>
>>>>> +Â Â Â  sec = find_section_by_name(file->elf,
>>>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  ".rela.discard.intra_function_call");
>>>>
>>>> I'm wondering, do we really need to annotate the intra_function_call
>>>> and group the in a section?
>>>>
>>>> Would it be a problem to consider all (static) call instructions with
>>>> a destination that is not the start offset of a symbol to be an
>>>> intra-function call (and set insn->intra_function_call and
>>>> insn->jump_dest accordingly)?
>>>
>>> Correct, we could automatically detect intra-function calls instead of
>>> having to annotate them. However, I choose to annotate them because I don't
>>> think that's not an expected construct in a "normal" code flow (at least
>>> on x86). So objtool would still issue a warning on intra-function calls
>>> by default, and you can annotate them to indicate if they are expected.
>>
>> I wondered the same thing when reading the patch. I'm confliected on
>> this. On the one hand auto-detecting this seems like an excellent idea.
>>
>> If/when the compiler generates them, they had better be okay too.
>>
>> Josh?
> 
> In general I prefer to keep it simple, and keep the annotations to a
> minimum.  And I don't think this warning has ever found anything useful.
> So I'd be inclined to say just allow them and automatically detect them.
> 
> However the fact that arm64 asm actually uses them worries me a bit.
> 
> So for me it kind of hinges on whether arm64 has a legitimate use case
> for them, or if the warning actually points to smelly code.
> 

Then what I can do is:
- by default, automatically detect and validate intra-function calls
- remove the INTRA_FUNCTION_CALL annotation
- add an objtool option to print a warning about intra-function calls
   (but still validate such calls).

This way by default intra-function calls are automatically detected and
validated. But you still have the option to print them out if you want
to check if there are any intra-function calls.

alex.
