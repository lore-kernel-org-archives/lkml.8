Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065AA20814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKFpil8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390861AbgE1N42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390782AbgE1N4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:56:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C6AC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:56:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w20so8478366pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NSCHZoX3QeqH6L33QAQLhgDcGYFDxPu6DWaF39Oa9XE=;
        b=sKFpil8CK1mMHL0wytcaK0eCTbjcqly0KJfRKCHmxGsrltR3p7+tY8llBnPMM3n4M9
         4Z82hX8aVyKwfuyVfcVv8oA7fBF476wFDRnDfYXSiboeObDvMs2JxnIgu91FCha4hASv
         B/6lJRwsUw6agzKYNro1i4v35xulqIKR+KqPWq1qvWmjsM8uwnwuLqr9NdVpoyUa10DB
         sgc45aSwLdkuQnd0nGbD1LvHOvDfBvQV+C2AWYdSowdeebmAt8zykoVfgRlpJSKCc1gR
         j0dpU2u9pY7IIZZtEJjENrAbHRcZ4cRKZT4eKKz1iOR/aHGPEEWpVEBHDqfyD4QEvc6Z
         cNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NSCHZoX3QeqH6L33QAQLhgDcGYFDxPu6DWaF39Oa9XE=;
        b=ZhBqW49vy1e5su3hGvWkV/SD4zp8oikoUdVsLpYHY9TInEA2i6vzcexP+q9JqBmV0E
         W9f35/ADgONzZzgq1VkZHBrlqvgy7U/zOPtQ/MjuvBriM7TtVzRloGC28DwI3IMPwBBX
         6oHLF6y70c1UPr1oFp7wliL0cULYgcyP5RMcqU02szXSTPiLAdXHBmbY99jME+hfxzO7
         HqcxW5dFfafBX2V4+Cz9N7DxWZpPdriOPrVFBm5l3XixYLuyRu3/915wd/eSSTspf56Q
         yKTIrWdkqHOJuSD9RkEqe0BommJ+S+0jV4LLYO7iLqnICbV+iN/sGvRtTqIuGWlCoq/2
         v1QA==
X-Gm-Message-State: AOAM532nxjM5tXXaUaxeRtCUz+SbvQFiIYv6EPikFssociasiSH0l7Kc
        z2q0Asftqv7FWwWqg3+FsQw=
X-Google-Smtp-Source: ABdhPJxVntSWy1jUPnVWxdWn61wrqF/5+Id3Itcc4ZZKWDAFPpWG0veIyRazhT9F7qvjRZ5To2YQgQ==
X-Received: by 2002:a63:482:: with SMTP id 124mr3062637pge.169.1590674181919;
        Thu, 28 May 2020 06:56:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 145sm4972007pfa.53.2020.05.28.06.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 06:56:20 -0700 (PDT)
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
 <20200527075048.GD3284396@kuha.fi.intel.com>
 <CAJZ5v0h0Xjovm-eVyiOG+j7kNEPxB=PZF4rLVEgwUW+H+61DFg@mail.gmail.com>
 <2407984.idRd5kzSG0@kreacher> <20200527222515.GA89212@roeck-us.net>
 <CAJZ5v0jPoi+5d+jv0iAuKkObSr=EDxmMhNqMTvLQNUEc_i9zcg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <64eb962a-eaef-9747-9408-eb9061cb42f6@roeck-us.net>
Date:   Thu, 28 May 2020 06:56:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jPoi+5d+jv0iAuKkObSr=EDxmMhNqMTvLQNUEc_i9zcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 3:57 AM, Rafael J. Wysocki wrote:
> On Thu, May 28, 2020 at 12:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Wed, May 27, 2020 at 11:01:16AM +0200, Rafael J. Wysocki wrote:
>>>
>>> So Guenter, can you please test the patch below to see if it still introduces
>>> the problems seen by you on ARM?
>>>
>>
>> arm64 and arm64be boot tests pass with the patch below.
> 
> Great, thanks!
> 
>> Some arm boot tests fail, but I think that is due to some other problem with -next.
>> Hard to say for sure at this point because -next is pretty badly broken
>> overall. I'll need to run some bisects to see what is going on.
> 
> I see.
> 

The failing arm boot tests are due to various dts changes (commit "arm64:
dts: vexpress: Move fixed devices out of bus node" and associated),
unrelated to this patch.

Guenter

> Thanks for giving this one a go.
> 
>>> ---
>>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>> Subject: [PATCH] kobject: Make sure the parent does not get released before its children
>>>
>>> In the function kobject_cleanup(), kobject_del(kobj) is
>>> called before the kobj->release(). That makes it possible to
>>> release the parent of the kobject before the kobject itself.
>>>
>>> To fix that, adding function __kboject_del() that does
>>> everything that kobject_del() does except release the parent
>>> reference. kobject_cleanup() then calls __kobject_del()
>>> instead of kobject_del(), and separately decrements the
>>> reference count of the parent kobject after kobj->release()
>>> has been called.
>>>
>>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
>>> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>> [ rjw: Drop parent reference only when called __kobject_del() ]
>>> Signed-off-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>> ---
>>>  lib/kobject.c |   34 +++++++++++++++++++++++-----------
>>>  1 file changed, 23 insertions(+), 11 deletions(-)
>>>
>>> Index: linux-pm/lib/kobject.c
>>> ===================================================================
>>> --- linux-pm.orig/lib/kobject.c
>>> +++ linux-pm/lib/kobject.c
>>> @@ -599,14 +599,7 @@ out:
>>>  }
>>>  EXPORT_SYMBOL_GPL(kobject_move);
>>>
>>> -/**
>>> - * kobject_del() - Unlink kobject from hierarchy.
>>> - * @kobj: object.
>>> - *
>>> - * This is the function that should be called to delete an object
>>> - * successfully added via kobject_add().
>>> - */
>>> -void kobject_del(struct kobject *kobj)
>>> +static void __kobject_del(struct kobject *kobj)
>>>  {
>>>       struct kernfs_node *sd;
>>>       const struct kobj_type *ktype;
>>> @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
>>>
>>>       kobj->state_in_sysfs = 0;
>>>       kobj_kset_leave(kobj);
>>> -     kobject_put(kobj->parent);
>>>       kobj->parent = NULL;
>>>  }
>>> +
>>> +/**
>>> + * kobject_del() - Unlink kobject from hierarchy.
>>> + * @kobj: object.
>>> + *
>>> + * This is the function that should be called to delete an object
>>> + * successfully added via kobject_add().
>>> + */
>>> +void kobject_del(struct kobject *kobj)
>>> +{
>>> +     struct kobject *parent = kobj->parent;
>>> +
>>> +     __kobject_del(kobj);
>>> +     kobject_put(parent);
>>> +}
>>>  EXPORT_SYMBOL(kobject_del);
>>>
>>>  /**
>>> @@ -663,7 +670,9 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
>>>   */
>>>  static void kobject_cleanup(struct kobject *kobj)
>>>  {
>>> +     struct kobject *parent = kobj->parent;
>>>       struct kobj_type *t = get_ktype(kobj);
>>> +     bool state_in_sysfs = kobj->state_in_sysfs;
>>>       const char *name = kobj->name;
>>>
>>>       pr_debug("kobject: '%s' (%p): %s, parent %p\n",
>>> @@ -681,10 +690,10 @@ static void kobject_cleanup(struct kobje
>>>       }
>>>
>>>       /* remove from sysfs if the caller did not do it */
>>> -     if (kobj->state_in_sysfs) {
>>> +     if (state_in_sysfs) {
>>>               pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
>>>                        kobject_name(kobj), kobj);
>>> -             kobject_del(kobj);
>>> +             __kobject_del(kobj);
>>>       }
>>>
>>>       if (t && t->release) {
>>> @@ -698,6 +707,9 @@ static void kobject_cleanup(struct kobje
>>>               pr_debug("kobject: '%s': free name\n", name);
>>>               kfree_const(name);
>>>       }
>>> +
>>> +     if (state_in_sysfs)
>>> +             kobject_put(parent);
>>>  }
>>>
>>>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
>>>
>>>
>>>

