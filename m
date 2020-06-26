Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD37C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834D720775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593169206;
	bh=NPMluDUS2B2Tb9RCJ567AWqohNWdAj5Y+Lfkbjs8aQY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Nvk9qZrN6kUCxG+1U+nMXcUU1s5632mYpR+YpZZpH+zKajWLWyAMKZ85xIYUJNwKj
	 2h0iONK3OwrbtN9O0gilrM5HwurCLB2B8zaNT+sGNktgVIx+BePuvXReWZgCsq/Js9
	 rKS96twD83VZxbK0DdCXswCaWp7oZvjm0g1fZBqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFZLAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:00:05 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:38116 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgFZLAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:00:04 -0400
Received: by mail-ej1-f67.google.com with SMTP id w16so8943908ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=18aTf3KZmsRbEv2hKvnfZvOhTd+7S+HPU3hrOMCQTuE=;
        b=KXmVHJEP5iB9y1QlXvw6xhMF9EBaMGou0C6uLbEhxlsRMRiUnPwmasWXQ7X9IbeJ3+
         u5Qb134I9A7HO2AwdPBZVqmivLCwF0prZVxjvPlUdF8MuMQkJZ6u013G0qTxXGuPai8Y
         /UxTg2JP8TsOlkF5I1cK0yxgI0jP5LZb6sNh6jAZRz/zG0YUQOLRVxuDUSIRjMKtuhX/
         d8NCSFFPHfKPTPffW/YrNBoh3xqxTHUnmXGpZgJf5NrIr4P2Lp+9T+eR6+XNlrdwu+jc
         mMgmK9p8WFx+E1np+RK3SnMCdLVCKkeyHanpI3iyjEf6EDpzg+UgDMQlBTtyuoVSUQ+S
         uehw==
X-Gm-Message-State: AOAM532Ym+Wjd8pynU0s6N9BdX2t4PErk+CwSoQ80FufzHbUntLniVX/
        jXNYxLlYtFxqNYquJRoEN+oHA/Udn/4=
X-Google-Smtp-Source: ABdhPJwcW4Hr4hmup9134Rg45L/IsR6JWotS/43dXtQHWjlls093+z752ZyemDZNCTkJglg5d3arhA==
X-Received: by 2002:a17:906:7a46:: with SMTP id i6mr1922010ejo.475.1593169202670;
        Fri, 26 Jun 2020 04:00:02 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id y2sm2524766eda.85.2020.06.26.04.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 04:00:01 -0700 (PDT)
Subject: Re: [PATCH v0 5/5] Add Documentation for console mouse reporting
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1593155911.git.tammo.block@gmail.com>
 <1eb8c1220ad8315a05ed55a54c54e163029467f1.1593155911.git.tammo.block@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e315288d-0940-14fc-0de1-a827bf8aa3bd@kernel.org>
Date:   Fri, 26 Jun 2020 13:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1eb8c1220ad8315a05ed55a54c54e163029467f1.1593155911.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 06. 20, 9:23, Tammo Block wrote:
> This patch adds a description of the kernel interface(s) used for mouse
> reporting and compares the old and new bitmask layout.

<irony>
Documentation for the vt code? Phew.
</irony>

Thanks for doing this.

> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  .../admin-guide/console-mouse-reporting.rst   | 82 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst
> 
> diff --git a/Documentation/admin-guide/console-mouse-reporting.rst b/Documentation/admin-guide/console-mouse-reporting.rst
> new file mode 100644
> index 000000000000..799288295655
> --- /dev/null
> +++ b/Documentation/admin-guide/console-mouse-reporting.rst
...
> +SRG protocol
> +++++++++++++
> +
> +For the SRG style protocol (xterm style, DECSET 1005 *is* set) the upper 11
> +bits of sel_mode are used like this:
> +
> +- 6    : Always 1, identifies SRG protocol / TIOCL_SELSRGREPORT
> +- 7    : Unused, should be 0. Ignored by kernel (future extensions)
> +- 8    : Set on button release events / TIOCL_SELSRGRELEASE
> +- 9-16 : The SRG byte, send to userspace as is / TIOCL_SELSRGMASK

To me -- a non-native -- it looks like s/send/sent/?

> +The SRG (upper) byte
> +++++++++++++++++++++
> +
> +The layout of the *upper byte* ("SRG") is identical to the SRG data layout,
> +for protocol "1005", as described in detail in the xterm [1]_ or
> +terminalguide [2]_ home pages. Short summary:
> +
> + - 1,2 : Buttons, lower bits (see notes below)
> + - 3-5 : Modifier keys (Shift, Alt and Ctrl)
> + - 6   : Mouse movement only, no button status change
> + - 7-8 : Buttons, upper bits (for buttons 4-15)
> +
> +Notes
> ++++++
> +
> +Button numbers are encoded like this:
> +
> +- 0-2  : Left, middle and right button
> +- 3    : No button pressed / Button release
> +- 4-15 : More buttons, e.g. 4 and 5 are scroll wheel
> +
> +Please note that button releases should only be reported for buttons 0-2.
> +
> +Also note that coordinates (xs,ys,xe,ye) are zero based for the TIOCL_SETSEL
> +syscall but one based for the escape sequences send by the kernel, so the

again "sent".

thanks,
-- 
js
suse labs
