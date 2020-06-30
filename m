Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A14020759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593504999;
	bh=+xHB9lVucHx2niSXqGbLIy1TUh7LI7CcDCWoI7xv9/Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FeLhOFC8EfxdnAsno3vjGowV3T7f/8ZfxKXrIRt+P/8QsrvRqrD7Qluu+ozhewD77
	 fPy/XNxetHpM/+CDw8in0NlPF76l4oPrhhfNCRZ8TOK7q6Cp74YPQjfgBt6ZD+h8zP
	 gsdoFguupxYoPeOqPzgiAClI9WX4Bg4EaiVSbZ4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgF3IQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:16:37 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39668 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgF3IQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:16:35 -0400
Received: by mail-ej1-f65.google.com with SMTP id w6so19595900ejq.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hko1yfUAmudr64+h8Vvsv9yxyiMyDyCQW7gtzOjfOyw=;
        b=sGUVa3Ou8h6GtBNmyibfGg7+VlBBYFyXiVhDaZxTm6gVMIpsT5TeHGtwLmO1DB3ycC
         MGAgxNk9k09L/rgDOnIHQayV5RcldMbBnFGg1xUK+/in/W04PxwkmmEIUEArAK20Au25
         ZiDyGdJgQtPxMZoFkAxwgS7KoqUvgzQeiov6RsJokYU2qYBZYvkEufBB2qkDPxPv9hx4
         96+gIQXVsqS6BKZ7LdFun+pDLnLvB3XsCvnrcekzmrdJeUrLw7lcyW7JxvNmYs5/NJvC
         VikyTXOXv5TPfxtEP0LjEa/w1AY/NJ0/PYyCgLERgpwz/fIZqHsurmwdNHGW3uNF5cxz
         KFxw==
X-Gm-Message-State: AOAM530XElYhI6n1W4I5pQgD+xt3ZGfTpE6SN2KF4++XWJI9YN2mP3Qp
        eGv4sNYxXDojgwcqhApmJNA=
X-Google-Smtp-Source: ABdhPJzuh51THrXwyTfekdCcie3/eFyVUGsVbZAlUy6KQbb5+18rK8QRUVY1MZv2JSBvm/IbR3X2Sg==
X-Received: by 2002:a17:906:ad9:: with SMTP id z25mr17291439ejf.53.1593504992761;
        Tue, 30 Jun 2020 01:16:32 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id ck6sm1121256edb.18.2020.06.30.01.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 01:16:31 -0700 (PDT)
Subject: Re: [PATCH v1 6/6] Documentation: Describe console mouse reporting
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <cover.1593499846.git.tammo.block@gmail.com>
 <ae41a64c682a2af6c8c0fbaa8d94c7b63a6f2450.1593499846.git.tammo.block@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cf6e7168-3de7-7269-9421-0275c2b29986@kernel.org>
Date:   Tue, 30 Jun 2020 10:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ae41a64c682a2af6c8c0fbaa8d94c7b63a6f2450.1593499846.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Randy who commented on v0 (you should have done it).

On 30. 06. 20, 9:12, Tammo Block wrote:
> This patch adds a description of the kernel interface(s) used for vt
> console mouse reporting and describes the protocols and bitmasks.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  .../admin-guide/console-mouse-reporting.rst   | 92 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst
> 
> diff --git a/Documentation/admin-guide/console-mouse-reporting.rst b/Documentation/admin-guide/console-mouse-reporting.rst
> new file mode 100644
> index 000000000000..11287cb233ba
> --- /dev/null
> +++ b/Documentation/admin-guide/console-mouse-reporting.rst
> @@ -0,0 +1,92 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Console Mouse Reporting
> +=======================
> +
> +A terminal may send escape sequences to enable applications to react to mouse
> +input. As the kernel does not know when to emit these events a mouse daemon
> +is needed to react to mouse movements and signal the kernel accordingly. The
> +kernel will then send an escape sequence to the application. This is called
> +mouse reporting and several types and protocols have been developed over time.
> +
> +See tiocl.h, the :manpage:`ioctl_console(2)` and :manpage:`console_codes(4)`
> +man pages and the xterm [1]_ or terminalguide [2]_ home pages for a detailed
> +list and description of the various protocols, their bit layout as well as
> +their limitations.
> +
> +Events and formats
> +++++++++++++++++++
> +
> +A linux console keeps state about two different aspects of mouse reporting,
> +the kind of **events** to be reported and the **format** to send to userspace.
> +
> +A mouse daemon can check which kind of mouse events a clients wants to be

client

> +informed about via the TIOCLINUX ioctl, using the TIOCL_GETMOUSEREPORTING
> +subcall. The values of the supported event classes (9, 1000, 1002, 1003) are
> +described in tiocl.h. Based on this information the daemon is responsible
> +for not sending data packages for unrequested events.
> +
> +A userspace client may request to be informed by the kernel about one of
> +the event classes and chose one of the data formats URXVT (1005), SRG
> +(1006) or X10/X11 (default) via console escape sequences. In general all
> +of them encode similar information, only the escape sequences differ.
> +
> +See the xterm [1]_ or terminalguide [2]_ home pages for all details.
> +
> +Reports from kernel to userspace client
> ++++++++++++++++++++++++++++++++++++++++
> +
> +The requested events are sent by the kernel to userspace encoded in a

an

> +escape sequence, details depend on the chosen format. All of them use one
> +based pointer coordinates and a single byte to encode the button status.
> +
> +Short summary (we call this the SRG button format for the rest of this text):
> +
> + - 1,2 : Buttons, lower bits (see notes below)
> + - 3-5 : Modifier keys (Shift, Alt and Ctrl)
> + - 6   : Mouse movement only, no button status change
> + - 7-8 : Buttons, upper bits (for buttons 4-15)
> +
> +Reports send from daemon to kernel

sent

> +++++++++++++++++++++++++++++++++++
> +
> +A report is send by a mouse daemon to the kernel via the TIOCLINUX ioctl,

sent (Randy pointed out this one already)

> +using the TIOCL_SETSEL subcall. The coordinates are encoded zero based in
> +xs and ys, with 0,0 as upper left corner, but see note below.

I think "the" is missing twice in that sentence, but leave it as is
unless some native speaker confirms.

> +The format used by the userspace mouse daemon for button encoding is almost
> +identical to the SRG button layout decribed above and is put into the sel_mode

described

> +of the tiocl_selection struct. All bits masked in TIOCL_SELBUTTONMASK are
> +unchanged compared to the SRG button format above, the remaining three are
> +changed the following way :

no space belongs before colons, here in Europe.

> +
> +- 3,4  : Unused, must be zero. The kernel knows modifier key state anyway.
> +- 5    : Always 1, identifies mouse report / TIOCL_SELMOUSEREPORT
> +
> +Notes
> ++++++
...

thanks,
-- 
js
suse labs
