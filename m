Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC50C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB04206EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGx0FkZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgIBAGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:06:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23091 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgIBAGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599005188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPbgN8C2hSf8lczuc3BmoRLj5BPs9jBaa0Zgqfz+x2U=;
        b=AGx0FkZwy8VNvbq0WMJES+UoZIkCCG/lSHD8vjj5zXuVFbMmsNALiX5oHosBAq4CA7eF3z
        bgfeR1MTRqMRqY62yCPKVHfH/tvuk80XSZCxTVpW4P7HCYs7g6kqbULRUSuwGZT0fgaDGB
        rF6CmeegmQGaQ1ClI8eOphTxcQP4ZvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-xhEN1IAZNGWigmaVXOmS1w-1; Tue, 01 Sep 2020 20:06:26 -0400
X-MC-Unique: xhEN1IAZNGWigmaVXOmS1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 688631DDF6;
        Wed,  2 Sep 2020 00:06:25 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0D5C60BE2;
        Wed,  2 Sep 2020 00:06:24 +0000 (UTC)
Subject: Re: [PATCH] module: Add more error message for failed kernel module
 loading
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, lkml <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
References: <20200829111437.96334-1-wqu@suse.com>
 <CAKi4VAJ_nZ9DT1Tm=uufbJPGgZJu+4j+DVVA9otv6oGXuD3jxg@mail.gmail.com>
 <df13d885-6f9d-dc8a-b850-8aa6ae6993eb@redhat.com>
 <CAKi4VAK4818=-FfSwG7jt-+CwY-3qEYrHfzZ45dTY948smOZ8g@mail.gmail.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <554c3764-526d-721b-69da-616ae22fdb70@redhat.com>
Date:   Tue, 1 Sep 2020 20:06:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKi4VAK4818=-FfSwG7jt-+CwY-3qEYrHfzZ45dTY948smOZ8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/20 4:17 PM, Lucas De Marchi wrote:
> On Tue, Sep 1, 2020 at 12:56 PM Prarit Bhargava <prarit@redhat.com> wrote:
>>
>>
>>
>> On 9/1/20 2:50 PM, Lucas De Marchi wrote:
>>> On Sat, Aug 29, 2020 at 4:15 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> When kernel module loading failed, user space only get one of the
>>>> following error messages:
>>>> - -ENOEXEC
>>>>   This is the most confusing one. From corrupted ELF header to bad
>>>>   WRITE|EXEC flags check introduced by in module_enforce_rwx_sections()
>>>>   all returns this error number.
>>>>
>>>> - -EPERM
>>>>   This is for blacklisted modules. But mod doesn't do extra explain
>>>>   on this error either.
>>>>
>>>> - -ENOMEM
>>>>   The only error which needs no explain.
>>>>
>>>> This means, if a user got "Exec format error" from modprobe, it provides
>>>> no meaningful way for the user to debug, and will take extra time
>>>> communicating to get extra info.
>>>>
>>>> So this patch will add extra error messages for -ENOEXEC and -EPERM
>>>> errors, allowing user to do better debugging and reporting.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  kernel/module.c | 11 +++++++++--
>>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/module.c b/kernel/module.c
>>>> index 1c5cff34d9f2..9f748c6eeb48 100644
>>>> --- a/kernel/module.c
>>>> +++ b/kernel/module.c
>>>> @@ -2096,8 +2096,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
>>>>         int i;
>>>>
>>>>         for (i = 0; i < hdr->e_shnum; i++) {
>>>> -               if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
>>>> +               if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
>>>> +                       pr_err(
>>>> +                       "Module %s section %d has invalid WRITE|EXEC flags\n",
>>>> +                               mod->name, i);
>>>>                         return -ENOEXEC;
>>>> +               }
>>>>         }
>>>>
>>>>         return 0;
>>>> @@ -3825,8 +3829,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>>>         char *after_dashes;
>>>>
>>>>         err = elf_header_check(info);
>>>> -       if (err)
>>>> +       if (err) {
>>>> +               pr_err("Module has invalid ELF header\n");
>>>>                 goto free_copy;
>>>> +       }
>>>>
>>>>         err = setup_load_info(info, flags);
>>>>         if (err)
>>>> @@ -3834,6 +3840,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>>>
>>>>         if (blacklisted(info->name)) {
>>>>                 err = -EPERM;
>>>> +               pr_err("Module %s is blacklisted\n", info->name);
>>>
>>> I wonder why would anyone actually add the blacklist to the command
>>> line like this and have no
>>> way to revert that back. This was introduced in
>>
>> Debug.  Debug.  Debug. ;)  The parameter was added to debug broken installations
>> and kernel boots.
>>
>>> be7de5f91fdc modules: Add kernel parameter to blacklist modules
>>> as a way to overcome broken initrd generation afaics.
>>
>> Not the generation of the initramfs, but blocking a module loaded during the
>> boot.  The installation may have failed and there's no easy way to then debug
>> what module was responsible for the failure.
> 
> if you are using initrd, then *inside* the initrd you should have the
> /etc/modprobe.d/* file
> you want. I said "broken initrd generation" because the tool should
> put the file there, and
> apparently for you it isn't.
> 
> Even if you don't have the file, you could use modprobe.blacklist= and
> let the blacklist happen
> in the userspace library rather than in the kernel. Module loading is
> not like firmware loading
> that happens without help from userspace.
> 
>>
>>  Either kernel
>>> command line (using modprobe.blacklist)
>>> or /etc/modprobe.d options are honoured by libkmod and allow a
>>> sufficiently privileged user to bypass it.
>>>
>>
>> Both of those options only work if the filesystem is mounted IIRC.  It could be
>> the case that modprobe.blacklist now works earlier in the boot, however, I've
>> never used it because module_blacklist is the biggest and best hammer that I can
>> use to get through a broken installation or boot.
>>
>> In any case you're incorrectly assuming that the system has a filesystem on it.
>> That's not necessarily the case as I'll explain below.
>>
>>> +Rusty, +Prarit: is there anything this module parameter is covering
>>> that I'm missing?
>>
>> This is the situation I have repeatedly come across :  A system at a remote site
>> will not boot any flavor of Linux.  Since the system would not install the only
>> way to debug was to provide install images to workaround a module load failure.
>> As you can imagine that is a time consuming process as well as a bad end user
>> experience.
>>
>> I got so sick of it that I wrote the code above (well similar to it anyway --
>> thanks for the review Randy ;)) to add the module_blacklist parameter to make
>> debugging an uninstallable "bricked" system easier.
>>
>> It's come in handy in some unexpected ways.  We've had situations where modules
>> have loaded and corrupted memory and blacklisting them revealed that the modules
>> were responsible for the memory corruption.
> 
> ok... but this seems a reimplementation of modprobe.blacklist= option
> in the kernel command line,
> but in kernel space, with no way to remove it after the kernel is booted.
>

That's *EXACTLY* what I want.  I do not want modprobe (because of some
misconfiguration) to load the module I've explicitly blacklisted.

P.

> Lucas De Marchi
> 
>>
>> P.
>>
>>>
>>> For the changes here,
>>>
>>> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>>
>>> thanks
>>> Lucas De Marchi
>>>
>>>>                 goto free_copy;
>>>>         }
>>>>
>>>> --
>>>> 2.27.0
>>>>
>>>
>>
> 

