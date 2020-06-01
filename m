Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4EBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3794720738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="el08y0ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgFAPJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:09:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21409 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgFAPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591024180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3RccGufA+FXMeFy4cF2DLyxYL+vFotiZlU7fjbCi7w=;
        b=el08y0msDUoe2YZb1zW+H3ZnypWKjr2XpZ+SLaNEYsTD4zokErbbGvV2tvMQmfmtU7BsFc
        aiqXx674R0uyuHZxMs7M5nZfStOqeZnvnn2YKtWeFMg2vK/ir6yFsIXph3Nhx2nK/R6mrl
        cq05twY+e2DxnU6CqKGmFxBgRFlMDxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-Mu6Vfn0oP3q3P3gzrHG0zQ-1; Mon, 01 Jun 2020 11:09:36 -0400
X-MC-Unique: Mu6Vfn0oP3q3P3gzrHG0zQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45D37100A614;
        Mon,  1 Jun 2020 15:09:35 +0000 (UTC)
Received: from treble (ovpn-116-170.rdu2.redhat.com [10.10.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84635768D6;
        Mon,  1 Jun 2020 15:09:34 +0000 (UTC)
Date:   Mon, 1 Jun 2020 10:09:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [PATCH 1/2] objtool: Rename rela to reloc
Message-ID: <20200601150932.6cgpdswnhy26e6ph@treble>
References: <cover.1590785960.git.mhelsley@vmware.com>
 <39f183f3acec8a758939dcbede7908a7455be8b8.1590785960.git.mhelsley@vmware.com>
 <20200529232200.xhjaemclbg2uqrih@treble>
 <20200530005244.GZ9040@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200530005244.GZ9040@rlwimi.vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 05:52:44PM -0700, Matt Helsley wrote:
> So I was rebasing my future patches and I found a few spots where
> objtool warning strings and code comments weren't fixed-up to
> consistent. Here's the new, complete regex -- it includes the original
> changes and the missed bits (e.g. note the new substitution for @rela
> comments):

Thanks, fixed.

-- 
Josh

