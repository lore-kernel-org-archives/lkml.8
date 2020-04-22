Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644E7C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F7206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587541518;
	bh=SFuuKuCDmUz/6+YIAohRQGbnXeuDc+lBBpM/F7qNxt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JgHRxKzr0btiSNANP/mgYm46W6lghUqIvM91aIjzi27CjAS6Cnz47vOEgRQyU9p+A
	 Z3yUduO6ai1w6qwMI5UOR7vdy1y+PDldO4QeEoSTWZ2riy9HHoLZhpx2UrIr0o5d9g
	 hAN/caFDQhQ+cmyAJrDXW0z4LPYL7jpYucicIvgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgDVHpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:45:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D993C03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:45:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so1146313wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uecPKpriXTCW3WPXlVyFe8EDCQwaAwVshvBb4/pq3A=;
        b=t41i42tG2CNYqEhd7H/1TKRPoI9NT75SIs++h2epz5duRs4XGu3vGoOAayC3SoboBg
         gqGtyiZkBBHUZHEnhp90bZM6DBEk3QnjXlVyuKaB2dEjEqQedaPTnDGJTfWDQDeK7sKf
         oozq0PyzMhrFqG5In/8aH5FWu9r1Fs0iwyAxb0HZEZvfrdMovLjTJtIEUH8/y8KS9Fm2
         BriOptl+mYVFJD05YG50HyaJtm79xACi4eJVGzocAxSBxmuctrjN+x2neUcNutYGRRr1
         ZpXale1v4XIUiCpF0TakzxlQxZ9OpYSRQha8FnAp54qGrq25lfPOW8qBg2ROEX11QcE5
         O7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uecPKpriXTCW3WPXlVyFe8EDCQwaAwVshvBb4/pq3A=;
        b=LhWGoAmuwGLHNNjO0Qfh47TBp3w14jL6yOfynXpX5/SSg7EQ8ywGMgdXf7AsWM1lSp
         JJNzmj604F00MnDEdJ7LRleUiCPQ7Cq/9G087M3lFOEnN+OG0XE0oE5IKmLzyqeLkJjH
         4J0OSBm8itG1BC+Nxlno6oFE6Kw6strvvCdM5z5ofowYkcvCFrkTkKl4GPvLaj+Qjx+N
         B5OEONVojJwC6vgnId6Alaa+3Ch9QjhHpjuX3sxqXjPwxZanYnZozach+Zjwv4QQsE5p
         ud33ezg6szCd5J7AhwqIQAHJR9pPkdcc+ij7N+YzHP+5xDSHEevzD0nEoe8GDaLcVDFp
         1M1A==
X-Gm-Message-State: AGi0Puah7MWwSy5LvB2UyhEuhIVFudg7ZxunbTvIquEJIynuwWIB8hLN
        lHPyPeOasnYYlHtUrWMS4Io=
X-Google-Smtp-Source: APiQypKEcCslVKMHhhTGvbuD7l/G5BD7dJunTIVdgXiqTxxI5vPhiW7LhpKxZFRrLnyuEcMFzZ41rA==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr8948957wmd.90.1587541515304;
        Wed, 22 Apr 2020 00:45:15 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h2sm7288127wro.9.2020.04.22.00.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 00:45:14 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:45:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200422074512.GA19309@gmail.com>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble>
 <20200420074845.GA72554@gmail.com>
 <20200420082728.GA20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420082728.GA20696@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Apr 20, 2020 at 09:48:45AM +0200, Ingo Molnar wrote:
> > Fortunately, much of what objtool does against vmlinux.o can be 
> > parallelized in a rather straightforward fashion I believe, if we build 
> > with -ffunction-sections.
> 
> So that FGKASLR is going to get us -ffunction-sections, but
> parallelizing objtool isn't going to be trivial, it's data structures
> aren't really build for that, esp. decode_instructions() which actively
> generates data.
> 
> Still, it's probably doable.

So AFAICS in the narrow code section I identified as the main overhead, 
only the instruction hash needs threading, i.e. this step:

                        hash_add(file->insn_hash, &insn->hash, insn->offset);
                        list_add_tail(&insn->list, &file->insn_list);

Objtool can still be single-threaded before and after generating the 
instruction hash.

99% of the overhead within decode_instructions() is in 
arch_decode_instruction(), which is fully thread-safe AFAICS.

So the run time of objtool could be cut in ~third on most systems.

Thanks,

	Ingo
