Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E528C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4737F20771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpKdtU5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441683AbgDOTNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416873AbgDOSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:52:36 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF50AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:52:34 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r25so4549409oij.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgEoSFcUV1M/U5BJXOCbG1aWzhtQRjBhec3N1YxGLos=;
        b=YpKdtU5+G5xdjFrN2oWUZKfYKJmRiTbTja7HdZ0DJLwb8VMJQlOTMlImR15gB/ZCVs
         dkQXl9glCmv6KBLGknTowh86MUzIeVOqHmsE9D5sVjllDc611/fa5RFwIKVoqWJMtf9F
         E48a4op9FB5NrhmF9IOZ7ZegKjczyKmMtGO0xhKXrVOc49+2mLv9VobHd285exEO4W+L
         E4SbXGoU+msFaoUljhEy3j7qX6adyRG72GHo4qYsAkGeXj/CRIdjS+GZ6ficbZiiy3Nl
         2E/d19RuHqA5LvDG94i/Aa58vm0ctSHrSTgrbxs40jSXdOBYK7uAflVglp5n8gC4RqHW
         9thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgEoSFcUV1M/U5BJXOCbG1aWzhtQRjBhec3N1YxGLos=;
        b=njH3+pZclGBVSs5Q7blKXU7tlulkfQN2KDWuO8Fwao6c5ES47ogia5E0m3kP0/4hW4
         M+wHoJZ6J3oBlHlsLv2xm5Y8hxABlBVAa9voo7YXD5xsxVBFnloajjypoMJTy7asqYQe
         oMO+xy3U6ODsQr4teQwlaTFbj5I7uWAR0jdkAzt4mi7/1TpuY61sQzFjS4lqKooxOTqs
         DLVK6IBg/dbQhKMz4NMX+v3wh87Zk0ggqUkusotD2NX1f1aYUCmKc9EKw6ooH9k6t1SN
         rnmAS0+j0gIIR8iyJwjtv/UfVkdL/vV/qv/W9vqikENjjfjAQZPUeZkqMGorvF3FIloU
         //DQ==
X-Gm-Message-State: AGi0PuaB9vyx9UCDrcn8oKSQ+2otD4cUwNNYhAINbZpk6/JOy61f3O9y
        nTjEY7XY7Hst6PewsmOoqbEPfOCo4HxXMZUxtOw=
X-Google-Smtp-Source: APiQypLKD51rssA/9iLGwpuMRSWyKatV2Hi5naKCQkdp8lntBt44rX87YsdJvxh5WolKAHkSn646s6uoN2dkxFTEDQs=
X-Received: by 2002:a05:6808:992:: with SMTP id a18mr526776oic.142.1586976754133;
 Wed, 15 Apr 2020 11:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <0000000000008a279405955ffd35@google.com>
In-Reply-To: <0000000000008a279405955ffd35@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 15 Apr 2020 11:52:22 -0700
Message-ID: <CAM_iQpXw8UfR9=fAspibACedOpb6SCJiL5c3=07Rmr=FpxZg-w@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/congwang/linux.git lockdep
