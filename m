Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B1C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C31C21473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTprQ7oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDSU5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:57:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB4C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:57:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so1516991pjw.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=10wHTDV3Jlt1o/4dM6dKNqfxFvNQyp03MchNiw6CNvI=;
        b=TTprQ7oF/qr5O2gY14ssBc2+YX0kYmNBCkX9t9k5Uq4nsNokKXIS5fzrJe4g6NsyQz
         YhSafGLhKFFbMSh8I2ktuQUDCQkK3I3OHZ/xxc4M+aXrAhGVpN4vIHZgAVXDeE8gLsCw
         p3gjJSNN4nS0O7kA6uiDNiTWRv8LX20XqeqhB08GTal/OjZtuPJaP6xhhUa3+J9FHo2s
         l20AYfXAnRWzxfhdbCDaWlrhW5MfQrC97rV+o06IkU8NdDv9+zfPzi8DOD92SixLOnh1
         VliQwl98W3bQpSzR6lPJKIqznYz9irARgmH33uGvHy0/S7fdRCMQYTYIMaZ5DjkiwlAW
         i7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=10wHTDV3Jlt1o/4dM6dKNqfxFvNQyp03MchNiw6CNvI=;
        b=KopJZwDrekAKbK26tbkK3lQv9JKkZSc8bldcl6onlio10irtdph9NZvqZLIi41yX0u
         Sl5O/FbT91Uv7pUSGq0umYJZSuo7YCHaO5FYjOZ4QslNTaA18JLgpslkOIg2BvIXlGUc
         DxCb6MscsbussE/hA8S46xfwcpft9itK4jY94NzCJrcm042qsUM3ZgdkEKzAHXvoWi+Q
         OaHzbvm54gMkzNWLIWzl3Ok+694d3NDoXqcxMwxXklyQWyQWHhXH3PVHnHCAkwti97Io
         4J7c95lTrzv7w85AOaaCzHvJLYBKXTXZBO8iL9fBJKbIxjM4+XeLioFjeoboRIbwQP94
         pl5w==
X-Gm-Message-State: AGi0Pubm3P8KY+79H2I+DCxY92a+hxKeNeLqtRGsOC7drdVZepgwgbKb
        SRGToruJrl5rv8ptbO3EnBI=
X-Google-Smtp-Source: APiQypJgkj5uU6XdvfpScoUbQerW8YThuQLYzrYHEdzNUz6J+baBEOVak35iML5kobr1tIWTj4SMsQ==
X-Received: by 2002:a17:90a:266c:: with SMTP id l99mr16058863pje.186.1587329851021;
        Sun, 19 Apr 2020 13:57:31 -0700 (PDT)
Received: from localhost (g19.222-224-154.ppp.wakwak.ne.jp. [222.224.154.19])
        by smtp.gmail.com with ESMTPSA id p8sm12089663pjd.10.2020.04.19.13.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 13:57:30 -0700 (PDT)
Date:   Mon, 20 Apr 2020 05:57:28 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCHv3 24/50] openrisc: Add show_stack_loglvl()
Message-ID: <20200419205728.GT7926@lianli.shorne-pla.net>
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-25-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418201944.482088-25-dima@arista.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 09:19:18PM +0100, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with

Instead of realization I would say "Implementation".

> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Introduce show_stack_loglvl(), that eventually will substitute
> show_stack().

Will you do the work to replace show_stack(), when is that planned?

Other than that small comment this looks fine.

Acked-by: Stafford Horne <shorne@gmail.com>


> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: openrisc@lists.librecores.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
