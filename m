Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 12:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFC5206D7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 12:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WRNld065"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgHEMm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgHEMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 08:35:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D05C034602
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 04:39:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z14so9685875ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6TvjUnTm3Y5LiaMbBPV2mUIVgR3ziXI0s8HbjrnA5yk=;
        b=WRNld065cEQU2INXDtduGn6EF8elmKTsER82EwhljYoNVp3VZCVgEQSzoypxXJUVlP
         nh7OKnoaPuuCpwx8piX6TQkBV6EQ6HBITZ4QShW6RM/1y92PnsSbaMi/igM7Z1motf/X
         cx1ukPSYcYAbwsDcf8zVArLSQp/YF3LYAwK+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6TvjUnTm3Y5LiaMbBPV2mUIVgR3ziXI0s8HbjrnA5yk=;
        b=e66jL0mUHcx45aUbnHozLJJUeV99PoUo2KrxVkroiaDcOizpdtORETfJD4MRrj0F6F
         Uw2Tz07TtJFUu66XH+aBHPX1eNez1XsF6ylBOwWh6RC30mwzMvI/c4PHseBvldNHNFy9
         0wYJH4qH3sjvY5Ge8kcab2FxcsihcCwY40N6e57KuYOs8n+VHUgJZkyEsnoCp87Pd2tu
         sgaEWm42E2gWUT9pcbl5AxJweX4/D3LvNH/XbdjAx0vId8vmRoIAFNhYm97I92vlLPyV
         zJOyjN2onX3unVLI5a2cUTRDdEcZm0xhPALh+/xbOLKmRWADygi80SlAmOvUmmxMpHQ5
         Dsuw==
X-Gm-Message-State: AOAM5303qMTJjU1Q1a2Y7zb0THzl0d0emZmdYLZbRvGhhB52oC5vCjaN
        ktI8C1bFZARDuLbLpOOIGHuobw==
X-Google-Smtp-Source: ABdhPJwbKV6OdZO3LdU7TLVM8VV0AtWx3f65Yb5ZEHaLrSidq/l+m2qGwqla2T3OTtXmTuju7w/C5g==
X-Received: by 2002:a2e:3312:: with SMTP id d18mr1214229ljc.222.1596627540325;
        Wed, 05 Aug 2020 04:39:00 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g21sm782579ljh.103.2020.08.05.04.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 04:38:59 -0700 (PDT)
Subject: Re: [RFC] saturate check_*_overflow() output?
To:     Kees Cook <keescook@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <202008031118.36756FAD04@keescook>
 <f177a821-74a3-e868-81d3-55accfb5b161@rasmusvillemoes.dk>
 <202008041137.02D231B@keescook>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6d190601-68f1-c086-97ac-2ee1c08f5a34@rasmusvillemoes.dk>
Date:   Wed, 5 Aug 2020 13:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008041137.02D231B@keescook>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2020 21.23, Kees Cook wrote:
> On Tue, Aug 04, 2020 at 08:11:45AM +0200, Rasmus Villemoes wrote:

>> What we might do, to deal with the "caller fails to check the result",
>> is to add a
>>
>> static inline bool __must_check must_check_overflow(bool b) { return
>> unlikely(b); }
>>
>> and wrap all the final "did it overflow" results in that one - perhaps
>> also for the __builtin_* cases, I don't know if those are automatically
>> equipped with that attribute. [I also don't know if gcc propagates
>> likely/unlikely out to the caller, but it shouldn't hurt to have it
>> there and might improve code gen if it does.]
> 
> (What is the formal name for the ({ ...; return_value; }) C construct?)

https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html

> Will that work as a macro return value? If so, that's extremely useful.

Yes and no. Just wrapping the last expression in the statement
expression with my must_check_overflow(), as in

@@ -67,17 +72,18 @@
        typeof(d) __d = (d);                    \
        (void) (&__a == &__b);                  \
        (void) (&__a == __d);                   \
-       __builtin_sub_overflow(__a, __b, __d);  \
+       must_check_overflow(__builtin_sub_overflow(__a, __b, __d));     \
 })

does not appear to work. For some reason, this can't be (ab)used to
overrule the __must_check this simply:

  - kstrtoint(a, b, c);
  + ({ kstrtoint(a, b, c); });

still gives a warning for kstrtoint(). But failing to use the result of
check_sub_overflow() as patched above does not give a warning.

I'm guessing gcc has some internal very early simplification that
replaces single-expression statement-exprs with just that expression,
and the warn-unused-result triggers later. But as soon as the
statement-expr becomes a little non-trivial (e.g. above), my guess is
that the whole thing gets assigned to some internal "variable"
representing the result, and that assignment then counts as a use of the
return value from must_check_overflow() - cc'ing Segher, as he usually
knows these details.

Anyway, we don't need to apply it to the last expression inside ({}), we
can just pass the whole ({}) to must_check_overflow() as in

-#define check_sub_overflow(a, b, d) ({         \
+#define check_sub_overflow(a, b, d) must_check_overflow(({             \
        typeof(a) __a = (a);                    \
        typeof(b) __b = (b);                    \
        typeof(d) __d = (d);                    \
        (void) (&__a == &__b);                  \
        (void) (&__a == __d);                   \
        __builtin_sub_overflow(__a, __b, __d);  \
-})
+}))

and that's even more natural for the fallback cases which would be

 #define check_sub_overflow(a, b, d)                                    \
+       must_check_overflow(                                            \
        __builtin_choose_expr(is_signed_type(typeof(a)),                \
                        __signed_sub_overflow(a, b, d),                 \
-                       __unsigned_sub_overflow(a, b, d))
+                       __unsigned_sub_overflow(a, b, d)))

(in all cases with some whitespace reflowing).

Rasmus
