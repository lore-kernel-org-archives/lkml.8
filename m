Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DCCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAF12070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aElSe4e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgG3O4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:56:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47507 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbgG3O4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596120990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKszPGuwEMpU5+IR0bvpm9HZk4pnbzEZAwwA9OvxBKo=;
        b=aElSe4e6+pxXWsgbAv6G3liC0qGf1lRwS1yNVTfStk5KdGdPjWAG0A145nZY8CR3qX/oVp
        KWcdoF4lqAFMFrhfD6bKXSupAZY62paMWWqjWZLBjS9xg3o+J0RslsWZDflG4Q60Bmvhtb
        E0rIgdcuAXeqs1W6WYC8+MGYyjDa8L4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-YQ0oL0tTO2CGOiiX58aJ5g-1; Thu, 30 Jul 2020 10:56:17 -0400
X-MC-Unique: YQ0oL0tTO2CGOiiX58aJ5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 259D51893DC0;
        Thu, 30 Jul 2020 14:56:16 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6639A10023A5;
        Thu, 30 Jul 2020 14:56:15 +0000 (UTC)
Date:   Thu, 30 Jul 2020 09:56:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 8/9] frame: Make unwind hints definitions available to
 other architectures
Message-ID: <20200730145613.lbsexjcqwj67ktmb@treble>
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-9-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730094652.28297-9-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:46:51AM +0100, Julien Thierry wrote:
> Unwind hints are useful to provide objtool with information about stack
> states in non-standard functions/code.
> While the type of information being provided might be very arch
> specific, the mechanism to provide the information can be useful for
> other architectures.
> 
> Move the relevant unwint hint definitions for all architectures to
> see.

The scope of include/linux/frame.h has been creeping, it's no longer
just about frame pointers.  Maybe we should rename it to objtool.h.

-- 
Josh

