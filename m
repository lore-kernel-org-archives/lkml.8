Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD76320776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GPDyEFC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404420AbgE1PdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404209AbgE1PdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:33:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3FDC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=N7KYbXOZahWSNPzUpziqxKJSxs3hD/AXIUg4RxP0suw=; b=GPDyEFC2AYPNH0DlDGwpeIvlUa
        atRgAn17c6ClxYTQd9ba02FITYPgtumagYelbeK9kPrwUv7Z7eCfuOw0PTWdggZZH1V0OpyicdVsI
        9KuCT+A8rUdMCgVqXfJ3acqi4LYJkVLk9KYydnNo9jiVttDYU7Qw3055dLz8U4CKNr7foC1tj30Iw
        X9QGQVZ4U7r8kCI1mSOA5p8xLmYvtjVrkv2KXQcAzAhLkKkWh8cxcoNKIePD6N1JOd6jB3AHvta4C
        /tqUWPKUbrkIRROs3mO9kckQWVvdI43Rz0tbsKz2ah4vR2nyfjUdo02xN7Y6niz9ytepkqC0i2UaV
        nMf6wfaw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeKWo-0006d5-CK; Thu, 28 May 2020 15:33:06 +0000
Subject: Re: [rcu:dev.2020.05.26a 56/72] refperf.c:undefined reference to
 `__umoddi3'
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202005280819.lJ4qjCcP%lkp@intel.com>
 <CAMuHMdUsD=xGa97tHmHZhohHiEqn5eD0QaOEwGNW7DGibkhB+g@mail.gmail.com>
 <20200528135141.GE2869@paulmck-ThinkPad-P72>
 <CAMuHMdXJOeQuA0+iT27vKAB+pNdrBBzvrfVTV=+cjm9r8=GwVQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57e9a457-f71f-9276-8645-968999830faa@infradead.org>
Date:   Thu, 28 May 2020 08:33:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXJOeQuA0+iT27vKAB+pNdrBBzvrfVTV=+cjm9r8=GwVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 8:31 AM, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Thu, May 28, 2020 at 3:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> On Thu, May 28, 2020 at 09:04:38AM +0200, Geert Uytterhoeven wrote:
>>> On Thu, May 28, 2020 at 5:26 AM kbuild test robot <lkp@intel.com> wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.26a
>>>> head:   63fdce1252f16032c9e1eb7244bb674ba4f84855
>>>> commit: bd5b16d6c88da451a46d068a25fafad8e83d14a6 [56/72] refperf: Allow decimal nanoseconds
>>>> config: m68k-allyesconfig (attached as .config)
>>>> compiler: m68k-linux-gcc (GCC) 9.3.0
>>>> reproduce (this is a W=1 build):
>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         git checkout bd5b16d6c88da451a46d068a25fafad8e83d14a6
>>>>         # save the attached .config to linux build tree
>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>>
>>>> m68k-linux-ld: kernel/rcu/refperf.o: in function `main_func':
>>>>>> refperf.c:(.text+0x762): undefined reference to `__umoddi3'
>>>>>> m68k-linux-ld: refperf.c:(.text+0x8f2): undefined reference to `__udivdi3'
>>>> m68k-linux-ld: refperf.c:(.text+0x97c): undefined reference to `__udivdi3'
>>>
>>> | --- a/kernel/rcu/refperf.c
>>> | +++ b/kernel/rcu/refperf.c
>>> | @@ -375,7 +375,7 @@ static int main_func(void *arg)
>>> |                 if (torture_must_stop())
>>> |                         goto end;
>>> |
>>> | -               reader_tasks[exp].result_avg =
>>> process_durations(exp) / ((exp + 1) * loops);
>>> | +               reader_tasks[exp].result_avg = 1000 *
>>> process_durations(exp) / ((exp + 1) * loops);
>>>
>>> div64_ul() for 64-by-unsigned-long division
>>
>> Ah, thank you for the explanation!
>>
>> This is just a performance-test module intended for SMP systems, so
>> I don't see much point in making it work on m68k, which looks to be
>> UP-only.  But it is clearly useful to prevent the test bots from building
>> refperf on m68k.  So one approach would be for me to make its Kconfig
>> option depend on SMP.  Another would be to make it depend on 64BIT.
>> Still another would be to make it depend on !M68K.
>>
>> I could potentially dump out the numbers in picoseconds, then
>> do the averaging and other division operations in userspace,
>> but that is strange enough to cause more trouble than it is worth.
>> (An rcu_read_lock()/rcu_read_unlock() pair takes -how- long???)  Though if
>> there was some point in running this on m68k, it might be worth it (with
>> "PICOSECONDS" in all caps or some such), but in this case it is not.
>> But this would probably require more data to be dumped to allow userspace
>> to do the operations, increasing the probability of lost printk()s.  :-/
>>
>> Left to myself, I would take the easy way out and make this depend
>> on 64BIT.
>>
>> But you must have run into this situation before.  Any thoughts?
> 
> Oh, this is not just on m68k. I expect the build bots to start complaining
> about other 32-bit platforms, too, like i386 and arm32 ;-)

Yes, I was just about to report it for/on i386.


> While restricting this to 64BIT will fix the issue, are you sure people
> on 32-bit SMP platforms don't want to run this code?
> 
> So I'd go for div64_ul() and do_div().
> 
>>> |         }
>>> |
>>> |         // Print the average of all experiments
>>> | @@ -386,7 +386,7 @@ static int main_func(void *arg)
>>> |         strcat(buf, "Threads\tTime(ns)\n");
>>> |
>>> |         for (exp = 0; exp < nreaders; exp++) {
>>> | -               sprintf(buf1, "%d\t%llu\n", exp + 1,
>>> reader_tasks[exp].result_avg);
>>> | +               sprintf(buf1, "%d\t%llu.%03d\n", exp + 1,
>>> reader_tasks[exp].result_avg / 1000,
>>> (int)(reader_tasks[exp].result_avg % 1000));
>>>
>>> do_div() for 64-by-32 division/modulo
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

thanks.
-- 
~Randy

