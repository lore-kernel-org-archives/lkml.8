Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C0C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027BC24653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582695914;
	bh=dywBPHcqQRK3tK3rmlQ+vgrYHMjMecnzaSIBGxs738g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=eZ2yxyxqbcHg36hYgbLgL8TFQfXCOXNiXTkli2dq7SbGnFBN74xQnYJIQdYYVzTc1
	 0qNpP+UVpDSxWCTL79aTkzFA6emp1zWfcsxcvtua7KmwB4lf53WRrw/oAKOZF2hKXA
	 7mW+FVU53D+Iv8ptVFimJAcxMhl5fTwwXqo8sdpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgBZFpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBZFpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:45:12 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94DA1206E2;
        Wed, 26 Feb 2020 05:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582695911;
        bh=dywBPHcqQRK3tK3rmlQ+vgrYHMjMecnzaSIBGxs738g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=spvtd7Po9KGEF83pv2kM4XTeS6PlnhfCOiMRWEH0G231pQjNb4HpRwHJwyQy75RFH
         LZwAwDHCm68bWckYG2vh8wWTHRgSC4P9YiNdLL38sW2fixtFrHBCcf6IKv5P9BDbKY
         TVT2Zu4tmh/ZwRZxgh9THHm6UL1snJWgebWIpR14=
Subject: Re: [patch 5/8] x86/entry/common: Provide trace/kprobe safe exit to
 user space functions
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.719921962@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <f6f11204-4277-fad0-c1c2-a21e0a380e3b@kernel.org>
Date:   Tue, 25 Feb 2020 21:45:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225221305.719921962@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:08 PM, Thomas Gleixner wrote:
> Split prepare_enter_to_user_mode() and mark it notrace/noprobe so the irq
> flags tracing on return can be put into it.

Is our tooling clever enough for thsi to do anything?  You have a static
inline that is only called in one place, and the caller is notrace and
NOKPROBE.  Does this actually allow tracing in the static inline callee?

--Andy
