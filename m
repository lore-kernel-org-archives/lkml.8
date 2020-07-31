Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0918AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD042083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgGaOCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:02:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgGaOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:02:22 -0400
Received: from [192.168.1.155] ([95.114.120.213]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MhToz-1kg5cc0SLD-00ef57; Fri, 31 Jul 2020 16:01:53 +0200
Subject: Re: [PATCH 1/1] platform/x86: revert pcengines-apuv2 wire up
 simswitch gpio as led
To:     Florian Eckert <fe@dev.tdt.de>, info@metux.net,
        vhart@infradead.org, andy@infradead.org,
        Eckert.Florian@googlemail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200713085010.26394-1-fe@dev.tdt.de>
 <6def788e-f2f8-da80-b189-56ae4630440f@metux.net>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <e95c8b76-cfaf-4d49-aa93-525093e61e03@metux.net>
Date:   Fri, 31 Jul 2020 16:01:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6def788e-f2f8-da80-b189-56ae4630440f@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jA9Or+qBlJ2CYZuXXMTrCs2fkwGYrSkJbjvlTgxK0uH9UmqrLJN
 OlLqUgTfZh3B6wkI06rEN8DcaNt3/Ej27WPajqsZUO5ezsLAKnmLYRY1W4dyt0UCW6SarCE
 MBTiRdSkLdgOvy1Ah0h1fDWiSid72TW+gcssaDnZPPnjoxl0bhUL5Weua6FVGXPbvg8Qkh9
 icaBcubOXgtrrTVPJNBrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ckw6LQbL208=:w2DqihxH7MkiAtM/DFWOyj
 4NHAA3DMGIXtqBZiK2uKa3FN46sg5dI71gqiOZ+DpXQ8JrFRd4BWcbvm+T7Os3NvURlKVF/bV
 8l5iixanSix0VFb+N5o1n85Mti6ETkCHgMVAIBAEWXbyVFQEJdIkZZFpnBo4FC9+Jmm8Og/ny
 maorzpNaAq0hBXsvSAtWMeDjQfJ7tl3huQ7sGyO4r7ecr7A9KL8Nx/W6e3xOVWxyS9IMJtJCw
 ZVsPv6lPfVwc9i9fJITXafDmX1eQjZO/g4BtKJxiaVyCOjQLaC6Jv7i1vs3lEjQqili9Qe1Mr
 8OfW+8kXBNn2J+Ua6wv84eRRTp2o1I+OFWlahVzvLTe65jGZwvaN9T4DLH2bByjx4CChDfeJ6
 ag0zFv1DEYgeXBjXcAbOoT8aFNMUSPJapxyfruh54y5ZqycI9DnXpYmZEi+bE5Kr45kj8036X
 caV91kwIxHgHW8BD30qC68Atw7G9rQYHVqTzMA5P9LTmKKtvM/ftWZ65vg9IntKVQWD2aSL1j
 1ao5fxdGWczv8ryipxnkVSE6/ujAmy6g5rm6ZCCqCmw8+fLw2gkN/UN5YzGTJXL+oMcNq2rwg
 PK+oeiLeVWXFo+ySbKtPoPQbDssUL0HarhKyRCvpfZb0n5DCVQq3DfHJ1dqGKsxjrN9PYoavz
 mh6rsnqgFwhxPyJMSAw4MtC5u1qRZcvkfP/6RbhOwdCydQ2Sw69V7es5vbX41grKY+khuQjiN
 CNRUGp7xXtCd2b0EBsFZl2tHHpBvB2Om8SoBHFXxAWWvbiIW3Z77OPuh+H/PDHcFhhbcSHcIZ
 g0aUntcNWpB2AitRqo5+0eTNGKTD/5LuJERljnG2gbQaCWz8MkHBfM+3zhXItUNgitTAQk/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.20 15:45, Enrico Weigelt, metux IT consult wrote:

Addendum: there's even more functionality we'll loose

Individual LED lines can be made available to specific
unprivileged users / processes, eg. chmod or passing fd's.

For example, allowing a web application to pull the switch,
w/o ever becoming root. And that's indeed a practial use case,
which is used in the field.

--mtx


> On 13.07.20 10:50, Florian Eckert wrote:
> 
> Hello Florian,
> 
>> This reverts commit 5037d4ddda31c2dbbb018109655f61054b1756dc.
> 
> no, please dont.
> 
>> This change connects the simswap to the LED subsystem of the kernel.
>> From my point of view, it's nonsense. If we do it this way, then this
>> can be switched relatively easily via the LED subsystem (trigger:
>> none/default-on) and that is dangerous! If this is used, it would be
>> unfavorable, since there is also another trigger (trigger:
>> heartbeat/netdev).
> 
> I don't think that potential silly abuse is a good argument. It if
> would, we should also disallow things like "echo FOO > /dev/sda" :p
> 
> The reason for it wire'ing up was having an simple and easy to use
> interface. Raw gpios do NOT meet this criteria: complicated to use and
> not stable addressing (from userland PoV) - would require an extra
> userland program just for that single specific task.
> 
> Yes, LED is not the optimal approach, same for other gpio-connected
> switches, eg. relais or various multiplexers. But as long as we don't
> have a really fitting subsystem, it's IMHO the best compromise we have
> so far.
> 
> Actually, I've already been hacking on a better subsystem, which models
> switchable inter-device connections. It's called portmux. But it's not
> usable yet. Lets talk about this instead of just wildly dropping
> existing functionality, that's used in the field.
> 
> 
> --mtx
> 

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
