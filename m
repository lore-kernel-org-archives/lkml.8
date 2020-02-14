Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7655BC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1B424654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581688160;
	bh=gYu23xf+Hu4DRAABqOwVb9xTVhBYHrpwfJaHnLQyDeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u7RkUHLWNCUumSstcHieO7ak6vBcaOguGlemvdjFC5mVJm4PnPO0q/QhjpgexALJP
	 52D965QKxrccXMao9RgeSF9ORbQPzCZGTcoRw9YWm2fsnSbDLE0S3OC2evLY6RIxMN
	 Rza1qWYV9CcdO1nzrYplXKZXayaERTk5c4+IozdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgBNNtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgBNNtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:49:19 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4C12467C;
        Fri, 14 Feb 2020 13:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581688159;
        bh=gYu23xf+Hu4DRAABqOwVb9xTVhBYHrpwfJaHnLQyDeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bTxFD3GXmSXfB8qkRjS4FuMHSe2buN/DPdajGfSAL0WVu5H/kakrEmIGBV7ajEPPB
         rdv1UpW2wiYYCkZ2f1oQoFFDeVHX+SmNZSgMX/sn4TOFi7Tb8j3sNBFoo/tnM561CH
         1k4zRdu87/XFNYBynRyXB5p4BNohK6THBF2HrnY8=
Received: by mail-qk1-f180.google.com with SMTP id w25so9242651qki.3;
        Fri, 14 Feb 2020 05:49:18 -0800 (PST)
X-Gm-Message-State: APjAAAWXW/LjKBflkJFB0jww6U29c60t9QtCgLu98d7/a+t2Yx1BnSCH
        gTjQVasgugN31LovzB2vFYhg3wPAnUKkX67pXg==
X-Google-Smtp-Source: APXvYqxdNmLqqCUkFMynzPrM6HJXGKcPmibGkRXimZqkhhzRJJRwFWO9hDeRL4lnzpQV8xwksG0yvubmp0rVKtGd+tM=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr2656541qkg.152.1581688157914;
 Fri, 14 Feb 2020 05:49:17 -0800 (PST)
MIME-Version: 1.0
References: <158166060044.9887.549561499483343724.stgit@devnote2>
In-Reply-To: <158166060044.9887.549561499483343724.stgit@devnote2>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Feb 2020 07:49:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_VwHdpQ_WnQHu5J-bfs1vRPd5HQwVekR+5kKdVi4sXw@mail.gmail.com>
Message-ID: <CAL_JsqJ_VwHdpQ_WnQHu5J-bfs1vRPd5HQwVekR+5kKdVi4sXw@mail.gmail.com>
Subject: Re: [PATCH 0/3] random: add random.rng_seed to bootconfig entry
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Salyzyn <salyzyn@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> The following series is bootconfig based implementation of
> the rng_seed option patch originally from Mark Salyzyn.
> Note that I removed unrelated command line fixes from this
> series.

Why do we need this? There's already multiple other ways to pass
random seed and this doesn't pass the "too complex for the command
line" argument you had for needing bootconfig.

Rob
