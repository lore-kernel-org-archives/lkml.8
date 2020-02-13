Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FCBC3B18F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D4B20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAdpu5qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBMWLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:11:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26035 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727772AbgBMWLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581631880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8CYIylXszw5T12nzwhCt2wOP17igubFfMw076GDMa8=;
        b=RAdpu5qFwLkwa57yNe4+SaAIid5CBmLJZZgJ3Dvc+KHjmePuynQXlvrBIBzWomyZAuSeSW
        fuAtrgmMndVqawuIoplIGGjsRabEPhTRPPP22WQTsWKP/9IEW7iFCsNc2v/xXU37y5Myk8
        Rs8Eqs7FH7LTyn29SL/rIe0ziOxz+08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-ClN-4b6NMPa4-IJWdfJHLw-1; Thu, 13 Feb 2020 17:11:04 -0500
X-MC-Unique: ClN-4b6NMPa4-IJWdfJHLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9746D1005514;
        Thu, 13 Feb 2020 22:11:03 +0000 (UTC)
Received: from treble (ovpn-121-12.rdu2.redhat.com [10.10.121.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFB14272A1;
        Thu, 13 Feb 2020 22:11:02 +0000 (UTC)
Date:   Thu, 13 Feb 2020 16:11:00 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: core/objtool] objtool: Fail the kernel build on fatal
 errors
Message-ID: <20200213221100.odwg5gan3dwcpk6g@treble>
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
 <158142525822.411.5401976987070210798.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158142525822.411.5401976987070210798.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:47:38PM -0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the core/objtool branch of tip:
> 
> Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
> Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
> AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00
> 
> objtool: Fail the kernel build on fatal errors
> 
> When objtool encounters a fatal error, it usually means the binary is
> corrupt or otherwise broken in some way.  Up until now, such errors were
> just treated as warnings which didn't fail the kernel build.
> 
> However, objtool is now stable enough that if a fatal error is
> discovered, it most likely means something is seriously wrong and it
> should fail the kernel build.
> 
> Note that this doesn't apply to "normal" objtool warnings; only fatal
> ones.

Clang still has some toolchain issues which need to be sorted out, so
upgrading the fatal errors is causing their CI to fail.

So I think we need to drop this one for now.

Boris, are you able to just drop it or should I send a revert?

-- 
Josh

