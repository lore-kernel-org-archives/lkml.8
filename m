Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30000C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0430220870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZyJX4QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGCGJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:09:55 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFAEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:09:55 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z63so27874356qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8wQ6nJ99VV4X+ihLHh/BfNM6BCbfRNbrHOnr3aa3Ejk=;
        b=sZyJX4QUj2Ro/bJX3IUlmb13bJuFyyUlj1KXuK7mcttvrnlFLpKhmMhX7Ei0fXS3HX
         MjP6wygowKrAHQZHFXuDH1+QAAlT8QypfCBY2mEnloOL9decegXAzBqtZ+x9iZYjdAhp
         He71Va/BNUBDkZYrZTPCGfvvfjvoqVo1Ew4UDPFSn+G6mecpH3LsDM8yTmf0tpXXSKlF
         mT5PXH9you1J5Mvq0VoC3iOUS5g6YqfHPVztAWMWfzmuilSBp6EdA0c+yVsoZIQ2UK7+
         Q/t3uCY93WOoFBEq/6qRoESOzJfnr4i5/hPJodiXdHmYN1k+Vp7HZ2Jzpvb2rIWPR36I
         B3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8wQ6nJ99VV4X+ihLHh/BfNM6BCbfRNbrHOnr3aa3Ejk=;
        b=VgWdh9Nh/R9x2li8Fet7SEb715Dh3jPmjzp26dOs1DT1k4oz2WRZ5xpYfs1Fzc8zMV
         w6BLel2a8oVKDQRr3/t4wFe2OZJNz4+4OHXDfspWDeUuHeFQ74SHwV5qlAOqFQ9bUlEv
         6ouR71nVTYKMtKpkFnYkY6daMXl4CZmtUH8TlRfcEB66vRN/kLHsDYh4RW3sqxq1khny
         fgLFd/7CXWThxXycQC0st/IpAifH2IPnlcQwHrWNesZ/GdsWNW1ZIHSLKX8S0/jSNxtp
         HFx9MwLXSXngUSAHJU+6TUivxvW4bsrbE3P1hbxFbNQ/Qd/on6FmPDvwLfa/uvcM9JuP
         X93A==
X-Gm-Message-State: AOAM531T+ZbbZmQsXDTNJDWdzk7k238NoSMAupBwAZNXj8C/iwhFhgN0
        rZtO0FA19iyoabCNNDisjSxnhpAgbLoA4+p5psuz0RbN7mZsQw==
X-Google-Smtp-Source: ABdhPJyLV0DqkFQBkt9IlC8n2E91928sefBYFbFQtfmt+fuKEVqgpCiGTrZCuf3QTjTv7lWDRlvK0jtUB6pIiZqHBe4=
X-Received: by 2002:a05:620a:1010:: with SMTP id z16mr32521469qkj.125.1593756594922;
 Thu, 02 Jul 2020 23:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6awRF3J=sn-bZ1FO-JzuEAhcBvb66ev7=5BB2YracCgWg@mail.gmail.com>
 <CAM_iQpWcK1ou9st5QWvdQ7MNfdV09WqjfPB1ASwpoJaBKzJrjQ@mail.gmail.com>
In-Reply-To: <CAM_iQpWcK1ou9st5QWvdQ7MNfdV09WqjfPB1ASwpoJaBKzJrjQ@mail.gmail.com>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Fri, 3 Jul 2020 14:09:43 +0800
Message-ID: <CAAvDm6aCU0+1iL28t7mf-bc=CM3e8ybAYCtJ6AfYTeLNUCmyVg@mail.gmail.com>
Subject: Re: How do you investigate the cause of total hang? Is there some
 information that I should pay attention to in order to get some hint?
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <Kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Cong Wang

Thank you for taking the time to respond to me.
Do you think the message(i.e. "RCU detect a stall on CPU 2") indicates
there is a lockup.

Cong Wang <xiyou.wangcong@gmail.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:07=E5=86=99=E9=81=93=EF=BC=9A


>
> On Tue, Jun 30, 2020 at 7:49 PM =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong <s=
unshilong369@gmail.com> wrote:
> >
> > Hi, list
> >
> > My x86 machine(linux4.19) sometimes hangs, suddenly not responding in
> > any way to the mouse or the keyboard.
> >
> > How can I investigate why it hung up? Is there extra information I can
> > find for a clue? Is there anything less drastic than power-off to get
> > some kind of action, if only some limited shell or just beeps,
> > but might give a clue?
> >
>
> If the hang was a crash which you didn't get a chance to capture the
> last kernel log, you can use kdump to collect them. The kernel log
> tells what kind of crash it is, a NULL pointer deref, a kernel page fault
> etc..
>
> If the hang was a hard lockup, you have to turn on lockup detector
> and also kdump to capture what the detector tells.
>
> Thanks.
