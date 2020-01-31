Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10E42082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z812Ip8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgAaAqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:46:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgAaAp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UpM7VFG/zdQEWVczMpq8Y9+PdpJOLXC1FfE6Cj2VPL4=; b=Z812Ip8GK0i5I8as4kw56sgX1
        n6Ne/Zw7lxZtjj+iT596InY105gESqowa+uCnSoDBxwNVxF2Q+p17ay+d2scn0QoEjXEqoiEFf7JT
        tgOA9YkX1Q3PHUjqLY+69kfFFtiCpHfnMckNHWpgWawts9G5aNdhXob8zDSA21eOFPLYxXEPL1CnW
        Maq6hg6OVAAUf7H72tDIu4MG6I3qTgC09FBslJWTJDLHve78n3QL2vJss5KfhD7t04Nmcf3b4WTtJ
        BTG2BJvG83AtARHWOYeKQ8MAvLOVvOFtfcY0gihDYrEmFbIBEV9rCIHf9Y2reWcYn0IUxwDiTDVv8
        ldUDGHLLQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixKRa-0006mu-L4; Fri, 31 Jan 2020 00:45:58 +0000
Date:   Thu, 30 Jan 2020 16:45:58 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Benjamin Gordon <bmgordon@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Raul Rangel <rrangel@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add a "nosymfollow" mount option.
Message-ID: <20200131004558.GA6699@bombadil.infradead.org>
References: <20200131002750.257358-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131002750.257358-1-zwisler@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 05:27:50PM -0700, Ross Zwisler wrote:
> For mounts that have the new "nosymfollow" option, don't follow
> symlinks when resolving paths. The new option is similar in spirit to
> the existing "nodev", "noexec", and "nosuid" options. Various BSD
> variants have been supporting the "nosymfollow" mount option for a
> long time with equivalent implementations.
> 
> Note that symlinks may still be created on file systems mounted with
> the "nosymfollow" option present. readlink() remains functional, so
> user space code that is aware of symlinks can still choose to follow
> them explicitly.
> 
> Setting the "nosymfollow" mount option helps prevent privileged
> writers from modifying files unintentionally in case there is an
> unexpected link along the accessed path. The "nosymfollow" option is
> thus useful as a defensive measure for systems that need to deal with
> untrusted file systems in privileged contexts.

The openat2 series was just merged yesterday which includes a
LOOKUP_NO_SYMLINKS option.  Is this enough for your needs, or do you
need the mount option?

https://lore.kernel.org/linux-fsdevel/20200129142709.GX23230@ZenIV.linux.org.uk/
