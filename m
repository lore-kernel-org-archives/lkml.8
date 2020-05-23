Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44011C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6022072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590257689;
	bh=rfSh5YB/F+vsm4SlCF5dr1Pn7gJNkXUmQbfSRjtzF08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vzBLnWSSc0GkcTDbR6W6uCeSIJBrhccWohV+CbWmMxEPfdK3jErKrAHZpOkVO31Jk
	 DgD+D24vvjUQKfbh0Wl/wvt0UCt1HcUSIc9poYetnNDJtd1uEgpIWRO7Yn5ML6/tMD
	 RKMLUiH3o+m++tKFbx/9k9qBc6kKBvzsNJkEjkjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgEWSOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgEWSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:14:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D6C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:14:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so16519246ljj.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtI0UP3HCAd6yl271WG5xHASAjmU3x5qBZaN7aSNblU=;
        b=Me5tDQ58b02SUxQ1K6RgO7JpWJ8qtS6N6HSpnFC+vXHQ1oPf5yEhmaqOEmDtbKinTk
         NUs3aeN2+vN7mBGjKTCj1D2l1/FQNMeipnpzocz0NsaHPlzeLRzEIiTetHcRyh5mxfiW
         AUMMQaJRA3XvuaKJnH9q0v/29ctP1DZH941TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtI0UP3HCAd6yl271WG5xHASAjmU3x5qBZaN7aSNblU=;
        b=OrIjg7fCCX4V9L7/QFWmVtzx69QmElXcBizDs+PVcJoBgAaJIx0ssUVUPXq6O8L/D7
         K6ACB1U3JjDQ9l13oQqV/uFFb8XN/iG2wdxR5XY8gWV3Z539gEN2PqjAZS8elB8ntvg8
         dujTBYJetIlLrj4Y6klXrDDXhTYs9uPZO5NTSka/DJWCVjuLJUyKWd05sq2L6OI4Jxkv
         1V6OHdhkysWzpO6yfX2CXd6sdq+ZAbN81Lto/0iRQqFWqaM4vteTJgraJ3hNNS1C3ZhG
         AaNVvG8kBFeSFXlgkz10jkV2tXN5q/wf/IRCnzUedJF11j/uJbVJZFqRflIVyVQhi2Oo
         I1sg==
X-Gm-Message-State: AOAM530LP2RVQwj3ff/Lewls7rL7Bqbx7w82UnlerTDa/SoToIRnxtFu
        KYz3IiwZ7Fi/gOKFyF0Mu2wug/RDXWs=
X-Google-Smtp-Source: ABdhPJw3+XBcg12caD+4L8b6WEV6ipYH3AO9Ao8483nKZVxKMrjT503A3vzefy1NrJCkfn3Uyte/fQ==
X-Received: by 2002:a2e:9a56:: with SMTP id k22mr4227257ljj.308.1590257685588;
        Sat, 23 May 2020 11:14:45 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a17sm1048656lji.50.2020.05.23.11.14.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 11:14:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c12so8349203lfc.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:14:44 -0700 (PDT)
X-Received: by 2002:a19:4048:: with SMTP id n69mr5329431lfa.31.1590257684192;
 Sat, 23 May 2020 11:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200523131759.GA55886@kroah.com> <20200523152922.GA224858@kroah.com>
In-Reply-To: <20200523152922.GA224858@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 May 2020 11:14:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
Message-ID: <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
To:     Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 8:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> The kobject patch that was originally in here has now been reverted, as
> Guenter reported boot problems with it on some of his systems.

Hmm. That original patch looks obviously buggy: in kobject_cleanup()
it would end up doing "kobject_put(parent)" regardless of whether it
had actually done __kobject_del() or not.

That _could_ have been intentional, but considering the commit
message, it clearly wasn't in this case.  It might be worth re-trying
to the commit, just with that fixed.

Btw, when you end up reverting a patch that was already the top patch,
you might as well just remove it entirely from that tree instead (ie
"git reset --hard HEAD^" instead of "git revert HEAD").

Unless somebody else uses your branches and you are afraid that the
non-reverted commit escaped out in the wild that way?

            Linus
