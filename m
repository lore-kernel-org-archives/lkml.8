Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC8EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A7D20870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgCCPsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbgCCPsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:48:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E067520866;
        Tue,  3 Mar 2020 15:48:04 +0000 (UTC)
Date:   Tue, 3 Mar 2020 10:48:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yiwei Zhang <zzyiwei@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com,
        elder@kernel.org, federico.vaga@cern.ch, tony.luck@intel.com,
        vilhelm.gray@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        paul.walmsley@sifive.com, bhelgaas@google.com, darekm@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        android-kernel <android-kernel@google.com>
Subject: Re: [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
Message-ID: <20200303104803.004bae25@gandalf.local.home>
In-Reply-To: <CAKT=dD=a2r8s_ksHmwdOvnpKG0JeRxCo+ERzYGPFTW6OR01Org@mail.gmail.com>
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
        <20200302235044.59163-1-zzyiwei@google.com>
        <20200303090703.32b2ad68@gandalf.local.home>
        <20200303141505.GA3405@kroah.com>
        <20200303093104.260b1946@gandalf.local.home>
        <CAKT=dD=a2r8s_ksHmwdOvnpKG0JeRxCo+ERzYGPFTW6OR01Org@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 07:15:46 -0800
Yiwei Zhang <zzyiwei@google.com> wrote:


> Hi Steve, since Greg has acknowledged again on the latest patch v4,
> will you help merge from your tree?

Yes, I can add it to my queue for the next merge window.

-- Steve
