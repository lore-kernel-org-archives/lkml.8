Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5B6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A457E206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584990421;
	bh=Ed+E6o6kmq+kYwvFkAcEUSY17gCmd9Wfq/So6iHeknI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qJyWewXj3JIOzk5HzXtitWpyq/4yyzuAcGwVyvO7Skmd8ndeUUcA+jF3wRe58Ung2
	 l5aaK9QmH/oXY6BxzckDtP1opbqnDWRVUKsfinFU3Uhjl8usQF7jc9ot51T6WsBytH
	 A7BIeVMi0Zw+mgAOPh4Mvr5LUJO73uBC2us3F6R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgCWTHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:07:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41561 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgCWTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:07:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id n17so5552426lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfUrbrOHGUI5+RGJfmznZYjXzdaPBRUHnD/pE6zbXgY=;
        b=LG/z5kbw9TabnGLGcEoBuoVS9x7mwoK48/xogV4RjDEQkj1Jue84DbaxbeRjIoqACD
         hFBuOHJwaM3/PyZkynCx6ThDYskICnR1QkVpxVD+3H+uq+dXSBmkylWn/lEK5//hH8dv
         t4UJZQYapp91ZrIKWy75pChRYojzNiPp8CcfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfUrbrOHGUI5+RGJfmznZYjXzdaPBRUHnD/pE6zbXgY=;
        b=P8fLNHb0LC7m2M9dVnAiN/vAR0JmtFnnZHNTaCZk52TnrWK6CsNffaTKagkCqz/rRf
         6i9HMdaz6darCwv0kwt8url3xZePCBfPZ3SCzyacsjudHY4vwOE5hYeYF9cQoMDv/Dkq
         p6jz+FszCPKyLS01MPSOSmyjVUhjA0QWQeMUm8Pe7jqTqnNlttKYxuxIwmTF1AQYTE1p
         3x5oBm8dgX3mZfepkzE7xT9PCWVmiNhXbjETVIOUXsINMxBnzEEeMp7iWAC6e1sgDHOO
         nGi2SYhwGYlvo0IUjnHSSTrMxPv6twV6fob+OL/WhZIG7UHGIhSM/P8dnLBAWk15Z2ci
         y6LA==
X-Gm-Message-State: ANhLgQ0O+G0bYnWLP8bNAO6hjr8mL1d13YA/98VjTP0WeWBmzQLcNyvt
        gnBh/u9Y6/charuu8MZmigv6hy4AaII=
X-Google-Smtp-Source: ADFU+vvnZyyhfaBEbw9W9z4/xiQDwnJ1xLvL96m5q9g78Qip7bj+jYlY2Kmx0k61zZgjGuZLs/TDvA==
X-Received: by 2002:a2e:94d5:: with SMTP id r21mr13950799ljh.81.1584990417117;
        Mon, 23 Mar 2020 12:06:57 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v9sm9021544ljv.82.2020.03.23.12.06.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 12:06:56 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id u12so15930217ljo.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:06:55 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr3857617lji.16.1584990415443;
 Mon, 23 Mar 2020 12:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200323185057.GE23230@ZenIV.linux.org.uk> <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200323185127.252501-5-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Mar 2020 12:06:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
Message-ID: <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 11:53 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> Lift stac/clac pairs from __futex_atomic_op{1,2} into arch_futex_atomic_op_inuser(),
> fold them with access_ok() in there.

So this is a deep internal macro and already has the double
underscore, but I'm inclined to say "add the unsafe here too" for
those __futex_atomic_opX() macros that are now called inside that
user_access_begin/end region.

And wouldn't it be lovely to get rid of the error return thing, and
pass in a label instead, the way "usafe_get/put_user()" works too?
That might be a separate patch from the "reorg" thing, though.

             Linus
