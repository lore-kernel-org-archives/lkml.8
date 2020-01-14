Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEE4C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C5524672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgANL61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:58:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42870 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:58:26 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irKpx-000374-Hh; Tue, 14 Jan 2020 12:58:21 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BF368101DEE; Tue, 14 Jan 2020 12:58:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Colin Ian King <colin.king@canonical.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/amd: fix uninitalized structure cp
In-Reply-To: <b59bb156-891e-3a26-3204-f5a0a1cc60d3@canonical.com>
References: <20200114111505.320186-1-colin.king@canonical.com> <20200114113834.GE31032@zn.tnic> <b59bb156-891e-3a26-3204-f5a0a1cc60d3@canonical.com>
Date:   Tue, 14 Jan 2020 12:58:20 +0100
Message-ID: <8736cickrn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> writes:
> On 14/01/2020 11:38, Borislav Petkov wrote:
>>>
>>> Addresses-Coverity: ("Uninitialized scalar variable")
>> 
>> I already asked about those: either document what those tags mean or
>> remove them.
>> 
> I can send a V2 w/o these if it so pleases you. I've had nobody else
> complain about these and we have literally hundreds of Coverity tagged
> issues now accepted in the kernel so that we can trace how fixes are found.

Please keep them. Having a reference how stuff got "reported" _is_
useful.

Thanks,

        tglx
