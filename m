Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC4C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B9D24654
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A7rtsSNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCJA0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:26:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59993 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbgCJA0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:26:17 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02A0PxL22004965
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 9 Mar 2020 17:26:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02A0PxL22004965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1583799962;
        bh=l8cIfFOJQ1rud7lMJxnw7VNi3H5zJJeiLSZ6XUw35uc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A7rtsSNZK/9OYmTs2D5xuT9LYA1BCu8CRBgg1xrxP3aDsc+WCjhYRgrSARjA7R7NO
         PH/c4KGAieKLWDvBlGjYo2lWQ0vaOQfcqofz4meGbl8oJUhHbOfzOQQu7zomaa1aoM
         9ZCL586WG1yfsEGIPBtRwqBKI4BfgjlypJyblQe6clXy3yt6j4ZH9yQ5H08h6krFAS
         80g6oeeQfAtjvi+hSR40YQDXVgWmvI7G2IphR4Cp/98VdIFQxH1hM/9RaBY6MBFF3E
         Xie6pUS3NpgxRPSi8MNYzx/h+IbezJyUIppgrpKyD2uYF3pjrBDbb193yXZcriQ5be
         ewwCJvlpFuLDA==
Subject: Re: [PATCH] x86/Kconfig: make X86_UMIP to cover any X86 CPU
To:     Borislav Petkov <bp@alien8.de>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, DavidWang@zhaoxin.com,
        CooperYan@zhaoxin.com, QiyuanWang@zhaoxin.com,
        HerryYang@zhaoxin.com, CobeChen@zhaoxin.com
References: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200309203632.GB9002@zn.tnic>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <79c4bc05-0482-3ce7-0f93-544977e466dc@zytor.com>
Date:   Mon, 9 Mar 2020 17:25:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200309203632.GB9002@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-09 13:36, Borislav Petkov wrote:
> 
> If you're going to do that, is there even any use for that config option
> at all?
> 
> AFAICT, it adds ~1K to kernel text so we might just as well remove the
> ifdeffery completely. The code ends up built in in 99% of the cases
> anyway...
> 

Perhaps the super-tiny-embedded kernel guys care? Otherwise it seems
pointless.

In general, once INTEL and AMD is enabled, it is just a matter of time
until other (still existent) vendors add those features, at least for
core features.

	-hpa
