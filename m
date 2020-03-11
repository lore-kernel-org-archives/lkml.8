Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5272AC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238F121655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgCKLkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:40:18 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47230 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgCKLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:40:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jBziW-001C1S-CG; Wed, 11 Mar 2020 12:40:04 +0100
Message-ID: <e3bfa0844566db1a837534218fe128f66cfe2e79.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Date:   Wed, 11 Mar 2020 12:40:03 +0100
In-Reply-To: <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
References: <20200226004608.8128-1-trishalfonso@google.com>
         <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
         (sfid-20200306_010352_481400_662BF174) <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
         <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Pid: 504, comm: modprobe Tainted: G           O      5.5.0-rc6-00009-g09462ab4014b-dirty
> RIP:  
> RSP: 000000006d68fa90  EFLAGS: 00010202
> RAX: 000000800e0210cd RBX: 000000007010866f RCX: 00000000601a9777
> RDX: 000000800e0210ce RSI: 0000000000000004 RDI: 000000007010866c
> RBP: 000000006d68faa0 R08: 000000800e0210cd R09: 0000000060041432
> R10: 000000800e0210ce R11: 0000000000000001 R12: 000000800e0210cd
> R13: 0000000000000000 R14: 0000000000000001 R15: 00000000601c2e82
> Kernel panic - not syncing: Kernel mode fault at addr 0x800e0210cd, ip 0x601c332b

Same if I move it to the original place from your v2 patch
(0x100000000000):

Kernel panic - not syncing: Kernel mode fault at addr 0x10000e0c7032, ip 0x601c332b

Not sure what to do now?

johannes

