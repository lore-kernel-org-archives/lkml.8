Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71290C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FE0206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="Si4G24rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgG0Q0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgG0Q0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:26:36 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17FAC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 09:26:36 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 2so9034449ybr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t/olIwYqxp1DyF1+bW9J2vZgk69Gj3uV2JTib0EW5Sg=;
        b=Si4G24rbigkgdAImlbDToCCGZL0kCGnAQvty5GeSVw4L0ScgzB8ijFZoUfapsn+BNF
         LJ8NxdyGuZ51rVMSGsRD6PhV7TeEzmVJAXRhsjW8pPo6Hxi7yFtwux+quxWdiNK/d6rh
         F7EmOX6qIvczVK1xW30DFscIJzdbF1AIGW4Q+cxGK/wjdPQK0+UXQM/BVR0I6zbzxepN
         y7x3fp1tTNol3me+YD/HmqpdU2sOD79SrKbkZIIFq0l0bKBzYc8SI7Baw2gTqchtRSp1
         dY7tPCj66Jq+jOpFtEwJVWx8gGFZ99c9brhF4TDXgPk80l+xmkGVypxtKbnjT5A/FWun
         k7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t/olIwYqxp1DyF1+bW9J2vZgk69Gj3uV2JTib0EW5Sg=;
        b=D6HS6Baje6BSwNZhLBxrCYLQOqKo6DEKpIeh73KmQWUl/SPiQPoRqdIcSKke24vBa4
         dwkQalFZVv97m7p0MU0cQ3v1UCutOzNH5gBAF0a+6quJNlcZxA7O3VoPy4s9sfhFWLzs
         hH9Zt8p/wduogStSZ5JI3Ei0MYJco+n7Kte7lomaoGoDOXbJVPY61sP4G7Go6cFS2rxv
         r5w9mOLevAoIi7cyYAZfMItYVJG6KA66taqiP/CR2HvdEe8jfmNbJWSMCwJVvuoEDeHi
         y9ODse8YyubGtpJrqQ6jFTaYHUhJ5TDqiaSfMCs1zBH6nQWKethd5ME4BTgAFnB7Jf5m
         guQA==
X-Gm-Message-State: AOAM531TxsAFTnGWSTCwt3tuflikS00vu0ZBALPpV3qBp/4man3dGYIt
        CnJJrBEOJKLAkc1vAW3T3xqHEOLQrqiGJuq8lUNOefY0ykg=
X-Google-Smtp-Source: ABdhPJwUz/OEyvaeMrlRL7/0gzWkSvl13aw4W+YbB6UZVVd9EunH/SkBmAxVgNok0fEA7Y4Mv3RanZgv5EEeNkF63v0=
X-Received: by 2002:a25:df0e:: with SMTP id w14mr20160814ybg.225.1595867195726;
 Mon, 27 Jul 2020 09:26:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:807:0:0:0:0:0 with HTTP; Mon, 27 Jul 2020 09:26:35 -0700 (PDT)
X-Originating-IP: [24.53.240.163]
In-Reply-To: <20200727160554.GG794331@ZenIV.linux.org.uk>
References: <20200723155101.pnezpo574ot4qkzx@atlas.draconx.ca> <20200727160554.GG794331@ZenIV.linux.org.uk>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Mon, 27 Jul 2020 12:26:35 -0400
Message-ID: <CADyTPEx=Y5KxYRV0JXgeH6njJMObTOFpAc4wmha0uUfO8yQfxQ@mail.gmail.com>
Subject: Re: PROBLEM: cryptsetup fails to unlock drive in 5.8-rc6 (regression)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-27, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Jul 23, 2020 at 11:51:01AM -0400, Nick Bowler wrote:
>> Hi,
>>
>> After installing Linux 5.8-rc6, it seems cryptsetup can no longer
>> open LUKS volumes.  Regardless of the entered passphrase (correct
>> or otherwise), the result is a very unhelpful "Keyslot open failed."
>> message.
>>
>> On the kernels which fail, I also noticed that the cryptsetup
>> benchmark command appears to not be able to determine that any
>> ciphers are available (output at end of message), possibly for
>> the same reason.
>>
>> Bisected to the following commit, which suggests a problem specific
>> to compat userspace (this is amd64 kernel).  I tested both ia32 and
>> x32 userspace to confirm the problem.  Reverting this commit on top
>> of 5.8-rc6 resolves the issue.
>>
>> Looking at strace output the failing syscall appears to be:
>>
>>   sendmsg(8, {msg_name=NULL, msg_namelen=0,
>> 	     msg_iov=[{iov_base=..., iov_len=512}], msg_iovlen=1,
>> 	     msg_control=[{cmsg_len=16, cmsg_level=SOL_ALG,
>> 	     cmsg_type=0x3}, {cmsg_len=32, cmsg_level=SOL_ALG,
>> 	     cmsg_type=0x2}], msg_controllen=48, msg_flags=0}, 0)
>> 	     = -1 EINVAL (Invalid argument)
>
> Huh?  Just in case - could you verify that on the kernel with that
> commit reverted the same sendmsg() succeeds?

Seems so; with commit 547ce4cfb34c reverted on top of 5.8-rc6 there is
no such error in the strace output.  This particular syscall seems
to be succeeding:

  sendmsg(8, {msg_name=NULL, msg_namelen=0,
	  msg_iov=[{iov_base=..., iov_len=512}], msg_iovlen=1,
	  msg_control=[{cmsg_len=16, cmsg_level=SOL_ALG,
	  cmsg_type=0x3}, {cmsg_len=32, cmsg_level=SOL_ALG,
	  cmsg_type=0x2}], msg_controllen=48, msg_flags=0}, 0) = 512

Cheers,
  Nick
