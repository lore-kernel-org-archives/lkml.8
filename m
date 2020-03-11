Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0018C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEvP79j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgCKDPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:15:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34471 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbgCKDPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:15:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id s13so645823ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEV4k+bL/wVs1DjJ9UUoZiAngHpSaiThFxZAjSeveQk=;
        b=TEvP79j4oY6rZiTlYvSjSFpJk1ozFQz4IwVwyVR+a7cDlhaqssZfpUY7A2Ue4LG4cO
         YoiKQCn8aR6M/RQ5Jjjpaz9ZP1WFPJxIrAaX+xe0BBOKVgqGwwFEkTIZ99gVJZ5h/Ym8
         F3N6iYFjKzgtKBrqAxuO9D7e2J9GDdKud3ifRKSoqBUFZr+C8ffStpoBYGZEVsH4LggS
         2RaUEAFj9kpkj5eDxpQHdQEoBrpjpE2A74vxVZJFK9VfzStuopAYwSSnMOS980/52PV4
         3J5ZQ7zdiQuFJ1n1fo6aaT8T5/wpq3xPK7KaUk13JVK/FwMAs9Ewf+E/PxRfgzuxDmkV
         Xpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEV4k+bL/wVs1DjJ9UUoZiAngHpSaiThFxZAjSeveQk=;
        b=opFGMfMAy4qblvrOXkQe6rza2DBux/2nGNdLdYgBUK406bosG6acOu1JIuD+ktaB6u
         bjec2+ki7zKJEe4Ktxqb1wTOwOAl4uWyfqAtBKz8wjoIgLQLk7fhTaC4LhpZzOILF9Gv
         2D2u91h8AzcA3hzV0PxdrBBxCXy+0OXxl2NCW9gULheY2VrGknZcibqE/r3VftBL//ES
         8T6IRvgE8Nm1rKLIeNN3+AqicXKWjvSjyWWww/+P9u9dtu2DZD8Dsn5d1XrT6RrnHli8
         9q2YbKFMueWDhuKoNfzfkdueSWJd4btWsd+RWxB2YkwL3Sg0jbnAB31qO9HIhVumkv/R
         02Vg==
X-Gm-Message-State: ANhLgQ3IZ4vczN1B4avKDrGhMl13OkfksPQaFuZVGOMiTU3K9gL3z9yQ
        CtotLwXFC+J7osWjo662MVQHTzzsZ1TmmmSR1dQ=
X-Google-Smtp-Source: ADFU+vs4SceWjDZAsNdiNje320/eiIBN9EGlR+jBzI1HHf1mo6xrIpP28dtXUguJ6qTOgfZy0FjgP8PsVEu95PExCMc=
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr676595ljj.253.1583896508887;
 Tue, 10 Mar 2020 20:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
 <20200309095102.GA13722@haproxy.com> <CANiq72kk8xW0cOJN+Nh5OoSmXEXqvmFXW827_VUQ2ssPkhO7Qg@mail.gmail.com>
In-Reply-To: <CANiq72kk8xW0cOJN+Nh5OoSmXEXqvmFXW827_VUQ2ssPkhO7Qg@mail.gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 11 Mar 2020 11:14:57 +0800
Message-ID: <CAFH1YnMid=XgngN2DATT+Wkg+Y3J_V_n8qYf5+2dmre+wsx+7A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] clean up misc device minor numbers
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy TARREAU <wtarreau@haproxy.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan@buzzard.org.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Miller <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 7:36 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Mar 9, 2020 at 10:51 AM Willy TARREAU <wtarreau@haproxy.com> wrote:
> >
> > Thanks for this! When I initially created panel.c about 20 years ago
> > I didn't even realize there was a miscdevice.h to centralize all this.
> > It's definitely cleaner this way.
>
> +1
>
> > So I've built for ARM to check, I could enable and successfully build
> > these modules that you touched: charlcd
>
> Thanks for checking Willy! Also compiled here for both arm and arm64;
> will send the ack.

Thanks Willy and Miguel, much appreciated!

Zhenzhong
