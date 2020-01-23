Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED97C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C8221D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PkSLtKYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAWTtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:49:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38828 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAWTtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:49:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so2026510pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:cc:from:subject:user-agent:date;
        bh=AsiBDxfR3YiAUP6+urybhWiy8mHMpvOtUZtlAgoqD+g=;
        b=PkSLtKYtYi1OcAK+7nw7vWeNOsVnqbyq+qI+VdhZDT2KFdzpC+bHz8WiajuMhK++nz
         Ne4HKz7CL/6hY12kMMKuYVLgTLGYXi95QSDNG8LX662hiyD70AgACtRdmMyb8KhIm8UR
         VUEH28tRg96g6WLiM4Q22CqJXuRA4WX19k1Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:cc:from:subject
         :user-agent:date;
        bh=AsiBDxfR3YiAUP6+urybhWiy8mHMpvOtUZtlAgoqD+g=;
        b=kobFx4MG5c/ym9Cw7ERNY9qQSP8gUqeotlcCt8iezyaJHbkZ0NlOk1+Lbmwl5juPG7
         cldUa/dr8Ql36uFDD3f9u5fhIZDT/TeEG25oZWCTlgmTsjrWZr5GrgmZ8OzGB5+6EL2Q
         Eh3cAW4LVLUrvGqpONmDjmowGnWShyFOFtwO9OMKbNrNkIPBYeQUANuO6Vpj9Xp4gHbp
         43G2eiLFMFIlG48epa/UB8WOQOXlmjTc2ggM4833V3/DnxX9G6g0mablBxUOLr/ytOge
         6ivn9h7Bm6ANwDlqPgsf6ibIirVf3a7wbvqBpXNPtUVqPloQwGgcY1JnUTlXNjcQRSPU
         cEag==
X-Gm-Message-State: APjAAAUCEoIoNyFGcXI0qZieFREAc2zMGxual6gAoOosLnrVX3sgQdEP
        joDVny30fJaUR3i389Evk+6DwQ==
X-Google-Smtp-Source: APXvYqwVEQXX+m3S5BGhf04yLN3caID/CuWtHA4zxtFC4LRWdaqmOtdLcHFyM8Ypv9iy28HI/QH1FA==
X-Received: by 2002:aa7:9556:: with SMTP id w22mr6978147pfq.198.1579808992570;
        Thu, 23 Jan 2020 11:49:52 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e18sm3856195pjt.21.2020.01.23.11.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:49:51 -0800 (PST)
Message-ID: <5e29f8df.1c69fb81.fc97b.8df8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200123160031.9853-1-saiprakash.ranjan@codeaurora.org>
References: <20200123160031.9853-1-saiprakash.ranjan@codeaurora.org>
To:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] pstore: Fix printing of duplicate boot messages to console
User-Agent: alot/0.8.1
Date:   Thu, 23 Jan 2020 11:49:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-01-23 08:00:31)
> Since commit f92b070f2dc8 ("printk: Do not miss new messages
> when replaying the log"), CON_PRINTBUFFER flag causes the
> duplicate boot messages to be printed on the console when
> PSTORE_CONSOLE and earlycon (boot console) is enabled.
> Pstore console registers to boot console when earlycon is
> enabled during pstore_register_console as a part of ramoops
> initialization in postcore_initcall and the printk core
> checks for CON_PRINTBUFFER flag and replays the log buffer
> to registered console (in this case pstore console which
> just registered to boot console) causing duplicate messages
> to be printed. Remove the CON_PRINTBUFFER flag from pstore
> console since pstore is not concerned with the printing of
> buffer to console but with writing of the buffer to the
> backend.
>=20
> Console log with earlycon and pstore console enabled:
>=20
> [    0.008342] Console: colour dummy device 80x25
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51df805e]
> ...
> [    1.244049] hw-breakpoint: found 6 breakpoint and 4 watchpoint registe=
rs.
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51df805e]
>=20
> Fixes: f92b070f2dc8 ("printk: Do not miss new messages when replaying the=
 log")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

While I like the idea, it seems that this breaks console-ramoops by
removing all the text that is printed in the kernel log before this
console is registered. I reboot and see that
/sys/fs/pstore/console-ramoops-1 starts like this now:

	localhost ~ # cat /sys/fs/pstore/console-ramoops-0
	[    0.943472] printk: console [pstore-1] enabled

Maybe this console can be "special" and not require anything to be
printed out to visible consoles but still get the entire log contents?
Or we should just not worry about it.

