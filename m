Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD90020661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i4ryt0VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbgEDSOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732352AbgEDSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:14:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24743C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:14:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p25so5913054pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LJmSp82Ligwp7WEnd3OlCUWXViCVJLdpeeRX1nJdOAo=;
        b=i4ryt0VLTZEgW9WQe4ALh7GSYN1W1JwqThJe+wRYZgNPFUczOTCCP213kc/oLApap1
         G0ekyN5KGn7TaWDNsjrmi06xnz+e4iALaF/Fp3Q1fClqTC4UOWucvy4YhBo+9Ij0krMM
         Z5LGe36D3Cdo4BukCzFGBjqJ8NjSHMXqYgJW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJmSp82Ligwp7WEnd3OlCUWXViCVJLdpeeRX1nJdOAo=;
        b=qzzeRSOwfxCT2AgAWZJVixhJQ6lWXaFvzpyH06wWWyGagqPORDktEIiGVhO0cVxFAB
         t0JEkdL44fs/3eUquKIMFy6FjLKyUFGmve0pNdbEN1MwXXq2z1IizeMWAV6NfWxMsPL0
         qShMgQLZzGY9KPn6s8JUITlyniUPhQurq4kxaS4LrguyJGQBnGkrxroO+Ke9HxiJD+tB
         NK1vTvAlLMxQCgR26bNUzru0ULzNPRXA2WQQFyOT7g3sxVFfp8KqC44IpAdqFchhpRu6
         cRcUhziRyfIqbaylc5PyDJ/vJeRCiVLefnfGrUTBOJX4Z2+di1SpkwBepAF3geyA3zRr
         eVHA==
X-Gm-Message-State: AGi0PuaeyE7ZBRQNWWUGc7yJ736UWdjTOy0umg5fK1n/Ry2WBeSU4Laa
        mecP2f+Xr9oU+qiQOQSfzRN7AQ==
X-Google-Smtp-Source: APiQypJpzCwRNKHAwOjPu5Y0o7IOylpPdGPyjby32XHu799JivYz0nUFllc5ajHtfLH+GbCdEk043g==
X-Received: by 2002:a65:5287:: with SMTP id y7mr232927pgp.86.1588616069763;
        Mon, 04 May 2020 11:14:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 127sm9632296pfw.72.2020.05.04.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:14:29 -0700 (PDT)
Date:   Mon, 4 May 2020 11:14:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/3] allow ramoops to collect all kmesg_dump events
Message-ID: <202005041112.F3C8117F67@keescook>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502143555.543636-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 10:35:52AM -0400, Pavel Tatashin wrote:
> Currently, ramoops is capable to collect dmesg buffer only during
> panic and oops events. However, it is desirable for shutdown performance
> analysis reasons to optionally allow collecting dmesg buffers during other
> events as well: reboot, kexec, emergency reboot etc.
> 
> How to quickly test:
> 
> virtme-run --mods=auto --kdir --mods=auto --kdir . \
> 	-a memmap=1G$8G -a ramoops.mem_address=0x200000000 \
> 	-a ramoops.mem_size=0x100000 -a ramoops.record_size=32768 \
> 	-a ramoops.dump_all=1 -a quiet --qemu-opts -m 8G
> ..
> # reboot -f
> 
> After VM is back:
> 
> # mount -t pstore pstore /mnt
> # head /mnt/dmesg-ramoops-0 
> Restart#1 Part1

Is there a reason that using ramoops.console_size isn't sufficient for
this?

I'm not strictly opposed to making these changes, but traditionally the
granularity of dmesg output has been pretty easily "all or crashes"
instead of a range within.

-- 
Kees Cook
