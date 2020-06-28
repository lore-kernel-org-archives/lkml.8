Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1EDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51FE20724
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgF1IUQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 04:20:16 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:19383 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgF1IUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:20:16 -0400
X-Greylist: delayed 53515 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jun 2020 04:20:14 EDT
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmAgw47kDQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id V07054w5S8K5IMr
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sun, 28 Jun 2020 10:20:05 +0200 (CEST)
Subject: Re: [PATCH] modpost: remove use of non-standard strsep() in HOSTCC code
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAK7LNARfgaVgmqzsa+n2rvPx5K1dsmcqMLSeLe_tMP0O017=Yw@mail.gmail.com>
Date:   Sun, 28 Jun 2020 10:20:04 +0200
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2F77152B-BF7D-4098-AE60-2F13794B027A@goldelico.com>
References: <11c1e65b393b4c3ca6118515c77bbf19524dab11.1593074472.git.hns@goldelico.com> <CAK7LNATCLscXNDZ1RUmbnM5BeV-tvKjz9kQB8eo0SNp10WbjFQ@mail.gmail.com> <2D851B90-5F85-4136-AF70-E764FDF4D7DD@goldelico.com> <CAK7LNARfgaVgmqzsa+n2rvPx5K1dsmcqMLSeLe_tMP0O017=Yw@mail.gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 28.06.2020 um 09:52 schrieb Masahiro Yamada <masahiroy@kernel.org>:
> 
> On Sun, Jun 28, 2020 at 3:17 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> 
>> Hi,
>> 
>>> Am 28.06.2020 um 07:51 schrieb Masahiro Yamada <masahiroy@kernel.org>:
>>> 
>>> On Thu, Jun 25, 2020 at 5:47 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>>> 
>>>> strsep() is neither standard C nor POSIX and used outside
>>>> the kernel code here. Using it here requires that the
>>>> build host supports it out of the box which is e.g.
>>>> not true for a Darwin build host and using a cross-compiler.
>>>> This leads to:
>>>> 
>>>> scripts/mod/modpost.c:145:2: warning: implicit declaration of function 'strsep' [-Wimplicit-function-declaration]
>>>> return strsep(stringp, "\n");
>>>> ^
>>>> 
>>>> and a segfault when running MODPOST.
>>>> 
>>>> See also: https://stackoverflow.com/a/7219504
>>>> 
>>>> So let's add some lines of code separating the string at the
>>>> next newline character instead of using strsep(). It does not
>>>> hurt kernel size or speed since this code is run on the build host.
>>>> 
>>>> Fixes: ac5100f5432967 ("modpost: add read_text_file() and get_line() helpers")
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> scripts/mod/modpost.c | 7 ++++++-
>>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>>>> index 6aea65c65745..8fe63989c6e1 100644
>>>> --- a/scripts/mod/modpost.c
>>>> +++ b/scripts/mod/modpost.c
>>>> @@ -138,11 +138,16 @@ char *read_text_file(const char *filename)
>>>> 
>>>> char *get_line(char **stringp)
>>>> {
>>>> +       char *p;
>>>>       /* do not return the unwanted extra line at EOF */
>>>>       if (*stringp && **stringp == '\0')
>>> 
>>> This check does not make sense anymore.
>>> 
>>> Previously, get_line(NULL) returns NULL.
>>> 
>>> With your patch, get_line(NULL) crashes
>>> due to NULL-pointer dereference.
>> 
>> Well, that is original code.
> 
> 
> Sorry for confusion.
> 
> I meant this:
> 
>  char *s = NULL;
>  get_line(&s);
> 
> 
> In the current code, get_line(&s) returns NULL.
> As 'man strsep' says this:
>  "If *stringp is NULL, the strsep() function returns NULL
>   and does nothing else."
> 
> With your patch, **stringp will cause
> NULL-pointer dereference.

Ah, now I see. strsep() has a special case that is not covered
by my patch.

On the other hand, get_line() is only called as get_line(&pos) and
pos = buf can not be NULL because that is checked before in read_dump().
This is why I did not observe a segfault.

But it is wise to make get_line() it more robust than needed. We do
never know who will copy this code fragment... And I am tempted to
handle the get_line(NULL) case as well.

>> I have only replaced the strsep() function.
>> But yes, it looks to be better in addition to
>> my patch.
>> 
>>> 
>>> 
>>> 
>>>>               return NULL;
>>>> 
>>>> -       return strsep(stringp, "\n");
>>>> +       p = *stringp;
>>>> +       while (**stringp != '\n')
>>>> +               (*stringp)++;
>>> 
>>> 
>>> Is this a safe conversion?
>>> 
>>> If the input file does not contain '\n' at all,
>>> this while-loop continues running,
>>> and results in the segmentation fault
>>> due to buffer over-run.
>> 
>> Ah, yes, you are right.
>> 
>> We should use
>> 
>> +       while (**stringp && **stringp != '\n')
>> 
>>> 
>>> 
>>> 
>>>> +       *(*stringp)++ = '\0';
>>>> +       return p;
>>>> }
>>> 
>>> 
>>> 
>>> How about this?
>>> 
>>> char *get_line(char **stringp)
>>> {
>>>       char *orig = *stringp;
>> 
>> ^^^ this still segfaults with get_line(NULL)
> 
> 
> This is OK.
> 
> get_line(NULL) should crash because we never expect
> the case  ' stringp == NULL'.
> 
> We need to care about the case ' *stringp == NULL'.
> In this case, get_line() should return NULL.
> 
> 
> 
> 
>>>       char *next;
>>> 
>>>       /* do not return the unwanted extra line at EOF */
>>>       if (!orig || *orig == '\0')
>>>               return NULL;
>>> 
>>>       next = strchr(orig, '\n');
>>>       if (next)
>>>               *next++ = '\0';
>>> 
>>>       *stringp = next;
>> 
>> Yes, this code is easier to understand than my while loop.
>> And strchr() is POSIX.
>> 
>> So should I submit an updated patch or do you want to submit
>> it (with a suggested-by: H. Nikolaus Schaller <hns@goldelico.com>)
> 
> Please send a patch.
> (Co-developed-by if you want to give some credit to me)

Yes, I will do in the next days.

BR and thanks,
Nikolaus Schaller

