Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668D6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0D3206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgFKQFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgFKQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:05:46 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED04C08C5C1;
        Thu, 11 Jun 2020 09:05:46 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 8F9F7FD7DD;
        Thu, 11 Jun 2020 16:05:39 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/translations/it_IT
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200609201241.81518-1-grandmaster@al2klimov.de>
 <4235548.LvFx2qVVIh@harkonnen>
 <cd260d03-27a4-7794-f58f-21e8e0be9755@al2klimov.de>
 <202006102009.CB14D7F@keescook>
 <8ee16c38-e28b-b4e6-ed30-55a59e216b49@al2klimov.de>
Message-ID: <4196faa9-64d3-481b-9c15-bb4abb237c18@al2klimov.de>
Date:   Thu, 11 Jun 2020 18:05:37 +0200
MIME-Version: 1.0
In-Reply-To: <8ee16c38-e28b-b4e6-ed30-55a59e216b49@al2klimov.de>
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



Am 11.06.20 um 09:01 schrieb Alexander A. Klimov:
> 
> 
> Am 11.06.20 um 05:12 schrieb Kees Cook:
>> On Wed, Jun 10, 2020 at 08:11:39PM +0200, Alexander A. Klimov wrote:
>>> Am 10.06.20 um 10:57 schrieb Federico Vaga:
>>>> On Tuesday, June 9, 2020 10:12:41 PM CEST Alexander A. Klimov wrote:
>>>>> Rationale:
>>>>> Reduces attack surface on kernel devs opening the links for MITM
>>>>> as HTTPS traffic is much harder to manipulate.
>>>>>
>>>>> Deterministic algorithm:
>>>>> For each file:
>>>>>     For each line:
>>>>>       If doesn't contain `\bxmlns\b`:
>>>>>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>>>>           If both the HTTP and HTTPS versions
>>>>>           return 200 OK and serve the same content:
>>>>>             Replace HTTP with HTTPS.
>>
>> Is this script somewhere we can read it? (It's easier usually to review
>> the code for bulk changes than the bulk changes themselves.)
> Is any of you familiar with Golang?
> 
> @Maintainers Would any of you actually review like this? If yes, is the 
> pseudo-code not enough?
> 
>>
>>>>>
>>>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>>>> ---
>>>>>    .../translations/it_IT/admin-guide/README.rst      |  2 +-
>>>>>    .../translations/it_IT/doc-guide/parse-headers.rst |  2 +-
>>>>>    .../translations/it_IT/doc-guide/sphinx.rst        | 10 +++++-----
>>>>>    .../translations/it_IT/process/2.Process.rst       | 12 
>>>>> ++++++------
>>>>>    .../translations/it_IT/process/3.Early-stage.rst   |  2 +-
>>>>>    .../translations/it_IT/process/4.Coding.rst        |  4 ++--
>>>>>    .../it_IT/process/7.AdvancedTopics.rst             |  8 ++++----
>>>>>    .../translations/it_IT/process/8.Conclusion.rst    | 14 
>>>>> +++++++-------
>>>>>    .../translations/it_IT/process/adding-syscalls.rst |  4 ++--
>>>>>    .../translations/it_IT/process/changes.rst         |  6 +++---
>>>>>    .../translations/it_IT/process/clang-format.rst    |  2 +-
>>>>>    .../translations/it_IT/process/coding-style.rst    |  2 +-
>>>>>    Documentation/translations/it_IT/process/howto.rst |  2 +-
>>>>>    .../it_IT/process/maintainer-pgp-guide.rst         |  2 +-
>>>>>    .../it_IT/process/submitting-patches.rst           |  4 ++--
>>>>>    .../it_IT/process/volatile-considered-harmful.rst  |  4 ++--
>>>>>    16 files changed, 40 insertions(+), 40 deletions(-)
>>>>>
>>>>
>>>>
>>>>> diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst
>>>>> b/Documentation/translations/it_IT/doc-guide/sphinx.rst index
>>>>> f1ad4504b734..0aaeb0297661 100644
>>>>> --- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
>>>>> +++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
>>>>> @@ -14,7 +14,7 @@ Per generare la documentazione in HTML o PDF, usate
>>>>> comandi ``make htmldocs`` o ``make pdfdocs``. La documentazione così
>>>>> generata sarà disponibile nella cartella ``Documentation/output``.
>>>>>
>>>>> -.. _Sphinx: http://www.sphinx-doc.org/
>>>>> +.. _Sphinx: https://www.sphinx-doc.org/
>>>>>    .. _reStructuredText: http://docutils.sourceforge.net/rst.html
>>>>
>>>> It is not part of the deterministic algorithm but you may consider 
>>>> this as
>>>> well
>>
>> Why did it not match?
> I didn't log that link-by-link. Maybe because I also didn't follow plain 
> HTTP redirects while opening HTTPS links. Maybe it even matched, but was 
> added after I made the changes.
> 
> Anyway, I'll maybe cover it in round II.
> 
>>
>>>>
>>>> -.. _reStructuredText: http://docutils.sourceforge.net/rst.html
>>>> +.. _reStructuredText: https://docutils.sourceforge.io/rst.html
>>>>
>>> I'll think about analyzing such almost-matches, extending the algo and
>>> supplying a second round of patches once all [1] of this round arrive in
>>> torvalds/master.
>>>
>>> [1]:
>>>
>>> ➜  linux git:(feature/https-links-3) ✗ git diff --shortstat
>>>   1963 files changed, 2882 insertions(+), 2882 deletions(-)
>>> ➜  linux git:(feature/https-links-3) ✗
>>
>> Is there a reason to do this one language at a time instead of just
>> doing everything in one go?
And yes, *at the moment* I'm patching one subsystem at a time. And the 
discussion around 93431e0607e5 and all of its prototypes shown that it 
was smarter than supplying thousands of patches at once.

Now I've (hopefully) made and corrected all possible mistakes in two 
patches and clearly know how to continue with the next thousands so the 
maintainers won't have anything to comply about.

Once the doc subsystems patches get applied (or even reach 
torvalds/master) I'll submit maybe ten patches at once. And the more 
maintainers apply them...

> There are two reasons:
> 
> * Jonathan said like theoretically you could give it all at once to 
> Linus, but practically I'd not do that, please split by subsystem
> * Linus *didn't even respond* (at least I didn't receive anything) to my 
> catch-them-all patch at all, not even like please not as .gz attachment 
> or please split by subsystem >
>>
