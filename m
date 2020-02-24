Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C835C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0762072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzi+z6/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBXNbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:31:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46106 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:31:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so5361176pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 05:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rk9xFvrjs94J+cp6mV5Ai1OOkOUlDjUhG7M3DID+zb4=;
        b=qzi+z6/Ve5agNazfStEPp1krW8/Y9os6e49n6WwFKKdXzlgwJW/Nz5aIMZd/jVnXJS
         NkmSfKEpwpyaIFY+c8fIFe4qon5D8vmYazu9w61STa7MqiJA8FjeO4edRGtuEU9W70i8
         0kCsRRfwMG3Zxq0ZGl4fb2vCGJNgtjfdkSh2pNto1agwD/QX2WyPIQ1u5vYDA+QRxmy3
         9rf51iu0Z8t5xFTJBYcEvH1YdfdM+PQU0tzgA4qrCUtEr/TMPVrKCrWZuz4At4QshjKI
         +pZJuOaXLECoY9tjdn2FqqI/zCX2BIyt0ZH4jmm5L9+Hbk1mKuxa7QBD2j3kqMoY/wHn
         seiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rk9xFvrjs94J+cp6mV5Ai1OOkOUlDjUhG7M3DID+zb4=;
        b=LmqFN/bo+/Om66SQSTZHHErI85+KeeJ2wHUQI40anCO1f1NIHCHPf1QEtfolIMDFXu
         3Zwex6KWYrCkT4ETK1CUjDxAi/4PdrDlntPhJgrxIvV/lQxDkBRi+GZGpf5daD7th2C6
         Co5c9ofzR+vhJ5/k63bj8VP0/POc6l8BraP8ba2DH0TRmeBt/+kykUYxQEJllIFVwe2i
         Jq81SjPYpORIElIW48FRYfPyfEYqGSkKWQHne5uCfhlm9kXEUjX4cZBItd8qXrYgbgUd
         +gQRxNAqMHKdhU0B14J/ibRGUMqlfeEnP+McWXu5SSsXiDABoPa0eC+4N35rRWVNZaKy
         vwsg==
X-Gm-Message-State: APjAAAUU9zNPrg8JFjEbDducr2xlwDMbG/gBCbRZeDwpHtE6Y2qjIdH2
        sN76eet5IxPMOaieSknrVY0OjdG/dp+YSNrNW0P+Yw==
X-Google-Smtp-Source: APXvYqyGqf4l/KWsrKzVIZkIBaE13bDXEBj992jRnsMCg6qwHyy+4e2P6IqnWeBvjXVr6y9mcWJGu39tDMEba6hLpN4=
X-Received: by 2002:a62:b604:: with SMTP id j4mr32889697pff.93.1582551077701;
 Mon, 24 Feb 2020 05:31:17 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009e7712059f5257af@google.com>
In-Reply-To: <0000000000009e7712059f5257af@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 24 Feb 2020 14:31:06 +0100
Message-ID: <CAAeHK+y2WZpj9jKMqZLZe5J9LxtdxaMeqA=9hGE=70fTL6s8sA@mail.gmail.com>
Subject: Re: BUG: bad host encryption descriptor; descriptor is too short (3
 vs 5 needed)
To:     syzbot <syzbot+069037c83014b5536cb7@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 2:28 PM syzbot
<syzbot+069037c83014b5536cb7@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    307a2623 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=13fa7a29e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cf0c83d9cbd23d52
> dashboard link: https://syzkaller.appspot.com/bug?extid=069037c83014b5536cb7
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12acfe09e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1613d1b5e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+069037c83014b5536cb7@syzkaller.appspotmail.com
>
> usb 1-1: config 0 interface 0 altsetting 0 has 2 endpoint descriptors, different from the interface descriptor's value: 4
> usb 1-1: New USB device found, idVendor=13dc, idProduct=5611, bcdDevice=40.15
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> hwa-hc 1-1:0.0: Wire Adapter v106.52 newer than groked v1.0
> usb 1-1: BUG: bad host encryption descriptor; descriptor is too short (3 vs 5 needed)
> usb 1-1: supported encryption types:
> usb 1-1: E: host doesn't support CCM-1 crypto
> hwa-hc 1-1:0.0: Cannot initialize internals: -19
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: BUG: bad host security descriptor; not enough data (4 vs 5 left)
