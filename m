Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E7FC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FC224650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582695338;
	bh=9bbcjN9SEF1PWCL8aSyZA24plSmItb3JHKjvJV3pbnE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=G1WbaX3Sx2nNawbcruwVohDhIkGJUtM5dO+UVb+5+Ai86SANWq73WR107weIxlA0C
	 3I2T9kVuhK6MHD3N4fAWgealoIPUeS2SEVbfTn7leK5tK7WZqAndDq82R4PfrQTp1q
	 bEaufDJT0cNy2jZ1q1Vooj+jKQH6gSaMQOQO4hXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBZFfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgBZFfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:35:37 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5517021927;
        Wed, 26 Feb 2020 05:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582695336;
        bh=9bbcjN9SEF1PWCL8aSyZA24plSmItb3JHKjvJV3pbnE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yipxq4WVvzXDpLiKwk4sgJ+LVWGWdpHX74wtvIHGLKFQ+GUiycPySqwrNucrIq/WR
         O38qtagPULwdJquh1kTTE0bkVjPM9HMnxKm6C2sRAV2l1gngsBO5JLX/aNbjvKFp8M
         w9wh+sDGHGJWJ/eNni2m+eQgtG1Hh6c7o25wtYwI=
Subject: Re: [patch 00/10] x86/entry: Consolidation - Part I
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225213636.689276920@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <5f2b5a3d-4399-664e-12ab-5ef9a747b499@kernel.org>
Date:   Tue, 25 Feb 2020 21:35:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225213636.689276920@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 1:36 PM, Thomas Gleixner wrote:
> Hi!
> 
> This is the first batch of a 73 patches series which consolidates the x86
> entry code.
> 
> 

In part 1, all but 08/10 are:

Reviewed-by: Andy Lutomirski <luto@kernel.org>

I object to patch 8 as described in my reply.
