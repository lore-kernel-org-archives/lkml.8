Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7877C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706D720787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUE0r61X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cC6Mo8eJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGPV2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:28:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGPV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:28:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594934915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQ+PlzA9B26wHo1dmNCnKAn7F5Oy++sykBKcPELUPDU=;
        b=oUE0r61XlGltGTjg005mqrRSijW5FJ0E9aWRlaErQ77m+K09VwTBGsRN4q1xMmAvRXqbVT
        bhu4VkXST0BaAAl9BeGJW1wJw1q3arOr55OqrXSRQXf+eeXX4OJZnh20QPMJjW6S4y7Rjd
        36Rd0KedufzIAbZmMME2RwzeWiuxQAgUoUdaDGr8J36Db4FGJ2gP5N5xXJrX83fTBHVpfj
        hZfOUs0d0kuwWVKEkICA9zeDEOuK837q/ibooG+Ve0UnmqErtVb0L78WmAHTgkafzWdHp+
        3JajUBhGZACCCJvGp84UDICotpiRI70tXUMhs31A39JQ6PD+dOLr/1csNMaTOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594934915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQ+PlzA9B26wHo1dmNCnKAn7F5Oy++sykBKcPELUPDU=;
        b=cC6Mo8eJEXM/j646xiRWb9FAkKXECI71ZPFK/q/D2eRtqbJdk8y07xKJaK7dKlRynQFAq3
        13hf/b99FbQJpbBw==
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch V3 02/13] entry: Provide generic syscall exit function
In-Reply-To: <202007161354.62030182F@keescook>
References: <20200716182208.180916541@linutronix.de> <20200716185424.116500611@linutronix.de> <202007161354.62030182F@keescook>
Date:   Thu, 16 Jul 2020 23:28:35 +0200
Message-ID: <87k0z3taik.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Thu, Jul 16, 2020 at 08:22:10PM +0200, Thomas Gleixner wrote:
>
> This looks correct to me. Did you happen to run the seccomp selftests
> under this series?

Yes, I threw the relevant self tests on it.
