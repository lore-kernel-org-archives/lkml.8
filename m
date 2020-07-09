Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B8DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D49206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgGIGpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:45:19 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:37386 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgGIGpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:45:18 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7385EBC06E;
        Thu,  9 Jul 2020 06:45:15 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: YAMA SECURITY MODULE
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200708073346.13177-1-grandmaster@al2klimov.de>
 <202007080103.2DAD857D4C@keescook>
 <2c05c0c3-e72a-7cc6-3391-2e0d3bdf6b2c@al2klimov.de>
 <202007081531.085533FC5@keescook>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <596fa9f8-954a-c452-2399-e063f4b04f57@al2klimov.de>
Date:   Thu, 9 Jul 2020 08:45:14 +0200
MIME-Version: 1.0
In-Reply-To: <202007081531.085533FC5@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 09.07.20 um 00:54 schrieb Kees Cook:
> On Wed, Jul 08, 2020 at 08:22:03PM +0200, Alexander A. Klimov wrote:
>>
>>
>> Am 08.07.20 um 10:05 schrieb Kees Cook:
>>> On Wed, Jul 08, 2020 at 09:33:46AM +0200, Alexander A. Klimov wrote:
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
>>>> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>>>               If both the HTTP and HTTPS versions
>>>>               return 200 OK and serve the same content:
>>>>                 Replace HTTP with HTTPS.
>>>>
>>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>>> ---
>>>>    Continuing my work started at 93431e0607e5.
>>>>    See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>>>>    (Actually letting a shell for loop submit all this stuff for me.)
>>>>
>>>>    If there are any URLs to be removed completely or at least not HTTPSified:
>>>>    Just clearly say so and I'll *undo my change*.
>> As written here...
> 
> I interpreted that as "any URLs [changed by this patch]". I wanted no
> URLs you changed to be removed nor not HTTPSified.
> 
>>>>    See also: https://lkml.org/lkml/2020/6/27/64
> 
> (You seem to be saying "any URLs [in the file]".)
> 
>>>>    If there are any valid, but yet not changed URLs:
>>>>    See: https://lkml.org/lkml/2020/6/26/837
> 
> The URL I commented on was not valid and not changed by your patch.
> 
>>>>
>>>>    If you apply the patch, please let me know.
>>>>
>>>>
>>>>    Documentation/admin-guide/LSM/Yama.rst | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/LSM/Yama.rst b/Documentation/admin-guide/LSM/Yama.rst
>>>> index d0a060de3973..64fd62507ae5 100644
>>>> --- a/Documentation/admin-guide/LSM/Yama.rst
>>>> +++ b/Documentation/admin-guide/LSM/Yama.rst
>>>> @@ -21,7 +21,7 @@ of their attack without resorting to user-assisted phishing.
>>>>    This is not a theoretical problem. SSH session hijacking
>>>>    (http://www.storm.net.nz/projects/7) and arbitrary code injection
>>>
>>> This link is dead. It is likely best replaced by:
>> ... I'd undo this change.
> 
> You sent me a patch to update URLs, gave me (seemingly) explicit
> instructions about which things would cause you to undo individual
> changes, none of which seemed to trigger, so I offered an improvement,
> that would add another HTTPS URL -- which is entirely within your stated
> desires to have "[one] commit ... per one thing [you've]i done" for
> a patch where the Subject is literally "Replace HTTP links with HTTPS
> ones", for which I suggested an improvement.
> 
>> But as it's the only one here, just forget this patch.
> 
> You seem hostile to accepting feedback on how this patch could be
> improved. It's one thing to use automation to help generate patches,
> and I understand your apparent desires to keep it automated, but that
> is not always how patch development turns out.
> 
> Your instructions appear to take a long way to just say "here's a patch,
> take it or leave it" which seems pretty anti-collaborative to me.
No, no and no.

If you look up other discussions (especially the very first one) on such 
patches, you'll see that *I react to change requests with improved* 
(shortened) patches.

*I do them manually* and I've no problem with doing things manually, I 
just automate everything that is possible.

*I don't demand to accept my patches as-is.* The only thing I demand is 
letting me focus on one thing at a time.
https://lkml.org/lkml/2020/6/27/64
You requested reanimatig a dead link. That's a legit thing, but it's 
*another* thing. Another than (the yet not done task of mine of) just 
HTTPSifying URLs.

And as it's the only URL here, of course the whole patch makes no sense 
anymore. If I'd replace the URL as you said, I'd make a *new patch* with 
a *new title* and just send it --in-reply-to here. And my statement 
"just forget [the old] patch" would still stand.

Also IMAO in this particular case *I don't deserve* to be the author of 
the new patch as *you did all the work* for it – i.e. figured out the 
replacement URL.

> 
