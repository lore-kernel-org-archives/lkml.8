Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F28208A7
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgE3BAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 21:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgE3BAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 21:00:00 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80A620810;
        Sat, 30 May 2020 00:59:58 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] fix missing handling of __user in nommu's
 uaccess()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20200529190218.36560-1-luc.vanoostenryck@gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <fb352763-1ed1-2072-9cfa-bc12974892cd@linux-m68k.org>
Date:   Sat, 30 May 2020 10:59:55 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529190218.36560-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On 30/5/20 5:02 am, Luc Van Oostenryck wrote:
> I received a bug report for an unrelated patch when used with m68k-nommu.
> It appears that the origin of the problem is that __get_user() and
> __put_user() doesn't handle correctly __user. These 2 patches fix this.
> 
> Note: this is only minimaly tested but is quite straightforward and
>        since this only change __user annotation it will not change the
>        generated code.
> 
> 
> Changes since v1:
> * fix typo: s/plan/plain/
> * appease checkpatch with better style: s/__force*/__force */
> * avoid excessive line length caused by the added cast.
> 
> Luc Van Oostenryck (2):
>    m68k,nommu: add missing __user in uaccess' __ptr() macro
>    m68k,nommu: fix implicit cast from __user in __{get,put}_user_asm()
> 
>   arch/m68k/include/asm/uaccess_no.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Looks good, thanks for the fixup.
Applied to the m68knommu git tree, for-next branch.

Regards
Greg

  
