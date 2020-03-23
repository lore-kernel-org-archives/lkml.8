Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA21C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36531206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr8vHGR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCWAre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 20:47:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30901 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbgCWAre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 20:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584924452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ig4doA85riL2XtPeQfs/qUQldiVkDlW3JAidx8gyjPc=;
        b=Vr8vHGR0aXm2uFpNGGAmkOTiTxU/Yi4MB0/PuM2x8+4FnEJCGJqTavoE+6K2Xqds3nAjy9
        MfPAjKhuMqy0QDhNEcgi7vpti2Fk0UIIHTgw7PBQCg9y3dGeMhNYsq8FpzZSIaxZAkfFeb
        YXXSyOTsfVs2XygPFP2E9IrU1CSuy0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-wd9H0AT3Pfu9Z28AQ4ibbQ-1; Sun, 22 Mar 2020 20:47:29 -0400
X-MC-Unique: wd9H0AT3Pfu9Z28AQ4ibbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48259189D6C3;
        Mon, 23 Mar 2020 00:47:27 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E17D25C1B2;
        Mon, 23 Mar 2020 00:47:24 +0000 (UTC)
Date:   Mon, 23 Mar 2020 01:47:18 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Simran Singhal <singhalsimran0@gmail.com>
Cc:     gregkh@linuxfoundation.org, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: kpc2000: Removing multiple
 blank lines
Message-ID: <20200323014718.461a6bbe@elisabeth>
In-Reply-To: <20200321140430.GA18933@simran-Inspiron-5558>
References: <20200321140430.GA18933@simran-Inspiron-5558>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Mar 2020 19:34:31 +0530
Simran Singhal <singhalsimran0@gmail.com> wrote:

> This patch fixes the checkpatch warning by removing multiple blank
> lines.

Actually, you're removing just one. Can you please re-post fixing the
description? Mind that it's going to be a "v2", that is, the second
version of this patch. Please see recent examples on this list about
that.

-- 
Stefano

