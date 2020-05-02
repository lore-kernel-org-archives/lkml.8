Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6982184D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aASxuV+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgEBNIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 09:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgEBNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:08:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68EEC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 06:08:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so15185198wrt.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FRw4ueRoXO+hQ6IkGlh7zfZgNzWt7O37UhFRQytFfPs=;
        b=aASxuV+umOVcQ7vMpj+gVDY+qsWNknGusCOUsELV9/dOd33gSVwnenJoVoljbHbxAl
         tY1DB4MVg6wWWtequq0Mc8w5cVKCCC0sVdSDToDDQ5eTk9rcg4t3eRMG1evknUa51JI2
         SoHzMfGxXc0U/SEqRpT57CcHcRsQudsxjVxRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FRw4ueRoXO+hQ6IkGlh7zfZgNzWt7O37UhFRQytFfPs=;
        b=sz039JdWRv5NpkSYI1nFn0GrGgCHcIt4YMKBiHwXCQAqa3Hf+/uUcLXFV/7U+9jIZw
         oDLkwC1QEAiV36nYlORQHFpJC4tD/ALqZfgKmDLrYypLIuJUkTf6BfCHZGWTWXdrh901
         khI7KiBWoeRxkNoaQ2ho1qBurchtXY2BG/GylejjpqH7UWSdgW7ojVhglfmzCf0CueWc
         6eo0rheNulQUsF9p7gFNe27v+uaoVeo3em4D4eWgocUvHqlr5lHOYx5uZoBby89pnMd6
         ikt3+oRlKppiddUQVI5Hqt1jUjRroZ0HmoiEsjkSn1eOvcAEduChgHft6umwIakP/9G3
         aw5w==
X-Gm-Message-State: AGi0PubCRVBY6CbItuIKl0FH7Q2WjXNKrSB4ISzjzKDZs4LK+N75b0N7
        IBmRkoqunDmNUgdUFFelPATWFg==
X-Google-Smtp-Source: APiQypI/Ei5aFzx5kOA21hIPcoKa3UNXIdrj1cU5PniUmhgQbn6GnQia53MexJYFg8LL9het5O8YUg==
X-Received: by 2002:adf:d0ce:: with SMTP id z14mr9871752wrh.179.1588424882718;
        Sat, 02 May 2020 06:08:02 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id d7sm9123809wrn.78.2020.05.02.06.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 06:08:02 -0700 (PDT)
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk>
Date:   Sat, 2 May 2020 15:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501202944.593400184@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2020 22.29, Peter Zijlstra wrote:
> Extend the static_call infrastructure to optimize the following common
> pattern:
> 
> 	if (func_ptr)
> 		func_ptr(args...)
> 
> +
>  #define static_call(name)	__static_call(name)
> +#define static_cond_call(name)	(void)__static_call(name)
>  
> +
>  #define static_call(name)	__static_call(name)
> +#define static_cond_call(name)	(void)__static_call(name)
>  

> +#define static_cond_call(name)						\
> +	if (STATIC_CALL_KEY(name).func)					\
> +		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
> +

This addresses neither the READ_ONCE issue nor the fact that, AFAICT,
the semantics of

  static_cond_call(foo)(i++)

will depend on CONFIG_HAVE_STATIC_CALL. Also, I'd have appreciated being
cc'ed on new revisions instead of stumbling on it by chance.

Rasmus
