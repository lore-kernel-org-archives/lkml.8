Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB566C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC3F20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbgCPSFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbgCPSFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:05:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221EF20409;
        Mon, 16 Mar 2020 18:05:46 +0000 (UTC)
Date:   Mon, 16 Mar 2020 14:05:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yiwei Zhang <zzyiwei@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com,
        elder@kernel.org, federico.vaga@cern.ch, tony.luck@intel.com,
        vilhelm.gray@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        paul.walmsley@sifive.com, Bjorn Helgaas <bhelgaas@google.com>,
        Dariusz Marcinkiewicz <darekm@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        android-kernel <android-kernel@google.com>
Subject: Re: [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
Message-ID: <20200316140544.42e3f383@gandalf.local.home>
In-Reply-To: <CAKT=dDnT_d-C2jfcgD+OFvJ=vkqxvQDmg3nAErvs9tXS6iifpw@mail.gmail.com>
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
        <20200302235044.59163-1-zzyiwei@google.com>
        <20200303090703.32b2ad68@gandalf.local.home>
        <20200303141505.GA3405@kroah.com>
        <20200303093104.260b1946@gandalf.local.home>
        <20200303155639.GA437469@kroah.com>
        <CAKT=dDnT_d-C2jfcgD+OFvJ=vkqxvQDmg3nAErvs9tXS6iifpw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 15:59:37 -0700
Yiwei Zhang <zzyiwei@google.com> wrote:

> Hi guys, thanks for all the help throughout this. After struggling a
> while, I failed to figure out when the next merge window is. Could you
> help point me to the release calendar or something?  Thanks again!

I have this queued in my local tree. I'm currently having some issues with
my testing (there appears to be an unrelated bug to my code keeping it from
passing). But you should see this patch fly by when I add it to my
linux-next queue.

-- Steve
