Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1E2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C2B206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHzwPBVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgG3OGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:06:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34316 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbgG3OGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596117989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGO4oze85/EJafD3eqbUd1S4qpOJJ5CpzsIVcHhg/wg=;
        b=XHzwPBVlFbIX3rytZd/aR5SyZxME0ebfmM7ndTSSVUpN2CvwGA4YaChbnrCuoldkszJtkt
        IUedz8FbKBZ9mrM3O0gQ5KR4GDcVchyaiJ1JMJ2OQws0/KwAJh8uR4OJaIWKkC1+yiyIjA
        tt8rfVhN0V5WvcSlhcxAzJRev06910A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-fRz1uVXDN8aomdZFm9zq4w-1; Thu, 30 Jul 2020 10:06:26 -0400
X-MC-Unique: fRz1uVXDN8aomdZFm9zq4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4D35100A614;
        Thu, 30 Jul 2020 14:06:25 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09C181992D;
        Thu, 30 Jul 2020 14:06:24 +0000 (UTC)
Date:   Thu, 30 Jul 2020 09:06:23 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhelsley@vmware.com, mbenes@suse.cz
Subject: Re: [PATCH v3 0/4] Remove dependency of check subcmd upon orc
Message-ID: <20200730140623.5aw7lm57j7qof5pm@treble>
References: <20200730094143.27494-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730094143.27494-1-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:41:39AM +0100, Julien Thierry wrote:
> Hi,
> 
> Matt Helsley's change[1] provided a base framework to opt-in/out
> objtool subcommands at compile time. This makes it easier for
> architectures to port objtool, one subcommand at a time.
> 
> Orc generation relies on the check operation implementation. However,
> the way this is done causes the check implementation to depend on the
> implementation of orc generation functions to call if orc generation is
> requested. This means that in order to implement check subcmd, orc
> subcmd also need to be implemented.
> 
> These patches aim at removing that dependency, having orc subcmd
> being built on top of the check subcmd.
> 
> 
> Changes since v2 [2]:
> - Rebased on recent tip/objtool/core

tip/objtool/core is slightly outdated, I got a conflict with patch 1.

I guess linus/master would be best.

-- 
Josh

