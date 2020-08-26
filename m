Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3315BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A3422B43
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHZSxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgHZSxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:53:30 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8DA2078A;
        Wed, 26 Aug 2020 18:53:29 +0000 (UTC)
Date:   Wed, 26 Aug 2020 14:53:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] ftrace: Fixup lockdep assert held of text_mutex
Message-ID: <20200826145327.7530b2e5@oasis.local.home>
In-Reply-To: <mhng-5de4c6ca-7e77-4b55-9097-59296872e6de@palmerdabbelt-glaptop1>
References: <20200813113743.001b6c31@oasis.local.home>
        <mhng-5de4c6ca-7e77-4b55-9097-59296872e6de@palmerdabbelt-glaptop1>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 17:29:32 -0700 (PDT)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> I pointed out in the patch notes that it seems reasonable to have the generic
> code handle this case, would you be opposed to doing it that way?

For now, lets hold off and see if other archs start to do it the same
way. Then we should look into making it more generic. It's an easy
enough fix per arch, so there's no urgency to this.

-- Steve
