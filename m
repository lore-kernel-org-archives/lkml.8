Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D42C35E03
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496822064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irYTkGz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgBYOuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:50:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28547 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729891AbgBYOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582642216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GonAkwVlYf7mzVM7tAIusLAuxzdFzrvz8yw0t7Xi+OU=;
        b=irYTkGz7lxIK+X4SQrAhw2KvrH4aTNc0IBR6qjuL8AR9z1zV4AFEU3dQqmlSWImxK2ujcu
        ngna4FojGDicRCs7kZHJkkluiC332H7b4PUs6njnQHmrvPLuyO5G6NQ3s0ELKdkvjFVrbq
        9mvoV+ohHKHb32IVthEtoyLuISrwH9g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-jR4PSYRCOVaITGHIYnzgsg-1; Tue, 25 Feb 2020 09:50:10 -0500
X-MC-Unique: jR4PSYRCOVaITGHIYnzgsg-1
Received: by mail-wr1-f72.google.com with SMTP id z1so3760431wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GonAkwVlYf7mzVM7tAIusLAuxzdFzrvz8yw0t7Xi+OU=;
        b=p+6TdjFGQjZ9mKTz0jP/8y9TT0AQweU2jk7fFl8dEvtHK6LE59dfuxr7ElK4oxjkog
         16FSgX1yPR2yWUdgQlyc/o2SHPX7A8RaGeJb2jk49Psux9s1Pml95vorLoRPvWjojw37
         08IZylzZyYqC0vP9dHcd51sVyFki3ZxsKW+B3OlhrsKAIJQMFJyLsUCglOJ2xTvlW0M/
         zY76Q+0g3qGvlcvbRCT17Hto3XIn4gnuoHRAMdXbxzGXYczs8/uDB7IOEm9AGxJQqfD5
         J/n6GFIPkX8XTNXG8f2wmwdlH1vocQ2PNyn6tKOGvZXDb5JWH9u8aYhnjt2jTu+4S2bA
         wxow==
X-Gm-Message-State: APjAAAU+OO5f1HwNFL6Ilxpc1kSEihJT/Uyg92EyCay51N7CiEcBqZgE
        W21XJ2ftHVRcE+j4IZ8vOp3NFT0+ZX3Y37nID9BSvK/ojn+rw9oDtwJMqTrKIOHRCKKY5hnwvYj
        HcqcsG0XFh0maxQqfYyKyjHcV
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr5769988wmi.61.1582642209406;
        Tue, 25 Feb 2020 06:50:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+iIC5OCh2NpGwo5mA3TZ40WonwUZ+83HCqIBOQqR8BujCaubJru/+q3u54ZoDEBYYgL8adg==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr5769960wmi.61.1582642209128;
        Tue, 25 Feb 2020 06:50:09 -0800 (PST)
Received: from localhost.localdomain ([151.29.22.129])
        by smtp.gmail.com with ESMTPSA id x132sm4502638wmg.0.2020.02.25.06.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:50:08 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:50:06 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     zanussi@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 03/25] sched/deadline: Ensure inactive_timer runs in
 hardirq context
Message-ID: <20200225145006.GH26415@localhost.localdomain>
References: <cover.1582320278.git.zanussi@kernel.org>
 <11a532007a600928e64e761722da7100e19a0c5f.1582320278.git.zanussi@kernel.org>
 <20200224083303.cdj27guxfxqkbyqo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224083303.cdj27guxfxqkbyqo@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/02/20 09:33, Sebastian Andrzej Siewior wrote:
> On 2020-02-21 15:24:31 [-0600], zanussi@kernel.org wrote:
> > [ Upstream commit ba94e7aed7405c58251b1380e6e7d73aa8284b41 ]
> > 
> > SCHED_DEADLINE inactive timer needs to run in hardirq context (as
> > dl_task_timer already does) on PREEMPT_RT
> 
> The message says "dl_task_timer already does" but this is not true for
> v4.14 as it still runs in softirq context on RT. v4.19 has this either
> via
>   https://lkml.kernel.org/r/20190731103715.4047-1-juri.lelli@redhat.com
> 
> or the patch which got merged upstream.
> 
> Juri, I guess we want this for v4.14, too?

Indeed. v4.14 needs this as well.

Thanks for noticing!

Best,

Juri

