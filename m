Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D1C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A7B2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCIOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:41:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59257 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCIOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:41:25 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBJaS-0001FK-Sk; Mon, 09 Mar 2020 15:40:56 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 795A21040A7; Mon,  9 Mar 2020 15:40:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 01/13] context_tracking: Ensure that the critical path cannot be instrumented
In-Reply-To: <20200309142223.GD9615@lenoir>
References: <20200308222359.370649591@linutronix.de> <20200308222609.017810037@linutronix.de> <20200309142223.GD9615@lenoir>
Date:   Mon, 09 Mar 2020 15:40:56 +0100
Message-ID: <87v9nd7frb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> On Sun, Mar 08, 2020 at 11:24:00PM +0100, Thomas Gleixner wrote:
>> context tracking lacks a few protection mechanisms against instrumentation:
>> 
>>  - While the core functions are marked NOKPROBE they lack protection
>>    against function tracing which is required as the function entry/exit
>>    points can be utilized by BPF.
>
> Just to clarify things up: IIUC, BPF scripts can be called from the
> function graph tracer hooks, and that BPF code uses RCU, right?

At least at the moment.
