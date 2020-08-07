Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A29FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A4922D01
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JpfLO58D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHGAWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHGAWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:22:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F7C06179F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 17:22:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so7587283wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrwX/wfFzmOB6yLRhb7qEWgDu6TEjOMw7c5SuWROcuA=;
        b=JpfLO58DHRpIaearkFKOnrfvqBCUl0RamhydiUAyJKHTIjLYcYkw7jHOswLhEnvlz+
         42rMjdrWtq1srri4CwkYJOOZqz9/+yBOurDBNaTXbUNL7sGwOZSau9gPNwqlyl1D/7TE
         o5VG1NlGwBD81xYZqfeyR2hIsZ7Qv7Lk4Sk5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrwX/wfFzmOB6yLRhb7qEWgDu6TEjOMw7c5SuWROcuA=;
        b=mh+iCxAeT/oDLUaR5Bppl5F8L5SmOqTfu3fDIWM1L2JrufDbWOd11fwcvc8xvzzkLF
         GHROVnX3MobtfDAGH97AXfkLHxEumeWbGZgNNc+8w1OahmDi1J1EKziLskd6XiY5wNBs
         4jwgRpqepSKR0/mTemTECzueH/O+/K/hT3eNjv9+5AGOIhYuj0RJmrD1yRPxh7Tb2vfe
         34YAdVOtcezS9+exp3zSRY4RbnXvWBxTv5o4yDC3GoqC3XzGjOvnGpmDUUaKV9pA11Bv
         Wn47BTIl66FMuFwm9X0znNcqVs+LwBixw0naj2uHGWU6i1voMFckxI39K9gEbwN9cpa2
         auTw==
X-Gm-Message-State: AOAM531ejGb8OTDIhPRYi8s3vg56KDnscDn/ZWVq9RXAsC/R0NE6WF6o
        9MbV+8kDD78d+Ciw9dzQkX6XBMIANhmKBVP2CDEgRQ==
X-Google-Smtp-Source: ABdhPJz2CSFYHBHps5lsYSSXi4LmfIaF9F6g3gv7J9WuzjjQKkuYj3RGkVMthT3YMgBgze8VgIBd8JCNOrPtY+ZUvC4=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr10198939wmj.56.1596759760832;
 Thu, 06 Aug 2020 17:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200729175845.1745471-1-keescook@chromium.org>
 <20200729175845.1745471-12-keescook@chromium.org> <20200805145342.GA22100@linux-8ccs>
In-Reply-To: <20200805145342.GA22100@linux-8ccs>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 7 Aug 2020 02:22:30 +0200
Message-ID: <CACYkzJ6dbUPydbg+HVt3toAPhgZAFut5Wt5OVckWMrKuPZ0ibw@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] module: Call security_kernel_post_load_data()
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        linux-efi@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:53 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Kees Cook [29/07/20 10:58 -0700]:
> >Now that there is an API for checking loaded contents for modules
> >loaded without a file, call into the LSM hooks.
> >
> >Cc: Jessica Yu <jeyu@kernel.org>
> >Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!

Reviewed-by: KP Singh <kpsingh@google.com>
