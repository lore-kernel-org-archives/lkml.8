Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A8BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396332078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588889;
	bh=l96HgeC8hRzBXelRWR4MFaV7f0NdACbDSrh3X+92im0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1TdHQ8Rpxj21gkVs0VkwYcnNXCJIuwYPITc4ryjvuHlmHFUwz0Y5q4sVUu2Xtjcay
	 vFYILh59ov5NzfY86p46faTmgPFBU9BDonQ1D8fDQJbVdUyF+AYiHkbTYvSa22ZsUU
	 MFIE1pPMe+le4hCJJDud2+lMEzDpYW+0v5ddyvW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgIHSOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbgIHSOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:14:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6B4C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:14:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y17so153481lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJ3ljRP1PgRw54jIC5gTvGtyMc45VqFJMstrdbMtx+8=;
        b=T3guH4044UWDX5KPSunMEQmHeqrSj26rDjWAj/+rJoe1eDKvJU3Ic5nCrQ96J5+i+t
         TZ5UQyD1VBTE66WnopwwccZGtD7nym6+GYbaxp2OB+C0cA/LP6AYd7h6ese5jpHgtpUQ
         A1mvhQk+ngGAheHTyaJCRFXabP8OkkaeacE5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJ3ljRP1PgRw54jIC5gTvGtyMc45VqFJMstrdbMtx+8=;
        b=PY9J0ZS0KfSea3llRLWUigMm8KiQhsdFZZlWBHzHJzUEdpLxz45D7mzMO9uDyjdhn5
         speiLu+tNQNqnEmlMWSCHSHG9UVZnmzFkM6Ty8svILofb7Ozp2xmlWlLj6Nhy/YVRosn
         sj+LVloOfE5iOVfKFGSDblhQehP0uyl8fqBsbz8E4PPf/gVH4iXTnPK9s/jF2bq9cNgR
         79vMDAXt1r5E3mpzZvk+MWWIbjwRb0UpAxbTfpMlhcCtJIJAnqv5VZBOr/coM2FNfASl
         e5S7x7/BhaoX3dlEgMOr1zAkLpYWi0LBzYGapW/VJZdO911VZk1HFSMoW+9JKwW/Zvv6
         uNOg==
X-Gm-Message-State: AOAM530R5SX97iLeAyOp2ztv3gOt7uOy8DTKscCFXyKtDEED/NNkJreC
        xvssiAq9LegGobFT63Z8MjHCNkEGJVRz+w==
X-Google-Smtp-Source: ABdhPJw2V1rzm52Ss3yMYnEgYuuhdDCrpcAS+gvV4s4L/ASieekOXav+Cspivufsxg12mfxwJsbG+A==
X-Received: by 2002:ac2:5399:: with SMTP id g25mr114187lfh.137.1599588855262;
        Tue, 08 Sep 2020 11:14:15 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g6sm70695lfh.18.2020.09.08.11.14.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 11:14:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id z19so164414lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:14:14 -0700 (PDT)
X-Received: by 2002:a19:745:: with SMTP id 66mr135177lfh.142.1599588854033;
 Tue, 08 Sep 2020 11:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200907082036.GC8084@alley>
In-Reply-To: <20200907082036.GC8084@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Sep 2020 11:13:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZUYjmPLiEaN5uHM4mGyYq8RBFvk=iZKkm9=8NxvcoZQ@mail.gmail.com>
Message-ID: <CAHk-=wiZUYjmPLiEaN5uHM4mGyYq8RBFvk=iZKkm9=8NxvcoZQ@mail.gmail.com>
Subject: Re: [GIT PULL] livepatching for 5.9-rc5
To:     Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh,

On Mon, Sep 7, 2020 at 1:20 AM Petr Mladek <pmladek@suse.com> wrote:
>
> - Workaround "unreachable instruction" objtool warnings that happen
>   with some compiler versions.

I know I said this fixes things for me, but I just realized it doesn't entirely.

I wonder how I missed the remaining one:

   arch/x86/kvm/vmx/vmx.o: warning: objtool:
vmx_handle_exit_irqoff()+0x142: unreachable instruction

so apparently gcc and objtool can still disagree even without that
'-flive-patching'.

The unreachable code in question is after the call to
handle_external_interrupt_irqoff(), and while that function is a bit
odd, in this case I think it's objtool that is wrong.

I think that what happens is that the function doesn't have a 'ret'
instruction, and instead returns by doing a tail-call to
__sanitizer_cov_trace_pc with my config. And maybe that is what
confuses objtool.

This is current tip-of-git of my tree, with a allmodconfig build (but
the actual config will then depend on things like the gcc plugins
being there too, so you may not get exactly the same thing as I do)

Josh? Am I missing something, and the objtool warning is valid? But
yes, that code is doing some very very special stuff with that thunk
call asm, so it's hard to read the asm.

                  Linus
