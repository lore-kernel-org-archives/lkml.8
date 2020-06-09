Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E002072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbF9ur/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgFIWSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgFIWSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:18:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F9C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 15:18:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id n11so206421qkn.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 15:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=dSfyjxwZ2gcnTTBhIxqYXNNn0wELjQoWIt+uyxpVh5U=;
        b=VbF9ur/9Ok1mT/YbwK08vFQPu3/bpmsjAEn1AvD85PQPgyQpM9G2L6Ci+pBjRipoIW
         7jwARGG5tqQHRrqyHMDP/z+4SkcCzHhONRtgkP2CNhkHqt0iOo211XuKm8ldKHRk+MBK
         /kp6Av7i5+4738aq03DSV1vIllvcs+5PLdSMVRGeUuyulxHr9GeMoWVyEjefKifU+Lqp
         zuqEDncw4lW58a3NG6tKvGyhASYS2mz2uIzFIYUKBzT2Xobv2igGIn9qhU/Yk7d/Rewo
         Nbl61d8z/EflUBnejp3D5KIskd3dKR7EdjC3zgE/7ZxEQJyACNj0jM92XjgR0ZraKzVY
         PNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=dSfyjxwZ2gcnTTBhIxqYXNNn0wELjQoWIt+uyxpVh5U=;
        b=b0rOoIYWtnMpEuL6u2Pl/qaxCtTSRX+9ddQFxjt0lhoJv1C+PbhDHZSbQLb5QqZ3K3
         IYGIaaanlM/2eVJLStjFvjIv5qza4ELDr4a0q/Av81bR+vYhGSvZuZfW8TQefk5YvMP6
         7eAaoe6Fped3doOBkz6TlZpvKnico+GSGAIMmHqeh/N3acXO0oZUMv08yYLxYJgSe1Nb
         HKuc96fZUo8eM25dZ5K0nnwWc/2x27zk8DPXtMQGYI+57wFy34tZZH+iyD0IKy568KhE
         D0zgXnVbu4FjjmUMBUmzRsGUrUoxXwrsyWxqPGnbzVhzRL8DAdXbdlyCqQxcl6B7ctXF
         QFyg==
X-Gm-Message-State: AOAM5321CzGwpqHUS9YyAHpsGYAUzLX5iTlEuh+gNskmHrLuvv6H2isb
        Y4/9Fu3iOZCPAHlV+3Wki6ysC30o
X-Google-Smtp-Source: ABdhPJwzKUQQ+v/+yomrBuSyR07UV0RXCRIuEdITTqeyRjRy5u6+tB+NVtZ7CJ6BTF0RZ1gUNzEooA==
X-Received: by 2002:a37:48cc:: with SMTP id v195mr131643qka.232.1591741114187;
        Tue, 09 Jun 2020 15:18:34 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id o6sm10347553qkh.28.2020.06.09.15.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:18:33 -0700 (PDT)
Date:   Tue, 9 Jun 2020 18:18:32 -0400
Message-ID: <20200609181832.GB124143@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: vim: linux-kernel: Add "fallthrough" as a keyword
In-Reply-To: <f0b213d90e0c2138bedcc4822063dde2650f787f.camel@perches.com>
References: <f0b213d90e0c2138bedcc4822063dde2650f787f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sat, 14 Mar 2020 12:08:40 -0700, Joe Perches <joe@perches.com> wrote:
> Add fallthrough as a keyword for source code highlighting as
> fallthrough was added as a pseudo-keyword macro to replace the
> various forms of switch/case /* fallthrough */ comments.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  plugin/linuxsty.vim | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
> index 18b28..44824 100644
> --- a/plugin/linuxsty.vim
> +++ b/plugin/linuxsty.vim
> @@ -69,6 +69,7 @@ function s:LinuxFormatting()
>  endfunction
>  
>  function s:LinuxKeywords()
> +    syn keyword cStatement fallthrough
>      syn keyword cOperator likely unlikely
>      syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
>      syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64
> 

I've applied the patch, sorry for the delay.

Thanks,

	Vivien
