Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E19C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FAD207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="JItgQQQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgFRSTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgFRSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:19:31 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EBFC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:19:31 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 05IIGwYF016460;
        Thu, 18 Jun 2020 19:17:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=4qgrLwHo/KWL93Z+mKCeWPhsFkKv+N90IiDj1jYDXv0=;
 b=JItgQQQ9Hkyr8wrUlP1n3Hv7BqKZN97x3gI8lXH5M6Cr5gN3J6RDpSCqt2n5VKYLTjTp
 00Omn/XBbMfc1znh0O0xcrfUb21mBhCJNcHhOim1c/s+XPTnpPXwPlrRZghwNS2YD2Dz
 /IkC8TXV/Teaqb5ZhwlNz7jHP+4IyiE5OjgMywdbIgcEQZVKfoT1gv37Q/e2CmVNBuAA
 sYqN+HN3NAkFMnDqMz6c2PLS9TDpuiE0Gep/Y7rZWvI39u4eZeAR5E+pgvbruqRscBOi
 zrNGkGYUT6r96uTaHHdrRLlVHOzS+43muvgsXumwu+nFNQQsqe58u89xlrzqQmENfNEY Jg== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 31qre72yxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 19:17:09 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 05II4fWb022736;
        Thu, 18 Jun 2020 14:17:08 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint6.akamai.com with ESMTP id 31qjm7mgg3-1;
        Thu, 18 Jun 2020 14:17:08 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id A5B513A4E3;
        Thu, 18 Jun 2020 18:17:07 +0000 (GMT)
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
To:     Petr Mladek <pmladek@suse.com>, Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linuxfoundation.org,
        gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
References: <20200617162536.611386-1-jim.cromie@gmail.com>
 <20200617162536.611386-23-jim.cromie@gmail.com> <20200618161912.GD3617@alley>
 <20200618174058.GE3617@alley>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com>
Date:   Thu, 18 Jun 2020 14:17:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618174058.GE3617@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180138
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 mlxlogscore=999 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/20 1:40 PM, Petr Mladek wrote:
> On Thu 2020-06-18 18:19:12, Petr Mladek wrote:
>> On Wed 2020-06-17 10:25:35, Jim Cromie wrote:
>>> 1. Add a user-flag [u] which works like the [pfmlt] flags, but has no
>>> effect on callsite behavior; it allows incremental marking of
>>> arbitrary sets of callsites.
>>>
>>> 2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
>>> And in ddebug_read_flags():
>>>    current code does:	[pfmltu_] -> flags
>>>    copy it to:		[PFMLTU_] -> mask
>>>
>>> also disallow both of a pair: ie no 'pP', no true & false.
>>>
>>> 3. Add filtering ops into ddebug_change(), right after all the
>>> callsite-property selections are complete.  These filter on the
>>> callsite's current flagstate before applying modflags.
>>>
>>> Why ?
>>>
>>> The u-flag & filter flags
>>>
>>> The 'u' flag lets the user assemble an arbitary set of callsites.
>>> Then using filter flags, user can activate the 'u' callsite set.
>>>
>>>   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
>>>   #> echo 'u+p' > control
>>>
>>> Of course, you can continue to just activate your set without ever
>>> marking it 1st, but you could trivially add the markup as you go, then
>>> be able to use it as a constraint later, to undo or modify your set.
>>>
>>>   #> echo 'file foo.c +up' >control
>>>   .. monitor, debug, finish ..
>>>   #> echo 'u-p' >control
>>>
>>>   # then later resume
>>>   #> echo 'u+p' >control
>>>
>>>   # disable some cluttering messages, and remove from u-set
>>>   #> echo 'file noisy.c function:jabber_* u-pu' >control
>>>
>>>   # for doc, recollection
>>>   grep =pu control > my-favorite-callsites
>>>
>>> Note:
>>>
>>> Your flagstate after boot is generally not all =_. -DDEBUG will arm
>>> compiled callsites by default, $builtinmod.dyndbg=+p bootargs can
>>> enable them early, and $module.dyndbg=+p bootargs will arm them when
>>> the module is loaded.  But you could manage them with u-flags:
>>>
>>>   #> echo '-t' >control		# clear t-flag to use it as 2ndary markup
>>>   #> echo 'p+ut' >control	# mark the boot-enabled set of callsites
>>>   #> echo '-p' >control		# clean your dmesg -w stream
>>>
>>>   ... monitor, debug ..
>>>   #> echo 'module of_interest $qterms +pu' >control	# build your set of useful debugs
>>>   #> echo 'module of_interest $qterms UT+pu' >control	# same, but dont alter ut marked set
>>
>> Does anyone requested this feature, please?
>>
>> For me, it is really hard to imagine people using these complex and hacky
>> steps.
> 
> I think that all this is motivated by adding support for module
> specific groups.
> 
> What about storing the group as yet another information for each
> message? I mean the same way as we store module name, file, line,
> function name.
> 
> Then we could add API to define group for a given message:
> 
>    pr_debug_group(group_id, fmt, ...);
> 
> the interface for the control file might be via new keyword "group".
> You could then do something like:
> 
>    echo module=drm group=0x3 +p >control
> 
> But more importantly you should add functions that might be called
> when the drm.debug parameter is changes. I have already mentioned
> it is another reply:
> 
>     dd_enable_module_group(module_name, group_id);
>     dd_disable_module_group(module_name, group_id);
> 
> 
> It will _not_ need any new flag or flag filtering.
> 
> Best Regards,
> Petr
> 

Yes, I'm wondering as well if people are really going to use the
new flags and filter flags - I mentioned that here:
https://lkml.org/lkml/2020/6/12/732

The grouping stuff is already being used by lots of modules so
that seems useful.

Thanks,

-Jason
