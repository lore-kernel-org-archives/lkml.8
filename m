Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E174C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4557A2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgDTTUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgDTTUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:20:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291EE20736;
        Mon, 20 Apr 2020 19:20:45 +0000 (UTC)
Date:   Mon, 20 Apr 2020 15:20:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <ellerman@au1.ibm.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC] seq_buf: Export symbols to external modules
Message-ID: <20200420152043.1cd0a2ae@gandalf.local.home>
In-Reply-To: <87eesmwjwj.fsf@vajain21.in.ibm.com>
References: <20200416035124.549067-1-vaibhav@linux.ibm.com>
        <20200416090951.6f74b0c8@gandalf.local.home>
        <87eesmwjwj.fsf@vajain21.in.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 14:47:48 +0530
Vaibhav Jain <vaibhav@linux.ibm.com> wrote:

> Having these symbols exported to modules should simplify generating file
> content for pseudo file systems like sysfs or procfs. Many of the in
> kernel modules export atleast one such attribute file. Using seq_buf
> api provides a safe way to populate the read buffers for these attrs
> as these string buffers are PAGE_SIZE in length and a buggy module can
> easily cause an overflow.
> 
> My specific use-case is exporting a set of nvdimm specific flags from
> papr_scm kernel module [1] via sysfs through a patch proposed at [2] and
> using seq_buf should considerably simply my code as suggested by Mpe
> at [3].
> 
> [1] arch/powerpc/platforms/pseries/papr_scm.c
> [2] https://lore.kernel.org/linux-nvdimm/20200331143229.306718-2-vaibhav@linux.ibm.com
> [3] https://lore.kernel.org/linux-nvdimm/878sjetcis.fsf@mpe.ellerman.id.au

This patch should be added to a patch series that needs it. Then I'll give
my ack to it. That way, there's a reason to export them.

-- Steve
