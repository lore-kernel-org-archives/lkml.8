Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A6C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A99920661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcOoH3Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgEEVVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:21:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55422 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgEEVVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588713671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/k8UcsPjQG2+7rFpDrJgoM6XT8Q73mUVSWFX1krD0BE=;
        b=BcOoH3Fjv/zYXclaMOD8n+UwqTLKnsJKP4xCN03RUPhLYW4fFuNU0W1IvmQ4Y07ecUAE0Z
        nvC1JwWJD9G6sSoSWDtAiXLyp7FUovoAGGQrI8OoTxfVK2ICWMSfz9VNyC9ML5MKTTZMPU
        RGT/B9tdaR1QMwp6r3RKBWFTAjSQTlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-vAPewjxXNp23ZuqMQ6HGmg-1; Tue, 05 May 2020 17:21:10 -0400
X-MC-Unique: vAPewjxXNp23ZuqMQ6HGmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF866800D24;
        Tue,  5 May 2020 21:21:07 +0000 (UTC)
Received: from treble (ovpn-114-99.rdu2.redhat.com [10.10.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 109765C1BD;
        Tue,  5 May 2020 21:21:02 +0000 (UTC)
Date:   Tue, 5 May 2020 16:21:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 06/18] static_call: Add basic static call
 infrastructure
Message-ID: <20200505212004.2p4jbgy763lftmo6@treble>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.128942570@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501202944.128942570@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:28:55PM +0200, Peter Zijlstra wrote:
> +++ b/include/linux/static_call_types.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _STATIC_CALL_TYPES_H
> +#define _STATIC_CALL_TYPES_H
> +
> +#include <linux/stringify.h>
> +
> +#define STATIC_CALL_PREFIX		__SC__

This should probably be STATIC_CALL_KEY_PREFIX.  And change the prefix
to __SCK__ for consistency?

> +#define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_PREFIX, name)
> +
> +#define STATIC_CALL_TRAMP_PREFIX	__SCT__
> +#define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
> +#define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
> +#define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))

-- 
Josh

