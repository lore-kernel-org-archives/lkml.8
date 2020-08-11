Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4519C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913CF2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iOeUdNug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgHKPZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:25:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728833AbgHKPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:25:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07BFOJta044848;
        Tue, 11 Aug 2020 11:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cEwk6TAa95zYV1nxW+N1opA9VVfSaCs08FvB3POEfBQ=;
 b=iOeUdNug91mwxq6LkF1sO727VPzsCU0i8y9yfmxNA7+NdLRrHdBU06QLzjzcjZMIWf3i
 l3USvjp+4uYf2hZa7poPqAwl/7pkEb89WIqTo/jS5JegX/h14jqtjBrk08SkD4fEVQvL
 +67oKss94tuAvU9N8+YRGbdrqjply3gP37VZ0GVbqtfx51tq2BVJb+8cA4eD8/aoAmCW
 ORoTYO+745lpVUmjHQlOMNc4UkCf5xDwWxyY2XT8NlA1paQ9FhWTtlVFoQ2vFoXtIrVT
 FzXhpUzqcKK4+yLsxCvv8QsrcrAEwiCPu/5HVNLUdCZxabvyuFa+fMbLgJkkGytzsoOv wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ut5nyw8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 11:24:21 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07BFOLuO045061;
        Tue, 11 Aug 2020 11:24:21 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ut5nyw5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 11:24:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07BFKOsk029899;
        Tue, 11 Aug 2020 15:24:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp83gpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 15:24:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07BFODgs20775192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 15:24:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4052052067;
        Tue, 11 Aug 2020 15:24:13 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.46.203])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 584635204F;
        Tue, 11 Aug 2020 15:24:12 +0000 (GMT)
Subject: Re: [PATCH] [v2] tools/objtool: Fix unnecessary jumps
To:     Youling Tang <tangyouling@loongson.cn>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <1597119505-8038-1-git-send-email-tangyouling@loongson.cn>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <c3cc66bb-bdf0-bc53-f7d3-75cf8d5f94d4@linux.vnet.ibm.com>
Date:   Tue, 11 Aug 2020 20:54:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597119505-8038-1-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_13:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=8
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=665
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/20 9:48 am, Youling Tang wrote:
> There is no need to jump to the "out" tag when "ret < 0", just return
> directly to "ret".
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

the patch looks good to me, the commit message doesn't explain the
reason for the change. It can be written like:

"Previously cleanup() function was called under the out label for both
fatal errors (ret < 0) and warnings.  Now that cleanup() function is
removed, the out label is no longer required. Remove it and return
immediately for the fatal errors with ret as return code and 0 for
warnings."


Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>


-- 
Kamalesh
