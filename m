Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D258720658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kl0qMavr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgHQTYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731970AbgHQTYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:24:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761CC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:24:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so3039061pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n32LWoSrsD3yQ3rMPfKnibY9bI4SixyCGhqWBe/ljHM=;
        b=kl0qMavriKg0e81CBNLz0jae/dnxJ+iW38gvYVPjCqfQaZ+mAYzLkbyiP+bHcdJX/r
         4GaLIsElPRD0nX/WfT98jtJoPe7Y1PB20/5qoA4l7Luu2OOw/7Cf7PPJ1w11WT14NtFQ
         1t42W+NHFHCPaxa6F7e5H3S27ECjJwNGgvJrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n32LWoSrsD3yQ3rMPfKnibY9bI4SixyCGhqWBe/ljHM=;
        b=R2IDjt/H0jr6731qKtiT3GqJNAPJWz44ItDDEXGSITpjgJNgVmW6O6dgof+Wlt+xCc
         uKM0zM60OMJU/xg0nAUHl0IXH8606FWJAXdIXz9zCMsfaGz25FZzvh7S9OW3d+YVE/qE
         4IWSoyZ26gPW61CysO9bbjElo5ZMX94SR90gcR0MsGIP/JyIjVYUiuFMb+jjX3hBNZWg
         twSBiwbbFULmWdTaUwc+hBxOEJ/TeO4fC15LXSgQZEbk0UI/n9RLuMVOA9R7w14EgXZm
         hlFrQk/JBvx7JpjjJCd7NGzSMILOrJpLZloAVdPOqFl9eAVXlA9sEnrN7g8SY2ExlkAo
         hnVA==
X-Gm-Message-State: AOAM5301CSSP8soVWzgVL5uPMte/GE6ehdUkxGRw1tS8a2BlPp/xmqVx
        FAIos6oc7r98cHj76FAXgl2DRA==
X-Google-Smtp-Source: ABdhPJxCnvr7OdyyfXgIjuvAGgqlvP3yekGPuJmDIAr7WhUPsbyprRa3J1vBwlaotiAdfvEJElUFww==
X-Received: by 2002:a62:928d:: with SMTP id o135mr9014150pfd.22.1597692271280;
        Mon, 17 Aug 2020 12:24:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1sm21321974pfo.212.2020.08.17.12.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:24:30 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:24:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        notify@kernel.org, Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: [PATCH RFC 2/2] lkdtm: Add heap spraying test
Message-ID: <202008171222.3F206231E@keescook>
References: <20200813151922.1093791-1-alex.popov@linux.com>
 <20200813151922.1093791-3-alex.popov@linux.com>
 <87zh6t9llm.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh6t9llm.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 01:24:37PM -0500, Eric W. Biederman wrote:
> Alexander Popov <alex.popov@linux.com> writes:
> 
> > Add a simple test for CONFIG_SLAB_QUARANTINE.
> >
> > It performs heap spraying that aims to reallocate the recently freed heap
> > object. This technique is used for exploiting use-after-free
> > vulnerabilities in the kernel code.
> >
> > This test shows that CONFIG_SLAB_QUARANTINE breaks heap spraying
> > exploitation technique.
> >
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> 
> Why put this test in the linux kernel dump test module?
> 
> I have no problem with tests, and I may be wrong but this
> does not look like you are testing to see if heap corruption
> triggers a crash dump.  Which is what the rest of the tests
> in lkdtm are about.  Seeing if the test triggers successfully
> triggers a crash dump.

The scope of LKDTM has shifted a bit, and I'm fine with tests that
don't cause crashes as long as they're part of testing system-wide
defenses, etc. It's easier to collect similar tests together (even if
they don't break the system).

-- 
Kees Cook
