Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C2CC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E024624654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710329;
	bh=XC5HWZChdpdyVR/sHe3gjLYY5rs5zXxK4u7OywTLHpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KLLl2uF/dpiV8lnqSNU6bCn318fEnKnFcYjO4Ui5iL58jKgHS5MC4V1VsAb4gewqs
	 uJgCrjSf8Rpt1fCLG+U9wIiPsEBdPuUovdhR81ZqdnAzUmt+Fnh+CGujXrvz/abKy5
	 7DnRI5bk9CMEyIvzS93CoGnck/fjG4m2FAYMMfGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbgBNT6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgBNT6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:58:49 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2889B24670;
        Fri, 14 Feb 2020 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710328;
        bh=XC5HWZChdpdyVR/sHe3gjLYY5rs5zXxK4u7OywTLHpE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SY15NjUO9PcKLxh7i6ZwO6NX31YVMxbMgN4ezk3OERsu210IZREbcF5B2w3hN0RwC
         ia6xMEt7nKfw8QRH0krNClFA+DXf7KMq8Kl/czVtkWG2Kt7JsBt5FoludaVoEKp48q
         /Qx6We0s8Rv02n9NrPTUFSCnpX/x29Jk1GZ04t+w=
Received: by mail-qt1-f182.google.com with SMTP id n17so7791614qtv.2;
        Fri, 14 Feb 2020 11:58:48 -0800 (PST)
X-Gm-Message-State: APjAAAVPkPL+dsvd7OtXFqP6ZobH84VutkU5Mdb2Pw5V4Auq4lpYE2uK
        MEI1WIORkYxAy645nrw1+VzT9b4JJ3b8nyNgxw==
X-Google-Smtp-Source: APXvYqwsXrnW+RM01kek/DuNdK+aWFf5bKCS1++/Ib4hvavk7926vsQnkmnIIg3GmV+0f7UWNCdv+H++sX8uLJIBQKA=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr3980294qtp.224.1581710327072;
 Fri, 14 Feb 2020 11:58:47 -0800 (PST)
MIME-Version: 1.0
References: <158166060044.9887.549561499483343724.stgit@devnote2> <158166062748.9887.15284887096084339722.stgit@devnote2>
In-Reply-To: <158166062748.9887.15284887096084339722.stgit@devnote2>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Feb 2020 13:58:35 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BDfWgGTVtppD-JEFHZRqpc00WaV2N7c6qsPBSaxOEPw@mail.gmail.com>
Message-ID: <CAL_Jsq+BDfWgGTVtppD-JEFHZRqpc00WaV2N7c6qsPBSaxOEPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] random: rng-seed source is utf-8
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
> From: Mark Salyzyn <salyzyn@android.com>
>
> commit 428826f5358c922dc378830a1717b682c0823160
> ("fdt: add support for rng-seed") makes the assumption that the data
> in rng-seed is binary, when it is typically constructed of utf-8

Typically? Why is that?

> characters which has a bitness of roughly 6 to give appropriate
> credit due for the entropy.
