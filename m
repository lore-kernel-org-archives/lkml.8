Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DD9C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE6824680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Us4yuKch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgBZPcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:32:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56354 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgBZPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582731124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WDYCv6Ky26rHkmkQmUC/cEiGCA+eHnjiAcV6WwTD8Rw=;
        b=Us4yuKchlDeTczA38wUVydnzH7fV5c39/baf5wP3fcoBsdZQartEqTiQC5DmOQ5vVM9UTj
        gjIu0o3tkZ7Vv6hmyz+Du0eZ+ow+lSdFR8s0QVydqQ6AAfD+FmEHA8WuwO65wTXEESDCuf
        +pIcldM/atZi0PN7RwKiUc6P2cQat68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14--FCYkm1kPP-VskxXyidm_A-1; Wed, 26 Feb 2020 10:32:00 -0500
X-MC-Unique: -FCYkm1kPP-VskxXyidm_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D1ADB66;
        Wed, 26 Feb 2020 15:31:58 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C63163148;
        Wed, 26 Feb 2020 15:31:55 +0000 (UTC)
Date:   Wed, 26 Feb 2020 16:31:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     zhe.he@windriver.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mhiramat@kernel.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: probe-file: Check return value of strlist__add
 for -ENOMEM
Message-ID: <20200226153153.GC217283@krava>
References: <1582727404-180095-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582727404-180095-1-git-send-email-zhe.he@windriver.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:30:04PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> strlist__add may fail with -ENOMEM. Check it and give debugging hint in
> advance.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

