Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB1EC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB74720842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njiKhj7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBJRqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:46:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41259 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJRqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:46:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so4047280pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Um+KObYsAAZ4zkjy8DfPk4gMVE/AcI+tTE3voE+GiRg=;
        b=njiKhj7QaIkkNSNQhUqILnlQOcBdfJGQikxxlQ1pEE0/84uh64gTFEhicom6s7pp4/
         89OE0A3tM4hYe5VaOCgP7upVl/TzXwLk6l6qyg3N9FosQbbK9sHHXLDKeiUNJJ5S082M
         GRWq7PpY65hGzS1jzrNMHEGb+6/6tx6KkKDR2itxR7qNft3ET66zfa6X1lNkaZ5I/baG
         hmGr9Wf1wcPm1rdTIe6COWJGIlBv5edgHE2XByqeAGpajoiW/BIihixLWvWh4EY8BA2y
         kYZ5z0Z7fGWUCnMO/js/UVGcNimazt1S5INz5Eei5FLlGCq0BPFsC+cPcWOH/f8KvdGc
         NfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Um+KObYsAAZ4zkjy8DfPk4gMVE/AcI+tTE3voE+GiRg=;
        b=CLTMP+tz0DK2IzPlBKxmgUmRHVOPEUkxw+vUxdnLdbIAGuokO0Frp1xziOHI77VjiA
         k7tn1McJL+4WOCMlvqKaG2iimDmmG3oxvJlC19cXWmx8s92f4N9AgNlpewdn2pw78Mae
         zRC8JaVzx2sJh+kL55JD4yhEcRgyTA6SOJ0KSTzSXCnIRhxKWotFl9b+T9Ugzx6vjbVZ
         EOobtYbt4Rj22CIzIKWMK6UHnk7R71RmVvawHjLBfCxcYyy3G3HUqZMakMMc9n/0R2Yh
         AnuPGBYeTlTfHxnElFV6dcEpyIQioWg7bzFRG/8mKWNf9Qkyny6MUGjTpj7doDskUzne
         UOIg==
X-Gm-Message-State: APjAAAUMufQjCXoaEQSg1+uPP2UDW/uICnrppWUhWxj9IJe10eFnjh3v
        ZXb5HDGYiU8db9nE+B7+hC2Cghm87toGldlqkeZwbA==
X-Google-Smtp-Source: APXvYqxiIwOpnR4LFNHTjqhqakXmaLmWK3XOeYVT3jSb6tOBB2Wclr5JOuazRiMQs0/fmgICCXuPAx3cnyQ/c648+2A=
X-Received: by 2002:a63:3754:: with SMTP id g20mr2660474pgn.384.1581356761468;
 Mon, 10 Feb 2020 09:46:01 -0800 (PST)
MIME-Version: 1.0
References: <9e787393-703b-ce56-8258-8dcf0cd5ff11@infradead.org>
In-Reply-To: <9e787393-703b-ce56-8258-8dcf0cd5ff11@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Feb 2020 09:45:51 -0800
Message-ID: <CAFd5g46b7KS34c3jzJp9wxpneuEOT8BSh+jaPfnYA8DAQpH8CQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: fix Sphinx directive warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 7:31 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Documentation warning due to missing a blank line after a directive:
>
> linux/Documentation/dev-tools/kunit/usage.rst:553: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 3 supplied.
> .. code-block:: bash
>         modprobe example-test

Uh oh, sorry for wasting your time, but it looks like I already sent
the exact same patch out already:

https://patchwork.kernel.org/patch/11360711/

Shuah, can you pick one of these up and send it out in the next rc?
