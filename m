Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE938C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C9820718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581906307;
	bh=6Nwl5lHxgMykRrAY3M1rtLG0EFNQ86rSNaSjuSDDEZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LnI9eh6yyKWcU2iavFABAygl+CgQmgk9IlaMHSE1lMjhSEGnYAgbVW25b0/5D78ue
	 8OjmhMU96exh8ieck+uVXnDJZIHaDltlpc/Ax5hK7LjMU41Rz76Iq026kxWBmEBW6n
	 th+eHBDyEvMcoXSNOVUzJ++dm72MUqj3aItct1Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgBQCZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:25:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40420 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQCZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:25:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so16984115ljo.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 18:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kd654Jvi3N2A7MnCrIjpOQhY0mSWg+UvXc8Pmg/fHOE=;
        b=SizI53Jr4bgQgFG2aqNiwd0aB45h4wUff+q/c2ukT27TMTpfc6iCQKNgM0Wz/Y/21F
         Y2xX3gWBcXEarwAnkIE98K7Gz/3GxQzL+dGroH95+ucTiB1Ogh9knxsQLDxAW8vA4qtT
         qmeuaaO+jeogpF9niJkxhFKIRFwgW6Ocj7bAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kd654Jvi3N2A7MnCrIjpOQhY0mSWg+UvXc8Pmg/fHOE=;
        b=m2gwS83oBpSKVryHiccXyaS7rZ8iGaLDrn7u8EspMdboeItlYxJ1bElEyQBXxjP0F6
         OXOxw2jczW2bSpVvIaxttOC5X5czUq7GyIVvFMAN2q7RWaWTqk4qxOljWQ+GjWbEF2hX
         Hxb70FmGO15BGkPCAaoXC9XYA/6M66Er82/KIWwAjtAexo0jEiIKa3G2BvYpS1RSA7qO
         6qqHCEM0MRrdayjP6zbFL9iLEsIoL8y+vM1cfBsssCT3LFzjlDYrS6/rCLcR9zGRTvRj
         tDuulG+/shB6yDT7eZhuiK9sNHffYsTeDFEYkr/040yIUDm3ufBU9o6FxHUCai31AYAO
         nxng==
X-Gm-Message-State: APjAAAWeoD6GW4ZGZXKHI1nRYnZIW/83H6h3LS/HBSozqN6cLSn162Hi
        hyz6OEZmwgndk7sMXNX2vEFOiN8Q/K8=
X-Google-Smtp-Source: APXvYqy60bOivxCXCtaPGTxSNHe5qqY8aF1JlqWi3G5td74RYMItw5IKTRft3kW8NBEAsKuQWkttJw==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr8588471lja.188.1581906303113;
        Sun, 16 Feb 2020 18:25:03 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id t21sm7727888ljh.14.2020.02.16.18.25.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 18:25:02 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id w1so16985443ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 18:25:01 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr8568137ljb.150.1581906301551;
 Sun, 16 Feb 2020 18:25:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <20200217020840.GA24821@codemonkey.org.uk>
In-Reply-To: <20200217020840.GA24821@codemonkey.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Feb 2020 18:24:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5AkQk-9By-QeyT+5H_t6DLZD=25uOz-ujnV8oEv1Y5Q@mail.gmail.com>
Message-ID: <CAHk-=wg5AkQk-9By-QeyT+5H_t6DLZD=25uOz-ujnV8oEv1Y5Q@mail.gmail.com>
Subject: Re: Linux 5.6-rc2
To:     Dave Jones <davej@codemonkey.org.uk>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 6:08 PM Dave Jones <davej@codemonkey.org.uk> wrote:
>
> This didn't happen in rc1, but showed up when I booted into rc2 and
> tried to and pull some stuff with rsync.
>
> [   70.794783] BUG: sleeping function called from invalid context at mm/slab.h:565
> [   70.795459]  kmem_cache_alloc+0x1d3/0x290
> [   70.795471]  alloc_extent_state+0x22/0x1c0
> [   70.795544]  __clear_extent_bit+0x3ba/0x580
> [   70.795569]  btrfs_truncate_inode_items+0x339/0xe50
> [   70.795647]  btrfs_evict_inode+0x269/0x540

At a guess (just by functions involved, and the timing between rc1 and
rc2 - no actual analysis), this is probably due to

    28553fa992cb ("Btrfs: fix race between shrinking truncate and fiemap")

which is also marked for stable, so... Filipe?

              Linus
