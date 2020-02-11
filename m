Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5815C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798B220838
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581386049;
	bh=JaiYmc+yaVMUPdk2p8ozUNz4geF4tcPMuM0mMHX4WpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=09rztXIwWANEeaoVe7aKt7m3KuZEuIy5w1Jq0GxzNbRB7ciic9T2j5UYBE8Xs3/aQ
	 FTT3LqjjnHl1+TXSQsGdtF4j/UIqUYU+QMBODtg/28UlHnKWCD8gOfEwp6RfIsyywH
	 YdeuR4HIecJ2jzkwJyHH/epoKucc5MSFOTauqjlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgBKBwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 20:52:04 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36865 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgBKBwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:52:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so5799197lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 17:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCLotiA/8gZdYFx7pzp6l6JRsUzdkxjw1MIKACjKDDE=;
        b=gE3blOQ60heY7R5Seu+lD0bGhcXgdKp1C3sGRKJ2XuJfXP7+myASE/B+e7of+d8Jqt
         Xfbb2WrblrANuP3AWlcydqAgT5jQWGcj6/1Z2dE5uzYAwxRrKeAByR48GoWnlPkVN+iO
         UjXz6X5IK/cz1Mj3+t5zR6/ffTJZWtV9mH5Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCLotiA/8gZdYFx7pzp6l6JRsUzdkxjw1MIKACjKDDE=;
        b=HHVJpDYicOSFiJ2g6E0iOn9T29U16WoyM2YQ3K1ljQt0yUzplnB+7fbKUMzm2HqNPa
         4mv9jA3f1Aa0jPVYsGDw0va2QU6gxiWAyeKnZzFmxM77ivbL40fNUjSgNPGFoWVm0MCj
         7e7T1fB+OEJVsaihM2mcX2CmEFi+QjmFqp7MapiR8LsSUCdXXFzglpc8BQ1FiV3WkvFd
         L6Vc2c0QyJj6lMeyji0QyU7c7RPJ/7SZOhJjUcbbPSdLzRkhl/NUsep0sd5sm9veBTMv
         bR7Isytcza0kon158KTrDWz/5ZusqVaog86O3mNLOw1TNUHX6jTF/4lGDjgWHT5CtZDZ
         1xJA==
X-Gm-Message-State: APjAAAWAsv6M9uMvyeuq3eOCsuUh/iRzHQhfTaDmRvPGVcsaMpBJv41Y
        Yn/fEQbRfpnNuJViqaHVB8eEJpRjXHM=
X-Google-Smtp-Source: APXvYqyVsgocpf3MJDSKi+XPO9dVviOJ4gud66+nVu/GcwSRBzLVgVeKju7ozIZ9B/GfQuxgacsloQ==
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr2187714lfk.175.1581385921369;
        Mon, 10 Feb 2020 17:52:01 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id l28sm887996lfk.21.2020.02.10.17.52.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 17:52:00 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id b15so5799162lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 17:52:00 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr2256698lfa.30.1581385919816;
 Mon, 10 Feb 2020 17:51:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581359535.git.jpoimboe@redhat.com> <7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com>
In-Reply-To: <7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Feb 2020 17:51:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgN0RtGNnYHjnaxtjO3BxL=t-nTUnEEwZu5J--BDhb95A@mail.gmail.com>
Message-ID: <CAHk-=wgN0RtGNnYHjnaxtjO3BxL=t-nTUnEEwZu5J--BDhb95A@mail.gmail.com>
Subject: Re: [PATCH 3/3] objtool: Add relocation check for alternative sections
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:33 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> So disallow relocations in alternative code, except where the x86 arch
> code allows it.

LGTM. Did this actually find anything? And if not, did you verify that
it would by intentionally creating a bad alternative (perhaps the
broken one from my patch?)

                Linus
