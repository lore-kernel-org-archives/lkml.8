Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB46C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4387421655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583876878;
	bh=tw50k1ZQWENDlydQOTLZPFKiSSdTIwBxk15+pWV+xII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nt1523yMdPu35InVOEZdV2xyxvzCzdvPoeO21uIhigS9hPsnBjwGp5ZMWg3geypw7
	 h7fQJHxwgjNnh4zi5E0xH3bZCFhz5J4Hp9Mo9QrICRQgHYIfbeHNzuAmqK2DF7ax2e
	 K4uN+ZUx0LPIrLoRJ6ABcToJEArddM29NfLnjFDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCJVr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:47:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42499 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJVr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:47:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id t21so12228116lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ppVh7LyRFIl1A+ELQ+dNJ6Ueqe7YDWhaCMx5Yyl/CY=;
        b=KpyfUwT0etYAj8+912O82nlR5HeLTpn4SDsTonOMcnn6Bd+D1ADvt7zQ/ZV6TMQH7k
         eOHDcGUHKwWB4kmeeO9si7StiS7ATtguh9IW2vUN6FfyLnkrtaG/hLlw/V3tOD6UJ7HC
         vgQx7S0Yjy+AZ7lit98JPffg4rZ7IJBRwdcDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ppVh7LyRFIl1A+ELQ+dNJ6Ueqe7YDWhaCMx5Yyl/CY=;
        b=ViK+zHGUU9q9wdNvNSlxfZ5vrnuuamnZ6H6AJxXeqRUOSA1JfX0MB4nPPPNrr+r8Iq
         28Cq/Au68gaRqdQ+s6i5ZG6pdR06CRpKHb015MEpC2NXmrTMtlJTs9oPzPBWECRF8vaN
         T2Y2n/6BAcGvqm5eGjQXIJ9Dw5yxdntcWt4DfxSuM7dlT3EFHCgE8Z4eRTi3S3kPgcKo
         s8yAV2k8DK7tPv05KdbD58cn3XitEz83xy0VSLMkcotu+sqReKalP/zAL5l97HCBzu4/
         +IjDt1s1NoqAxQ4Ejl+XUSpZrjmeHLcLZ6ZbwmgPtdHq1x7mazrF80Jv4eZ2bcrwgTk6
         wj2g==
X-Gm-Message-State: ANhLgQ3OCceaDdCoUDhukgQDhYbnNbALXLhvsB61xrc5QLZKS5O8ooEf
        n9RQ2Y3Btr2x1Z2ApBqw6GP7NQF2XBo=
X-Google-Smtp-Source: ADFU+vuqVavq1gvVUp1gjk7E1booUuoe3mljNWKCFZvyvd/ITloAPJ96a2hGCoVVqsE4bMW/CVmhaQ==
X-Received: by 2002:a05:6512:202:: with SMTP id a2mr111732lfo.108.1583876872609;
        Tue, 10 Mar 2020 14:47:52 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s7sm5962055lfp.51.2020.03.10.14.47.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 14:47:51 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id q10so11495018lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:47:50 -0700 (PDT)
X-Received: by 2002:ac2:5508:: with SMTP id j8mr99474lfk.31.1583876870571;
 Tue, 10 Mar 2020 14:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200308140314.GQ5972@shao2-debian> <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
 <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
 <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
 <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
 <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
 <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
 <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
 <878sk7vs8q.fsf@notabene.neil.brown.name> <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
 <875zfbvrbm.fsf@notabene.neil.brown.name>
In-Reply-To: <875zfbvrbm.fsf@notabene.neil.brown.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Mar 2020 14:47:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
Message-ID: <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 2:22 PM NeilBrown <neilb@suse.de> wrote:
>
> A compiler barrier() is probably justified.  Memory barriers delay reads
> and expedite writes so they cannot be needed.

That's not at all guaranteed. Weakly ordered memory things can
actually have odd orderings, and not just "writes delayed, reads done
early". Reads may be delayed too by cache misses, and memory barriers
can thus expedite reads as well (by forcing the missing read to happen
before later non-missing ones).

So don't assume that a memory barrier would only delay reads and
expedite writes. Quite the reverse: assume that there is no ordering
at all unless you impose one with a memory barrier (*).

             Linus

(*) it's a bit more complex than that, in that we do assume that
control dependencies end up gating writes, for example, but those
kinds of implicit ordering things should *not* be what you depend on
in the code unless you're doing some seriously subtle memory ordering
work and comment on it extensively.
