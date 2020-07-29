Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D4FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE97A20672
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="tulOiKgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgG2Srr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2Srq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:47:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E25C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:47:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e13so23244102qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=de92zVYajUZRhB1uxDhwk9+GWBtXRj8Z9N8YqTT4pXA=;
        b=tulOiKgwhpXla1+dxpXaNWsRkCJ6mqgeNv1wePakOerlPst9LSR8Oi165paGpcPkxE
         Kp9DPcVm797w0sgwqPXc7A2VwW4rU4n5ayMEgKHtZ++NSvRc3jJqJWctzozvy0sR2qzn
         Tw5+eRfsYxlM3sVvSwM/oeBwbmh9B6QskAYiimaHJPLToJJT9GnsXClPDCLFZgP4bBMO
         C8U4geZPUs2F3AXkZm3HXw+Up1WyW9/Lj1YsmZLzQJdYUrFhGOiAdWyGPdLEmWLmNtf4
         jApkbJdSlS7DWvEy2BNxbll75JfOZ7luEllg6d51ZQBtvI2CZc8q7WJY1n0Hjxu+M4Fi
         reCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=de92zVYajUZRhB1uxDhwk9+GWBtXRj8Z9N8YqTT4pXA=;
        b=tp/Q53TrNKyDHrdFJxmo2g3kxiSQw7fPigxI9xYECKEWf+xUBJf8CI1EMHKNoe0Lmi
         tmLjqtmqfx+RvhjPRSmRtr4/42w7iQsrFiBzoV5+jbfZ/pgLP8ekY2rCzBxgUFUeTVV/
         QbowZPnDSM7b/uhOfUvDCzi7L3AjQFbkdQDd0s9+95fdtMsKKi7O/6o+mA/5KRyveMCf
         +3/ji7KCjM1oznWGgg+RGoRVz+1Ky2rAwaH0yYAIfBuNc9rbu5/5vLC+eCr69Okw+KTY
         MhGrdSW04cXY/p0zrx4KGf1R/O0ZIFADyUGLqAaeCZyph43o9YCZiDN9wAFpvzFpKqX4
         d7jg==
X-Gm-Message-State: AOAM530S07qhy4baSzIt5WMoc9UuzgZFnDDLIa/dBoVTIPBQrEBWM6II
        SkEkNcdXNCO6pf7YLPiwMUaBIA==
X-Google-Smtp-Source: ABdhPJy+qIWfZGcgwPuaP0Yke5sjGxIvpb/hZbPh59TzQelDx2QYkw7+P7jjnyXIDnBgeCK4CFiCdw==
X-Received: by 2002:a37:517:: with SMTP id 23mr35137201qkf.63.1596048465682;
        Wed, 29 Jul 2020 11:47:45 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::10a7? ([2620:10d:c091:480::1:2ed9])
        by smtp.gmail.com with ESMTPSA id c133sm2231150qkb.111.2020.07.29.11.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 11:47:44 -0700 (PDT)
Subject: Re: Inverted mount options completely broken (iversion,relatime)
To:     Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
 <1f56432b-a245-a010-51fd-814a9cf4e2b1@redhat.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b8c98c88-d6e2-de53-5906-27970d23c0b2@toxicpanda.com>
Date:   Wed, 29 Jul 2020 14:47:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1f56432b-a245-a010-51fd-814a9cf4e2b1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 2:41 PM, Eric Sandeen wrote:
> On 7/29/20 11:32 AM, Josef Bacik wrote:
>> Hello,
>>
>> Eric reported a problem to me where we were clearing SB_I_VERSION on remount of a btrfs file system.  After digging through I discovered it's because we expect the proper flags that we want to be passed in via the mount() syscall, and because we didn't have "iversion" in our show_options entry the mount binary (form util-linux) wasn't setting MS_I_VERSION for the remount, and thus the VFS was clearing SB_I_VERSION from our s_flags.
>>
>> No big deal, I'll fix show_mount.  Except Eric then noticed that mount -o noiversion didn't do anything, we still get iversion set.  That's because btrfs just defaults to having SB_I_VERSION set.  Furthermore -o noiversion doesn't get sent into mount, it's handled by the mount binary itself, and it does this by not having MS_I_VERSION set in the mount flags.
> 
> This was beaten^Wdiscussed to death in an earlier thread,
> [PATCH] fs: i_version mntopt gets visible through /proc/mounts
> 
> https://lore.kernel.org/linux-fsdevel/20200616202123.12656-1-msys.mizuma@gmail.com/
> 
> tl;dr: hch doesn't think [no]iversion should be exposed as an option /at all/
> so exposing it in /proc/mounts in show_mnt_opts for mount(8)'s benefit was
> nacked.
> 
>> This happens as well for -o relatime, it's the default and so if you do mount -o norelatime it won't do anything, you still get relatime behavior.
> 
> I think that's a different issue.
> 
>> The only time this changes is if you do mount -o remount,norelatime.
> 
> Hm, not on xfs:
> 
> # mount -o loop,norelatime xfsfile  mnt
> # grep loop /proc/mounts
> /dev/loop0 /tmp/mnt xfs rw,seclabel,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0
> 
> # mount -o remount,norelatime mnt
> # grep loop /proc/mounts
> /dev/loop0 /tmp/mnt xfs rw,seclabel,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0
> 

Oops you're right, I'm blind.  Same happens for btrfs, so using -o norelatime 
simply does nothing because it's considered a kernel wide default.

> 
> Are there other oddities besides iversion and relatime?

It doesn't look like it, I checked a few others of the MS_INVERT variety, these 
appear to be the only ones.  I really don't want to have this discussion again 
in the future tho when we introduce MS_SOME_NEW_AWESOME.  Thanks,

Josef

