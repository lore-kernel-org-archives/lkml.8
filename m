Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDD7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE779206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1TD+V2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFBNq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:46:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBBDC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 06:46:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q25so3223385wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qSTMEdvjk3TF6RfwsS1dypnjhMY3GyU5XrIVPs/JS5Y=;
        b=Y1TD+V2YHn6cONPIQz2HtNHu42aROGvx5fTK74Y/eXE/BpTSFPKO97aZAU+6LAcDD2
         9eGLijRbtxLbjqHPVYMtMMWMCX4L71GKSR/D3vk3ONBGn0ZuUSYzaZzOPzUwhVTfkdyL
         m9kqQJBKc26Wx6iXh0OJu4ne5z3abM4GnbYFvR4NRbx7c5ilsNggcNXt0gP1y8QDdcY+
         C4HHl3457Vo4dPJ7/dl2BbymecQiJdYL0NvVKWjpfH44stka49Jtgv9CbYEqOhKxBIPb
         SV8zjJVZ8Mqi35YB5QHQJC65BR7b/m7AAL8BMfG4q8jE/a/1tygDsEeYknjTIy5ZB8n2
         sl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qSTMEdvjk3TF6RfwsS1dypnjhMY3GyU5XrIVPs/JS5Y=;
        b=UTWlBB3AHtE7fO4/UmQTiLf+kk+1aJT32omcYlifWDHfIl0Ym9fPmDOxZLcZxGe+V0
         BBOQ5dPSTNtEJnE9Iwo0oOn5kIF3cGm7KhumStHh9u0IRy1RLkH3ktDEEFQFUGj5I2nY
         3IeyQsww/J1LhFIIivrskitZsK6xo9nvksnd/C3K+gl2aIjg0P5kXXSMd8eDPLZRFVJn
         J3TSrbMJf0W+fSNf0ApDB1Wg/ur8FjF3zAPISYjHEYv+bVuseVRmYdgIQHf5mOizIfy1
         +0UaaYWyreystfNoAUbu3zRcwMcLnTzHe6UHBIkbT/YrQvUMhSSALANqaJ7X17nJKIO/
         HyWQ==
X-Gm-Message-State: AOAM530brsiG+XJ78uVzWNrv8+Nljs67ESOJkPqB1V/JoSqH8pEmuoLY
        95rbQhZpMT1nxnD0vbD0UZWVIg==
X-Google-Smtp-Source: ABdhPJyjTmzSO2w5j42gGxx21vuAkkZvWzGoUQv7gnIV0Xj7BY0fEtNOZY9l9pz9e+Qlxp8caIOedg==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr4170692wmb.119.1591105613992;
        Tue, 02 Jun 2020 06:46:53 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d13sm3407055wmb.39.2020.06.02.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:46:52 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:46:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] kdb: Switch to use safer dbg_io_ops over console
 APIs
Message-ID: <20200602134650.mdovxoa6cj2hgvei@holly.lan>
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
 <1590751607-29676-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590751607-29676-5-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 04:56:47PM +0530, Sumit Garg wrote:
> In kgdb context, calling console handlers aren't safe due to locks used
> in those handlers which could in turn lead to a deadlock. Although, using
> oops_in_progress increases the chance to bypass locks in most console
> handlers but it might not be sufficient enough in case a console uses
> more locks (VT/TTY is good example).
> 
> Currently when a driver provides both polling I/O and a console then kdb
> will output using the console. We can increase robustness by using the
> currently active polling I/O driver (which should be lockless) instead
> of the corresponding console. For several common cases (e.g. an
> embedded system with a single serial port that is used both for console
> output and debugger I/O) this will result in no console handler being
> used.
> 
> In order to achieve this we need to reverse the order of preference to
> use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> store "struct console" that represents debugger I/O in dbg_io_ops and
> while emitting kdb messages, skip console that matches dbg_io_ops
> console in order to avoid duplicate messages. After this change,
> "is_console" param becomes redundant and hence removed.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Looking good, only one minor comment left on my side (including the
three patches prior).

> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9e5a40d..5e00bc8 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -560,12 +560,14 @@ static void kdb_msg_write(char *msg, int msg_len)
>  	if (msg_len == 0)
>  		return;
>  
> -	if (dbg_io_ops && !dbg_io_ops->is_console)
> +	if (dbg_io_ops)
>  		kdb_io_write(msg, msg_len);

Since this now slots on so cleanly and there are not multiple calls
to kdb_io_write() then I think perhaps factoring this out into its
own function (in patch 1) is no long necessary. The character write
loop can go directly into this function.


Daniel.
