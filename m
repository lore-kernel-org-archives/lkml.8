Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE51C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0442078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGHSWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:22:06 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801D9C061A0B;
        Wed,  8 Jul 2020 11:22:06 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 0842FBC0D4;
        Wed,  8 Jul 2020 18:22:03 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: YAMA SECURITY MODULE
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200708073346.13177-1-grandmaster@al2klimov.de>
 <202007080103.2DAD857D4C@keescook>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <2c05c0c3-e72a-7cc6-3391-2e0d3bdf6b2c@al2klimov.de>
Date:   Wed, 8 Jul 2020 20:22:03 +0200
MIME-Version: 1.0
In-Reply-To: <202007080103.2DAD857D4C@keescook>
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



Am 08.07.20 um 10:05 schrieb Kees Cook:
> On Wed, Jul 08, 2020 at 09:33:46AM +0200, Alexander A. Klimov wrote:
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>>
>> Deterministic algorithm:
>> For each file:
>>    If not .svg:
>>      For each line:
>>        If doesn't contain `\bxmlns\b`:
>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>              If both the HTTP and HTTPS versions
>>              return 200 OK and serve the same content:
>>                Replace HTTP with HTTPS.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>   Continuing my work started at 93431e0607e5.
>>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>>   (Actually letting a shell for loop submit all this stuff for me.)
>>
>>   If there are any URLs to be removed completely or at least not HTTPSified:
>>   Just clearly say so and I'll *undo my change*.
As written here...

>>   See also: https://lkml.org/lkml/2020/6/27/64
>>
>>   If there are any valid, but yet not changed URLs:
>>   See: https://lkml.org/lkml/2020/6/26/837
>>
>>   If you apply the patch, please let me know.
>>
>>
>>   Documentation/admin-guide/LSM/Yama.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/LSM/Yama.rst b/Documentation/admin-guide/LSM/Yama.rst
>> index d0a060de3973..64fd62507ae5 100644
>> --- a/Documentation/admin-guide/LSM/Yama.rst
>> +++ b/Documentation/admin-guide/LSM/Yama.rst
>> @@ -21,7 +21,7 @@ of their attack without resorting to user-assisted phishing.
>>   
>>   This is not a theoretical problem. SSH session hijacking
>>   (http://www.storm.net.nz/projects/7) and arbitrary code injection
> 
> This link is dead. It is likely best replaced by:
... I'd undo this change.
But as it's the only one here, just forget this patch.

> https://www.blackhat.com/presentations/bh-usa-05/bh-us-05-boileau.pdf
> (this is the same person, but it seems storm.net.nz is gone)
> 
>> -(http://c-skills.blogspot.com/2007/05/injectso.html) attacks already
>> +(https://c-skills.blogspot.com/2007/05/injectso.html) attacks already
>>   exist and remain possible if ptrace is allowed to operate as before.
>>   Since ptrace is not commonly used by non-developers and non-admins, system
>>   builders should be allowed the option to disable this debugging system.
> 
> With that change:
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> for the docs tree.
> 
