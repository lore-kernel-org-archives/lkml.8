Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E31FC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39449206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587504629;
	bh=iGWHWArtYfGvIv4rVaYPU1ekenldJSIRhkvSxFRzOs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eXgBos9ifj4sZZ/aByJo0U5HiTlu0vT7BJk27BkoJYpB1dscgVsjcqzvEsWglqauZ
	 eiyarocCylqb/tuWZIXRJA45S/2bOjXGDlDEvM/sv3l6WNqEAxLlE3ThuXrXlXs+fJ
	 lazyRuxhlE6Bv4Mn+d7/xytQn2AP5eo3pJwKjrjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDUVa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUVa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:30:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E425C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:30:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so104096ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvK0oTAUp8anEWmdGI1Bg/ATwdwno3Sv2/od6yBSXAc=;
        b=FOiPol+JLjtolgG0HLIc6p+5MapSczKJpEfM7u0qWPMmucI24/ZkKmlYAtPcUduXSG
         Zgb0n13aAiuOKRQbum6muKeAC+lobr3+VAZU4b4uLYdeNCmgi+wlcatdGti5FpDyFJJC
         EQf0xVsz8eA4sLQwaznrD67RpYXHv5XpA6rDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvK0oTAUp8anEWmdGI1Bg/ATwdwno3Sv2/od6yBSXAc=;
        b=fzqasKguRgTm4So9MtZusF/F/Jx3NBEUN6S3ypg00Ut0mTo6Ae634B+JZA0CJOO4JE
         b4wjT4ZGOyHUeQ7pE8rn8yEP99RL5AtC2xWorPbuf063AkFKCl3cnjWLZS+ewdCx0z6v
         9aYiArKxnoiUBv7sXfbufD2sYRjuN0mQui5aCYHJUQIsqyXbv8Eb1aIQu3UZ8xZeA1Cm
         bM2tOYXpkiriitjTmSUrvtUPh/vAUOQQGum+rjQ9pwKd7SVCQqp9XiJqbguZrmuj2MhE
         42NyzQH1jGWJAL2OxxBgzAbRA1JRKMhCGTnWKRls3+Vux3WZVn0rCRKsDzdwcE48jjuK
         fv7w==
X-Gm-Message-State: AGi0Pube0uI3GJ49jPUPi9mGQ5ZkjnioLqpwct0mza+wGzhYW5V/fUdS
        qEA3bwh2U6aU3Ivjx4KmroDo1vlk4bU=
X-Google-Smtp-Source: APiQypIV8Tr83TUItb+iy/E7Zzm9WYfwKgGxW0KAeuUGL/h1lNlCQTeY9mGh3Fzta++cgtaGx2Yrng==
X-Received: by 2002:a2e:9842:: with SMTP id e2mr8662335ljj.273.1587504625036;
        Tue, 21 Apr 2020 14:30:25 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id m5sm2969100lfb.56.2020.04.21.14.30.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 14:30:23 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id h6so12352792lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:30:23 -0700 (PDT)
X-Received: by 2002:a19:7706:: with SMTP id s6mr14928777lfc.31.1587504623199;
 Tue, 21 Apr 2020 14:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org> <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
 <20200421212347.GV2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200421212347.GV2483@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 14:30:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhpFhUV51jabGEzHN51aKTL5fbQBvNw9=3cXnO8PXs3A@mail.gmail.com>
Message-ID: <CAHk-=whhpFhUV51jabGEzHN51aKTL5fbQBvNw9=3cXnO8PXs3A@mail.gmail.com>
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Harald Arnesen <harald@skogtun.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 2:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> (not seeing the original report in the archives or my list copy)

Hmm. It was cc'd to lkml, but maybe the attached 3.2MB picture ended
up making it too big to actually make it to the list...

The picture was just the bottom of the oops - I decoded the Code:
section just to verify that yeah, it's the div instruction in
arch_scale_freq_tick, from kernel_init -> native_smp_prepapre_cpus
(the rest of the oops has scrolled off the page).

> I'm assuming it's some sort of dodgy virt setup, actual real proper
> hardware should never get here like that.

It actually looks like a native boot on a Lenovo T510i laptop to me.

Also, see

  https://lore.kernel.org/lkml/b90ba443-9b9d-481e-7ecc-d5a25816e02f@oracle.com/

where Dave Kleikamp seems to say that it happens on his Lenovo T410.

So I do think it's real, and _not_ virtualization. Please don't
dismiss it as some vmware artifact. Looks more like it's triggered by
some Lenovo Thinkpad BIOS setup issue.

                Linus
