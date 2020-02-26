Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968DDC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CC124653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582696409;
	bh=YJAYP9uxW0FBKT9bLe0D3NvnIHdDvRqJxzcbQq24pMU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mySYxZEHsFK0USZSMgSSzZYp8PWPGH43doHBp2T5E2sVsZzk68deQOtoJx/nTrVAF
	 Yv7rQRxnnlH7XFWi+NtiH4WBJdh9weUInz+MxfuBDoEW+DlIO9nKewzefRZ8V1Y+ID
	 9IO7DEmAdQpVHMh5C8n5SPF1a6Z1YpkPfGxu9xxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBZFx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBZFx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:53:28 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C47E21556;
        Wed, 26 Feb 2020 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582696407;
        bh=YJAYP9uxW0FBKT9bLe0D3NvnIHdDvRqJxzcbQq24pMU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QCWSYSNMPCfRqnX1yoau3RvFFnU/3ggXzFnUiPgIAdkT/SJxxcwvIUkuNiRWju3Fj
         ctyXUDjrqj/bQVt5H2gMzN32Bh8G0WpgoOgdZYodtkfGBXSXXCTxDpejL+mtCnR3Pg
         EBgy1L1iyX1J429Zo5BlsEBLA5wRGTz21l8MTfUg=
Subject: Re: [patch 03/24] x86/entry/64: Reorder idtentries
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.485203436@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <19ec0b66-da68-28cc-9996-40820592847f@kernel.org>
Date:   Tue, 25 Feb 2020 21:53:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.485203436@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:16 PM, Thomas Gleixner wrote:
> Move them all together so verifying the cleanup patches for binary
> equivalence will be easier.

Acked-by: Andy Lutomirski <luto@kernel.org>

