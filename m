Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98059C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8CC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU0txn6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCWSyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:54:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36230 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgCWSyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:54:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id l23so4453848otf.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eYdwCoi6+B7cT6vKJP6cIiqR5gdPu2kksP52cVJiUw=;
        b=KU0txn6TzYAgt7T8VRBLMC/zjpm9DnpqDJ7hEq/vbbz1U/hmry/tlxh9L8nUrv0CG/
         DpgPHe6jULzNlPYwgvfgIukRiDi3wfLFjR1eZgKcMzd/A+ZPutN9Yv8Am0HTiqeNO/33
         JQlEiasIDaQsSFi4BlagPMpgfxidwpB9ClXerRo0rAHeav4fDAlkedjKK6HdTiHCkN3T
         m9rXSscuXl0/lWTdYKRo2IC2qooN1QKXuEhy71wbw/+ptcI/GoqTxZCRSmfseNGfmzFX
         G9RKj8ticka+T2v5qNpm4xzUXtekIuzhUkORb15A/ETJTLUFl7fs7c9zviI1alovGQIG
         AHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eYdwCoi6+B7cT6vKJP6cIiqR5gdPu2kksP52cVJiUw=;
        b=U1TTD24MBTPslHxp1MoZkOBFlxkUbeBbjg1BaI77YWDOBKGPzdRJ7a4J+POAUyqVjf
         S2hzMoTOzxXH+ejV++DaIPWf61h/EwzeiNeS0nIt5EoO7OwrmVaJ6ex858/xBLSZNT5K
         /BgNVQ+o4t47keznG25owXVJuM2Ux3aJGbaWNss7aOLPjWlckgmtUZ2k2QXrstKXrq+b
         KgB76M7fPFkX+DeLzA9iHdoPMroULEmrVpRupBIdGatHOM4mqYj4InF4yACITQrXyE8D
         mDhnNo060fHFWqhBTLqC8k5RXxnnENQ6AvS2Ws1QllXHpsNOA+/0LwzX3pUkKgW0lOFw
         HrgA==
X-Gm-Message-State: ANhLgQ2He9wqPndAmFRlRmJtQ55mrZOksOr95tlV94DtkRq2oM8O6pv5
        KS2hZ/MzDRutUsK3ByxnoBVikU6yniiXzMuJ517h6Swq
X-Google-Smtp-Source: ADFU+vtZYEu68/qkiuqT3SFCjpvlqQrvZz3oPJFJE7gxuGyy43i+Hi9BaTSOSnupgqOxR/Cxt0N423Bd7bA/zqb5ikc=
X-Received: by 2002:a9d:414:: with SMTP id 20mr19645047otc.300.1584989679880;
 Mon, 23 Mar 2020 11:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
 <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com>
In-Reply-To: <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Mon, 23 Mar 2020 11:54:28 -0700
Message-ID: <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 11:19 AM <hpa@zytor.com> wrote:
> Pointing to any number of memory chunks via setup_data works and doesn't need to be exposed to the user, but I guess the above is reasonable.

so, good to go?

>
> *However*, I would also suggest adding "initrdmem=" across architectures that doesn't have the ambiguity.

agreed. I can look at doing that next.

ron
