Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E84C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 00:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423EE2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 00:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1XWiS2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgFVAuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 20:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFVAuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 20:50:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DBCC061794;
        Sun, 21 Jun 2020 17:50:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d21so6510798lfb.6;
        Sun, 21 Jun 2020 17:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBt2BmfEHSKv5KEnevExVHyEchus6u1QtT1Ztdm6pos=;
        b=a1XWiS2PRwgbuoHsY63HsLZYNzxcxAaAke8mNZd3o+6BCpiGyxZMlCj3bIw589Jmoz
         BkI24ONNmQ1D4ymFJZu0TNajjWPwdMhpz9ngCVktcSGPxTjaFuDYxGng/uXaIyrreBA+
         l6ORVwivtMAE1u2j2IC1P6GELFWQq0psXXsdd36JNzVTQh+GZWLOG5Qx66vJ964DXj+d
         xcv21TkADxqNA+SU7Eqm3OCS/EISggyg0rAQIWD0qjW3aqJscHPctStvO7EkiBX1N0Zj
         Cg/mxHP51w02hLAnhm2sSEpxXqUVR0Tw2D17Nkn1r/RzTmYmWPn42rEQy0Qef11vH1MJ
         cpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBt2BmfEHSKv5KEnevExVHyEchus6u1QtT1Ztdm6pos=;
        b=GeM/ojwo/psn1PDx58EoXzS9NaZhX7EJ92ZjOgtb6vW+lefU/bM2EIZHnDyU+D1jGS
         ofmwQDpTU1dp8r4qGj0E2dtyNlE0reZZ0oUPoKQ8nHYSNxKM/k1upZmhr2ATUXz+HEZx
         HGhB2O30KCk0chbmKRFleIZxcgDnrSZCiRAuUlika0PWDiW97zwXgCwTqOZ+Fa+9093E
         weAcFXB7OdvCezYYOs4pLVCE1ZsJ2GhGi8fXMwh9reR5FQKWHRqlMo6YTVzyrtxIWl88
         8ZH1l1YM5VPvdcmeREdgjb2AZlpBZ5BQ2h4Udvf/1dU0S0ZbILi4db0C+osjscXKZLuN
         iouA==
X-Gm-Message-State: AOAM531PT0WptkHZ0wI8Aq5x0iDOIX4s03m82ZXy6H+JdiETHK3gUSbY
        s4UX8IWvMIP3Dq9whEsWDV8dVNb+ZZ/adH6PrGk=
X-Google-Smtp-Source: ABdhPJyRrZ4qxLIMj6icfHoTkq0I1TXX8y74Bhmj6/OkOYnU4EV+n3VWY90mmdSrxKJkbwJn8nl4oebKSuJ7QSNsqEY=
X-Received: by 2002:a19:48d3:: with SMTP id v202mr2744445lfa.202.1592787020211;
 Sun, 21 Jun 2020 17:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <ee99271a-6eb5-0dec-87d2-504b3ad4724d@web.de>
In-Reply-To: <ee99271a-6eb5-0dec-87d2-504b3ad4724d@web.de>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Mon, 22 Jun 2020 08:50:08 +0800
Message-ID: <CAKq8=3LaX0tWs0BfdpCYvKRRz5Cqv4cOXo1wcVvpY72cQA8RGA@mail.gmail.com>
Subject: Re: [PATCH] arch/x86: Check return value from a notify_die() call
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 10:40 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> I propose to improve the previous patch subject.
>
>
> > This is detected by Coverity scan: #CID: 1464472(CHECKED_RETURN)
> >
> > FIXES: c94082656dac7(x86: Use enum instead of literals for trap values)
>
> Is the following tag specification more appropriate?
>
> Fixes: c94082656dac7 ("x86: Use enum instead of literals for trap values")
Your description looks like more appropriate, thank you.
But I want to receive suggestions from other reviewers also. So I will
send V2 patch as your point
once got confirmed. Sorry.
>
> Regards,
> Markus
