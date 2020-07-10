Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF273C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C4920772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGJVSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:18:38 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:37376 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgGJVSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:18:38 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B093EBC070;
        Fri, 10 Jul 2020 21:18:33 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: USB MASS STORAGE
 DRIVER
To:     Stafford Horne <shorne@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200708095500.13694-1-grandmaster@al2klimov.de>
 <20200708103928.GC585606@kroah.com>
 <6b78a3fd-04b9-fc8e-b5c6-f03372a4cd31@al2klimov.de>
 <20200709061409.GA130260@kroah.com>
 <20200710103621.GA437393@lianli.shorne-pla.net>
 <53342e1a-8430-2557-94c7-1da979a79e68@al2klimov.de>
 <20200710205530.GC437393@lianli.shorne-pla.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <893675cd-e909-6520-1201-873168e04d7d@al2klimov.de>
Date:   Fri, 10 Jul 2020 23:18:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200710205530.GC437393@lianli.shorne-pla.net>
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



Am 10.07.20 um 22:55 schrieb Stafford Horne:
> On Fri, Jul 10, 2020 at 09:36:03PM +0200, Alexander A. Klimov wrote:
>>
>>
>> Am 10.07.20 um 12:36 schrieb Stafford Horne:
>>> On Thu, Jul 09, 2020 at 08:14:09AM +0200, Greg KH wrote:
>>>> On Wed, Jul 08, 2020 at 08:41:54PM +0200, Alexander A. Klimov wrote:
>>>>>
>>>>>
>>>>> Am 08.07.20 um 12:39 schrieb Greg KH:
>>>>>> On Wed, Jul 08, 2020 at 11:55:00AM +0200, Alexander A. Klimov wrote:
>>>>>>> Rationale:
>>>>>>> Reduces attack surface on kernel devs opening the links for MITM
>>>>>>> as HTTPS traffic is much harder to manipulate.
>>>>>>>
>>>>>>> Deterministic algorithm:
>>>>>>> For each file:
>>>>>>>      If not .svg:
>>>>>>>        For each line:
>>>>>>>          If doesn't contain `\bxmlns\b`:
>>>>>>>            For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>>>>>> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>>>>>>                If both the HTTP and HTTPS versions
>>>>>>>                return 200 OK and serve the same content:
>>>>>>>                  Replace HTTP with HTTPS.
>>>>>>>
>>>>>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>>>>>
>>>>>> Your subject lines are very odd compared to all patches for this
>>>>>> subsystem, as well as all other kernel subsystems.  Any reason you are
>>>>>> doing it this way and not the normal and standard method of:
>>>>>> 	USB: storage: replace http links with https
>>>>>>
>>>>>> That would look more uniform as well as not shout at anyone.
>>>
>>> I would agree.  The OpenRISC patch for this series says:
>>>     "OPENRISC ARCHITECTURE:..."
>>>
>>> Here it would just be "openrisc:..." I think fixing the whole series is needed.
>>> Greg is not the only on complaining.
>>>
>>> Ideally, I think, it would be good to have this sent out as a series i.e [PATCH 3/55]
>>> rather than individual patches so this could be discussed as a whole.
>> 1) To who? As right now? As right now plus Torvalds, KH, Miller, etc.?
>>     As right now, but all-to-all?
> 
> Make sure you have a cover letter explaining what you expect.
> 
> You can ask maintainers to pick up individual patches by mentioning that in the
> cover letter.
> 
> You can use `git send-email --cc-cmd` so each patch goes only to the
> maintainers, for example:
> 
>    send-email --to linux-kernel@vger.kernel.org --cc-cmd scripts/get_maintainers.pl`
> 
>> 2) Apropos "series" and "as whole"... I stumbled over
> 
> I stumble over "apropos". :)
> 
>>     `git log --oneline |grep -Fwe treewide`
>>     and am wondering:
>>     *Shouldn't all of these patches even begin with "treewide: "?*
>>     E.g.: "treewide: Replace HTTP links with HTTPS ones: GCC PLUGINS"
> 
> As Greg said that is not what patch subjects loo like.
> 
>    - GCC PLUGINS: is not correct, remove it.
>    - treewide: may work, but as you want individual maintainers to pick up the patches put
>      a subsystem in the subject as maintainers like.
No, I don't "want" to have this or that particular recipient.
I'd just like to get my changes in master.

You say like if I send to individual maintainers, I have to take their 
subject likes. OK...

But if I use "treewide:" – who do I send to (if not to individual 
maintainers per patch)?

>    - The rest of the text should be lowercase "replace http links with https"
> 
> Have a look at other patch subject lines based on the file you are editing.  For example:
> 
>    $ git log --oneline -- Documentation/kbuild/gcc-plugins.rst
>    2020-03-10 2b4cbd5c9505 Jonathan Corbet  docs: move gcc-plugins to the kbuild manual
> 
>    $ git log --oneline -- scripts/Makefile.gcc-plugins
>    2019-03-04 81a56f6dcd20 Kees Cook        gcc-plugins: structleak: Generalize to all variable types
>    2018-12-29 668c35f69cc7 Linus Torvalds   Merge tag 'kbuild-v4.21' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
>    2018-12-12 189af4657186 Ard Biesheuvel   ARM: smp: add support for per-task stack canaries
>    2018-12-01 ce2fd53a10c7 Masahiro Yamada  kbuild: descend into scripts/gcc-plugins/ via scripts/Makefile
>    2018-09-04 10e9ae9fabaf Alexander Popov  gcc-plugins: Add STACKLEAK plugin for tracking the kernel stack
>    2018-07-24 7ccb95e8fe91 Kees Cook        gcc-plugins: Regularize Makefile.gcc-plugins
>    2018-07-02 c17d6179ad5a Masahiro Yamada  gcc-plugins: remove unused GCC_PLUGIN_SUBDIR
>    2018-06-11 59f53855babf Masahiro Yamada  gcc-plugins: test plugin support in Kconfig and clean up Makefile
>    2018-06-11 8034c2fb1225 Masahiro Yamada  gcc-plugins: move GCC version check for PowerPC to Kconfig
>    2018-06-11 5aadfdeb8de0 Masahiro Yamada  kcov: test compiler capability in Kconfig and correct dependency
> 
> 
> So you will have:
> 
>    docs: replace http links with https
>    gcc-plugins: replace http links with https
> 
> -Stafford
> 
>>>
>>> -Stafford
>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>>
>>>>> Hi,
>>>>>
>>>>> I'm very sorry.
>>>>>
>>>>> As Torvalds has merged 93431e0607e5 and many of you devs (including big
>>>>> maintainers like David Miller) just applied this stuff, I assumed that's OK.
>>>>>
>>>>> And now I've rolled out tens of patches via shell loop... *sigh*
>>>>>
>>>>> As this is the third (I think) change request like this, I assume this rule
>>>>> applies to all subsystems – right?
>>>>
>>>> Yes, you should try to emulate what the subsystem does, look at other
>>>> patches for the same files, but the format I suggested is almost always
>>>> the correct one.  If not, I'm sure maintainers will be glad to tell you
>>>> otherwise :)
>>>
>>>
