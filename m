Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14AAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A2720656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598217177;
	bh=nLgwnKShUqKPc0FGg/NC07wShXozDBhWeWygswaJ1Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uogV7mEmKwX/jIy/pCmT+4O/fu5EYoqaL8vfePoa4X9YlsnSX15nGO9LgeSgYkQ/O
	 pOuUmaanVY+MgX//2tFj342U7yikd9N2ysmoqav+l8rcm4H7MqOgrbicU2vVdn+Se/
	 /v0vChbEKZd/q9+kXutLmwHDrVg4/xMJTZtpjjq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHWVM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 17:12:56 -0400
Received: from mail.stusta.mhn.de ([141.84.69.5]:33766 "EHLO
        mail.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgHWVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 17:12:55 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Aug 2020 17:12:54 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4BZSQ04x3mz3Q;
        Sun, 23 Aug 2020 23:02:48 +0200 (CEST)
Date:   Mon, 24 Aug 2020 00:02:46 +0300
From:   Adrian Bunk <bunk@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, alex.gaynor@gmail.com,
        geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200823210246.GA1811@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost>
 <20200712193944.GA81641@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200712193944.GA81641@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 12:39:44PM -0700, Josh Triplett wrote:
>...
> Rust has hard stability guarantees when upgrading from one stable
> version to the next. If code compiles with a given stable version of
> Rust, it'll compile with a newer stable version of Rust.
>...

In librsvg, breakages with more recent Rust versions in the past year
required updates of two vendored crates:
https://gitlab.gnome.org/GNOME/librsvg/-/commit/de26c4d8b192ed0224e6d38f54e429838608b902
https://gitlab.gnome.org/GNOME/librsvg/-/commit/696e4a6be2aeb00ea27945f94da066757431684d

For updating Rust in Debian stable for the next Firefox ESR update it 
would actually be useful if these violations of the "hard stability 
guarantee" in Rust get fixed, so that the old librsvg 2.44.10 builds 
again with the latest Rust.

It also makes me wonder how such regressions slip into Rust releases.

cu
Adrian
