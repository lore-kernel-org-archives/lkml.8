Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE96C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7556D207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="diMqmdWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgESS15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgESS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:27:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E9DC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:27:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d3so246366pln.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYhYvn46e/4SmfmVVbZOq3r5oEKfrjVdnN/U9wz4NtY=;
        b=diMqmdWQ0qSMkp9euf6IGqcO8VzRvq0vOJY26a1wQ5Q8T/huOrpQE0gd6Ko7mlQmCM
         RYUjZqut0yYI6BG9dGiYopn7GCLIpO4F540x9+dcHcfT4ZhgrSPNJ2FyiIX9KBoAii2Y
         chvdiDdXI9/bVqduNh/8dHrLs1iQVkGJhhmbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYhYvn46e/4SmfmVVbZOq3r5oEKfrjVdnN/U9wz4NtY=;
        b=fr8Im0GPwiw0D6Pt4Sg1QSqhT8UvMLQYjK4bzvUryK/s68YMyvKDQVJ3fzIDD7JzQJ
         ZvjkWv0heAjEGeymc5pdy0mUT6w3Y4/sYvvOjnDfThMJTtycZHFHW4jwki2AHl/jGuyY
         RRFVBWfIOhJvF0Pp95zztiemzvXX3ER/Fnbopxw/xOCHwZJbLLkveZ0YWOe3wFJuViRw
         HYUxqrOAWhLu5kqGfLsiozG/Jp3FgQ17MaccEEMstbuRBnsAr8ecB/1NbQoTXjDmrGT+
         M2JMk8pljQhsXYb5PKlISJIJEh1+w4sMQwLvSm6wadaiCIOdpX8YTmqEpl4jMv++PNuo
         wBRA==
X-Gm-Message-State: AOAM531clHnIMkSgjtm3CF/OMiLWoF1Uf5Sytx844KJgW34lRl4dthXn
        FaJ29u2Bg+PEYPKkFcBMLfr50A==
X-Google-Smtp-Source: ABdhPJwaMTz8VrJTiETmULOC2bj+5LoutuSFETDCsFxyIxYRNBzPP4NYcHiEs4ivLHsqq7MQflRUMw==
X-Received: by 2002:a17:90a:8b84:: with SMTP id z4mr954246pjn.86.1589912873632;
        Tue, 19 May 2020 11:27:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a27sm146456pgn.62.2020.05.19.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:27:52 -0700 (PDT)
Date:   Tue, 19 May 2020 11:27:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 5/8] exec: Move the call of prepare_binprm into
 search_binary_handler
Message-ID: <202005191127.E9F66F9E88@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87d070zrvx.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d070zrvx.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 07:32:18PM -0500, Eric W. Biederman wrote:
> 
> The code in prepare_binary_handler needs to be run every time
> search_binary_handler is called so move the call into search_binary_handler
> itself to make the code simpler and easier to understand.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
