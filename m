Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DA0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E109F20732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVIDc+Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgFRWe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFRWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:34:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F211C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:34:54 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so8117760eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ufkff4bYaZWMJREeHgxGoHlsRSLljnQgAYuH2o8gfeU=;
        b=AVIDc+Cega1zTowFz1uGkCeD4iQZjrQiufHKq9gfN8xZsoFPIUDZqXP28r9GUEMph7
         mbmek3PruIUh7HQKwKC5OdOdceiOuOhVfAtFaLdG4xgzObAi0URB8f27q4lnwjS/U1wS
         wCiQFwUPYrM5kIDcBBSOlNOrRbHxftRlkAchhFgTyCSikDuyKcwMHM6oexOxsLhuKHmp
         ZMWwWYyjVd0BQNFhrjJturNrRaSXp04LqOGi7JSJ+lEuiSLfL2NdVNMd9mfg2cw6aa+k
         cwNidQc+3drzHtwxivKHbGUXgVp6pxRAhQKyiiAjosCgR6i59b/JYqfX27Np2GR5yQNc
         sOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ufkff4bYaZWMJREeHgxGoHlsRSLljnQgAYuH2o8gfeU=;
        b=qvl9oW8Ks+UjJCK9eh6gvW4/sEHzsF18rkvqkjnEPZ4ObUerjZFId0xaC3fp1J3T1O
         lLPdHKC2nMCtoNn7xBERGRearQgjQ1ZVG5agsd7wYFkVsdfhalKmd11USRGQhjc4qa0I
         eu+LQB5w06Ci1oMjGBRZ1SC7cMvzm4wovy29OX+2I77QW2WvmF3PC9E5EDHcL9kqvRFm
         lVGmXtj7zs6jRMDfEoxiSf1E/uR83De/oWCd6j9OvMeo+gIoulZTimLeMejTRLXK8YlW
         E5BcGktU513bUYHuBdoAa+QlN7LuAlQhZwXQh/iqLBzEBsRtIcOCyZjJspicBebv1GLe
         jydg==
X-Gm-Message-State: AOAM532e/MvSCp5AGeOFcjwT5wV5oLdt8ha3BwTlSdgWo42BO5Y5xiB8
        +MgcudzEev6bqUZNy9WDcAkV9A==
X-Google-Smtp-Source: ABdhPJyBrgQ+0bTNY3GAlWVdUQDXCuXcollRqx2rTOzb6DvAsmzuIHqcYVUuK7/sL4rN/UIS21M21w==
X-Received: by 2002:a17:906:ced0:: with SMTP id si16mr563963ejb.545.1592519692941;
        Thu, 18 Jun 2020 15:34:52 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-140.ip.btc-net.bg. [212.5.158.140])
        by smtp.googlemail.com with ESMTPSA id k2sm3326758ejc.20.2020.06.18.15.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 15:34:52 -0700 (PDT)
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
To:     Jason Baron <jbaron@akamai.com>, jim.cromie@gmail.com
Cc:     Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
 <20200617162536.611386-23-jim.cromie@gmail.com> <20200618161912.GD3617@alley>
 <20200618174058.GE3617@alley>
 <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com>
 <CAJfuBxwLKDSx6RA_ZOk=eEHw0P3FeAcT=PCr-aHjUFKDS2p8cQ@mail.gmail.com>
 <172c0580-279f-aa3e-817a-4216067bea10@akamai.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <23396523-28c3-74e6-3e62-be68e5a5465a@linaro.org>
Date:   Fri, 19 Jun 2020 01:34:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <172c0580-279f-aa3e-817a-4216067bea10@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, Jim,

On 6/18/20 10:40 PM, Jason Baron wrote:
> 
> 
> On 6/18/20 3:11 PM, jim.cromie@gmail.com wrote:
>> On Thu, Jun 18, 2020 at 12:17 PM Jason Baron <jbaron@akamai.com> wrote:
>>>
>>>
>>>
>>> On 6/18/20 1:40 PM, Petr Mladek wrote:
>>>> On Thu 2020-06-18 18:19:12, Petr Mladek wrote:
>>>>> On Wed 2020-06-17 10:25:35, Jim Cromie wrote:
>>>>>> 1. Add a user-flag [u] which works like the [pfmlt] flags, but has no
>>>>>> effect on callsite behavior; it allows incremental marking of
>>>>>> arbitrary sets of callsites.
>>>>>>
>>>>>> 2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
>>>>>> And in ddebug_read_flags():
>>>>>>    current code does:       [pfmltu_] -> flags
>>>>>>    copy it to:              [PFMLTU_] -> mask
>>>>>>
>>>>>> also disallow both of a pair: ie no 'pP', no true & false.
>>>>>>
>>>>>> 3. Add filtering ops into ddebug_change(), right after all the
>>>>>> callsite-property selections are complete.  These filter on the
>>>>>> callsite's current flagstate before applying modflags.
>>>>>>
>>>>>> Why ?
>>>>>>
>>>>>> The u-flag & filter flags
>>>>>>
>>>>>> The 'u' flag lets the user assemble an arbitary set of callsites.
>>>>>> Then using filter flags, user can activate the 'u' callsite set.
>>>>>>
>>>>>>   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
>>>>>>   #> echo 'u+p' > control
>>>>>>
>>>>>> Of course, you can continue to just activate your set without ever
>>>>>> marking it 1st, but you could trivially add the markup as you go, then
>>>>>> be able to use it as a constraint later, to undo or modify your set.
>>>>>>
>>>>>>   #> echo 'file foo.c +up' >control
>>>>>>   .. monitor, debug, finish ..
>>>>>>   #> echo 'u-p' >control
>>>>>>
>>>>>>   # then later resume
>>>>>>   #> echo 'u+p' >control
>>>>>>
>>>>>>   # disable some cluttering messages, and remove from u-set
>>>>>>   #> echo 'file noisy.c function:jabber_* u-pu' >control
>>>>>>
>>>>>>   # for doc, recollection
>>>>>>   grep =pu control > my-favorite-callsites
>>>>>>
>>>>>> Note:
>>>>>>
>>>>>> Your flagstate after boot is generally not all =_. -DDEBUG will arm
>>>>>> compiled callsites by default, $builtinmod.dyndbg=+p bootargs can
>>>>>> enable them early, and $module.dyndbg=+p bootargs will arm them when
>>>>>> the module is loaded.  But you could manage them with u-flags:
>>>>>>
>>>>>>   #> echo '-t' >control             # clear t-flag to use it as 2ndary markup
>>>>>>   #> echo 'p+ut' >control   # mark the boot-enabled set of callsites
>>>>>>   #> echo '-p' >control             # clean your dmesg -w stream
>>>>>>
>>>>>>   ... monitor, debug ..
>>>>>>   #> echo 'module of_interest $qterms +pu' >control # build your set of useful debugs
>>>>>>   #> echo 'module of_interest $qterms UT+pu' >control       # same, but dont alter ut marked set
>>>>>
>>>>> Does anyone requested this feature, please?
>>>>>
>>>>> For me, it is really hard to imagine people using these complex and hacky
>>>>> steps.
>>>>
>>>> I think that all this is motivated by adding support for module
>>>> specific groups.
>>>>
>>>> What about storing the group as yet another information for each
>>>> message? I mean the same way as we store module name, file, line,
>>>> function name.
>>>>
>>>> Then we could add API to define group for a given message:
>>>>
>>>>    pr_debug_group(group_id, fmt, ...);
>>>>
>>>> the interface for the control file might be via new keyword "group".
>>>> You could then do something like:
>>>>
>>>>    echo module=drm group=0x3 +p >control
>>>>
>>>> But more importantly you should add functions that might be called
>>>> when the drm.debug parameter is changes. I have already mentioned
>>>> it is another reply:
>>>>
>>>>     dd_enable_module_group(module_name, group_id);
>>>>     dd_disable_module_group(module_name, group_id);
>>>>
>>>>
>>>> It will _not_ need any new flag or flag filtering.
>>>>
>>>> Best Regards,
>>>> Petr
>>>>
>>>
>>> Yes, I'm wondering as well if people are really going to use the
>>> new flags and filter flags - I mentioned that here:
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2020_6_12_732&d=DwIBaQ&c=96ZbZZcaMF4w0F4jpN6LZg&r=1fLh1mlLqbfetnnGsbwXfpwmGlG4m83mXgtV4vZ1B1A&m=vltk6sSzPDQIqO4gGkJeDY6jcEarG4xTztab2EHtPFY&s=6x1EHNoRxebA99Tu-C2i0s5dmdzyEF9bXVcv_cYoM_I&e= 
>>>
>>
>> yes, I saw, and replied there.
>> but since that was v1, and we're on v3, we should refresh.
>>
>> the central use-case is above, 1-liner version summarized here:
>>
>> 1- enable sites as you chase a problem with +up
>> 2- examine them with grep =pu
>> 3- change the set to suit, either by adding or subtracting callsites.
>> 4- continue debugging, and changing callsites to suit
>> 5- grep =pu control > ~/debugging-session-task1-callsites
>> 6- echo up-p >control   # disable for now, leave u-set for later
>> 7- do other stuff
>> 8 echo uP+p >control # reactivate useful debug-state and resume
>>
>>
>>> The grouping stuff is already being used by lots of modules so
>>> that seems useful.
>>
>> I now dont see the need.
>>
>> given N debug callsites, any group can be defined by <N queries,
>> probably a lot less
>> if module authors can use ddebug_exec_queries(), cuz its exported, (15/21)
>> then they can act (+p or -p) on those sets defined by <N queries.
>>
>> and now any callsite can be in any number of groups, not just one.
>> It would be prudent to evaluate such groupings case by case,
>> because the intersecting callsites are subject to "last manipulator wins"
>> but its unnecessary to insist that all sets are disjoint.
>> Unlike pr_debug_n, however its spelled.
>>
> 
> hmm - so I think you are saying there is then no need to change the
> calling functions themselves - its still 'pr_debug()'. You could even
> use the 'format' qualifier for example to implement your groups that
> way.
> 
> For example:
> 
> pr_debug("failure type1: blah");
> pr_debug("failure type2: blah blah");
> 
> and then do: ddebug_exec_queries("format type1 +p", module);
> 
> I would be curious to see what Stanimir thinks of this proposal
> and whether it would work for his venus driver, which is what
> prompted this module group discussion.

Hmm, we spin in a circle :)

Infact this was my first way of implementing the groups in Venus driver,
you can see it at [1].

 +#define VDBGL(fmt, args...)	pr_debug("VENUSL: " fmt, ##args)
 +#define VDBGM(fmt, args...)	pr_debug("VENUSM: " fmt, ##args)
 +#define VDBGH(fmt, args...)	pr_debug("VENUSH: " fmt, ##args)
 +#define VDBGFW(fmt, args...)	pr_debug("VENUSFW: " fmt, ##args)


[1] https://lkml.org/lkml/2020/5/21/668

-- 
regards,
Stan
