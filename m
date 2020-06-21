Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C22C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFC4207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgFUOaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgFUOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:30:35 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49FC061794;
        Sun, 21 Jun 2020 07:30:35 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id D77B2467E1;
        Sun, 21 Jun 2020 14:30:27 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/process
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Joe Perches <joe@perches.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
 <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
Date:   Sun, 21 Jun 2020 16:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
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



Am 21.06.20 um 15:46 schrieb Miguel Ojeda:
> Hi Alexander,
> 
> On Sun, Jun 21, 2020 at 3:37 PM Alexander A. Klimov
> <grandmaster@al2klimov.de> wrote:
>>
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
>>            If both the HTTP and HTTPS versions
>>            return 200 OK and serve the same content:
>>              Replace HTTP with HTTPS.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
> 
> Looks fine, although it would be nice to have a link to the discussion
Which discussion? 93431e0607e5 ? IMAO the patches don't depend on each 
other.

> (using a `Link: ` line to `lore.kernel.org`). Also having the script
> in the kernel would be nice for future re-runs (e.g. you could add it
> as a first patch in the series).
IMAO:

* The script should not be neccessary once all of my changes[1] arrive 
in torvalds/master. Instead reviewers should say like C'mon dude, what's 
this new plain-HTTP link doing in your patch? We have 2020! Look at e.g. 
93431e0607e5 .

* The program language agnostic algo description of mine should be 
enough. If it's not enough, I shall improve the description.

* Today I've added "If not .svg:". Imagine Torvalds merges the script, 
closes the merge window *and then* someone runs it on a random subsystem 
and discovers a missing condition. Do they have to patch the script, 
wait for the patch to arrive in torvalds/master *and then* patch the 
(other) subsystem, so they can refer to the now patched script? W/o a 
such central "rule on how to HTTPSify links" they'd just describe 
*their* algo. Or (even better) there wouldn't be much more insecure 
links, so the algo could be omitted.

After all please show me one of the big bosses (Torvalds, K-H, ...) 
who'd tolerate to have a...

* written w/o focus on maintainability
* not documented at all
* *Golang* file

... in the kernel tree.

If I correctly understand, you kernel devs write code so that if even 
the maintainer leaves the project, another one could just take over.

How many kernel devs would read and understand (all of them I guess) 
*and maintain that Go script* of mine?


[1]
➜  linux git:(master) git stash show --shortstat
  1857 files changed, 2664 insertions(+), 2664 deletions(-)
➜  linux git:(master)

> 
> Other than that:
> 
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
> Cheers,
> Miguel
> 
