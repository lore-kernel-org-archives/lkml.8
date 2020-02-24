Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F773C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE420714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBXJWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:22:07 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:52251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:22:07 -0500
Received: from [192.168.178.56] ([109.104.43.98]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGi6m-1jA1oK1ycM-00DqDT; Mon, 24 Feb 2020 10:21:42 +0100
Subject: Re: [PATCH v2] irqchip/bcm2835: Quiesce IRQs left enabled by
 bootloader
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Schneider <serge@raspberrypi.org>,
        Kristina Brooks <notstina@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
References: <20200212123651.apio6kno2cqhcskb@wunner.de>
 <61cc6b74-3dd2-38d0-6da0-eb3fbd87c598@i2se.com>
 <20200223182445.n44wgrourk4cpfoq@wunner.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <1a5735e8-b876-92e4-9f1e-687f5abf8708@i2se.com>
Date:   Mon, 24 Feb 2020 10:21:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200223182445.n44wgrourk4cpfoq@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:nvv+kzY7b4+AacEf0WpzQB8/RizEp3+ZM6DrnRkvntJts48S1Pw
 rOcsEq61Ufa2KgomwK6FKBjdHDbxoyzKZcaFckx5h0rSqwHToryJcMrXqIMg2baqOSOoVkL
 7kz9+JW7d2XTEd9ZaxchbR9jPOTPlhyIPA2jNxnH30QPJXyBXfnW9aGu8ZTbKx+czIe5xYo
 vmJkkzZJOQH6cNOLp4MBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fAsX8aDpBAI=:/wSapfaezyq+vnt/TzdcWr
 HLvx64INvtF3e82wUf+qOZiYxrFUCJ/aIhLi9DTMRBxUOfcBjkk98VZVh7nwgY2plXye0Ngsv
 dRztdjzU3ZxL89f5kO6rrcSWfZ7mrg4iZK3U7SsZ1ZE/6Zi1xdZ0lWh0nweqf5KJ6tDzghp9t
 zN5V7RfjsNhus25gjZkFfecbY/PhjDbr808sukOEXuBZm8k8c7r6KnHRjAoJRVhMR8H4JP0An
 Ls4RU+jCZSCB+5zTrVKYrnORTpP4GF+eNgOFPPSnJNi7m+OmozV/Eg3PBtWitHIw3bA+PQjag
 Lx268ak1oVJHCiv6+R/dYSCbKjMnih/zEFf+sqw3//zrwNyaGkLo5uHwnuINzYZcch5p7Sl7s
 90k9ToxqbFTaMuwG473sB8X7A33ET5NxKm9e6cB+yNHWMzIHarGPZRADS2XG46v4j/Bw+4rlq
 gpPWn7HgX+fK7BFfE4VPj7DMQGNmKtLu9ScH8FEc70oh/Y5s3RsQexbjUZKizp1U4FHLcCJXB
 CVoeATEmafQAajFSf7y1hcNF883fL7pVuFI9lq0o1GxZcn5fBOsD1+6yx3wjuBc+gYiELf0Ev
 cMrgwCAr27zyIVZqWPyycA0QQbUxuiuSABK3LnaDl0qibNur/V8xO5upivU9ZSyvWT/CNZ5u4
 Zd3gMkLljB2uJpmPiXI/S94WskRRsJILUtGI4zzn8O8e0CjwhgmKIdt5whryEji03uFePjU5P
 GObo3F7YUN4HIIKv5f92OmJZpuAUiKt+AhLjlKmTHNPyKat7ZbYr8s2IIM6ABXkStqnSXVxEn
 mwTRduyOrKY0l9tCzlBOH3ZCGWkdWAdHj5Ueur/gtT218+bEFEpjAizflyQUGn5ay3BXm7X
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 23.02.20 19:24, Lukas Wunner wrote:
> On Sun, Feb 23, 2020 at 06:59:56PM +0100, Stefan Wahren wrote:
>> thanks for all the investigation. Unfortunately the patch below doesn't
>> compile, since it lacks the definiton of REG_FIQ_ENABLE.
> Ugh, I recall fixing that when compile-testing.  I must have forgotten
> to invoke "git commit --amend" before "git format-patch".
>
>> Btw the name is a little bit unlucky because it defines a single flag
>> within REG_FIQ_CONTROL instead of a separate register.
> The Foundation's repo uses that name so I stuck by it to reduce the
> number of merge conflicts Phil will have to resolve.  Happy to change
> though, suggestions welcome.

readability has a higher prio. How about:

#define FIQ_CONTROL_ENABLE BIT(7)

Regards
Stefan

