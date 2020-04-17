Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F072AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3291206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFtvjFqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgDQUSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:18:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35934 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgDQUSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:18:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HKCxcb105139;
        Fri, 17 Apr 2020 20:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=a1u4i9qCKl/LOyYn/BeRfknGYxmnO4PLWnrEBiyuaI4=;
 b=jFtvjFqhcDYTbe1R1RSBsGw+s6Jc4uozlxlRCRSs3IiK1sQtLjNOEoCLDul817/pFF7s
 d9TL251sRmwjS1SqQni1RqsNwPs9C3ouO5HmKlYkNeizcWtfoOWx8a3Z7hz+fouALNHk
 Ma+YpkVhB3AWcD6nQHdL3vy30X4UqZPVsVxfrVMaLMTEhv1s9uYU2nVBBPbLElwcUaX2
 Qf07Zpius1eJIitz1HLzErA5fB5BcC+fFdyleksVV36iZ+gA9QI9bDmMosXUiyOS4SuG
 Lv+z+65G9OVp0NRHAC6OUOOhssEyI9Qm2RrmAR5INpYJ2zsUS3fFH/y/y+Ey5G2qx9Yf Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30dn961420-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 20:17:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HKHBhV008133;
        Fri, 17 Apr 2020 20:17:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30emerqsx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 20:17:58 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03HKHuZW031756;
        Fri, 17 Apr 2020 20:17:57 GMT
Received: from linux-1.home (/10.175.17.90)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 13:17:56 -0700
Subject: Re: [PATCH v5 00/17] objtool: vmlinux.o and noinstr validation
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com
References: <20200416114706.625340212@infradead.org>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <17f5217f-c09b-484d-daae-bb0aa54d6b9b@oracle.com>
Date:   Fri, 17 Apr 2020 22:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416114706.625340212@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/20 1:47 PM, Peter Zijlstra wrote:
> As should be familiar by now; these patches implement the noinstr
> (no-instrument) validation in objtool as requested by Thomas, to ensure
> critical code (entry for now, idle later) run no unexpected code.
> 
> Functions are marked with: noinstr, which implies notrace, noinline and sticks
> things in the .noinstr.text section. Such functions can then use instr_begin()
> and instr_end() to allow calls to code outside of this section in sanctioned
> areas.
> 
> On the way of getting there, it also fixes the x86/ftrace trampiline ORC
> unwind.
> 

I have sent a few very minor comments; you can add my review for all patches:

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
