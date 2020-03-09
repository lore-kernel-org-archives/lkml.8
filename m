Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB3C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA20D20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjAWkBP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCILgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:36:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43527 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:36:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id q9so716000lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9AMCNpkHEsKxMjRpDAqgwr2TQNY3wMs/qsGzuuGdEc=;
        b=XjAWkBP3FJUFtYhVirCY+w9wiSmIuFLx6mKaBxZqQz1ZLYv5lVDzRiuh+XHFmabWo3
         Y0nHIG5wumWVYL2yfFA3jxy7kseqc40U8erbyinYeMf6KrcYB+svkXmVziD3UdCL0zzu
         rSsWkfLonDolDm4kEV0VdeiUd/TwGgUgTgzlluvCtbuC+hhFOx8ndZkBoq1RFIhiU8bU
         j5ChU+b3gzULAcwaUl6HWmDihsfqfK9B1twWF3Ymxk5R1yOFEh7MuNDz1mmcUNWni+E+
         d4oCikLg23H72Kd2hkZ9DXDnFeZUfwozKqNxafmdsQM3xDtIt47KdL6mi25SrIyNC4Rk
         kosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9AMCNpkHEsKxMjRpDAqgwr2TQNY3wMs/qsGzuuGdEc=;
        b=bJ/68kRm/OE7xrZb0cnCy68YrutEyqdeh55FXegPp4TEZZR5/sNU20EevFgUimtMeB
         Diq2zJaDBFeXsVUx+HznsRl9TfH4zwfBun3DFnvpo177BwEzEV1euG7du9GDp87LK+aB
         2bVmLeBz7Eda46Hh8plvs8urHBX1lQGD4z9F1MOiUpeJ2mj/SFeLtZY1Q/gboAhbCskY
         cuHoMbcCH4iblZ1CLmJj5AVMAwNOinrZZghsmfnexYwAFfTG1ka9nnb38N3pquKbRvG2
         oKbk5TVeI7jT7ubleEBxGp8oo31/XVMfbbpvhOw13nKr45FopAj/RoB6UGp+w4sCjCOy
         eUKA==
X-Gm-Message-State: ANhLgQ13lcPRO5bWfY7ublOwj6Rr/vWPWZx5CuzkQhuCPOOHsX+jZvk1
        9/tL/JS2J9TVeZ6CBowVdpKrO3ENJMfrGcyi41M=
X-Google-Smtp-Source: ADFU+vstBmldtObLzwoW2XtGjKSGpqv6ZCrMDZvhMrPBS4Pv0w6KK9e6IEDF6wp+eY4YN8k68dRxXvBL6kH4Jzl8ZQc=
X-Received: by 2002:a05:6512:308d:: with SMTP id z13mr8935309lfd.74.1583753813108;
 Mon, 09 Mar 2020 04:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200309021747.626-1-zhenzhong.duan@gmail.com> <20200309095102.GA13722@haproxy.com>
In-Reply-To: <20200309095102.GA13722@haproxy.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Mar 2020 12:36:42 +0100
Message-ID: <CANiq72kk8xW0cOJN+Nh5OoSmXEXqvmFXW827_VUQ2ssPkhO7Qg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] clean up misc device minor numbers
To:     Willy TARREAU <wtarreau@haproxy.com>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, mpm@selenic.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan@buzzard.org.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Miller <davem@davemloft.net>, b.zolnierkie@samsung.com,
        rjw@rjwysocki.net, Pavel Machek <pavel@ucw.cz>, len.brown@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 10:51 AM Willy TARREAU <wtarreau@haproxy.com> wrote:
>
> Thanks for this! When I initially created panel.c about 20 years ago
> I didn't even realize there was a miscdevice.h to centralize all this.
> It's definitely cleaner this way.

+1

> So I've built for ARM to check, I could enable and successfully build
> these modules that you touched: charlcd

Thanks for checking Willy! Also compiled here for both arm and arm64;
will send the ack.

Cheers,
Miguel
