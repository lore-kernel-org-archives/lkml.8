Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6E0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8D1212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="teYDg3m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgCaTJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:09:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48146 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCaTJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:09:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VJ7UqP088808;
        Tue, 31 Mar 2020 19:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=doew+ZyC9CR+4+YfZJlCHKqZdFQhUrotbR5npIqHeO4=;
 b=teYDg3m7/3Z928ssv4+tzmyeLv6c3S4AP5xxp3DN0pUNwt0Ti1srUQ4jXsI7pwodD0qc
 aaEYhFEwceI0bJC4K0H+4lNt9R0hMhPniby9ReSqsJSrIkzakrAfckP1J2Byv6Z/xE3N
 eJpltVM9cFKzDdh0bGE5PkjB1Quna6Qr5Ly/Of/mFsO9ZDAtruEgRrmPSdmRwulk6l6x
 tAXJ1Xj6v37J6618jrnNEddeD2NeZYtWHBW9U0NiRy48BNwy+4izmG5Vs2T/8GITtAyG
 J1zbblJpyR1j0uODdPb4S3tuZO4rQJMeoyWnDDYVIRoSy5pKWY7khQJNuUkBw09LA3M+ YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cev1edg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 19:08:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VJ6vLA172771;
        Tue, 31 Mar 2020 19:08:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 302g2eq9rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 19:08:55 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02VJ8koH015384;
        Tue, 31 Mar 2020 19:08:48 GMT
Received: from [10.175.15.184] (/10.175.15.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Mar 2020 12:08:46 -0700
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
To:     Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
 <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
 <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
 <ae25b7b1efcfe4eda9465c4fb4712ede928a33c4.camel@perches.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <f3b392d2-d8a4-6788-91b9-d74d98f035a5@oracle.com>
Date:   Tue, 31 Mar 2020 21:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ae25b7b1efcfe4eda9465c4fb4712ede928a33c4.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/20 9:00 PM, Joe Perches wrote:
> On Tue, 2020-03-31 at 20:56 +0200, Rasmus Villemoes wrote:
>> On 31/03/2020 20.20, Joe Perches wrote:
>>> On Tue, 2020-03-31 at 13:26 +0200, Vegard Nossum wrote:
>>>>   #define compiletime_assert(condition, msg) \
>>>> -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>>>> +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>
>>> This might be better using something like __LINE__ ## _ ## __COUNTER__
>>>
>>> as line # is somewhat useful to identify the specific assert in a file.
>>>
>>
>> Eh, if the assert fires, doesn't the compiler's diagnostics already
>> contain all kinds of location information?
> 
> I presume if that were enough,
> neither __LINE__ nor __COUNTER__
> would be useful.
> 

__LINE__ is only used currently for creating a unique identifier, as far
as I can tell.

The way it works is that it creates a function declaration with the
attribute __attribute__((error(message))), which makes gcc throw an
error if the function is ever used (i.e. calls are not compiled out).

The number does appear in the output, but it's not even really obvious
that it's a line number. And the compiler's diagnostics are pretty good
at showing the whole "stack trace" of where the call came from
(including the proper line numbers).


Vegard
