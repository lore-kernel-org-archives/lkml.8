Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C58BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841AA20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgGHDUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGHDUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:20:21 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A87C061755;
        Tue,  7 Jul 2020 20:20:21 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 27D67BC0C2;
        Wed,  8 Jul 2020 03:20:17 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kdump
To:     Dave Young <dyoung@redhat.com>
Cc:     bhe@redhat.com, vgoyal@redhat.com, corbet@lwn.net,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200627103151.71942-1-grandmaster@al2klimov.de>
 <20200701075803.GB3878@dhcp-128-65.nay.redhat.com>
 <1de76ef5-e447-2274-c45a-3b0356bd63ae@al2klimov.de>
 <20200708031704.GA10532@dhcp-128-65.nay.redhat.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <8479acd3-5e35-4b64-5b2a-ad6549a62e4b@al2klimov.de>
Date:   Wed, 8 Jul 2020 05:20:17 +0200
MIME-Version: 1.0
In-Reply-To: <20200708031704.GA10532@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 08.07.20 um 05:17 schrieb Dave Young:
> On 07/01/20 at 07:33pm, Alexander A. Klimov wrote:
>>
>>
>> Am 01.07.20 um 09:58 schrieb Dave Young:
>>> On 06/27/20 at 12:31pm, Alexander A. Klimov wrote:
>>>> Rationale:
>>>> Reduces attack surface on kernel devs opening the links for MITM
>>>> as HTTPS traffic is much harder to manipulate.
>>>>
>>>> Deterministic algorithm:
>>>> For each file:
>>>>     If not .svg:
>>>>       For each line:
>>>>         If doesn't contain `\bxmlns\b`:
>>>>           For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>>>             If both the HTTP and HTTPS versions
>>>>             return 200 OK and serve the same content:
>>>>               Replace HTTP with HTTPS.
>>>>
>>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>>> ---
>>>>    If there are any URLs to be removed completely or at least not HTTPSified:
>>>>    Just clearly say so and I'll *undo my change*.
>>>>    See also https://lkml.org/lkml/2020/6/27/64
>>>>
>>>>    If there are any valid, but yet not changed URLs:
>>>>    See https://lkml.org/lkml/2020/6/26/837
>>>>
>>>>    Documentation/admin-guide/kdump/kdump.rst | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>>>> index 2da65fef2a1c..8cfa35f777f5 100644
>>>> --- a/Documentation/admin-guide/kdump/kdump.rst
>>>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>>>> @@ -65,20 +65,20 @@ Install kexec-tools
>>>>    2) Download the kexec-tools user-space package from the following URL:
>>>> -http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
>>>> +https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
>>>>    This is a symlink to the latest version.
>>>>    The latest kexec-tools git tree is available at:
>>>>    - git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>>>> -- http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>>>> +- https://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>>>>    There is also a gitweb interface available at
>>>> -http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
>>>> +https://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
>>>>    More information about kexec-tools can be found at
>>>> -http://horms.net/projects/kexec/
>>>> +https://horms.net/projects/kexec/
>>>>    3) Unpack the tarball with the tar command, as follows::
>>>> @@ -511,7 +511,7 @@ dump kernel.
>>>>    You can also use the Crash utility to analyze dump files in Kdump
>>>>    format. Crash is available on Dave Anderson's site at the following URL:
>>>> -   http://people.redhat.com/~anderson/
>>>> +   https://people.redhat.com/~anderson/
>>>
>>> Would you mind to update above url as well?
>> I'll update all of the URLs not changed yet, but (please) not in this patch
>> round.
>>
>> See also https://lkml.org/lkml/2020/6/26/837
> 
> If this series can be taken soon then we can wait and submit a patch
> later.
> 
> Or just drop this one from your series, I can submit another one to take
> the https and crash url together later.
> 
> Either works.
Or (if you don't apply as-is) I'll just cover patched+non-patched 
together in round II.

> 
>>
>>>
>>> Dave have moved it to below url instead:
>>> https://crash-utility.github.io/
>>>
>>> Thanks
>>> Dave
>>>
>>
> 
