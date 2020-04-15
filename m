Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AECC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE11F2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ev9CSshm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407896AbgDOCU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392934AbgDOCUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:20:12 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8B1C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:20:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i22so1863197otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YgPSbyNGvVAoCuqxUNRN4NpvxLHfZUZwSYt/tFcW1eg=;
        b=ev9CSshmpd288OI2RySLh2q2mgmSffhzS/LnOCL38PGI3ZsMqiL0rPSGgnbtmlw5EL
         NhkILugezD7xMSKBJ+PJPlDo3aYyXF1RieA0dXPDz7eQd/KzXyd30KRray7Zvb2NCK03
         YoHqTRD4A8BV+iPiReVBaXpzabySWyCuWb+NOm6ywm1NO39EFOFp9ePDBmwI8J7MkQow
         ZyIPIoai6Jm2JypvCm9HBfBehqlu/kmhUqH5YN8S6c5CRTjE9R3STlMNFCJNCbs8XE8g
         JQ2TSRlQtEWSTd1bnG0ttffyDPzTyXvqw+mqwJ9J9hZqgU53tLybMP7oJHn46lZaj5FB
         dIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YgPSbyNGvVAoCuqxUNRN4NpvxLHfZUZwSYt/tFcW1eg=;
        b=Jrfs68OAYbd672gl/X439RhAPX47pTDejHrs70aIRBF859n1NSnOIRbb0kFdp/fjfk
         DoW4o34k6F8Szyc09W3Sq+XbdBOG3WRvfbBsvstDe0GZUCn3lITd3GwMquHxgpnJRFOg
         hbw9PBKugL7KKC7qpO9EEnBtgfCp9qJHD+H95s78P7QgAd1+qZQV2wJ4g4efiQtJVhh+
         LHmZ7r2tbo3oEYzsGDvMwR/AjEOi7vH5j412L84ZPS9eUYB5VC/2Q7DiGhJcF3UFt/wp
         HHyJbHWfWvzwN7st8Li/JEZLYJUA4lrXZGRB1v24b2mGCwkDX1o1HELzKxtf67kUY2oC
         svjg==
X-Gm-Message-State: AGi0PuYRv5Ebzqunj7jvgErNQKT0HKz2kQQCmjmy0RAGNGwoXW0c0SBa
        ZUJhBmOcM3I2kE217cLGXkdcjYMxcxaZPW8S35qA3w==
X-Google-Smtp-Source: APiQypJbJVHBMOgHcTS4BGuutJMmdrlcohkCbUpyNWvmKFjsa0z87Ut3vCJXMeOUxLX1dxAeBEhNt3o7rl9Rl5rMcE4=
X-Received: by 2002:a9d:3988:: with SMTP id y8mr11164280otb.352.1586917212201;
 Tue, 14 Apr 2020 19:20:12 -0700 (PDT)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 14 Apr 2020 19:20:01 -0700
Message-ID: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
Subject: On trace_*_rcuidle functions in modules
To:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,
  So recently I was looking at converting some drivers to be loadable
modules instead of built-in only, and one of my patches just landed in
-next and started getting build error reports.

It ends up, recently in the merge window, the driver I was converting
to module switched a trace_*() function to trace_*_rcuidle() to fix a
bug.  Now when building as a module, if tracing is configured on, it
can't seem to find the trace_*_rcuidle() symbol.

This is because, as you are aware, we don't declare trace_*_rcuidle
functions in modules - and haven't for quite some time:
  https://lore.kernel.org/lkml/20120905062306.GA14756@leaf/

I wanted to better understand the background rationale for that patch,
to understand if not exporting the rcu_idle_exit and rcu_idle_enter,
calls was because they weren't used or if it was a more intentional
decision to avoid allowing modules to use them.

Would it be reasonable to revisit that patch? Or is there some
recommended alternative solution?

thanks
-john
