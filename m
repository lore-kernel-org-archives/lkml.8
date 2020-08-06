Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D0FC4CC61
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ED523329
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PYkZEwya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgHFIjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:39:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHFIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:39:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0768W6xm124452;
        Thu, 6 Aug 2020 08:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lf50GodO0mCylc7OJJLRGIYO+4WAUG7p3sPhgRl0PVk=;
 b=PYkZEwyaAy97LKM1cBB6joJzabSMnCLElGbAySJCQBIpEie/sXyKzz+E2jmHzrjHYvY/
 KID+gQXEAER/FuMaNVvv3A3DHZHoINpypTv2g3+rj4pIgbjCXt9BjExRwejzzCxtzYf1
 Uy3ol5cKz+eAa+vk3oN89OLAx9KtJHNzYfJ2xr490ttUiHoF0XTZpIb4fBqBBVxqc7KD
 tQuuGOFASV9no9BNU7KevdBpHgNEog5+eKqpftYltlYQTmzbe7ew4HR4D6+AWOzNMK7z
 w8LUob3ttMME1ccv8QZC3EElvvyPtdr1yXWg816TQ7qnemFcsPBLpsx3QSZ5WD77mFiP +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32r6ep1kg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 06 Aug 2020 08:38:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0768X5Mh164119;
        Thu, 6 Aug 2020 08:36:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32qy8mwhab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Aug 2020 08:36:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0768aNQd018198;
        Thu, 6 Aug 2020 08:36:24 GMT
Received: from [10.175.60.188] (/10.175.60.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Aug 2020 01:36:23 -0700
Subject: Re: Minor RST rant
To:     Christoph Hellwig <hch@infradead.org>, peterz@infradead.org
Cc:     NeilBrown <neilb@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20200724132200.51fd2065@oasis.local.home>
 <20200724113325.44923f75@lwn.net> <20200724144234.3227b501@oasis.local.home>
 <877dusv5lc.fsf@notabene.neil.brown.name>
 <20200729124445.GB2638@hirez.programming.kicks-ass.net>
 <1e60ff85-4965-92cb-e50b-8ea9ccf6788e@oracle.com>
 <20200805151230.GT2674@hirez.programming.kicks-ass.net>
 <20200806064823.GA7292@infradead.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <d739e7e1-4eca-b927-1df8-dd04bec3b85e@oracle.com>
Date:   Thu, 6 Aug 2020 10:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806064823.GA7292@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=853 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxlogscore=871 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-08-06 08:48, Christoph Hellwig wrote:
> On Wed, Aug 05, 2020 at 05:12:30PM +0200, peterz@infradead.org wrote:
>> On Wed, Aug 05, 2020 at 04:49:50PM +0200, Vegard Nossum wrote:
>>> FWIW, I *really* like how the extra markup renders in a browser, and I
>>> don't think I'm the only one.
>>
>> The thing is, I write code in a text editor, not a browser. When a
>> header file says: read Documentation/foo I do 'gf' and that file gets
>> opened in a buffer.
>>
>> Needing a browser is a fail.
> 
> And that is my main problem with all the RST craze.  It optmizes for
> shiny display in a browser, but copletely messed up the typical
> developer flow.
> 

If you are using vim, you can put this in ~/.vim/after/syntax/rst.vim:

   syn region rstInlineLiteral matchgroup=Special start="``" end="``" 
concealends
   syn region rstEmphasis matchgroup=Special start="\*\*" end="\*\*" 
concealends
   setlocal conceallevel=2

This will hide the ``foo`` and **bar** markup on lines that are not
currently under the cursor.


Vegard
