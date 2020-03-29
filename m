Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37EBC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D0B20714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlyA4T0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgC2Vkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:40:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36716 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgC2Vkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:40:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so18860602wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgmROX3BkKzlgBc4NFWPQwQ8h8d52JCY0V2IOQ/owaI=;
        b=qlyA4T0q4+SSHWrTFaEcJlORmZU3pRQPkEvp5F/+HEtsi5tpLFRS5PID3Ae7GG+qB9
         eP2zfS+OHM2Q11dDi/UTDHU0ChOytMBfa9+3uCmWYIkyMuhuwzPJ5kTbVsd1G9NCNqDo
         BwxcGxm9qerV09Wm6ZVEyH4dyKz6Pw2xsfrLVHp2TD9JsJg4vSwsw5Kn/YrAeRE/toMR
         utWmoK9E/IGZjLiMe2sbe0FEPEjdqdF4CAc99VYUNAl/Xr7b6PyOdewihnJcIm0SLT/A
         V9YiCZZ0GEx5J0cBWsET1u7QxNv8D3ddXFUHyt8dd2w5U68Q8zNCxTpxGV6udmEonNTW
         hUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgmROX3BkKzlgBc4NFWPQwQ8h8d52JCY0V2IOQ/owaI=;
        b=r+90YYdQLjP5ed7yUZJ1U9DYhCJiJdUOTaUGQ+I5v5ofh3VPT7nIHVNNI+8H4ra7e9
         60d3bqNIJ4OYs9r5mT3Qy9KOlHG/4HXGmDbpm58qXPLu9yzrMF1oUpF7wJf935qowM+k
         LOb+Agm7nBFyWOkP2GPrT6lptnfR5N2tbg2Z4p/YKaqXscZZIalFe3svIpJsVdH9Ioe9
         KxylqoWwVx+92RQzbMjuNlQo0ZZkzY8kAg9vFa8cX/eWwuxI1Be75bdmVihcsMWpFDk2
         x+XSn/1jB4CuLyMcsa5PcLXiAr9E7zkYVMo3VoKaEj/TwAS2C4NXpts5zF0u/McS7Bxk
         MYww==
X-Gm-Message-State: ANhLgQ3Qb9goH/IYuFqlm8Rn5mgPiM9foxYLzFmF9we2lxgbBknw+cdc
        oGz//+Z0SY7gogubtzIjLVwhdHmVa1ljE7ddLUU=
X-Google-Smtp-Source: ADFU+vsa3r9uz8suX398A2w7vjHl4H5qnIB3+tO4GIRUd/dfrUpEG+GwxbUMUQtY4clxTGn7JJBDV5I/zAk8s49ys9k=
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr10858278wrs.85.1585518030514;
 Sun, 29 Mar 2020 14:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200317004507.1513370-1-krisman@collabora.com>
In-Reply-To: <20200317004507.1513370-1-krisman@collabora.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 29 Mar 2020 23:40:19 +0200
Message-ID: <CAFLxGvzGo8CPbH1NAo_d2NYHaJDZjYEELz=dufKtTwcBkZif_A@mail.gmail.com>
Subject: Re: [PATCH 0/2] fixes to the hypervisor ubd thread
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 1:45 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> While debugging a somewhat related issue, I ran into two issues I
> believe can cause the hypervisor to write garbage to the pipe.
>
> This was find by visual inspection and is only slightly tested.  It
> seems to partially some the problems my test case shows.
>
> Please, let me know what you think

Both patches make sense. Thanks for fixing, applied.

-- 
Thanks,
//richard
