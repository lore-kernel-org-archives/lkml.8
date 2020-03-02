Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358AFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1C1246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFrAoUaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCBJ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:59:21 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:51252 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:59:20 -0500
Received: by mail-pj1-f47.google.com with SMTP id l8so694077pjy.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yBAtOE7z+JsF0yFi8ZyN6O418OZ3pIjiUlokh8yYoZ8=;
        b=hFrAoUaG9P3sVx8CACSo7eEyWZFX13nPr6Nag0DvYdFRF2HgTU5s/7joXFgX3X4PqK
         RKkTQzqHU5w4Q4ZdVxiD7amzx27Rloqksn5pTdT8akJ0mvoHL9n9D4dkzu4SZDnJjunS
         +ugyMF+UfwhBym3nPGcT4gYbNJsC0o1meklRXlGsa8tVFnX6VA9YQ/f/wQOuUTfS39fE
         KBPwoJI3Te3OvEhcSH7BFs5ess3AiKWbHrX6igIOY8SHqfsaVc1ldSzjdGAOZ5ZPAe2F
         d4hMbx3Etvv1CSigCTh4OmrqlBDOQqvBBJFRC8Pg5XEZhgdTksPXFmpmQpZmY7D2xmq1
         MrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yBAtOE7z+JsF0yFi8ZyN6O418OZ3pIjiUlokh8yYoZ8=;
        b=E5RFhIh2nU8GbpjDUyAz2/eYHwRQHUJIGsTfKPNtFeMSvygfjfD8CC06SQgPk82RuT
         oOuucV3XTCoB4kx2ajofgW6lKYTpUmb8uwIcpXI4vuRkjop4slDc0eWxf5Ky9Cljkzy6
         L39QTiD7tWuUpZpIWTmxmj7bWvkln1bqJCtvty/WTHTl0W8UHEwn9dsFPlLGHO0ra3a0
         jjtndnWsqpcIjI6dHnxkdQdVcsjU5oBr6+zfL9qErhp/Y9n3e6xP75tMIid3jG8+CiPC
         0NsSWe49pzlRhwiced5YNmLQbAEFccm8UhRIenvBUTWcIsULvixMe6XHnCbMBoEfiJlt
         NQrg==
X-Gm-Message-State: APjAAAXVlfiKS4J+RuJU/dTM03SsH1rlBtVenc6t/xrmM4JMtCNwlFCl
        bgErmjkdT3NsI/jEUo0akNU=
X-Google-Smtp-Source: APXvYqw5L8Qjtuyjztt9BwEFf5zcEGTk2Op2B2mUI5xvrRjTlO9H2TWvdmD3kE/A4LVFFRGGIIm0JA==
X-Received: by 2002:a17:90a:3188:: with SMTP id j8mr19946254pjb.82.1583143159704;
        Mon, 02 Mar 2020 01:59:19 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id p2sm1341004pfb.41.2020.03.02.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 01:59:18 -0800 (PST)
Date:   Mon, 2 Mar 2020 18:59:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        John Ogness <john.ogness@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200302095916.GA66317@google.com>
References: <20200228031306.GO122464@google.com>
 <20200228100416.6bwathdtopwat5wy@pathway.suse.cz>
 <20200228105836.GA2913504@kroah.com>
 <20200228113214.kew4xi5tkbo7bpou@pathway.suse.cz>
 <20200228130217.rj6qge2en26bdp7b@pathway.suse.cz>
 <20200228205334.GF101220@mit.edu>
 <20200229033253.GA212847@google.com>
 <20200229184719.714dee74@oasis.local.home>
 <20200301052219.GA83612@google.com>
 <20200302094907.qdbhe6iobegah56t@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302094907.qdbhe6iobegah56t@pathway.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/02 10:49), Petr Mladek wrote:
[..]
> It is just a detail. But I would make the flag independent
> on the existing printk_safe stuff. printk_safe will get removed
> with the lockless printk buffer. While the irq_work() will still
> be needed for the wakeup functions.

Yeah, somehow I thought, for a moment, that we would also remove
printk_deferred() once we have lockless buffer, but seems that we
can remove it only when console_sem is gone.

> Sergey, do you agree and want to update your patch accordingly?

Yes, can update the patch.

	-ss
