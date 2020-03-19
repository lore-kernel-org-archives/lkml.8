Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C21C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD5A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCSNtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:49:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbgCSNtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:49:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47DB16AAA082909C29D6;
        Thu, 19 Mar 2020 21:49:16 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.205) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Mar 2020
 21:49:05 +0800
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Subject: Why is text_mutex used in jump_label_transform for x86_64
To:     <andrew.murray@arm.com>, <bristot@redhat.com>,
        <jakub.kicinski@netronome.com>, Kees Cook <keescook@chromium.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, <bobo.shaobowang@huawei.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <f7f686f2-4f28-1763-dd19-43eff6a5a8f2@huawei.com>
Date:   Thu, 19 Mar 2020 21:49:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi，everyone

I'm sorry to disturb you. I have a problem about jump_label, and a bit 
confused about the code

I noticed that text_mutex is used in this function under x86_64 
architecture,
but other architectures do not.

in arch/x86/kernel/jump_label.c
         static void __ref jump_label_transform(struct jump_entry *entry,
              enum jump_label_type type,
              int init)
         {
          mutex_lock(&text_mutex);
          __jump_label_transform(entry, type, init);
          mutex_unlock(&text_mutex);

in arch/arm64/kernel/jump_label.c

         void arch_jump_label_transform(struct jump_entry *entry,
                                        enum jump_label_type type)
         {
                 void *addr = (void *)jump_entry_code(entry);
                 u32 insn;

                 if (type == JUMP_LABEL_JMP) {
                         insn = 
aarch64_insn_gen_branch_imm(jump_entry_code(entry),
jump_entry_target(entry),
AARCH64_INSN_BRANCH_NOLINK);
                 } else {
                         insn = aarch64_insn_gen_nop();
                 }

                 aarch64_insn_patch_text_nosync(addr, insn);
         }


Is there anything wrong with x86

or

is this missing for other architectures?


Thanks

---- Cheng Jian





