Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC09FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3D5222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qKzjcy6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgCBT2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:28:18 -0500
Received: from mail.efficios.com ([167.114.26.124]:59142 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgCBT2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:28:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A807B242DE4;
        Mon,  2 Mar 2020 14:28:13 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0himL2_oJ-AY; Mon,  2 Mar 2020 14:28:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 51092242DE3;
        Mon,  2 Mar 2020 14:28:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 51092242DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583177293;
        bh=KJbmqk8Jn/jNZwggc69QEGzQFTkgls359xQwJIARzOg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qKzjcy6lQP1TDW8ftDXlvUwHY8WRFGjV1NHZfocWxTs996wSg0GiVojTih+t2TVvq
         YwIYkmTrbkcGmSuclj+6oYDGdzsAsgOdnb6WltwJIgloDUC7zD3Y0iypqSr4hytEKy
         1GLROl1iZf5vBtqBSSgVP4I2VEY7LxDW2z1RBak2kWZ6NbGDqQ4hDNW+IavmbDPTo7
         LQazFWYlpXv/ML9us4zb3jlDynNV1m4H7KBol1RgOd20AgbG4ZTVVF8hjO8VCPw2Vy
         J8ugs54ThV8kLYABOYL3Y2l5nNpCfqfgQIcBob9I5PQolFhEr+Z5P7gJsi9KeNzESm
         Soo4kpfGltLAw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2K2HHPeG7YUI; Mon,  2 Mar 2020 14:28:13 -0500 (EST)
Received: from localhost (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id D6519242DE2;
        Mon,  2 Mar 2020 14:28:12 -0500 (EST)
Date:   Mon, 2 Mar 2020 14:28:11 -0500
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org
Subject: Re: [PATCH 0/3] Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-ID: <20200302192811.n6o5645rsib44vco@localhost>
References: <20200221114404.14641-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221114404.14641-1-will@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Feb-2020 11:44:01 AM, Will Deacon wrote:
> Hi folks,
> 
> Despite having just a single modular in-tree user that I could spot,
> kallsyms_lookup_name() is exported to modules and provides a mechanism
> for out-of-tree modules to access and invoke arbitrary, non-exported
> kernel symbols when kallsyms is enabled.
> 
> This patch series fixes up that one user and unexports the symbol along
> with kallsyms_on_each_symbol(), since that could also be abused in a
> similar manner.

Hi,

I maintain a GPL kernel tracer (LTTng) since 2005 which happens to be
out-of-tree, even though we have made unsuccessful attempts to upstream
it in the past. It uses kallsyms_lookup_name() to fetch a few symbols. I
would be very glad to have them GPL-exported upstream rather than
relying on this work-around. Here is the list of symbols we would need
to GPL-export:

stack_trace_save
stack_trace_save_user
vmalloc_sync_all (CONFIG_X86)
get_pfnblock_flags_mask
disk_name
block_class
disk_type
global_wb_domain
task_prio

In order to provide address-to-symbol mapping at trace post-processing
(for which we have a prototype branch), we would also need the "_text"
symbol to be GPL-exported, as well as the list of currently loaded
modules (LIST_HEAD(modules) or a getter function).

The tricky part is justifying having those exported for a project
which is not upstream.

I welcome advice on this matter,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
