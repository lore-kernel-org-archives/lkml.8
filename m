Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7DBC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2F2204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHCTElMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgIAQGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730544AbgIAQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598976347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mupIaS0dTEeO07mNOTIqZq0+JowOp33CO07KogYwAJE=;
        b=DHCTElMcNKOtA8mxdODVINkr5S2kadOYLpXEfnKfmkF3MqETQw3WMvYpF2cpNV7IfEhEES
        JX4A3QNka9CD/bQzkqKMAfCFR1ADaigIZ4PGs2iflN1imEdJkCPmVRKN8135+bGwbSeRCp
        41t+1tnvsrUoIulq4G8AWGVHxX6eCi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-tu6J1amPNxGCLdngGv6UsA-1; Tue, 01 Sep 2020 12:05:44 -0400
X-MC-Unique: tu6J1amPNxGCLdngGv6UsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D82D518BFEC5;
        Tue,  1 Sep 2020 16:05:42 +0000 (UTC)
Received: from treble (ovpn-113-168.rdu2.redhat.com [10.10.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CECD05D9CD;
        Tue,  1 Sep 2020 16:05:40 +0000 (UTC)
Date:   Tue, 1 Sep 2020 11:05:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        benh@kernel.crashing.org
Subject: Re: [PATCH v4 0/4] Remove dependency of check subcmd upon orc
Message-ID: <20200901160538.a2t3qiagdanx6xtw@treble>
References: <20200825124742.29782-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825124742.29782-1-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:47:38PM +0100, Julien Thierry wrote:
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
> Changes since v3 [2]:
> - Rebased on v5.9-rc1
> - Renamed objtool_setup_file() to objtool_open_read()
> - Fixed misplaced elf_write() when file->elf->changed is true
> - Avoid additional allocation for orc data and compile out orc
>   definition when not needed instead
> 
> [1] https://www.spinics.net/lists/kernel/msg3510844.html
> [2] https://lkml.org/lkml/2020/7/30/415

Thanks, I grabbed the patches and will work with Peter to get them
merged.

-- 
Josh

