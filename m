Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49E220674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580817270;
	bh=kaFMBzxhagSbrYS+zS3O9SbCDL4qry+IIcGowt+UL/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wWNTWwM+Te/fWpTlXIjUNWuFSrByu8peBw0UJ28TgZB3P+drSQIAedx8OGFNIvCo5
	 Z0+l6rpo7fcf3RtzHiu0Y2SWY3HAk3Xy//elN2cSmhL8ptk9m0Vq/ZbmATS9z1t3aZ
	 au9oKKNbwrOUuBnRQLAh1K7RykO+s4GEuutybktM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBDLy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:54:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44994 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgBDLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:54:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so11942818lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 03:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yX+ida8pfl0LTkmQBZ8UesmAMvaSo4x+eVGozJlhRbE=;
        b=Msx1Lk+gS6WK5KpsBIBXAZ6Q+BjDDE6D5RVC5kF4wW7nWes0L0h9qxiZNCWwdTt5Po
         1uDep+XkjiT7YMZHsV3SVf/SDiOW2mDJCF9LBQDua4wQuOpK5DYKkztX0FV1VyxuNlCz
         0nulKLN5X+CXcluOmZatBJy0rtpvm9Q2szSCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yX+ida8pfl0LTkmQBZ8UesmAMvaSo4x+eVGozJlhRbE=;
        b=OY82Cf1TM8cy0ztMF4/JKzMd4O9a5ik1iH53qK/7K6pHO8Yx3ehgwK+VcD3PBHXwS5
         RSU54URv1eVcMNstSu4e0c1J/bEsHyv0fSFmGxHAPhOv1DesZxI1Q+9RB2BAbrFMihUI
         dYfXzRsDrp2gzPFryh4WqcgCZftjtf4EKChUR2f5IliU/ytE0bcUrMUm6n0iJ86vTFkx
         khAqR8Zm9FXDUrx3yH/w7FFF37YNZayQ7OnQo7fhibWUb4ZoYM+qquDcSZheTi3xQoR2
         guP2xp/JIKUxnUApy5vAzLo16bK/DqFZZQxuHAGI3KtO0+1Xta7TrYCQJR+Uz1ozPupM
         GxZA==
X-Gm-Message-State: APjAAAV1d6X5kj35xF07wCml+0/ZUMOwubySM0dxQE2Sgf+0sSePjLz0
        s4lMNqc2RtFx7ol65NdXmyH5uKrXt1DvUg==
X-Google-Smtp-Source: APXvYqxBV8tlpplAD3oit8h967PxNOrJ7rOL1RBwEzyD3YGCQ0w/JBbMBNoN2HavHjG+y4s08sTPzQ==
X-Received: by 2002:a19:ca59:: with SMTP id h25mr14823818lfj.27.1580817266993;
        Tue, 04 Feb 2020 03:54:26 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id n23sm10341234lfa.41.2020.02.04.03.54.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 03:54:26 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id v17so18294798ljg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 03:54:25 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr17424595ljb.150.1580817265630;
 Tue, 04 Feb 2020 03:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20200204053155.127c3f1e@oasis.local.home>
In-Reply-To: <20200204053155.127c3f1e@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Feb 2020 11:54:09 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
Message-ID: <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Changes for 5.6
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 10:32 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  - Added new "bootconfig".
>    Looks for a file appended to initrd to add boot config options.
>    This has been discussed thoroughly at Linux Plumbers.
>    Very useful for adding kprobes at bootup.

Is there a way to disable this from the "real" kernel command line?

If I have problems, I want to boot with a known kernel command line
(forcing text mode etc). If the bootconfig file always gets parsed,
there's no way to do that from the bootloader (grub2, whatever)..

              Linus
