Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F39A2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTKn3CoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgC3Ie6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:34:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34520 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729594AbgC3Ie5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585557296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VI4VJLvwA2Wnz1xcO7Y+Io0RjGUfdGgCzJ2iSp2r2DU=;
        b=iTKn3CoZXapbq49bu6BdujZ63BNuVMTASDQi53Sb/KRfXsKAnlLtu0w2LLe86R8Fuk4o8m
        SDO4NDDL7a8iWmTT5RBKLafolQ/s6rBNxbXw/o4bR79jYkGnJDhlZXu9dBIzheT16N74Rc
        2sS3JH3vNhwWdVYpCRhJwHMsRC/CMXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-VzhFc2_pNWWc7DodrKjNHA-1; Mon, 30 Mar 2020 04:34:52 -0400
X-MC-Unique: VzhFc2_pNWWc7DodrKjNHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6191E8010C8;
        Mon, 30 Mar 2020 08:34:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id ACE89100EBAF;
        Mon, 30 Mar 2020 08:34:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 30 Mar 2020 10:34:50 +0200 (CEST)
Date:   Mon, 30 Mar 2020 10:34:46 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Adam Zabrocki <pi3@pi3.com.pl>, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: Curiosity around 'exec_id' and some problems associated with it
Message-ID: <20200330083446.GA13522@redhat.com>
References: <20200324215049.GA3710@pi3.com.pl>
 <202003291528.730A329@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003291528.730A329@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29, Kees Cook wrote:
>
> On Tue, Mar 24, 2020 at 10:50:49PM +0100, Adam Zabrocki wrote:
> >
> > In short, if you hold the file descriptor open over an execve() (e.g. share it
> > with child) the old VM is preserved (refcounted) and might be never released.
> > Essentially, mother process' VM will be still in memory (and pointer to it is
> > valid) even if the mother process passed an execve().

This was true after e268337dfe26dfc7efd422a804dbb27977a3cccc, but please see
6d08f2c7139790c ("proc: make sure mem_open() doesn't pin the target's memory"),
iir it was merged soon after the 1st commit.

Oleg.

