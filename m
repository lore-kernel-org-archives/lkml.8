Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FB4C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1417F20658
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCYTq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:46:27 -0400
Received: from ciao.gmane.io ([159.69.161.202]:49314 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbgCYTq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:46:26 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1jHByq-000EJ8-Gt
        for linux-kernel@vger.kernel.org; Wed, 25 Mar 2020 20:46:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 2/2] SUNRPC: Optimize 'svc_print_xprts()'
Date:   Wed, 25 Mar 2020 20:46:17 +0100
Message-ID: <54664e85-cc8b-9de3-79c6-0664fc5bcd9a@wanadoo.fr>
References: <20200325070452.22043-1-christophe.jaillet@wanadoo.fr>
 <EA5BCDB2-DB05-4B26-8635-E6F5C231DDC6@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Cc:     linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <EA5BCDB2-DB05-4B26-8635-E6F5C231DDC6@oracle.com>
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/03/2020 à 15:52, Chuck Lever a écrit :
> Hi Christophe,
>
>
>> On Mar 25, 2020, at 3:04 AM, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Using 'snprintf' is safer than 'sprintf' because it can avoid a buffer
>> overflow.
> That's true as a general statement, but how likely is such an
> overflow to occur here?
>
I guess, that it us unlikely and that the 80 chars buffer is big enough.
That is the exact reason of why I've proposed 2 patches. The first one 
could happen in RL. The 2nd is more like a clean-up and is less 
relevant, IMHO.
>
>> The return value can also be used to avoid a strlen a call.
> That's also true of sprintf, isn't it?

Sure.


>
>> Finally, we know where we need to copy and the length to copy, so, we
>> can save a few cycles by rearraging the code and using a memcpy instead of
>> a strcat.
> I would be OK with squashing these two patches together. I don't
> see the need to keep the two changes separated.

NP, I can resend as a V2 with your comments.
As said above, the first fixes something that could, IMHO, happen and 
the 2nd is more a matter of taste and a clean-up.


>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch should have no functionnal change.
>> We could go further, use scnprintf and write directly in the destination
>> buffer. However, this could lead to a truncated last line.
> That's exactly what this function is trying to avoid. As part of any
> change in this area, it would be good to replace the current block
> comment before this function with a Doxygen-format comment that
> documents that goal.

I'll take care of it.


>> ---
>> net/sunrpc/svc_xprt.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index df39e7b8b06c..6df861650040 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -118,12 +118,12 @@ int svc_print_xprts(char *buf, int maxlen)
>> 	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
>> 		int slen;
>>
>> -		sprintf(tmpstr, "%s %d\n", xcl->xcl_name, xcl->xcl_max_payload);
>> -		slen = strlen(tmpstr);
>> -		if (len + slen >= maxlen)
>> +		slen = snprintf(tmpstr, sizeof(tmpstr), "%s %d\n",
>> +				xcl->xcl_name, xcl->xcl_max_payload);
>> +		if (slen >= sizeof(tmpstr) || len + slen >= maxlen)
>> 			break;
>> +		memcpy(buf + len, tmpstr, slen + 1);
>> 		len += slen;
>> -		strcat(buf, tmpstr);
> IMO replacing the strcat makes the code harder to read, and this
> is certainly not a performance path. Can you drop that part of the
> patch?

Ok


>
>> 	}
>> 	spin_unlock(&svc_xprt_class_lock);
>>
>> -- 
>> 2.20.1
>>
> --
> Chuck Lever
>
>
>
>


