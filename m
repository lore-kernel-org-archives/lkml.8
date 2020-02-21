Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32585C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD2F24656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582312046;
	bh=6uLcqMfduTQKF6OYwQIQoguS6KxpI6uDdyPC87CBEZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d5POvyYJHVLsIaIDE3G3I6FaXEkx6GNVHntEBylhC9Or3TPKKvy7/cyuijr99pSCt
	 xlc1ZShnP7F7gJ49pk4+2bLM6KLzZ/3Gh1NY75m7LlvDUmCQpGPCd9gav5tQhwmk0Z
	 +ElTZkAQsVJVTaoTCBx6e3oAkCtL+OX77MNMBTuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgBUTHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbgBUTHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:07:24 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF5C24656
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582312043;
        bh=6uLcqMfduTQKF6OYwQIQoguS6KxpI6uDdyPC87CBEZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JXfl7jNl9P0pfrPYH/9f7zS0Jhrbj74KdDlid4yxEcBiM65pgItXKeV/YVsto30la
         7j0vie4wpeu7DuBMPm1JMALlVFrF5ou6plMEnG9yuPhwqpXfzaBNZgKRZ9i0p59eMk
         GCELhoGU9i6KVAQsAIEdRmUFBKVxKK8NclEstY1Y=
Received: by mail-wr1-f46.google.com with SMTP id g3so3200530wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:07:23 -0800 (PST)
X-Gm-Message-State: APjAAAUX3tacDJoW2/lZ/zpTY4tHhynBpJLfnBzR8sHsk/kgAmHnMQIF
        xEPVIJDNlF7L/7qfmxddaxwJdpPEH3xX7jq3KV2G1w==
X-Google-Smtp-Source: APXvYqzbWc881wp5/f01vlRJb42V4BGKJGPzcqlnJpomUjicOi9hX7W1f798+mdqv0+k9G9T9EnTzM6IylNrbz8rF1Y=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr48995112wrm.75.1582312042068;
 Fri, 21 Feb 2020 11:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20200221133416.777099322@infradead.org> <20200221134215.264229755@infradead.org>
In-Reply-To: <20200221134215.264229755@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 21 Feb 2020 11:07:10 -0800
X-Gmail-Original-Message-ID: <CALCETrWTbSC1cKgfP_v5LCE1-FQ6bF6E+nA5UmB0SphCCCt1vA@mail.gmail.com>
Message-ID: <CALCETrWTbSC1cKgfP_v5LCE1-FQ6bF6E+nA5UmB0SphCCCt1vA@mail.gmail.com>
Subject: Re: [PATCH v4 04/27] x86/mce: Delete ist_begin_non_atomic()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 5:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> It is an abomination; and in prepration of removing the whole
> ist_enter() thing, it needs to go.
>
> Convert #MC over to using task_work_add() instead; it will run the
> same code slightly later, on the return to user path of the same
> exception.

This looks correct to me.
