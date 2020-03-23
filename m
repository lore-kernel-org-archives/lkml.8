Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B15C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B723920719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCWQdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:33:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCWQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:33:43 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGQ1B-0002JV-7s; Mon, 23 Mar 2020 17:33:37 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id ACBFF1040AA; Mon, 23 Mar 2020 17:33:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 04/17] kernel: futex.c: get rid of a docs build warning
In-Reply-To: <20200320170035.581f5095@coco.lan>
References: <cover.1584456635.git.mchehab+huawei@kernel.org> <aab1052263e340a3eada5522f32be318890314a1.1584456635.git.mchehab+huawei@kernel.org> <87h7yj59m0.fsf@nanos.tec.linutronix.de> <20200320170035.581f5095@coco.lan>
Date:   Mon, 23 Mar 2020 17:33:36 +0100
Message-ID: <87h7yfowtb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Fri, 20 Mar 2020 16:28:23 +0100
> Thomas Gleixner <tglx@linutronix.de> escreveu:
>
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> 
>> The subject prefix for this is: 'futex:'
>
> Ok!
>
>> >   * For shared mappings (when @fshared), the key is:
>> > - *   ( inode->i_sequence, page->index, offset_within_page )
>> > + * ( inode->i_sequence, page->index, offset_within_page )  
>> 
>> Sigh. Is there no better way to make this look sane both in the file and
>> in the docs?
>
> The enclosed patch would do the trick.
>
>
> [PATCH 04/17 v2] kernel: futex: get rid of a docs build warning

The prefix is still wrong. See above.

git log --oneline $FILE usually gives you a pretty good hint.

Thanks,

        tglx
