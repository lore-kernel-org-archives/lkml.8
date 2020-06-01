Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603DAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F73B20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFANsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgFANsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:48:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4202068D;
        Mon,  1 Jun 2020 13:48:43 +0000 (UTC)
Date:   Mon, 1 Jun 2020 09:48:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/5] seq_buf: Export seq_buf_printf
Message-ID: <20200601094842.3cd0cab6@gandalf.local.home>
In-Reply-To: <87367f9eqs.fsf@linux.ibm.com>
References: <20200527041244.37821-1-vaibhav@linux.ibm.com>
        <20200527041244.37821-3-vaibhav@linux.ibm.com>
        <87367f9eqs.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jun 2020 17:31:31 +0530
Vaibhav Jain <vaibhav@linux.ibm.com> wrote:

> Hi Christoph and Steven,
> 
> Have addressed your review comment to update the patch description and
> title for this patch. Can you please provide your ack to this patch.
> 
> 

I thought I already did, but it appears it was a reply to a private email
you sent to me. I didn't realize it was off list.

Anyway:

 Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
