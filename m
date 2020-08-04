Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3259C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C1022B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgHDJRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:17:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:40006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgHDJRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:17:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7F87AD25;
        Tue,  4 Aug 2020 09:17:55 +0000 (UTC)
Message-ID: <1596532658.19923.6.camel@suse.com>
Subject: Re: [PATCH] cdc-acm: rework notification_buffer resizing
From:   Oliver Neukum <oneukum@suse.com>
To:     trix@redhat.com, gregkh@linuxfoundation.org, t-herzog@gmx.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 11:17:38 +0200
In-Reply-To: <20200801152154.20683-1-trix@redhat.com>
References: <20200801152154.20683-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, den 01.08.2020, 08:21 -0700 schrieb trix@redhat.com:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this error
> 
> cdc-acm.c:409:3: warning: Use of memory after it is freed
>         acm_process_notification(acm, (unsigned char *)dr);
> 
> There are three problems, the first one is that dr is not reset

Hi,

thank you, good catch.

	Regards
		Oliver

