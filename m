Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA660C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7F72070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQ24aoVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgATPw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:52:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38470 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbgATPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579535545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=siJ2sfjzWDacIjNlyKFxd2oMlncO7B3hkvb0Wjp0h7Y=;
        b=FQ24aoVGO9HsbCugVtdA2VHlrBatHrL/OmxWvjz2BOEK5U9s6MxgME5ONxqMTi/Zk+HWq/
        FRfQboND5Wr4P+q2pQMbvtkPE/KjJXH/9SLeaC9SyS1Ll/JFcrdvGbA2vFZTD2nMspL6yk
        MKaqMRWGmUWaZLS0eizAhGDB7COW9Cg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-wXNF9myXPlCSEOjSfBcqig-1; Mon, 20 Jan 2020 10:52:22 -0500
X-MC-Unique: wXNF9myXPlCSEOjSfBcqig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27FAB800D41;
        Mon, 20 Jan 2020 15:52:21 +0000 (UTC)
Received: from treble (ovpn-125-19.rdu2.redhat.com [10.10.125.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C87360BF7;
        Mon, 20 Jan 2020 15:52:20 +0000 (UTC)
Date:   Mon, 20 Jan 2020 09:52:17 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20200120155217.ikvlphvlaswh3twt@treble>
References: <20191206135406.563336e7@canb.auug.org.au>
 <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 08:17:30AM -0800, Randy Dunlap wrote:
> On 12/5/19 6:54 PM, Stephen Rothwell wrote:
> 
> kernel/cred.o: warning: objtool: prepare_creds()+0x2c3: unreachable instruction

Here's another one I haven't recreated yet - if you can share the .o and
the config that would be helpful.

-- 
Josh

