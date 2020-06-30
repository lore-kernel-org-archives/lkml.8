Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B6DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6B0206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593546794;
	bh=VtHcwGe4bG3mw+i2K8QzB/gUr1DDUDo4QT0ffrAj9ZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Os4yr6QwweNESsOPzvP1qkr1LIAfiwx7OPW3TAfsgVoCtpm1eNqOcaw7Lx0EIFpsc
	 HrbrcdpuF/bmhGO4cHtiUpBWQ5WpVUCl0aXqApguVFBDvPX0rtzaFy896J0coCyGgw
	 QpmXOWUgLgUrCsgE7w+PJITYH4pNcCMKTabheOf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgF3TxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgF3TxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:53:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF72C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:53:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so24016587ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YkmHTisRyR+XHwRU8pflDRJ5mhycFuIOFgtKJueDbI=;
        b=WgKX6C2z4yDEi8WLdZvFM/JRkJ4LS/z9z06RY0kgSCh3GfkgDELPfWaRxcAoy8t+m5
         uYu2RHnDe0knQnMjyo9ojiJs07br/VE2CJfx69QgERtjto10gsWNp2JocnSAEom2rRVd
         JKmpjmYgA3HDcCjcfHEG9PdN3vIEiR97lgOeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YkmHTisRyR+XHwRU8pflDRJ5mhycFuIOFgtKJueDbI=;
        b=VSEUDSQVVMb/1jGTmw7nuWE5xYk2qwH01nqXfnviMbP2RKHpsW+ZIKQo8sCJTdt3HH
         /HfB24gcd+w0ajvcaO0ySeGvk67UAe8U8kW3g+AYGAeRBDXBwmWr4kKrAE1soa+yhe5v
         cdRgdLwEZ5J/ENbGgAsacl7IsetfmeZ1np38D0fL4Sgojo1pOvWw2hb3mMfqStQtBr0w
         SpwZGkJsoNIazZkAvOJslfxyNI2FVkCSCAh0pDUqc5xMxvhpmH8Xcz5mSykWLxQH/h4Z
         vBnT0lZ0BBu56nCCtTBA0CBOmTTTQytI8Ajhd0sNhxwwD2ETOU585mpqLwqbljl239YF
         NaBg==
X-Gm-Message-State: AOAM533ybvlF1tDZpQOfXHBv9qvP9rWlOgE+iBgodsJHNIfgyb9LeaK0
        4k8vrdrQIAI3uaaKNylTFCWO+W1l6fs=
X-Google-Smtp-Source: ABdhPJxg0ikr9L9oX0RyBCFRyoTE3ihPjspuykih92pbxj0BPrpmhfCdCLx/4vIneClJ2skesz0sng==
X-Received: by 2002:a2e:9d87:: with SMTP id c7mr4269613ljj.168.1593546786170;
        Tue, 30 Jun 2020 12:53:06 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id a23sm1155807lfb.10.2020.06.30.12.53.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 12:53:05 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 9so24043665ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:53:05 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr6344857lji.70.1593546784711;
 Tue, 30 Jun 2020 12:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <341326348.19635.1589398715534.JavaMail.zimbra@efficios.com>
 <CANn89i+GH2ukLZUcWYGquvKg66L9Vbto0FxyEt3pOJyebNxqBg@mail.gmail.com>
 <CANn89iL26OMWWAi18PqoQK4VBfFvRvxBJUioqXDk=8ZbKq_Efg@mail.gmail.com>
 <1132973300.15954.1593459836756.JavaMail.zimbra@efficios.com>
 <CANn89iJ4nh6VRsMt_rh_YwC-pn=hBqsP-LD9ykeRTnDC-P5iog@mail.gmail.com> <CAHk-=wh=CEzD+xevqpJnOJ9w72=bEMjDNmKdovoR5GnESJBdqA@mail.gmail.com>
In-Reply-To: <CAHk-=wh=CEzD+xevqpJnOJ9w72=bEMjDNmKdovoR5GnESJBdqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 12:52:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEghg5_pX_GhNP+BfcUK6CRZ+4mh3bciitm9JwXvR7aQ@mail.gmail.com>
Message-ID: <CAHk-=wjEghg5_pX_GhNP+BfcUK6CRZ+4mh3bciitm9JwXvR7aQ@mail.gmail.com>
Subject: Re: [regression] TCP_MD5SIG on established sockets
To:     Eric Dumazet <edumazet@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Jonathan Rajotte-Julien <joraj@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you're not willing to do the work to fix it, I will revert that
> commit.

Hmm. I only now noticed that that commit is over two years old.

So I think it's still wrong (clearly others do change passwords
outside of listening state), but considering that it apparently took
people two years to notice, at least some of the onus on figuring out
a better morel is on people who didn't even bother to test things in a
timely manner.

At some point "entreprise vendor kernels" or whatever who stay with
legacy kernels for a long time only have themselves to blame.

             Linus
