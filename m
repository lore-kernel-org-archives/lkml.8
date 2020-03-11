Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D796DC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73915206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCBNaIvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgCKSbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:31:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41101 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:31:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so1476765plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Iqh7YiU1WCa8iFIZ350TOhDUP5JUQC2PJuS43lrAIc=;
        b=sCBNaIvcQUpuWnWFUFlhtSUd+3jwTL2Zn0qWMLjvQTngEKPn0Ajd0dY+z6q1pIxry8
         z3r3c7CZGkRKRSWTzdU3uHAP2hC0vpVKFtbAIYPLnRPP8K+vMdOGgbr8z+oJi/5HoRG2
         C50D+CKEw3y43Id+4rMs325yfEDGEwOzKhaNh13qKk111D9ix3Wuexp/R8cOJ/HfUH2n
         VAEtJ4mLqcs60m22Lyu0yDVsD2OkogPq6j9A78Ku7AVsu+F51iSSRmbGKKhmloCpMT5T
         ZP3teFRJjBaFPpQsy3EQlafwkNQN84Lo8cJnAOte5TNI/aY36t6yDR+PFNEc0G3B44mz
         UP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8Iqh7YiU1WCa8iFIZ350TOhDUP5JUQC2PJuS43lrAIc=;
        b=PvAzaJwA88YY31Vsj7HwPMVUuzsgyPf5SBC26Xs8RbU48hphctSXd/UIrrxquAy84O
         ScrqgpqGHL2fBc+reamDNht/gftfrei4TuQ72s/UKduMhNNkiBuLsKSFsDQwY3HgI2Fe
         NowZzf3+kIhAHV7cJHXAxohzRBguxgI9EC0HfgX7VRULrTuWZQDMb5FfLtDPkn4Ogn2w
         6BT80xO58GkhpFeRNYCahkwEA0oiyZPIhQbcBwY1VGSzz6rUdLGH84j6D0XMZwKZD1Qc
         4ZtskXoRnNgIiFPYQeqF/1A1/bT8IOs/3g0zFfZeGepEXcwNX43j9f7XCrvZohIH1Pz2
         5wHQ==
X-Gm-Message-State: ANhLgQ1ljwNz2KKrK2I6mYRNltJeQ1M+D/pIP4kUz/z4J7A33+tqCqV3
        L9+0pX72V64ugEHbA5RRPes=
X-Google-Smtp-Source: ADFU+vtR3A8/gUhTR53MDaQSvdcpPtSN5EFirqyWWfjgN2TcJ+Cyl/pgjnRxBWp4OoDBoR/OrmldAg==
X-Received: by 2002:a17:902:208:: with SMTP id 8mr4322464plc.103.1583951474983;
        Wed, 11 Mar 2020 11:31:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p14sm48927616pgm.49.2020.03.11.11.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:31:14 -0700 (PDT)
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, Emese Revfy <re.emese@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <20200309164931.GA23889@roeck-us.net> <202003111020.D543B4332@keescook>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <04a8c31a-3c43-3dcf-c9fd-82ba225a19f6@roeck-us.net>
Date:   Wed, 11 Mar 2020 11:31:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202003111020.D543B4332@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 10:21 AM, Kees Cook wrote:
> On Mon, Mar 09, 2020 at 09:49:31AM -0700, Guenter Roeck wrote:
>> On Thu, Dec 06, 2018 at 09:32:57AM +0100, Ard Biesheuvel wrote:
>>> On ARM, we currently only change the value of the stack canary when
>>> switching tasks if the kernel was built for UP. On SMP kernels, this
>>> is impossible since the stack canary value is obtained via a global
>>> symbol reference, which means
>>> a) all running tasks on all CPUs must use the same value
>>> b) we can only modify the value when no kernel stack frames are live
>>>    on any CPU, which is effectively never.
>>>
>>> So instead, use a GCC plugin to add a RTL pass that replaces each
>>> reference to the address of the __stack_chk_guard symbol with an
>>> expression that produces the address of the 'stack_canary' field
>>> that is added to struct thread_info. This way, each task will use
>>> its own randomized value.
>>>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Emese Revfy <re.emese@gmail.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Laura Abbott <labbott@redhat.com>
>>> Cc: kernel-hardening@lists.openwall.com
>>> Acked-by: Nicolas Pitre <nico@linaro.org>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> Since this patch is in the tree, cc-option no longer works on
>> the arm architecture if CONFIG_STACKPROTECTOR_PER_TASK is enabled.
>>
>> Any idea how to fix that ? 
> 
> I thought Arnd sent a patch to fix it and it got picked up?
> 

Yes, but the fix is not upstream (it is only in -next), and I missed it.

Guenter

