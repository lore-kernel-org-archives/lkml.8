Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1085EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD36F206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596996291;
	bh=OPs635+YB2E/9UhkNy4T3ZJerTKavMQ4keusGFgxqcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tlZZpLOZIXbWG2D1d9Oni4fT6iNYkeJei41Kre45gCmhYRNZ6LS0O5inqgaETYwpx
	 vz5p0jijGItBETvFN7t6gYQ2ch0aFj3tzvP0HvRGfCnTakzJotyGVwWsKffreJu84T
	 v+IHTMB4J7w2ObAvGRoQMcku8ZYyilI4dil+WqMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHISEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgHISEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 14:04:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C060C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 11:04:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so7237234ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BG/6UUzuOweVBBcANerDegzEOPHQ5euSh32fkjDyuE=;
        b=OqO3VVcpPivDRCvdlKEfFTIX6VdwAKXPXAn5HYXdTcxmrve3rpBOTbaiLrxFRJ16TN
         5ZLeYSCR2Q/kI21RJEFXYWbUtHAGQ+SEp6kXG4eBNfM0Y4uSwPpOQx7cw0XZUYfv1IzN
         7G8kphPPMbI9cZa9e/xIAFf2B5EwFg5bJFviY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BG/6UUzuOweVBBcANerDegzEOPHQ5euSh32fkjDyuE=;
        b=RZAeUZ1XMUjTGy4r937XVTUxZvCLd2hKU1kdNRIZblqsUHN2na5IIgaA5STpFACozT
         xj8tiAffbp53Vg10TIwZaPFf68tdLSSxvLKbLOPop58q4VtZrIzJ6//WctX8A8meGJFy
         szlXQ+D3tgH5NtCWVhKPHBmWKgz5UZCy/0NwvU2fZYdwvIWm5cLWwJl0ryOemlUj6N62
         BOHW004AbOxlmzN44G0aDnJWbzvW301J/ONwpG16cd8gOs7rdeyimM51zBhzbtKFXFeR
         uBNmgW0OlXOvnQmszfO/lcYsX0VCqwW4P6jG5lL8BhxE0PbyX+4KAvshiCpQIhrRe5Ke
         6z3Q==
X-Gm-Message-State: AOAM532U86DjZm19ctu9JdYBD/MG9wz0mKoPMxxpwz6pqImq8wzemMQc
        hBJV596SJmjfGtGjIFjZyjUscxv0SSk=
X-Google-Smtp-Source: ABdhPJz78v4oz4Huli9PZLYlTJKw8NOUeVd4vDd8NkxQykfj9rAyOUW+8juIxm9YWqM/p/Qr4xyoNw==
X-Received: by 2002:a2e:9e97:: with SMTP id f23mr10430781ljk.216.1596996285657;
        Sun, 09 Aug 2020 11:04:45 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a30sm9204612lfo.1.2020.08.09.11.04.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 11:04:44 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id b30so3534550lfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 11:04:44 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr11132205lfa.192.1596996283903;
 Sun, 09 Aug 2020 11:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200630160346.696f6419@canb.auug.org.au> <20200809181838.23c6b829@canb.auug.org.au>
In-Reply-To: <20200809181838.23c6b829@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Aug 2020 11:04:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjsrVPKirEN7hTioibRYSOZuo82seuUm6k7=tqeWHnZg@mail.gmail.com>
Message-ID: <CAHk-=wjjsrVPKirEN7hTioibRYSOZuo82seuUm6k7=tqeWHnZg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the thunderbolt tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 9, 2020 at 1:19 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I looks like the above report got lost along the way to you :-(

Hmm. Why didn't I see this as a build failure?

Oh. Because the USB4_KUNIT_TEST stuff requires everything to be built
in. And I have them as modules.

That's a bit unfortunate. I see the commentary in commit 54509f5005ca
("thunderbolt: Add KUnit tests for path walking") about how this is
fine because only developers run the tests, but it has this very
unfortunate side issue of not getting a lot of build coverage either.

> Here's the patch in case you want to directly apply it:

Will do. Thanks,

             Linus
