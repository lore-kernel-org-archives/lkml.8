Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9841CC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F92323EF2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bRVTtBIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgDFOcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:32:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgDFOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:32:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036ERmb5164674;
        Mon, 6 Apr 2020 14:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VSir/jwIS86Ti+Bjs0dKhCzkqxS9YJ8FGAa/hLbL5NA=;
 b=bRVTtBINEmWcHUhDlRnrE8XVaBIbv6S9WX3TBCU8hBOXD3+tJzaaK1jy6cK1zoVnPox7
 1Nk2WQXUwFgnpTImAxKUsJGT6gR7u05HY3AHD80tRNqMAxYR89wjlgMwNHxqpzsut09y
 8U3o2rEzz7C59E0DhySJKqOc4prbZF3w3oObNyhnB3ctdH04yxcGF0gWsGAr27t5WSnk
 mJ77d7Yjnydfef4+cjLlt1Pwy6/w4j3xj/LAttetfDtrAX3hzx9TVN+xq2pk5No33emG
 dY56QH6zcQMoWhyiVFyNgfr2LWAFABJXebFHHEWyuHZaaRjK1p789hTjoodgXJff/785 Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 306hnqy7m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:32:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036ESQAx170971;
        Mon, 6 Apr 2020 14:30:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30839q5pqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:30:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036EU2eN005591;
        Mon, 6 Apr 2020 14:30:05 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 07:30:02 -0700
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <20200402152717.GE20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <94272807-23c0-3eae-8312-9488607186ca@oracle.com>
Date:   Mon, 6 Apr 2020 16:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200402152717.GE20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/20 5:27 PM, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 10:22:17AM +0200, Alexandre Chartre wrote:
>> With retpoline, the return instruction is used to branch to an address
>> stored on the stack. So, unlike a regular return instruction, when a
>> retpoline return instruction is reached the stack has been modified
>> compared to what we have when the function was entered.
>>
>> Provide the mechanism to explicitly call-out such return instruction
>> so that objtool can correctly handle them.
> 
> https://lkml.kernel.org/r/20200331222703.GH2452@worktop.programming.kicks-ass.net
> 
> And also, the split out version:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=core/objtool&id=ec9d9549901dfd2ff411676dfc624e50219e4d5a
> 

HINT_RET_OFFSET works fine when an immediate value is pushed on the
stack. However if the value is pushed from a callee-saved register
(%rbp, %rbx, %r12-%r15) then we still have a "return with modified
stack frame" warning. That's because objtool checks callee-saved
registers pushed/popped on the stack, and we have retpoline functions
built for each register (see arch/x86/lib/retpoline.S)

So that's why I also added a bool to has_modified_stack_frame() to
no check registers:

@@ -1432,7 +1478,8 @@ static bool is_fentry_call(struct instruction *insn)
  	return false;
  }
  
-static bool has_modified_stack_frame(struct insn_state *state)
+static bool has_modified_stack_frame(struct insn_state *state,
+				     bool check_registers)
  {
  	int i;
  
@@ -1442,6 +1489,9 @@ static bool has_modified_stack_frame(struct insn_state *state)
  	    state->drap)
  		return true;
  
+	if (!check_registers)
+		return false;
+
  	for (i = 0; i < CFI_NUM_REGS; i++)
  		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
  		    state->regs[i].offset != initial_func_cfi.regs[i].offset)


alex.
