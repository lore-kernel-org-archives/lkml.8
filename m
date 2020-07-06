Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A10C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021F82073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGFIPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:15:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:58654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgGFIPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41029AD5D;
        Mon,  6 Jul 2020 08:15:43 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        "lollivier@baylibre.com" <lollivier@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Green Wan <green.wan@sifive.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
        <mvmftabiklh.fsf@suse.de>
        <CAEn-LTqMAf8vaaMhkX7h7+iY8U8v6JTSpW1FMj+JDr7PaWx1zw@mail.gmail.com>
        <BN6PR1301MB2020C5FAA902AC521721319A8C6A0@BN6PR1301MB2020.namprd13.prod.outlook.com>
X-Yow:  I'm into SOFTWARE!
Date:   Mon, 06 Jul 2020 10:15:42 +0200
In-Reply-To: <BN6PR1301MB2020C5FAA902AC521721319A8C6A0@BN6PR1301MB2020.namprd13.prod.outlook.com>
        (Yash Shah's message of "Fri, 3 Jul 2020 05:53:23 +0000")
Message-ID: <mvmtuylcb4h.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 03 2020, Yash Shah wrote:

> Yes, you are right. The userspace governor is the only one supported.

That doesn't make sense to me.  How is the userspace governor different
from any other governor?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
