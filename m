Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18609C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C4520768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgFOVYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOVYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:24:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A48220679;
        Mon, 15 Jun 2020 21:24:30 +0000 (UTC)
Date:   Mon, 15 Jun 2020 17:24:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v13 2/6] seq_buf: Export seq_buf_printf
Message-ID: <20200615172429.6e66ed0f@oasis.local.home>
In-Reply-To: <20200615125552.GI14668@zn.tnic>
References: <20200615124407.32596-1-vaibhav@linux.ibm.com>
        <20200615124407.32596-3-vaibhav@linux.ibm.com>
        <20200615125552.GI14668@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 14:55:52 +0200
Borislav Petkov <bp@alien8.de> wrote:

> Can you please resend your patchset once a week like everyone else and
> not flood inboxes with it?

Boris,

Haven't you automated your inbox yet? I have patchwork reading my INBOX
and it's smart enough to understand new series, and the old one simply
disappears as "superseded".

Email is just the wires to our infrastructure. Get with the times man! ;-)

-- Steve
