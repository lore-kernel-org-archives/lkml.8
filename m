Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A7220665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5NQL21U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgIDStM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgIDStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599245350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiYSRBaMluJSVw3MWVD8YBv3e0YIzVGvkRBc3uY9Q5M=;
        b=I5NQL21U3Eir0+LziducBhG3YErqD7Hq0hcN0GPLy76qRY1ia/NLO1S3ZVS5wLMfY6fYbV
        0xn46sKEB8+84UxAfuM83VrsgXqa8GgxY33HSyfCQfQDRuHfusTw1i1snIVMH+u1I9vN74
        olTKARhQsQXIKusTnEG8JVLZ0q+w8LM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-46EtkNuMOWKeIdo1q_bFVQ-1; Fri, 04 Sep 2020 14:49:07 -0400
X-MC-Unique: 46EtkNuMOWKeIdo1q_bFVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E5C218B9EDB;
        Fri,  4 Sep 2020 18:49:06 +0000 (UTC)
Received: from treble (ovpn-117-138.rdu2.redhat.com [10.10.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C996E87B2D;
        Fri,  4 Sep 2020 18:49:05 +0000 (UTC)
Date:   Fri, 4 Sep 2020 13:49:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v3 09/10] objtool: Make unwind hints definitions
 available to other architectures
Message-ID: <20200904184904.px725vsob6zwd3ir@treble>
References: <20200904153028.32676-1-jthierry@redhat.com>
 <20200904153028.32676-10-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904153028.32676-10-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:30:27PM +0100, Julien Thierry wrote:
> +/*
> + * UNWIND_HINT_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP
> + * (the caller's SP right before it made the call).  Used for all callable
> + * functions, i.e. all C code and all callable asm functions.
> + *
> + * UNWIND_HINT_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset
> + * points to a fully populated pt_regs from a syscall, interrupt, or exception.
> + *
> + * UNWIND_HINT_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
> + * points to the iret return frame.

Now that this is generic, I think REGS_PARTIAL would be better.

> + *
> + * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
> + * aren't used in struct orc_entry due to size and complexity constraints.
> + * Objtool converts them to real types when it converts the hints to orc
> + * entries.

Now that ORC_TYPE_* have been replaced by UNWIND_HINT_TYPE_*, I think
this last paragraph should be removed.

-- 
Josh

