Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC0FC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC46A2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587810319;
	bh=IYbxD6rDnCzT0DVLR78cEsG65/KLxoU5AKSHsAkOnCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cZIwtvWkgj/S/F1bXm3cHlnBMMYIiJd7YdqR+7bJNU+/zomK49bUGQjkKSg27RL8v
	 +Y0olefi5XJEvu+G8+iMGQ7yCVdPjQ6fINpW9+Txi3jmXWT13DusZoabkiXQysUSKV
	 /d/RS5Q/D5UHrUNdzRjt6iIzc1hVcgufhhG1Hl8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDYKZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726062AbgDYKZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:25:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A4DC09B04A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 03:25:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so13752683wrt.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MmQBP4V8E026I85UvyaH5GpmvHj/r/4y5r6vf11SObQ=;
        b=m/do77aA3RFy5W9uSNoXIPr8AoTdcBWsHZDqWR7chAgFAyZmCMOZV4/36FzJABh2NS
         km+ust9sXzLwnPthhSUZPtjb7m1QGH33G3GZplmLVt4IijWcgD2CGT41qxbc8LkOhb2Q
         iFyHbsGHrxBtnPLohDnFIncfosQxvmsYd7rJzIEqg6D65PVW0F2k8qTmBBHpbKd8kY/J
         DvwBO8Vi5uAxooHIPeu+zWrO9MYobFVuesKerKgnRURz8kCUATBntG9Obp9vIL7tReZ2
         83Ij/McS19OUzUBOzNjj9EesxpaOS9194puTo8DJbmKeW7wd4sQd3jPQI8pZQEu1Q7Xr
         p/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MmQBP4V8E026I85UvyaH5GpmvHj/r/4y5r6vf11SObQ=;
        b=sWPZcuxN6xZbMe3YxCsmrUKLwLDEiaS9E2R6XJPiowvIxtIGcxCUNpxPCzO6K/b6M/
         8McG6xvynBTmMIO4dFyXgInFLPeN5bpxI6CqT+dDsTbtxDGDBRFHYHfuWoCxH3WdaVD5
         CxtvATLGDFaNjy2REFepNpcc02Zse7Q7VGcN+L3LQuvg1vYGkoGc7LAMMnIecRdDQkfL
         FzqIsRjmF39SBnGimXtcDsCxe8yA2bs6lN8NKs4VFQ7CUGtVzLL/lSRVzyI8VA2Qh2Up
         0fUmqo7kLf/scMUJ3ASqm6Umbj92cu1J3IC0xn8JkEzFJruY6RaQZoc5aYaRgDfy3Wwc
         hWSA==
X-Gm-Message-State: AGi0PuZyzMzmX9NUJ9sJmVhbM72bn0tAx+jbiHhtGNABCdrQJ1l06vPV
        JuwF07kiQTiHzIxTi/gqMQY=
X-Google-Smtp-Source: APiQypJpXL2nDvsoD9Y0v4Xp9bz4s3CPV4ivb18zEyS3/jC94Qdz/Q4/kwSTbU3E1JOEXmtlNU9CcQ==
X-Received: by 2002:adf:9d83:: with SMTP id p3mr16927037wre.142.1587810315549;
        Sat, 25 Apr 2020 03:25:15 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q10sm11358449wrv.95.2020.04.25.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 03:25:14 -0700 (PDT)
Date:   Sat, 25 Apr 2020 12:25:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 00/11] ORC fixes
Message-ID: <20200425102512.GA12331@gmail.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> v2:
> - Dropped three patches which technically weren't fixes.  Will post them
>   later as part of another patch set with more improvements.
> - Removed show_iret_regs() declaration [mbenes]
> - Added Miroslav Reviewed-by, Linus Reported-by
> 
> v1 was here:
> https://lkml.kernel.org/r/cover.1584033751.git.jpoimboe@redhat.com
> 
> Jann Horn (1):
>   x86/entry/64: Fix unwind hints in rewind_stack_do_exit()
> 
> Josh Poimboeuf (9):
>   objtool: Fix stack offset tracking for indirect CFAs
>   x86/entry/64: Fix unwind hints in register clearing code
>   x86/entry/64: Fix unwind hints in kernel exit path
>   x86/entry/64: Fix unwind hints in __switch_to_asm()
>   x86/unwind/orc: Convert global variables to static
>   x86/unwind: Prevent false warnings for non-current tasks
>   x86/unwind/orc: Prevent unwinding before ORC initialization
>   x86/unwind/orc: Fix error path for bad ORC entry type
>   x86/unwind/orc: Fix premature unwind stoppage due to IRET frames
> 
> Miroslav Benes (1):
>   x86/unwind/orc: Don't skip the first frame for inactive tasks

Thanks for doing this. These ORC handling bugs IMHO look serious and 
widespread enough to warrant x86/urgent treatment, and the v2 series is 
fixes-only.

Any objections against targeting v5.7-rc3 with this, assuming that 
there's no problems found during review and it passes about a week of 
testing?

Thanks,

	Ingo
