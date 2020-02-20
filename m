Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D28FC11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFAA20722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgBTNSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:18:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:39150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgBTNSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:18:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1893ACA1;
        Thu, 20 Feb 2020 13:18:38 +0000 (UTC)
Date:   Thu, 20 Feb 2020 14:18:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200220131836.7yo7ktnhggo7653z@pathway.suse.cz>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219150744.428764577@infradead.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-02-19 15:47:25, Peter Zijlstra wrote:
> Since there are already a number of sites (ARM64, PowerPC) that
> effectively nest nmi_enter(), lets make the primitive support this
> before adding even more.

Reviewed-by: Petr Mladek <pmladek@suse.com>	# for printk part

The rest looks good as well.

Best Regards,
Petr
