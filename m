Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB055C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F68A2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gV3CRGJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgDGO2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgDGO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037ERj7i147104;
        Tue, 7 Apr 2020 14:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Goihtn9rgqAJTR6qpyPmZdKS5VFl0VQlxjENwDfJrvE=;
 b=gV3CRGJafUB149X0UIV4F4JDdXizlHEZhKrtE7LhW48zLlQByjV7TQFes5RL8KJ402G1
 W+m9FSqbdQS3VzNjNldoi39Z9PVVDEWnRB1+jpNMlVGlFRaJrBpicB3Bpvv9V6TCFmTE
 vdzLEfptdnkIQcMmOirmvmDSDKXDst3k4UYRqMezXJSnV0XfTeSpsMwsJCKBX6MwyP+x
 hHt0CxJ4xtOGrI6UwXnOf22/7ZYHqugHH1/XxMmi/GlwdWRrevB8gwcSBVnzHPSZswdu
 w/zV5RJcpQRig2y+g1Rm9AyC3xQYiez2/JmV22A3g0MKukhIudwyAjX1J27osyYW4dqb Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 306j6mdb1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 14:28:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037ERH9S024263;
        Tue, 7 Apr 2020 14:28:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3073qg64bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 14:28:08 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037ES6nA014362;
        Tue, 7 Apr 2020 14:28:07 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 07:28:06 -0700
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
Date:   Tue, 7 Apr 2020 16:32:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200407133454.n55u5nx33ruj73gx@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/20 3:34 PM, Josh Poimboeuf wrote:
> On Tue, Apr 07, 2020 at 03:28:37PM +0200, Peter Zijlstra wrote:
>> Josh, we should probably have objtool verify it doesn't emit ORC entries
>> in alternative ranges.
> 
> Agreed, it might be as simple as checking for insn->alt_group in the
> INSN_STACK check or in update_insn_state().
> 

We could do that only for the "objtool orc generate" command. That way
"objtool check" would still check the alternative, but "objtool orc generate"
will just use the first half of the alternative (like it does today with
ANNOTATE_NOSPEC_ALTERNATIVE). We can even keep all ANNOTATE_NOSPEC_ALTERNATIVE
but only use them for "objtool orc generate".

alex.
