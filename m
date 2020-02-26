Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A20C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1821724653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582696255;
	bh=ctVqMjwa/F25yqka0j/NszWNx07B6icBsj8wlcnfc/Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mKrZ/iWS1KaUZ4JhnA2xHGzZhMm1yCRK3DY7YdVEG8mcvQNNJ2q7toPDOi8YRlvAs
	 tj+qI4cqkJQ7IBd00RKfdqzJKy0m6GUp7j1+PpaAr4vdF+02j6t/eNrtRe1hREwVkL
	 ini5uzCzbYFAf1+hYtE1OWBY6vAjiiSv1fWwdWyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBZFuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:50:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBZFux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:50:53 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C11206E2;
        Wed, 26 Feb 2020 05:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582696253;
        bh=ctVqMjwa/F25yqka0j/NszWNx07B6icBsj8wlcnfc/Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zFpfda9vV9ADuHEkZb/MHcfCb5ft4jKHzlpeLVxWzvFSbl8mmWEbHR0HdCdkKmh2w
         ig+SxXZdHph0hemWnOL/n9diuMWNDyDA7MhkOeLK/Iu6fBkZ8lIiWbGjsEg7QV5bYb
         Nw+rEAEYgfncdvUpcd7oKRukR4hR+bY5qH/+UzD4=
Subject: Re: [patch 7/8] x86/entry: Move irq tracing to
 prepare_exit_to_user_mode()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.919875257@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <db063edd-f1de-bbb4-3c8b-465904308aad@kernel.org>
Date:   Tue, 25 Feb 2020 21:50:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225221305.919875257@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:08 PM, Thomas Gleixner wrote:
> which again gets it out of the ASM code.

Why is this better than just sticking the tracing in
__prepare_exit_from_usermode() or just not splitting it in the first place?

(ISTM the real right solution is to make sure that it's okay for
trace_hardirqs_... to be safe even when rcuidle.  But I may still be
missing something.)
