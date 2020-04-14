Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CE620678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="odqJ3CG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391820AbgDNQgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:36:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46846 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391804AbgDNQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:36:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EGN4uj068794;
        Tue, 14 Apr 2020 16:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+yPSkB6MIowJQszHtIzPH9Ov/fiqm3RcXe6FOdMkD8Q=;
 b=odqJ3CG+AUp9pXI/W0yO++ae/10q/N6Z7mt6A75QMaW+bskDJpSC8wZl9FWJV1sjbOUD
 7pUd7PzzqK48OYdpH/7hC21QxgaC5sgUDkynNzZwNBSOz+Ni2NY03pCooKiFdbhnzBhU
 PeLp2iGy1FFfZE7gA3IPGaTt0/3ruOJxAPAqWOybdwJfKs/jJSAr3l8JWgqm4e+qGOcl
 /eJBuW0FXnr40BS53DxDxBIEknOxP7E6k6/EAqDNFxupPdHa0vbGfE6Hyd88e/zjkP0g
 +rUCoO85e3Nv4aOevHYOUDJ4HwV3BsexiP1kml7W3z5vzMnsjv27NmINNNqky9maINPn Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30b5ar5wjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 16:35:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EGR8Ru161303;
        Tue, 14 Apr 2020 16:35:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30ctaamadh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 16:35:45 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EGZiZu031320;
        Tue, 14 Apr 2020 16:35:44 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 09:35:44 -0700
Subject: Re: [PATCH V3 5/9] objtool: Add return address unwind hints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-6-alexandre.chartre@oracle.com>
 <20200414161636.GP20713@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <546b2d81-39ca-00e1-4df2-d4eaa18496a4@oracle.com>
Date:   Tue, 14 Apr 2020 18:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414161636.GP20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/14/20 6:16 PM, Peter Zijlstra wrote:
> On Tue, Apr 14, 2020 at 12:36:14PM +0200, Alexandre Chartre wrote:
>> Add the UNWIND_HINT_RADDR_DELETE and UNWIND_HINT_RADDR_ALTER unwind
>> hint macros to flag instructions which remove or modify return
>> addresses.
> 
> I'm confused by this thing; why? AFAICT the rest of the patches are
> actually simpler without this one.
> 

This is required to indicate to objtool that assembly instructions are
changing return addresses. For example, in patch 8:

For retpoline:

@@ -88,6 +96,7 @@
  	lfence
  	jmp	.Lspec_trap_\@
  .Ldo_rop_\@:
+	UNWIND_HINT_RADDR_ALTER
  	mov	\reg, (%_ASM_SP)
  	ret
  .endm

The unwind hint indicates that the return address has been altered, so the
code won't return to the return address which was on the stack.

Also for RSB stuffing, this is used to indicated that the stack adjustment
instruction (add $(BITS_PER_LONG/8) * 2, sp) is actually removing the last
two return addresses.

alex.
