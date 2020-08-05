Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DF82177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tapVYhCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgHERWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:22:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34052 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgHERVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:21:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075ElEES126944;
        Wed, 5 Aug 2020 14:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=50kpLbsOD0ZKoRp8Q7BM9oovT52SXSK2r0dSb0ESevc=;
 b=tapVYhCIpNpfMnd3DVbCh5/jibmd+RPm0FkdZXF5he1B576M7KNK8hNAF1QkSQ4FfbFW
 PQzKZwCCQ5SBm7M0iKv1+CdnE8g4BdWCe/0cnh8GDau44yMSKn0/0l+i4h9BOrL+0qOO
 1Tth5STnQJJ5yu7MD92TOI1ML2ULvxSG2PgC4I4nM4C1luQZOFvjckBs6H0F58VQsUc9
 geLYkajzx7MnjHjocanXbfyzziW8+fUgKnfa1IbGVjQ6gFyxLgsLZ4xkks68brlvasd0
 5MVqhtGdPf9ofUVKTUhR/F0d/zPPuI9TVPv/bK2H5UsseHT6DGxaMDD2Cg1FQ2/oU8Q0 iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32pdnqdv1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 14:49:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075EmuBh181161;
        Wed, 5 Aug 2020 14:49:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32pdnth08k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 14:49:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 075EnrqE009945;
        Wed, 5 Aug 2020 14:49:55 GMT
Received: from [10.175.0.119] (/10.175.0.119)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 07:49:53 -0700
Subject: Re: Re: Minor RST rant
To:     peterz@infradead.org, NeilBrown <neilb@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20200724132200.51fd2065@oasis.local.home>
 <20200724113325.44923f75@lwn.net> <20200724144234.3227b501@oasis.local.home>
 <877dusv5lc.fsf@notabene.neil.brown.name>
 <20200729124445.GB2638@hirez.programming.kicks-ass.net>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <1e60ff85-4965-92cb-e50b-8ea9ccf6788e@oracle.com>
Date:   Wed, 5 Aug 2020 16:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729124445.GB2638@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-29 14:44, peterz@infradead.org wrote:
> On Sat, Jul 25, 2020 at 09:46:55AM +1000, NeilBrown wrote:
> 
>>   Constant names stand out least effectively by themselves.  In
>>   kernel-doc comments they are preceded by a '%'.  Would that make the
>>   text more readable for you?  Does our doc infrastructure honour that in
>>   .rst documents?
> 
> It does not. It also still reads really weird.
> 
> And for some reason firefox chokes on the HTML file I tried it with, and
> make htmldocs takes for bloody ever.
> 
> Give me a plain text file, please. All this modern crap just doesn't
> work.
> 

FWIW, I *really* like how the extra markup renders in a browser, and I
don't think I'm the only one.

If you want to read .rst files in a terminal, I would suggest using
something like this:

$ pandoc -t plain Documentation/core-api/atomic_ops.rst | less

It looks pretty readable to me, things like lists and code are properly
indented, the only thing it's missing as far as I'm concerned is marking
headings more prominently.

The new online documentation is a great way to attract more people to
kernel development (and just spread typical kernel knowledge to
non-Linux/non-kernel programmers). The old Documentation/ was kind of
hidden away and you only really came across it by accident if you did a
treewide 'git grep'; the new online docs, on the other hand, are a
pleasure to browse and explore and frequently show up in google searches
for random kernel-related topics.


Vegard
