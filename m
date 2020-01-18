Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B5C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A48724683
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8AORjqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgARUlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:41:37 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:47040 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgARUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:41:37 -0500
Received: by mail-oi1-f169.google.com with SMTP id 13so25334370oij.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoflbrywHown98SWqX2OQZb8P7vOFu8Bc1hY/Ui+HR0=;
        b=n8AORjqh7ykx52tB6IqrWvYbz/n7Zlq8YOB8ciNtlGuiCjfK7FTUbfx/WV/JUE1rNg
         WmSCLVUxYcAFkQZRkMkt81uYhRag/Z1ojsNnOBnCPxtxLxTu6OWxPY5JDzryM+c0opv2
         U0o9M4fTP3EMX9aenpWjuWq53zgOROz0FNBQvapav808gjdXruHTP89k8U+RnZhrYFKv
         UCPff61/k1qeD90NkPn3jg1kzuTxDwWDSX2dih3Vkd3LAK1UyLGchdUUUDzBg1kVrhg4
         Jx6yTonVT0PImPuTqhe+7gOV+88Y0guJT2m7Permck58ENR3yxMNgmtOmcijAgGmG0D7
         9Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoflbrywHown98SWqX2OQZb8P7vOFu8Bc1hY/Ui+HR0=;
        b=H8APdawWFy7hIRquX51ePUDjKbp9xNiuOVZAtqS0dX3+tcHG+/dsI7575U04S25px1
         5DsqS22r3Clt0viH33m+eoCvjjxEKqtyir1JzP3GuAUpuEx33mQ9ZcuySsaxVu8orTep
         BpRzb4/Yo9p79GhAkXXgVEdxuGivECkbn1QUCb+2fuKzarhWIGO1KGpOx23QgMjB4pDz
         KzFuQl8UFh5Q5lvG4hm38zw9GvK1Y716kLXFfadHRaUufT8nKDpoH5WybOxclOengJfN
         MVTKhNUR66qKmDNgdNJldSM273Kwi9HZgutDKwlotRDjB+m3MLJRM+1TrQBHkuAXEzSH
         diNQ==
X-Gm-Message-State: APjAAAWjqy/b6k22KXdtNZA11Zaq5XeurPf9z7UsPOSoQpIpco0lzZzQ
        QnDEcl13sKkIs7SdLjZC7X9fUe0+cRlEZKx/yi8=
X-Google-Smtp-Source: APXvYqzg1DUMI68fosRLxBDZaaz8DC8M0AVaUR2Wb1UqW/ioYcLj1utIT/Ioiv5/wu9oO0hB4RZ7p6ZZAhT58bxtI70=
X-Received: by 2002:aca:6545:: with SMTP id j5mr8388440oiw.60.1579380096142;
 Sat, 18 Jan 2020 12:41:36 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
 <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com>
 <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com> <CAMArcTUJ=Nemq=hsEeOzc-hOU4bPOKq_Xa1ECGDk4ceZHzhGVw@mail.gmail.com>
In-Reply-To: <CAMArcTUJ=Nemq=hsEeOzc-hOU4bPOKq_Xa1ECGDk4ceZHzhGVw@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 18 Jan 2020 12:41:25 -0800
Message-ID: <CAM_iQpU+d4bbtN_oE+G0CaWmeSbBEyS1Wuc7s1vK36gGrcYzjQ@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 7:09 AM Taehee Yoo <ap420073@gmail.com> wrote:
> Yes, I fully agree with this.
> If we calculate the subclass for lock_nested() very well, I think we
> might use static lockdep key for addr_list_lock_key too. I think
> "dev->upper_level" and "dev->lower_level" might be used as subclass.
> These values are updated recursively in master/nomaster operation.

Great! I will think about this too. At least I will remove the other keys
for net-next.

Thanks.
