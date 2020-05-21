Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB8AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4402072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dATQhHHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEUPzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgEUPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:55:33 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AD6C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:55:33 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y17so5352444ilg.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PYhboJAJ7RUBKUATlYhVk5ySk5gU8YKi+aCx6DRehKg=;
        b=dATQhHHQvJut0ZdygKw6g8AVHjd45Sqhq824JTQz3o6b/bur/kKqQ/50Asso5pexJn
         LZMlI99ySYlyVBwxVeWOx7L88HOPdVuLsE/R4OTPgjl8K4DkM9irR8FiBPwd2ysSZgiv
         xdtRA3KgWuxo2+dCzkmMg6FNqCbRUHSzVgMO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PYhboJAJ7RUBKUATlYhVk5ySk5gU8YKi+aCx6DRehKg=;
        b=De+HsWBqrVRx957V2JMn7REpZooOTz2VhhQyl+3WFM3mgiIATkSJ9bMiULpYpAAfLv
         GMmQ06S7BZhzipfQrlCOc2B2sa7d/qa41t0HqOY+nF2dy4pYOnXRuBluR3Tg5xcuwKtW
         1EzlxuMj0FYKTa8s19OmODGWCwm5taYhGWsNXuY8syyY8YVdbqiOP0GmquKZdMK+pDMp
         0mDd4TZtcR4gU6blFQ7j1kpNEQ4AHUgh9/JRX5JMFw5DNSdoNxRHiI5dcxO4GwvIg9q6
         oIkxwYVpeQWe0tCBZ8dJjPYEOS/RjuzE4nwoO+P3XMNvcqNsEcRFZTnnT11n5r11jCzK
         aaTg==
X-Gm-Message-State: AOAM530KBEpOmoXwNTSpvURJ+ha55FsAzuhpsE+v3cDSRwDg5o8svTRi
        irJjlu2rrQXSPSgJF2p13TKzE4S+HEdMJI+KMFYUrRTV
X-Google-Smtp-Source: ABdhPJyoa5zm89sVnN9Gx9+B/moZwqm85Wya5bEMLTeH4USwyojqOZgpl+YvxIKAJrXIhkq0vx/jG8rH9qgUkNBRQ1c=
X-Received: by 2002:a05:6e02:ec2:: with SMTP id i2mr9391335ilk.262.1590076532103;
 Thu, 21 May 2020 08:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200521155346.168413-1-joel@joelfernandes.org>
In-Reply-To: <20200521155346.168413-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 21 May 2020 11:55:21 -0400
Message-ID: <CAEXW_YTj83gO0STovrOuL9zgDwEYWRJusUZ3ebVw_jOG6yJxTg@mail.gmail.com>
Subject: Re: [PATCH RFC] sched/headers: Fix sched_setattr userspace
 compilation issues
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthew Blecker <matthewb@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Mike Frysinger <vapier@google.com>,
        Christian Brauner <christian@brauner.io>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        vineethrp@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:53 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> On a modern Linux distro, compiling the following program fails:
>  #include<stdlib.h>
>  #include<stdint.h>
>  #include<pthread.h>
>  #include<linux/sched/types.h>
>
>  void main() {
>          struct sched_attr sa;
>
>          return;
>  }
>
> with:
> /usr/include/linux/sched/types.h:8:8: \
>                         error: redefinition of =E2=80=98struct sched_para=
m=E2=80=99
>     8 | struct sched_param {
>       |        ^~~~~~~~~~~
> In file included from /usr/include/x86_64-linux-gnu/bits/sched.h:74,
>                  from /usr/include/sched.h:43,
>                  from /usr/include/pthread.h:23,
>                  from /tmp/s.c:4:
> /usr/include/x86_64-linux-gnu/bits/types/struct_sched_param.h:23:8:
> note: originally defined here
>    23 | struct sched_param
>       |        ^~~~~~~~~~~
>
> This is also causing a problem on using sched_attr Chrome. The issue is
> sched_param is already provided by glibc.
>
> Guard the kernel's UAPI definition of sched_param with __KERNEL__ so
> that userspace can compile.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

If it is more preferable, another option is to move sched_param to
include/linux/sched/types.h

 - Joel


> ---
>  include/uapi/linux/sched/types.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/=
types.h
> index c852153ddb0d3..1f10d935a63fe 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -4,9 +4,11 @@
>
>  #include <linux/types.h>
>
> +#if defined(__KERNEL__)
>  struct sched_param {
>         int sched_priority;
>  };
> +#endif
>
>  #define SCHED_ATTR_SIZE_VER0   48      /* sizeof first published struct =
*/
>  #define SCHED_ATTR_SIZE_VER1   56      /* add: util_{min,max} */
> --
> 2.26.2.761.g0e0b3e54be-goog
>
