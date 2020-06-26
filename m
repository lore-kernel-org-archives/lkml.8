Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626B82075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgFZOhf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:37:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgFZOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:37:34 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M6pck-1jkzjP0nYU-008KIM for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 16:37:33 +0200
Received: by mail-qt1-f180.google.com with SMTP id u17so7626753qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:37:33 -0700 (PDT)
X-Gm-Message-State: AOAM5338gU+9p6ZQY8SifH07OT+E9qsh6LPvnzgaHxaLNruN70LEp5gy
        Hdrc6qjQSqpLPC6JfaXcpgjlc3jwVlS4xUei04Y=
X-Google-Smtp-Source: ABdhPJzPXxN6ESSty09MIuCyFaZ9s40WUZ7jBjdy2XnwFHjrVH8caWphfoVJHKqJHD7wEzCQ327eZwzTo0eJgYnWHDQ=
X-Received: by 2002:ac8:33d7:: with SMTP id d23mr3106382qtb.204.1593182252119;
 Fri, 26 Jun 2020 07:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-5-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-5-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:37:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2mjN6J22vLZkDQH5ONA4HGkqg6O+h4YYCKeVY1RKa+rA@mail.gmail.com>
Message-ID: <CAK8P3a2mjN6J22vLZkDQH5ONA4HGkqg6O+h4YYCKeVY1RKa+rA@mail.gmail.com>
Subject: Re: [PATCH 04/10] misc: lkdtm: bugs: At least try to use popuated variable
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:PFi/Ny6C736jO1oUmx+QmhrSiqR7/Pd7UTtfTVz9PjZGTuaBVAg
 YNoub8uFNBkXpjtFQijQTs4ydb2L5hbQnRttNTKdthQNx/JO9lo+X1V+Yy8aqzMQpgsMotR
 N5rrTsgUahahVzGrzE+UxOSA7pOcPnf6D+YXuT8sxR9aBINDWYCXStt8FxVsS3RHJrhRhBy
 xhdd1JDNGQ4xDgTEPzQ4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:otGEgxTyiWM=:UReDEzGAqFaRBQd2NgEuHM
 CkWsKyObxsmVxuaTGiLQcJH8I0nryNaWRGREBxnAfXvLIXs6D26rRS1u0RTP6F0zH8wdDL7n8
 j03qvoy6pEDXspnANtKmRUFTKfOCN+aLJNHoikVQSLrRZMKRH5gT+SqfFVpEYfiJOOgzgrdGV
 AZHp9aWj3M1N2JKNE9HaW5jrvlbxDPRN2Qlxb+JBjKpCpymJ1FoeHYOZwXiPhFP0PpWh+GIPH
 OqQkd+ErinGOdaOe5vXBYzZQzhDwuIrKcNHXLJ5TwgNXA1P3zG3Q3A3dGoTgO152HuI5PJ0+e
 w2XBg6/ngrMtStX/28M+S0LJCPjBxX62se9YzlPRTYXp+TG2UymIqJ56g9oxTkKwoh7Boemqd
 JFE80yEgorcHoKKmMaNuNn9YCyclgP5YiGfZKuLeq4cvjYfGA14AoNlPl60Hux+uuaHhXsF62
 XE6WCBCCJkT8oaoGr6HrgZNWyL22T/nVVZ3+cWLCs9W8BxelWH9uk8OqRtB82dj1uGQ5ivyaT
 2sYVpk9mFCxlOfAhDhGddWBQ7lehs+9ndTtIagiG7JRD02N3tuQtag+N1CS/yBdRWghyeeUJO
 Ahq5uq1e1RFg5FgpR5u6c0k8naAT5VrBFs27rOfO0D3yPB1crcwnJHE+JezItzThW9yR2D2uZ
 hGe2zt5HWPv2K8YyHtuuWyNux07VKKfnskXLJZ4U7uxroCmYIxlrczEk/baGtSVbeAaxtsMA5
 00BgillhvQOiKqP5J/k81cSGMaiSUKxRoACj4lWwyjUHQnpVCdwTNCPBKe2RpnlLv2vBsiaKG
 jIs9Zi6xDfxlI48YqDQT39dLAxT2AV/rSM7r0iX+VS+sHXoimU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> The result may not be intereresting, but not using a set variable
> is bad form and causes W=1 kernel builds to complain.
>
> Fixes the following W=1 warning(s):
>
>  drivers/misc/lkdtm/bugs.c: In function ‘lkdtm_STACK_GUARD_PAGE_LEADING’:
>  drivers/misc/lkdtm/bugs.c:331:25: warning: variable ‘byte’ set but not used [-Wunused-but-set-variable]
>  331 | volatile unsigned char byte;
>  | ^~~~
>  drivers/misc/lkdtm/bugs.c: In function ‘lkdtm_STACK_GUARD_PAGE_TRAILING’:
>  drivers/misc/lkdtm/bugs.c:345:25: warning: variable ‘byte’ set but not used [-Wunused-but-set-variable]
>  345 | volatile unsigned char byte;
>  | ^~~~
>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I think a clearer way to address this would be to add a cast to void than
to actually use the variable.

Looking at the implementation, it also seems odd to use a 'const char *' as
the source and a 'volatile char' as the destination, I would have expected
the opposite (marking the source volatile to force the access),
though I suppose the effect is the same.

    Arnd
