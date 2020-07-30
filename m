Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C785C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9937206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgHF5Mq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgG3OJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:09:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37742 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727776AbgG3OJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596118184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6WINITRrttu57H5Ow4z7uhB5cozF06t59zUSHHbIkJc=;
        b=bgHF5Mq7oppZWu8k7EZ+2oaf9bcMuMgWorlfJ68sdo0be5e1NwszUR/8uop3BKP/V3Cpxc
        nWXxGp3ZB8KNq84zEHb6Yl1IugflVmhZPl84V3R7s//indNmeup/xfdykzoEl2b0EoN8Vj
        BCmm8f3MRT7ASwoUYglPRecDk6KiAaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-59XMCS6XOra8IvyfMPGEGg-1; Thu, 30 Jul 2020 10:09:40 -0400
X-MC-Unique: 59XMCS6XOra8IvyfMPGEGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98C71106F8C4;
        Thu, 30 Jul 2020 14:09:39 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B6C8A181;
        Thu, 30 Jul 2020 14:09:38 +0000 (UTC)
Date:   Thu, 30 Jul 2020 09:09:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhelsley@vmware.com, mbenes@suse.cz
Subject: Re: [PATCH v3 1/4] objtool: Move object file loading out of check
Message-ID: <20200730140936.uvw73r655356lhtm@treble>
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-2-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730094143.27494-2-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:41:40AM +0100, Julien Thierry wrote:
> +struct objtool_file *objtool_setup_file(const char *_objname)
> +{
> +	if (objname) {
> +		if (strcmp(objname, _objname)) {
> +			WARN("won't handle more than one file at a time");
> +			return NULL;
> +		}
> +		return &file;
> +	}
> +	objname = _objname;
> +
> +	file.elf = elf_open_read(objname, O_RDWR);
> +	if (!file.elf)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&file.insn_list);
> +	hash_init(file.insn_hash);
> +	file.c_file = find_section_by_name(file.elf, ".comment");
> +	file.ignore_unreachables = no_unreachable;
> +	file.hints = false;
> +
> +	return &file;
> +}

How about calling it objtool_open_read()?  It's (sort of) a wrapper
around elf_open_read().

-- 
Josh

