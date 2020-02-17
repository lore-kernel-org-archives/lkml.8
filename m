Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC327C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB7A20857
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="EqUdG7l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBQDCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:02:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39061 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgBQDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:02:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id c5so11102627qtj.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4sAYXlDOpkoChpB5SyFiOYLmVpISq/ks9MwJ62LSWM=;
        b=EqUdG7l0hqv1ramBoPZBDn3ljsNOdfEUmi9aMIGPYmRB17n3JJipC8wI9RSS018WLH
         ICTm9m74FEPrVfFUUZyD1UcDnMxsv1uI8QuTZH22I3VIOJB1T486MksR/XNH1/asq8GW
         zg5tSCcVI9KOSrV0VB0Jpy55mInSsVQC/QDB2wN8Jc0bQtcvMi/aVUy0R2ZJJax/WeUb
         mwtxsu0q6itmmXrfbe8Oyv6QPrqwaLKBvqjf79KZXFkq3freqxHvtn8AiUKqszDX6sUF
         zzRXyIr6Bu1vktXVhgDbOz8+fjcTQVYsTf6CgiFtSGozWJE4P3Y+6kWDgrxrgocqbUqX
         +3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4sAYXlDOpkoChpB5SyFiOYLmVpISq/ks9MwJ62LSWM=;
        b=NsPqHI6aCrb2kCIuGfoXvd9e63/VsUC2LcidbXb5LH0u21wmWCi5fc9xatAdysGXVx
         ULbN8fRAjOP0haPn6TvTPLuUc/JnmF+bNNUO6aoqFdALxHp1+vSMJmb5UdZ0FYwzVODW
         PNytBlUz7VJ4gco8kamCYJ0dAW+vBvZLBiO+2ciSj3eKIWmI4zEcl5a+T6fUe8AodNpv
         28sNu9OzmyYf5j7pf1+EZAcHjxcM1zEK1XxyAaM7lTHrS4jCXTM53JcruHugIZyKUvVp
         nNeqESKjLn6DYlO2aQ91CLOGWwEuC8MChhP0yqP0ePVV+i5ZgNy9CaWsZD5L+U0LIYD+
         DYhQ==
X-Gm-Message-State: APjAAAWTs7sBQ4Jam2OzIcFI+Zi4XufQTRUEkX15C65lsAnrSh0OgZks
        grA/A2PZotSXIJgFsqC0Ng7E6W9Xb+Y=
X-Google-Smtp-Source: APXvYqyrJBdNTCQm9dw1eqB9dgNTZ5C4AQmJkwp6KU7yyicMEaYTYB/Y9ErWvpscoI7UaG4uHbp0mQ==
X-Received: by 2002:ac8:7392:: with SMTP id t18mr10926466qtp.332.1581908523543;
        Sun, 16 Feb 2020 19:02:03 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::2183])
        by smtp.gmail.com with ESMTPSA id j4sm8023122qkk.84.2020.02.16.19.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 19:02:02 -0800 (PST)
Subject: Re: Linux 5.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Jones <davej@codemonkey.org.uk>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <20200217020840.GA24821@codemonkey.org.uk>
 <CAHk-=wg5AkQk-9By-QeyT+5H_t6DLZD=25uOz-ujnV8oEv1Y5Q@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8025e1bf-4834-83c6-d12c-4e817f875776@toxicpanda.com>
Date:   Sun, 16 Feb 2020 22:02:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg5AkQk-9By-QeyT+5H_t6DLZD=25uOz-ujnV8oEv1Y5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/20 9:24 PM, Linus Torvalds wrote:
> On Sun, Feb 16, 2020 at 6:08 PM Dave Jones <davej@codemonkey.org.uk> wrote:
>>
>> This didn't happen in rc1, but showed up when I booted into rc2 and
>> tried to and pull some stuff with rsync.
>>
>> [   70.794783] BUG: sleeping function called from invalid context at mm/slab.h:565
>> [   70.795459]  kmem_cache_alloc+0x1d3/0x290
>> [   70.795471]  alloc_extent_state+0x22/0x1c0
>> [   70.795544]  __clear_extent_bit+0x3ba/0x580
>> [   70.795569]  btrfs_truncate_inode_items+0x339/0xe50
>> [   70.795647]  btrfs_evict_inode+0x269/0x540
> 
> At a guess (just by functions involved, and the timing between rc1 and
> rc2 - no actual analysis), this is probably due to
> 
>      28553fa992cb ("Btrfs: fix race between shrinking truncate and fiemap")
> 
> which is also marked for stable, so... Filipe?
> 

I assume Filipe wrote this based on my patch here

https://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git/commit/?id=c821555d2b9733d8f483c9e79481c7209e1c1fb0

which makes it so we can allocate safely in this context, but that patch hasn't 
made it's way to you yet.  Do you want it now?  It was prep for a much less safe 
patchset, but is fine by itself.  Thanks,

Josef
